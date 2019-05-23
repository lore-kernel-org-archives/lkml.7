Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F652C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D692217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="YUC8gLjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfEWLgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:36:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39201 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbfEWLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id f1so4133631lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N81VduL34DQfMDrcwklUsVpIH+zv/8mLQSEnWzPurkE=;
        b=YUC8gLjRT3RpGd1P5TgxaNiCYI994Q059+IpAjSQEiYFBnlHyMen2ZSJO8DLwhRJd1
         xPdPMZ+fGemuH0rxQCjwq1EuW3H5cdUj95U3jAlAKQ8hV3XGH9IJp51zhDGfoM4pQsrY
         8uyqWEFeYXiznUDqN9D/6Xrl96FI+PjejmIHWZLbcq0Kp+NpBteyg+d+Y3A//NFLnodM
         5rpKLEgSuom6vTsBFE/K5PsLDTKgHJPj7Cl5HxVo4IBgc6n/byyqoAT8TSm6rYlDCE/6
         UFW8hQaI42QgPWM9L9iLWdns0AznlhUFrq2mTSDQbfGPN5LfWYytjBTOS7YA5zz5YEQG
         dIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N81VduL34DQfMDrcwklUsVpIH+zv/8mLQSEnWzPurkE=;
        b=F4lbnF8AOImME1YWKKuoui322Y17YyPso31UjWYYNmtRE1PNY6CGb7Eac19C7euszW
         P8NBYtWVYHO40UMgsgBZ4KFW0h5rxyo+EeC0GCTMxXxqjtFoAjGDiVZM/HB4+x2/esPk
         e8trE+S9ynBQd+wdD8wfi0mK/o7nE0xhRzB317rBdDI1rTLRTEMPafyhAr6xzJYapamy
         cDkUzY6NaPnb1JaxVrNqne/AIgVD3aXDe/pabd7K2O3H1jBQyEldsr014cwKQFYT9hXC
         ZGdgm1TMCzbyHp7WopHQmMnbbfxYtodxGGPYPf6woPeIzvgTF966KJ76L9eMqlhfZrU0
         0BFw==
X-Gm-Message-State: APjAAAV+xs2GyA/9FODHqJmXWIp+kGRzZup7B/t2tGULbqhIniGmujFe
        +1N9Fm09P0+DqeAfqw1c6PUr8Q==
X-Google-Smtp-Source: APXvYqwXNT8B12ktl98j3v3Ee/yAwsO/8sfKR2XyP5+WPd5PTUnOgcdgXNyeIHpX8wKnDEPlmr/gpw==
X-Received: by 2002:a19:700b:: with SMTP id h11mr1359602lfc.25.1558611395583;
        Thu, 23 May 2019 04:36:35 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:35 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: kpc2000: remove extra blank lines in cell_probe.c
Date:   Thu, 23 May 2019 13:36:10 +0200
Message-Id: <20190523113613.28342-6-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings "Please don't use multiple blank lines".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index b621adb712ff..0da41ca17eb7 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -94,7 +94,6 @@ void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, co
 	}
 }
 
-
 static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 			    char *name, const struct core_table_entry cte)
 {
@@ -111,7 +110,6 @@ static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 
 	dev_dbg(&pcard->pdev->dev, "Found Basic core: type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
-
 	cell.platform_data = &core_pdata;
 	cell.pdata_size = sizeof(struct kpc_core_device_platdata);
 	cell.num_resources = 2;
@@ -137,7 +135,6 @@ static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 			       NULL);                  // struct irq_domain *
 }
 
-
 struct kpc_uio_device {
 	struct list_head list;
 	struct kp2000_device *pcard;
@@ -347,7 +344,6 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	return 0;
 }
 
-
 static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_regs_offset, int engine_num, int irq_num)
 {
 	struct mfd_cell  cell = { .id = engine_num };
-- 
2.20.1

