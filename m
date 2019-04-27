Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F305206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfD0PcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60746 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zB-Fj; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004O7-8Q; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hui Peng" <benquike@163.com>, "Takashi Iwai" <tiwai@suse.de>,
        "Mathias Payer" <mathias.payer@nebelwelt.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.328485829@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 007/202] ALSA: usb-audio: Always check descriptor
 sizes in parser code
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 3e96d7280f16e2f787307f695a31296b9e4a1cd7 upstream.

There are a few places where we access the data without checking the
actual object size from the USB audio descriptor.  This may result in
OOB access, as recently reported.

This patch addresses these missing checks.  Most of added codes are
simple bLength checks in the caller side.  For the input and output
terminal parsers, we put the length check in the parser functions.
For the input terminal, a new argument is added to distinguish between
UAC1 and the rest, as they treat different objects.

Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Reported-by: Hui Peng <benquike@163.com>
Tested-by: Hui Peng <benquike@163.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16:
 - Drop changes in parse_audio_input_terminal() and UAC3 handling
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -258,6 +258,11 @@ static int snd_usb_create_streams(struct
 			return -EINVAL;
 		}
 
+		if (h1->bLength < sizeof(*h1)) {
+			dev_err(&dev->dev, "cannot find UAC_HEADER\n");
+			return -EINVAL;
+		}
+
 		if (!h1->bInCollection) {
 			dev_info(&dev->dev, "skipping empty audio interface (v1)\n");
 			return -EINVAL;
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -412,12 +412,8 @@ static int parse_uac_endpoint_attributes
 		csep = snd_usb_find_desc(alts->extra, alts->extralen, NULL, USB_DT_CS_ENDPOINT);
 
 	if (!csep || csep->bLength < 7 ||
-	    csep->bDescriptorSubtype != UAC_EP_GENERAL) {
-		usb_audio_warn(chip,
-			       "%u:%d : no or invalid class specific endpoint descriptor\n",
-			       iface_no, altsd->bAlternateSetting);
-		return 0;
-	}
+	    csep->bDescriptorSubtype != UAC_EP_GENERAL)
+		goto error;
 
 	if (protocol == UAC_VERSION_1) {
 		attributes = csep->bmAttributes;
@@ -425,6 +421,8 @@ static int parse_uac_endpoint_attributes
 		struct uac2_iso_endpoint_descriptor *csep2 =
 			(struct uac2_iso_endpoint_descriptor *) csep;
 
+		if (csep2->bLength < sizeof(*csep2))
+			goto error;
 		attributes = csep->bmAttributes & UAC_EP_CS_ATTR_FILL_MAX;
 
 		/* emulate the endpoint attributes of a v1 device */
@@ -433,6 +431,12 @@ static int parse_uac_endpoint_attributes
 	}
 
 	return attributes;
+
+ error:
+	usb_audio_warn(chip,
+		       "%u:%d : no or invalid class specific endpoint descriptor\n",
+		       iface_no, altsd->bAlternateSetting);
+	return 0;
 }
 
 /* find an input terminal descriptor (either UAC1 or UAC2) with the given
@@ -440,13 +444,17 @@ static int parse_uac_endpoint_attributes
  */
 static void *
 snd_usb_find_input_terminal_descriptor(struct usb_host_interface *ctrl_iface,
-					       int terminal_id)
+				       int terminal_id, bool uac2)
 {
 	struct uac2_input_terminal_descriptor *term = NULL;
+	size_t minlen = uac2 ? sizeof(struct uac2_input_terminal_descriptor) :
+		sizeof(struct uac_input_terminal_descriptor);
 
 	while ((term = snd_usb_find_csint_desc(ctrl_iface->extra,
 					       ctrl_iface->extralen,
 					       term, UAC_INPUT_TERMINAL))) {
+		if (term->bLength < minlen)
+			continue;
 		if (term->bTerminalID == terminal_id)
 			return term;
 	}
@@ -463,7 +471,8 @@ static struct uac2_output_terminal_descr
 	while ((term = snd_usb_find_csint_desc(ctrl_iface->extra,
 					       ctrl_iface->extralen,
 					       term, UAC_OUTPUT_TERMINAL))) {
-		if (term->bTerminalID == terminal_id)
+		if (term->bLength >= sizeof(*term) &&
+		    term->bTerminalID == terminal_id)
 			return term;
 	}
 
@@ -561,7 +570,8 @@ int snd_usb_parse_audio_interface(struct
 			format = le16_to_cpu(as->wFormatTag); /* remember the format value */
 
 			iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-								       as->bTerminalLink);
+								       as->bTerminalLink,
+								       false);
 			if (iterm) {
 				num_channels = iterm->bNrChannels;
 				chconfig = le16_to_cpu(iterm->wChannelConfig);
@@ -597,7 +607,8 @@ int snd_usb_parse_audio_interface(struct
 			/* lookup the terminal associated to this interface
 			 * to extract the clock */
 			input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
-									    as->bTerminalLink);
+									    as->bTerminalLink,
+									    true);
 			if (input_term) {
 				clock = input_term->bCSourceID;
 				if (!chconfig && (num_channels == input_term->bNrChannels))

