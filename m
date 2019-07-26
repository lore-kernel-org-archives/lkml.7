Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D2C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E599022C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+5weXap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGZCOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:14:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39783 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfGZCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:14:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so24164488pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=omBls9Gx4bP4rqZZvHf2qg7ZHRKve5iFfEyz6IL0Sek=;
        b=L+5weXap3F/aUB3dU/dLA+E47mrqkGreRpNSO0P4EFp34DviXxVckUNAji93YEXOrK
         HaXiMFlzinZ1Ps+NCoJ+hMG9sIwJJyJm/PzOok2v1rnIamul1CNL0fjm0MUIGlLhpxSb
         g+c2f/hrtp3AoRTqU4Z0QrXkbM0IUSQr0Lm4Zztarg2M6/UgVLVwCJhRMnTOSc4P5wFm
         3+XHFE6MdqFXDzfFKidY+d8i5f8F7LEHmKEOAQ1t0Las1rpnsalyj0HJLZZeBsVfxXai
         J6x1DEySm84MM/MLR9GOgWy2utfArMn2CBkWLzlmTKJetppAHmDK0VkjzznOnj2R5GyV
         vjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=omBls9Gx4bP4rqZZvHf2qg7ZHRKve5iFfEyz6IL0Sek=;
        b=PdXctl3Geb3uRGvYDc3j/QQxt7fbLEv5vHENGQ2JTQFUHteNDAM6C2z12LSQWU9Hiq
         UOn8n1s1fICRlxiXGJGOebex6DqgYemLPjwGmAMwvDdtjq7CMofFWe22yuFZ5s4XkGB/
         VlKNcgEhmGSzObj7eSHbUUN2FiApH0ow13bqr/OkUEy05Z2Zp596/rClR5NwYr+ypl66
         Xd1LljSjo252zevAXmt6Gg6luddKPufe9qKzchLH6aYbcPck1rbbdi4jtqyG/32Utui0
         W9rm7g32wSQS2KRoWjJb++e58G4D6i4Jnoy+0pljZFUPCvhnC/Wx+h8MiTG50IcWXkUb
         KfwA==
X-Gm-Message-State: APjAAAU+wZC59QuLPJBIgY0XSTJIik6oQ81ngH3GL529SnIuM83LrCzK
        wOZQHb+b91Y1S9BLmcZdMdjmJsz84II=
X-Google-Smtp-Source: APXvYqzhtWZULLiTvGVlGqmQlDUERIrGC3/w9xnlHbHonHpzpbFCDrgdVCtDSTQxnMeQWP0657yc/A==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr9939058plu.343.1564107293936;
        Thu, 25 Jul 2019 19:14:53 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id y128sm69564365pgy.41.2019.07.25.19.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 19:14:53 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, tglx@linutronix.de,
        rfontana@redhat.com, gregkh@linuxfoundation.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] ALSA: i2c: ak4xxx-adda: Fix a possible null pointer dereference in build_adc_controls()
Date:   Fri, 26 Jul 2019 10:14:42 +0800
Message-Id: <20190726021442.21177-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In build_adc_controls(), there is an if statement on line 773 to check
whether ak->adc_info is NULL:
    if (! ak->adc_info ||
        ! ak->adc_info[mixer_ch].switch_name)

When ak->adc_info is NULL, it is used on line 792:
    knew.name = ak->adc_info[mixer_ch].selector_name;

Thus, a possible null-pointer dereference may occur.

To fix this bug, referring to lines 773 and 774, ak->adc_info
and ak->adc_info[mixer_ch].selector_name are checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Fix the errors reported by checkpatch.pl.
  Thank Takashi for helpful advice.

---
 sound/i2c/other/ak4xxx-adda.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 5f59316f982a..b03e6d1be656 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -775,11 +775,12 @@ static int build_adc_controls(struct snd_akm4xxx *ak)
 				return err;
 
 			memset(&knew, 0, sizeof(knew));
-			knew.name = ak->adc_info[mixer_ch].selector_name;
-			if (!knew.name) {
+			if (!ak->adc_info ||
+				!ak->adc_info[mixer_ch].selector_name) {
 				knew.name = "Capture Channel";
 				knew.index = mixer_ch + ak->idx_offset * 2;
-			}
+			} else
+				knew.name = ak->adc_info[mixer_ch].selector_name;
 
 			knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 			knew.info = ak4xxx_capture_source_info;
-- 
2.17.0

