Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49401C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173222054F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc3nvB5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHOEgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:36:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34870 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHOEgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:36:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id g17so2560191otl.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 21:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gkJ9/4CSZ9hO3Aj7FMNUqCua5NIMc7cNOEioWbqpfI=;
        b=jc3nvB5ZcIMMeb6t6pAdfEPR/JjjJNIg96nvPsRhj4dIOm7MGut0NoL1JUoIPGZHWz
         bYhyQ3L9iEEOlzZiI4mdJl7HjUJfwvarE8hUaWtM5YeVFOOAy7qRQVxgvYNRUEkGCrJS
         ZV6RNLwR9AhVNkq36qN3CyOSMBX0C/6lSrenUS97WZTP8xlH1PxNvBinkZXw7qVqUlf4
         Xzx+roJWChURtCs2yeBDJrVKDlzMavbmR1tOFMzhWNc1BG5wOGSDEqGayFvT5sZuhaf3
         AxDfRh0PJ9SvV3PENcOdcuPouLsEeWM5iRHvvOsIPCVbMz8eQxHIHcxzTtCcTFFvVRk+
         Z2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gkJ9/4CSZ9hO3Aj7FMNUqCua5NIMc7cNOEioWbqpfI=;
        b=slLWHHLIMiQFoWsXBfFNOdCVJM3wdhjrJYjIu0eff+z86OTtRX8B7wVSAPLQ+n1UIW
         2WDCHs3OFvCmqE2kHe+f4OHYTtnsCcC+fCy4yGxJA1eu0bUhO3aFHu1obQ2i1sPIe0OA
         WOxrFrQNo7apmpb62BRXlNT2vTtTZ8J4H5vDCxubL/yUShPY2uIebfWM1YzTci0TE19/
         Hixr5hdLOXVxcqiMrrGv/ZwNNX+qshkXM1KCh+/js84cNjRsfbDTskE98F2pfS9jB5br
         /jJFWpQjWKqXQeKR+NuxSNy7FtbXpspgnRucmxNe41CZX/acfjsbHHU6u/IiNd+DAX77
         SKkw==
X-Gm-Message-State: APjAAAUZWiZ9L5y2+yCCmDdp6LDbijgkYyugFaarfiNnJ/LY5QrweJIo
        n7ulX3MBo7iOEN0EUz5uMvE=
X-Google-Smtp-Source: APXvYqx6ut8hlUWZSU2LFZIuV11ddpYwSGIcPG/5VDT7er30Sm7CgTv9xqhl75MNKGUVrcRRZZQZ3A==
X-Received: by 2002:a5d:9d43:: with SMTP id k3mr3259887iok.111.1565843771651;
        Wed, 14 Aug 2019 21:36:11 -0700 (PDT)
Received: from peng.science.purdue.edu (cos-128-210-107-27.science.purdue.edu. [128.210.107.27])
        by smtp.googlemail.com with ESMTPSA id x11sm3643219ioh.87.2019.08.14.21.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 21:36:11 -0700 (PDT)
From:   Hui Peng <benquike@gmail.com>
To:     security@kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wenwen Wang <wang6495@umn.edu>,
        Allison Randal <allison@lohutok.net>,
        YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix a stack buffer overflow bug check_input_term
Date:   Thu, 15 Aug 2019 00:35:49 -0400
Message-Id: <20190815043554.16623-1-benquike@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`check_input_term` recursively calls itself with input
from device side (e.g., uac_input_terminal_descriptor.bCSourceID)
as argument (id). In `check_input_term`, if `check_input_term`
is called with the same `id` argument as the caller, it triggers
endless recursive call, resulting kernel space stack overflow.

This patch fixes the bug by adding a bitmap to `struct mixer_build`
to keep track of the checked ids by `check_input_term` and stop
the execution if some id has been checked (similar to how
parse_audio_unit handles unitid argument).

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ea487378be17..1f6c8213df82 100644
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
@@ -782,6 +783,8 @@ static int check_input_term(struct mixer_build *state, int id,
 	int err;
 	void *p1;
 
+	if (test_and_set_bit(id, state->termbitmap))
+		return 0;
 	memset(term, 0, sizeof(*term));
 	while ((p1 = find_audio_control_unit(state, id)) != NULL) {
 		unsigned char *hdr = p1;
-- 
2.22.1

