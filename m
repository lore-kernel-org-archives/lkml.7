Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F65C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19824100
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="W5j4zwKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2Tmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:42:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44631 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Tmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:42:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id e13so3669615ljl.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15FB7VWNTS09jOnKS7kZ1lxWffgJJH8elfqUbjMzIek=;
        b=W5j4zwKb9VnXxdkr6VCOXw01H3xP+Drolc6weYEBYi1SSl5fMA7WPay5KzfRe27+nS
         UUEGUKnMBYlAP193V62aNMxwa5A3IixqGZgYlGUkLBXwGnyiY5j49KX9T56RfwvTIGFm
         aBb9oOYAvZdEXYPatPJnirigsmFJ6zKcKNwT2x54Iu4M2JQxSKBI6FJU9Y5InZTZ5DbD
         StAUqmYTcHH0Kd5nnC24XL3M71Ibf3uCk5FXWCutOspBG1/WD7Z2XAI/r9gEo+kcd5lc
         Y+royAcZQ1UzR9jXbjFmHyIc93mySXzVBWNZZQ9m5KyLgPHeeBhzlL7LMIl7aDBjDRQY
         SYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15FB7VWNTS09jOnKS7kZ1lxWffgJJH8elfqUbjMzIek=;
        b=YLQbw2LyQgtDgNfxJlVa0nGmgAQgtjylIF4vqXnGl4yOkboxdmaPh3Ectnw6sHagxt
         5+ediBD2GYbNkNNNjy1/Fz6kH+P41L51rF+AFsCAfXq5IEJbPt5015Pj9TSqsuZnxJDS
         TbvYzmvGaJN8EoSlLqR3BifDBuaJ609O5GCj9x6OecApqsSTa6a8e7wxkytTuUb9TsoV
         VUhf/xSAJSLRmaRpShsn1lJxElS6vgDcYQqi94n9l1iSm3nsUhGbmA24Fn8sbhlVLGyX
         scq6Y/7vDbjCl/JExsnRwH5zudB1k7LDq7b9SydzepQzl9XpYokqNJa3MoaqwxsXgICq
         eUwA==
X-Gm-Message-State: APjAAAVPpQPR+WnGbT8zUcQ81vi3UKu88Az32wSPC80+vj7cucGEhGi1
        YevOO1xL4Cal5RycDjsb3kRLaA==
X-Google-Smtp-Source: APXvYqxA0lxab6Nu0SnqoWH9AnjYE6KgXIbGd4+maWc2k1YB44uaXwmkoYZBDi+B/giCmDI6RB4xUg==
X-Received: by 2002:a2e:8587:: with SMTP id b7mr59051396lji.101.1559158949520;
        Wed, 29 May 2019 12:42:29 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id l18sm29731lja.94.2019.05.29.12.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:42:28 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, simon@nikanor.nu, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: replace bogus variable name in core.c
Date:   Wed, 29 May 2019 21:42:22 +0200
Message-Id: <20190529194222.9048-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"struct kp2000_regs temp" has nothing to do with temperatures, so
replace it with the more proper name "regs".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 4110032d0cbb..11ac57e31d45 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -314,24 +314,24 @@ static long kp2000_cdev_ioctl(struct file *filp, unsigned int ioctl_num,
 	case KP2000_IOCTL_GET_PCIE_ERROR_REG:       return readq(pcard->sysinfo_regs_base + REG_PCIE_ERROR_COUNT);
 
 	case KP2000_IOCTL_GET_EVERYTHING: {
-		struct kp2000_regs temp;
+		struct kp2000_regs regs;
 		int ret;
 
-		memset(&temp, 0, sizeof(temp));
-		temp.card_id = pcard->card_id;
-		temp.build_version = pcard->build_version;
-		temp.build_datestamp = pcard->build_datestamp;
-		temp.build_timestamp = pcard->build_timestamp;
-		temp.hw_rev = pcard->hardware_revision;
-		temp.ssid = pcard->ssid;
-		temp.ddna = pcard->ddna;
-		temp.cpld_reg = readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG);
-
-		ret = copy_to_user((void*)ioctl_param, (void*)&temp, sizeof(temp));
+		memset(&regs, 0, sizeof(regs));
+		regs.card_id = pcard->card_id;
+		regs.build_version = pcard->build_version;
+		regs.build_datestamp = pcard->build_datestamp;
+		regs.build_timestamp = pcard->build_timestamp;
+		regs.hw_rev = pcard->hardware_revision;
+		regs.ssid = pcard->ssid;
+		regs.ddna = pcard->ddna;
+		regs.cpld_reg = readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG);
+
+		ret = copy_to_user((void*)ioctl_param, (void*)&regs, sizeof(regs));
 		if (ret)
 			return -EFAULT;
 
-		return sizeof(temp);
+		return sizeof(regs);
 		}
 
 	default:
-- 
2.20.1

