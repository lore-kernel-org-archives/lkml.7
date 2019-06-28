Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F9F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683022;
	bh=I8BsnMtTgMubzxxoGR4e6AEXSX4PVM/cEuKWxos/uqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T2jDBuEzjOPvhyQJY0lw9gRsxqe9ep82TfXcsVBE2KXf+VXymyO1Xe2Gx+P/jURUR
	 2+zSFjLjicVD/EHKl3ST/ucJQZI/HIBZqfOjhkZ1kvFgr0LBYNyKS4ELsOtbAyznKt
	 +Q+TxgFlz9aR5dFhT9GyuaBNTguD3f9gEyBl4lX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF1AuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46231 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfF1AuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so2043833pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5YuFi6wQz815HLumeYih2vZ7yJGUUzK81KZ4UHpdkE=;
        b=RghZw8n210WBhiaFlhN7k2BtDESAm4YCYVrRd7RYKd4G/iu+Ki3Cpuj9f/MzfdEteY
         ZOQBQ9zyH66f4EcKU9Us2muctDIJhBNLZRAd937mbwtKVP4bLdQQzvEU+Bjkd5kGpz4n
         1uEiPzXt90gpQ75ipPf0h5JYeCW+Qkc+PInMOMRbd3MTibZJ3rOm5BN63tx3fPcS5cZu
         ZkMwz+pgiGpzawC8zkgksrNh8XwPZnuFCeepvBv/satXCAv05cYDlO2BOs+j02ptzTaf
         01uwiWP18nnOY49ASY/aFaaygaUtwq4CdQpPGxHcvfGf39bIY5IwnAlXZBY+ZRRV9S5x
         IQag==
X-Gm-Message-State: APjAAAX9YQQbuJQ+GwGzIOcBj28vCWBBmR4SVjGB1uRrMJCl+Q6tbx00
        akqHq6RLffnEMRZSgO2iGHL4eg==
X-Google-Smtp-Source: APXvYqxsYnA1syozsfK0rSE+AAruFi3hspGXjnsXOpnbU/0EQNXN73FE9GR0RH5JOn0z34Ftgtlvsg==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr9628988pjv.118.1561683018485;
        Thu, 27 Jun 2019 17:50:18 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id v27sm280406pgn.76.2019.06.27.17.50.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:17 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>
Subject: [PATCH 02/15] fpga: dfl: fme: remove copy_to_user() in ioctl for PR
Date:   Thu, 27 Jun 2019 17:49:38 -0700
Message-Id: <20190628004951.6202-3-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

This patch removes copy_to_user() code in partial reconfiguration
ioctl, as it's useless as user never needs to read the data
structure after ioctl.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index d9ca9554844a..6ec0f09e5994 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -159,9 +159,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	mutex_unlock(&pdata->lock);
 free_exit:
 	vfree(buf);
-	if (copy_to_user((void __user *)arg, &port_pr, minsz))
-		return -EFAULT;
-
 	return ret;
 }
 
-- 
2.22.0

