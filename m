Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49162C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2091B217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="U9NNSz9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfGVN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:57:59 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34724 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfGVN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:57:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id D427F9BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3QWEY6RK9xKR for <linux-kernel@vger.kernel.org>;
        Mon, 22 Jul 2019 08:57:57 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id AEAFE7D0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:57:57 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id v3so43601497ios.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kVakesV2CvYZvwzJLrv2MoVIkC/dgF99lbHbHv6O6Do=;
        b=U9NNSz9qiMTtAyk7MlpM4DImJC3y78wo2G+1IAHh0xmEu2kWLBbXp8mhyLL2nitquG
         7YzbVpWn1aX1lkYF60rLi/FV8kTlSIL2i4t/O7+2agIGasmz62Ke1AKye/xaZ0vnqywZ
         4wqXIDecPuu0A27k+7Hc3tB5nes9o0mdWHPeAfZ/1AEHiSEs0t2ffvXy1iT9N24wlpww
         LfPsaLdmyWT9TobcNKPR2vanwhaGEDRpbL5P3sbchdQUAhXn0MGcXK4Kp4iNdcWl6F+7
         W6v6Q8Hk8UOfPJ+tYq8mfiIQlA39fGVIjTW4uS3ZWmNZtI1wsOvmBTgZCSREIwCey4Dv
         YqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kVakesV2CvYZvwzJLrv2MoVIkC/dgF99lbHbHv6O6Do=;
        b=gZ0C0HZpT9Fjk07CvW106XD61BO2boVys6aiXCcOh4dRgAXGO0v+7ZbKhCOhkJeg15
         e6kfsi4StrT1OY8OatvxPAqhVGYwXvUa9A2FCSquuKsJ3J4ziRuVyCMRK3z10rj+Ltmx
         8ri5NVTsQuwhPaZigRQ47DhmttP9eqJ+ar6bkGBrzZVUB0Fbq+Ru6uI4ScNePKcHvIbR
         DaD7yvstKBognGQgbg+XIyr9q4riQymS16Z0ZT7bj3xMGhYLznAjBdlUK1F2dZx0eEwq
         WlwEOuPC37xJgz6IAhBes1vANoO+eV9cICCsjFGKwunCsSB8oEitgSPxLiQADiDd7/aj
         d+BQ==
X-Gm-Message-State: APjAAAXMa1Ydyn1wQ8yxRUARtwEbr697swY5sRRnCZsypuZ0UyYScL9g
        lOB041oKV4PrSo8LcRP9DuV0pudopWQ3Ruu+KRP9HTkBXzg5jLA8rFlsoPbT1onNaoBpGNqVB9a
        1DeifewFmWQ058bSHG7m3UorFpRK4
X-Received: by 2002:a6b:6505:: with SMTP id z5mr61900542iob.295.1563803877411;
        Mon, 22 Jul 2019 06:57:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxSV0VUNFzRDvGQhggNhPxAkdfsSabNRwARqBBqvGMqIAHjhSFEIi5DtsjwVuBBJzc2A+mYA==
X-Received: by 2002:a6b:6505:: with SMTP id z5mr61900522iob.295.1563803877257;
        Mon, 22 Jul 2019 06:57:57 -0700 (PDT)
Received: from localhost.localdomain (128-092-121-091.biz.spectrum.com. [128.92.121.91])
        by smtp.gmail.com with ESMTPSA id u17sm36913414iob.57.2019.07.22.06.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:57:56 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: dapm: fix a memory leak bug
Date:   Mon, 22 Jul 2019 08:57:44 -0500
Message-Id: <1563803864-2809-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In snd_soc_dapm_new_control_unlocked(), a kernel buffer is allocated in
dapm_cnew_widget() to hold the new dapm widget. Then, different actions are
taken according to the id of the widget, i.e., 'w->id'. If any failure
occurs during this process, snd_soc_dapm_new_control_unlocked() should be
terminated by going to the 'request_failed' label. However, the allocated
kernel buffer is not freed on this code path, leading to a memory leak bug.

To fix the above issue, free the buffer before returning from
snd_soc_dapm_new_control_unlocked() through the 'request_failed' label.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f013b24..23b9b25 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3706,6 +3706,8 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
 			w->name, ret);
 
+	kfree_const(w->sname);
+	kfree(w);
 	return ERR_PTR(ret);
 }
 
-- 
2.7.4

