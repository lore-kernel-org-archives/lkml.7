Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97702342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd9mO68e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfH3Vrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:47:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41600 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfH3Vrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:47:35 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so16998730ioj.8;
        Fri, 30 Aug 2019 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ktj9ijOXrDlsClzwNjZ3ksaxYmWqZ56FuwuOhvsPKKo=;
        b=gd9mO68eLPusJAzfzxl4zLc8gKbKmfkQ7af1kIyZebpDXbHObeZ0TtAcr7+/gXb065
         wz6v1UFCUc+PlNoolMSw/7RKrxDAQ0CBN8TbBN/dGfbJf/diJxWpIRaeUTj+DMxdb5Hp
         rnU7Hmv6RUAKnVozjfs2IaL0UJBIGb0RwXDeUU9klT4aJGkO1HIqrN8leDReJ2jOh2sO
         ePCIl6WCFnhVoL6ytAH46sZmFC/mZJLldqLzVDUvoOBTezvVcuXF0C9Nu5dyPG6L5Z85
         I7xgtw2L0KUEGgpRb2nn566RDyB+6ExIzCEIMdbrLeE+ex9oLl0Ul2i4bLr5Pt9+Pzo3
         Jy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ktj9ijOXrDlsClzwNjZ3ksaxYmWqZ56FuwuOhvsPKKo=;
        b=dgOj37ebvBE3FtF0ObI2dj9VdDCbeo6q9e5p0K/h3dGPHn+sJJV2Ob143+IozR5EqU
         Tk3hh0nlcUvn/Dk5fFDTPbr0+HuGsF/RVTIywvvFoUs5LyI7tZJe69lb86RJBtVUGaOg
         TzDaNWzDCADspBg1H5IEetLgIC5gYjge71Xa4NaV061qzKTYIuAtfEHJbqgad3AljfuM
         7nKYWQi2xin+3q6hbTwFlZmYhz37yZl/Zd5CvoxkPL/ipLd5q7FrtrZsIKTnbiFQIoEF
         ivVVu5qR8S63FZpHkSqje8hRYfMZWpk1ew6Bu7BAwtUWq58pd1nKK9IWAyECMPBjFOvm
         JHSg==
X-Gm-Message-State: APjAAAVAA7olvZlG2PwqrI326jY+XIdTSDIHhcuG1Kfqc6UX98eYFmaS
        Mw9aLhmbML3dZKJvrSlOeWzYsFM6327Dyw==
X-Google-Smtp-Source: APXvYqyeFTplYCjFE+3c/w8BqfcYCdDNh+VGXtKXRugkIy1aYSS1whlWxjgPreD2EGxux4fx2zZztg==
X-Received: by 2002:a5d:974d:: with SMTP id c13mr2090159ioo.87.1567201654419;
        Fri, 30 Aug 2019 14:47:34 -0700 (PDT)
Received: from peng.science.purdue.edu (cos-128-210-107-27.science.purdue.edu. [128.210.107.27])
        by smtp.googlemail.com with ESMTPSA id i14sm328004ioi.47.2019.08.30.14.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:47:34 -0700 (PDT)
From:   Hui Peng <benquike@gmail.com>
To:     stable@vger.kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Fix a stack buffer overflow bug in check_input_term
Date:   Fri, 30 Aug 2019 17:47:29 -0400
Message-Id: <20190830214730.27842-1-benquike@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`check_input_term` recursively calls itself with input from
device side (e.g., uac_input_terminal_descriptor.bCSourceID)
as argument (id). In `check_input_term`, if `check_input_term`
is called with the same `id` argument as the caller, it triggers
endless recursive call, resulting kernel space stack overflow.

This patch fixes the bug by adding a bitmap to `struct mixer_build`
to keep track of the checked ids and stop the execution if some id
has been checked (similar to how parse_audio_unit handles unitid
argument).

CVE: CVE-2018-15118

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 10ddec76f906..e24572fd6e30 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -81,6 +81,7 @@ struct mixer_build {
 	unsigned char *buffer;
 	unsigned int buflen;
 	DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
+	DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
 	struct usb_audio_term oterm;
 	const struct usbmix_name_map *map;
 	const struct usbmix_selector_map *selector_map;
@@ -709,15 +710,24 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
-static int check_input_term(struct mixer_build *state, int id,
+static int __check_input_term(struct mixer_build *state, int id,
 			    struct usb_audio_term *term)
 {
 	int err;
 	void *p1;
+	unsigned char *hdr;
 
 	memset(term, 0, sizeof(*term));
-	while ((p1 = find_audio_control_unit(state, id)) != NULL) {
-		unsigned char *hdr = p1;
+	for (;;) {
+		/* a loop in the terminal chain? */
+		if (test_and_set_bit(id, state->termbitmap))
+			return -EINVAL;
+
+		p1 = find_audio_control_unit(state, id);
+		if (!p1)
+			break;
+
+		hdr = p1;
 		term->id = id;
 		switch (hdr[2]) {
 		case UAC_INPUT_TERMINAL:
@@ -732,7 +742,7 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				/* call recursively to verify that the
 				 * referenced clock entity is valid */
-				err = check_input_term(state, d->bCSourceID, term);
+				err = __check_input_term(state, d->bCSourceID, term);
 				if (err < 0)
 					return err;
 
@@ -764,7 +774,7 @@ static int check_input_term(struct mixer_build *state, int id,
 		case UAC2_CLOCK_SELECTOR: {
 			struct uac_selector_unit_descriptor *d = p1;
 			/* call recursively to retrieve the channel info */
-			err = check_input_term(state, d->baSourceID[0], term);
+			err = __check_input_term(state, d->baSourceID[0], term);
 			if (err < 0)
 				return err;
 			term->type = d->bDescriptorSubtype << 16; /* virtual type */
@@ -811,6 +821,15 @@ static int check_input_term(struct mixer_build *state, int id,
 	return -ENODEV;
 }
 
+
+static int check_input_term(struct mixer_build *state, int id,
+			    struct usb_audio_term *term)
+{
+	memset(term, 0, sizeof(*term));
+	memset(state->termbitmap, 0, sizeof(state->termbitmap));
+	return __check_input_term(state, id, term);
+}
+
 /*
  * Feature Unit
  */
-- 
2.17.1

