Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6FC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4F21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="UKvbwE9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390942AbfEXLIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:08:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42266 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390819AbfEXLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:08:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so8272646ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BrNHORCd/DxvHapwA+VYnwfAJG4jUky2f2ZEQG38ko=;
        b=UKvbwE9kCp1HUEQTbws9yp/ghVEvXHBxX1y0F1mIrRD5nq3qdJeFGlU9L68XEwET9P
         8xFU/86adUUBycbF8UadcPfCWOKgILWKlrSqOd4tPvaspIACy2oZv39q5oip7ykFGw7A
         SWba1i93yBWZk8WheaSFX1Ob30bDxdGw7XezhYohapdWIDylLY1474zHsALWYGRliM1z
         fV3Wsod9hqyVqqY+94R/VGAt46fhATrfHU2WigSMV9QGbdSovw0YeDs8JhUKul7Ut4TF
         uuL1dmHrS6FiB16COb9BnXLhgIs7TWxbKxwoGGzc1n9lO0nbxdYQfvT2OSyM803LjK2e
         d6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BrNHORCd/DxvHapwA+VYnwfAJG4jUky2f2ZEQG38ko=;
        b=SmLtf9M5p+68/fShYddXftTcRRHIe61DAWcKwCieHqmGS7zb9HkXpjIEOzL7zJy0Qc
         l4GsFwXHmDteZuknbKXFr/hExLDSboxZdkj4rgELeZQc6TNwhtLQAUvafQb+U+HXark+
         Ud+6f3wiFX5LFoNe0q6J8QHuYgnq03nBoW9zH3lgOvvlouck+bjSjUcxR/TivJgrV+xZ
         TiR2Bc/VS+ZTuI8/5+VLIErIB84u7z+EPI0Qf4Wni+t2gwTFAGikBU9En+HTiWsj6fze
         uLr3WWtGFokpABbEk0K1y9xEqVBxAe9AHYzhFnorIEAs/E+EWSKoINcp8zLiQP4/dyCx
         0w+g==
X-Gm-Message-State: APjAAAX//7b69QHvKxwpU+P4N86/6tVxh/q5lioao1oLRCBm8tubIryj
        nbh3our0+gQ+l6G5SnEuwiykTA==
X-Google-Smtp-Source: APXvYqyrecsKqyGlJQlmylwAOIU++VYjUMqUOgeIFIWDM4P26pdc1cdLK+UT6ovGhvV82YASFPv+Iw==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr38744971ljw.153.1558696092014;
        Fri, 24 May 2019 04:08:12 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x21sm446234ljj.43.2019.05.24.04.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:08:11 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: kpc2000: add missing spaces in core.c
Date:   Fri, 24 May 2019 13:08:01 +0200
Message-Id: <20190524110802.2953-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524110802.2953-1-simon@nikanor.nu>
References: <20190524110802.2953-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl errors "space required before the open brace '{'"
and "(foo*)" should be "(foo *)".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 40f65f96986b..bb3b427a72b1 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -308,7 +308,7 @@ static long kp2000_cdev_ioctl(struct file *filp, unsigned int ioctl_num,
 
 	dev_dbg(&pcard->pdev->dev, "kp2000_cdev_ioctl(filp = [%p], ioctl_num = 0x%08x, ioctl_param = 0x%016lx) pcard = [%p]\n", filp, ioctl_num, ioctl_param, pcard);
 
-	switch (ioctl_num){
+	switch (ioctl_num) {
 	case KP2000_IOCTL_GET_CPLD_REG:             return readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG);
 	case KP2000_IOCTL_GET_PCIE_ERROR_REG:       return readq(pcard->sysinfo_regs_base + REG_PCIE_ERROR_COUNT);
 
@@ -326,7 +326,7 @@ static long kp2000_cdev_ioctl(struct file *filp, unsigned int ioctl_num,
 		temp.ddna = pcard->ddna;
 		temp.cpld_reg = readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG);
 
-		ret = copy_to_user((void*)ioctl_param, (void*)&temp, sizeof(temp));
+		ret = copy_to_user((void *)ioctl_param, (void *)&temp, sizeof(temp));
 		if (ret)
 			return -EFAULT;
 
-- 
2.20.1

