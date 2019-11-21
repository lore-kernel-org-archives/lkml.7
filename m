Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB936C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B326720898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TbXcZ93p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKUIPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:15:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32962 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUIPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:15:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so3132100wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppdXOwTCOHJBslqqkHtMotBNjKQr4/HLLSmXIlfKn5I=;
        b=TbXcZ93plWK4bAWJcfLyzxI+4etcs03Szkm7G6rDMa2pHnupYk/f5ga2Vfhzfzliyx
         ouHZRgQebTf9UtelZm+SlPamQadwc0uRFvx+ap51JmuaD2NC68WhdPYaGHHSIiMsbKhf
         YifnYC+f6Byn4RW8XuD46Wowol/uZ62XjGxZCTeUF7nB7PXt4t3B7yuti/GZut0lcFpR
         qWoKOLbernVARfDVvHD7PtVzjcTYL71ySkRwcTfM0FxWnVRJoK1dbfCyqzV6znnzuaSo
         NOefX0QGVkTyi2BaojCKHN7Fp+BoYw/vca4Wjmc6o8hXSO8lla/YyPB37Dt9EQVe4+qA
         Rjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppdXOwTCOHJBslqqkHtMotBNjKQr4/HLLSmXIlfKn5I=;
        b=Z3ubQSEOe/yFIZPKxSG6mvk38PUhiqS8a9qHu5XXsVC9n8yNGE7k3BhUQzHqiEolC2
         ef+UWCHZL55pmp9R4gVm/r/g46hAQC38ybTxOZ6pGE5xwN+Viog6vYs00XApIqfLC4TH
         iJmvLphoyPHUzNv03IiqkNF+ylG7mo+MtIjMlo66bzhIC13GqKTF0uLqaJK54UHMkAVF
         HZ+68wJixssRP57jKjv1cq6HtXr2LcKPPGtZsQxFlGz7SRJBXN/Som+e2f4KHCIXXg/Q
         gD4DisOgU68IPIBz1AlN/vjJPwG0kxHn2wKSeerJxai0BmKQGGIMHCPIdwkOuNwYsl7h
         JeFQ==
X-Gm-Message-State: APjAAAU0//gGx2mflGYBWygGTeFZAcFSSIDj901+afMukNHqqSMximu3
        B5LaDySOLlUPcLZuq6d/2aNVkw==
X-Google-Smtp-Source: APXvYqxnWiDeclOsZiVIDP1hcF7kueSw27gghY0GU9xK2mF7vk5GzQTJof7FeL/1t0shyFSLSwNMbw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr7959566wmj.32.1574324104216;
        Thu, 21 Nov 2019 00:15:04 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id w13sm2315075wrm.8.2019.11.21.00.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 00:15:03 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@redhat.com, airlied@linux.ie, arnd@arndb.de,
        fenghua.yu@intel.com, gregkh@linuxfoundation.org,
        tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/5] agp: remove unused variable size in agp_generic_create_gatt_table
Date:   Thu, 21 Nov 2019 08:14:41 +0000
Message-Id: <1574324085-4338-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following warning:
drivers/char/agp/generic.c:853:6: attention : variable ‘size’ set but not used [-Wunused-but-set-variable]
by removing the unused variable size in agp_generic_create_gatt_table

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/char/agp/generic.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index df1edb5ec0ad..4d2eb0800b2a 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -850,7 +850,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 {
 	char *table;
 	char *table_end;
-	int size;
 	int page_order;
 	int num_entries;
 	int i;
@@ -864,25 +863,22 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 	table = NULL;
 	i = bridge->aperture_size_idx;
 	temp = bridge->current_size;
-	size = page_order = num_entries = 0;
+	page_order = num_entries = 0;
 
 	if (bridge->driver->size_type != FIXED_APER_SIZE) {
 		do {
 			switch (bridge->driver->size_type) {
 			case U8_APER_SIZE:
-				size = A_SIZE_8(temp)->size;
 				page_order =
 				    A_SIZE_8(temp)->page_order;
 				num_entries =
 				    A_SIZE_8(temp)->num_entries;
 				break;
 			case U16_APER_SIZE:
-				size = A_SIZE_16(temp)->size;
 				page_order = A_SIZE_16(temp)->page_order;
 				num_entries = A_SIZE_16(temp)->num_entries;
 				break;
 			case U32_APER_SIZE:
-				size = A_SIZE_32(temp)->size;
 				page_order = A_SIZE_32(temp)->page_order;
 				num_entries = A_SIZE_32(temp)->num_entries;
 				break;
@@ -890,7 +886,7 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 			case FIXED_APER_SIZE:
 			case LVL2_APER_SIZE:
 			default:
-				size = page_order = num_entries = 0;
+				page_order = num_entries = 0;
 				break;
 			}
 
@@ -920,7 +916,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 			}
 		} while (!table && (i < bridge->driver->num_aperture_sizes));
 	} else {
-		size = ((struct aper_size_info_fixed *) temp)->size;
 		page_order = ((struct aper_size_info_fixed *) temp)->page_order;
 		num_entries = ((struct aper_size_info_fixed *) temp)->num_entries;
 		table = alloc_gatt_pages(page_order);
-- 
2.23.0

