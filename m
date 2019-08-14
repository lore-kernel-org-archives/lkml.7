Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E213C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608CA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4jfsXx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfHNChK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:37:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36343 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfHNChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:37:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so46811218otr.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 19:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hV2pKWlMxnhaypGzns6kJSRcp18KAhjsh92Ko5vM2dU=;
        b=s4jfsXx+Cq+klsDPXG+/AvuC0BYDeQjlCJgMXkRlH6uOTDU0uk3KDxxap7JNbXYqZn
         5wymoRYTTpTBAFjfHQvCHNtf9pA6e+DA34DFVNR5sVBCPQFulY4qlafhcJ3i0mh3iw4B
         QsMATqQdvXL/I3B1lqcuI7SeJ4CJL6cnKGVO+o5QfK3rNkM9Zf+gqu6dKGh4UTYoZYKt
         GacMgdbyQQFh+EqCKftFmQJTn9nhX87zjEC6HuvAsaA3wVebgOlYuggqskABTeS8/W+F
         8KWzyETW2o8SuHJQUocXaSek2bkbt8LRpIrGaPk6kJVPttyR+yAaLh39j1WvDavSedYp
         jT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hV2pKWlMxnhaypGzns6kJSRcp18KAhjsh92Ko5vM2dU=;
        b=gWuvZAtODz2b7BkCiRk7acGpcozFk5CefUe3a5UMVOkPkGRS56E7bCOxWwVyn/d+ZB
         OZAbfFxdXFifjJvIsHCG6AW3eIf5IO9QQNy4Oti7uhf0+BhruvaaNhmHvWbPzrSYms1t
         R4qGqllfOlSzi2zCEMiQ/w9xcgNO5ffx+LCG321gBUTqqyZpP2wSRsMlLA//tf0sts1i
         aJDKn6decEPb+YGg3OAwaTjs4vx+kpgX0sv9GHhdfXp3mW14cW8jZN38n/UrZmjhhBZ/
         GlGpBrRLZKCzMVvTgZ5FNvR3xjOfQYqG+6UDIGGr/5VB0UsUSmXrscfkg7rsCFL+R4Cq
         xKJA==
X-Gm-Message-State: APjAAAWxFiF0OJZcJAgAEdqgrpK2kr3K7mBAgVI159Pbf7nMRQFE5qBh
        e1WUdrfHbchmXXDzLjv26QY=
X-Google-Smtp-Source: APXvYqwCm95c1dn4xfbMaEyHxx8PGMDXqkcsKW7lYisFSX5mPMe4ewDWvMLmZIc03W0kaSBlbWSJSQ==
X-Received: by 2002:a5e:c911:: with SMTP id z17mr13586768iol.119.1565750227338;
        Tue, 13 Aug 2019 19:37:07 -0700 (PDT)
Received: from peng.science.purdue.edu (cos-128-210-107-27.science.purdue.edu. [128.210.107.27])
        by smtp.googlemail.com with ESMTPSA id y19sm14805008ioj.62.2019.08.13.19.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:37:06 -0700 (PDT)
From:   Hui Peng <benquike@gmail.com>
To:     security@kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Wenwen Wang <wang6495@umn.edu>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix an OOB bug in parse_audio_mixer_unit
Date:   Tue, 13 Aug 2019 22:36:24 -0400
Message-Id: <20190814023625.21683-1-benquike@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `uac_mixer_unit_descriptor` shown as below is read from the
device side. In `parse_audio_mixer_unit`, `baSourceID` field is
accessed from index 0 to `bNrInPins` - 1, the current implementation
assumes that descriptor is always valid (the length  of descriptor
is no shorter than 5 + `bNrInPins`). If a descriptor read from
the device side is invalid, it may trigger out-of-bound memory
access.

```
struct uac_mixer_unit_descriptor {
	__u8 bLength;
	__u8 bDescriptorType;
	__u8 bDescriptorSubtype;
	__u8 bUnitID;
	__u8 bNrInPins;
	__u8 baSourceID[];
}
```

This patch fixes the bug by add a sanity check on the length of
the descriptor.

Signed-off-by: Hui Peng <benquike@gmail.com>
Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
---
 sound/usb/mixer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7498b5191b68..38202ce67237 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2091,6 +2091,15 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 	struct usb_audio_term iterm;
 	int input_pins, num_ins, num_outs;
 	int pin, ich, err;
+	int desc_len = (int) ((unsigned long) state->buffer +
+			state->buflen - (unsigned long) raw_desc);
+
+	if (desc_len < sizeof(*desc) + desc->bNrInPins) {
+		usb_audio_err(state->chip,
+			      "descriptor %d too short\n",
+			      unitid);
+		return -EINVAL;
+	}
 
 	err = uac_mixer_unit_get_channels(state, desc);
 	if (err < 0) {
-- 
2.22.1

