Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D425C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF0F2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494278;
	bh=xXQt8UGofUcuwu2F6gVS6aa86ztULV+z4Wq+Gjv1c0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivgT2yHqfCYaIyLtddDf9m9HnNpbuihBoXocnPLEO3gBjFCuGmBDxsLWcAuy4+AOd
	 aXYYlrjvAeeK2xxVSyUPxXiatHZw6oXQJF4nWVgyJn8mX9JULXkVZRClooqFRXdHlo
	 SRfI24Pmpw5xHek1Blrk6j8gZcq8l5NoZIJHnhrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbfHVRRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390308AbfHVRIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:25 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614872341D;
        Thu, 22 Aug 2019 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493704;
        bh=xXQt8UGofUcuwu2F6gVS6aa86ztULV+z4Wq+Gjv1c0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTFmOhqKy6jCmTOAgjPPKHbmA7mhNUMzQQuLz93raEeoDXVL5qAPAL6TfMdc2RtZZ
         704vshF38/qvispwpkT/EjQVGXrG0QleuM4kZVcMy2U0IB1Rhx8pK+llZU0TR/P5k2
         ihPHbpYbs5jnVaA923to5ZMB+5XvJ8XVaqn8yUSE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 018/135] ALSA: usb-audio: Fix a stack buffer overflow bug in check_input_term
Date:   Thu, 22 Aug 2019 13:06:14 -0400
Message-Id: <20190822170811.13303-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Peng <benquike@gmail.com>

commit 19bce474c45be69a284ecee660aa12d8f1e88f18 upstream.

`check_input_term` recursively calls itself with input from
device side (e.g., uac_input_terminal_descriptor.bCSourceID)
as argument (id). In `check_input_term`, if `check_input_term`
is called with the same `id` argument as the caller, it triggers
endless recursive call, resulting kernel space stack overflow.

This patch fixes the bug by adding a bitmap to `struct mixer_build`
to keep track of the checked ids and stop the execution if some id
has been checked (similar to how parse_audio_unit handles unitid
argument).

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7498b5191b68e..2051a64fa2904 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -68,6 +68,7 @@ struct mixer_build {
 	unsigned char *buffer;
 	unsigned int buflen;
 	DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
+	DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
 	struct usb_audio_term oterm;
 	const struct usbmix_name_map *map;
 	const struct usbmix_selector_map *selector_map;
@@ -773,16 +774,25 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
-static int check_input_term(struct mixer_build *state, int id,
+static int __check_input_term(struct mixer_build *state, int id,
 			    struct usb_audio_term *term)
 {
 	int protocol = state->mixer->protocol;
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
 
 		if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
@@ -800,7 +810,7 @@ static int check_input_term(struct mixer_build *state, int id,
 
 					/* call recursively to verify that the
 					 * referenced clock entity is valid */
-					err = check_input_term(state, d->bCSourceID, term);
+					err = __check_input_term(state, d->bCSourceID, term);
 					if (err < 0)
 						return err;
 
@@ -834,7 +844,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC2_CLOCK_SELECTOR: {
 				struct uac_selector_unit_descriptor *d = p1;
 				/* call recursively to retrieve the channel info */
-				err = check_input_term(state, d->baSourceID[0], term);
+				err = __check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
 				term->type = UAC3_SELECTOR_UNIT << 16; /* virtual type */
@@ -897,7 +907,7 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				/* call recursively to verify that the
 				 * referenced clock entity is valid */
-				err = check_input_term(state, d->bCSourceID, term);
+				err = __check_input_term(state, d->bCSourceID, term);
 				if (err < 0)
 					return err;
 
@@ -948,7 +958,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC3_CLOCK_SELECTOR: {
 				struct uac_selector_unit_descriptor *d = p1;
 				/* call recursively to retrieve the channel info */
-				err = check_input_term(state, d->baSourceID[0], term);
+				err = __check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
 				term->type = UAC3_SELECTOR_UNIT << 16; /* virtual type */
@@ -964,7 +974,7 @@ static int check_input_term(struct mixer_build *state, int id,
 					return -EINVAL;
 
 				/* call recursively to retrieve the channel info */
-				err = check_input_term(state, d->baSourceID[0], term);
+				err = __check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
 
@@ -982,6 +992,15 @@ static int check_input_term(struct mixer_build *state, int id,
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
2.20.1

