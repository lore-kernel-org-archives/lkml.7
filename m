Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B277C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEF9217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="QAGzqLK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbfEXLIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:08:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37832 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390604AbfEXLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:08:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so6215075lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAh5sTUfLqIpXw6XnDPa1VaK8Bc9ulk6b5eIRhj46IM=;
        b=QAGzqLK6WR4AjanSSfDZWs9ZHMTszOZ9CxmYlvkVBWa6b+R0iP6X5FnHBfVOW4HsCJ
         Dkml9rIVF4naBaAFe3CMKolO69WufsL8tB5ncI1QsKDINnlArh+UtOOQKjCPI8HovD0z
         oA/5IQ4ZTD2eJjoyW2TBronTQvzRTHwub/HocuXhCuffvOwh9HnytAtQRu4ZKMTQ2q7J
         vvEgPBUIaCJuKcFKZy99K6lihzvhMRovgnWay9gvlsAJZxADSHH6XpsRbtlAQKLICy/+
         3fENtVB8vf6BKjoZhuHTxLerNVp5SKEPHm2VqoSvOgUkFLA5GhJb/jzuH8lut0qOYCDW
         LQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAh5sTUfLqIpXw6XnDPa1VaK8Bc9ulk6b5eIRhj46IM=;
        b=uLzkoQbEr+lGAImNxUKD/gkJyM9FuBCs/XgooARxbsuqaWxT7VTPlzK/XSqJNGgmDZ
         zIepGODvf0F5eXvIimRjM8e2Zi/puzTQiSI0xCISB80MPDXFOsxX9MnHjE2OCCOuIUxv
         3ZBVZK1dlNBE6S+aotTSnXuC8BzUd4X/04UcH2uPT7gfWgJOBJ+Q4V4Ld6urEM3uC6Zo
         seblFDecub2U4SFmqMzGgTwvL+22rYYEirzjVZmKUD8Jt/LDLVVSu43ATmVeKjBAXotb
         v06Os6FcNO+8OdAPzwzqK5VdyAmqXLG4Z/nvczVQK5AjgtrSJwHXy7/nAc8ob+HCUhLh
         1L4g==
X-Gm-Message-State: APjAAAUw7PfyAEtRKreVNExMOjgpQXCxAIHvU/vZY39npiGaw4kn+fXd
        LySPpTaK3w4Fa+1JWq/N5sAf8AzqTmjsdw==
X-Google-Smtp-Source: APXvYqxT0j/iZqyCj2K7bA4yMbxZBQvW87xsNXRY9jnQBVbo40USBps7+1+5s2igJ24I/Zvu3oqn9w==
X-Received: by 2002:a19:700b:: with SMTP id h11mr5032428lfc.25.1558696091132;
        Fri, 24 May 2019 04:08:11 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x21sm446234ljj.43.2019.05.24.04.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:08:10 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: kpc2000: remove extra blank line in core.c
Date:   Fri, 24 May 2019 13:08:00 +0200
Message-Id: <20190524110802.2953-3-simon@nikanor.nu>
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

Fixes checkpatch.pl check "Please don't use multiple blank lines".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index b464973d12ad..40f65f96986b 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -262,7 +262,6 @@ static int kp2000_cdev_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-
 static ssize_t kp2000_cdev_read(struct file *filp, char __user *buf,
 				size_t count, loff_t *f_pos)
 {
-- 
2.20.1

