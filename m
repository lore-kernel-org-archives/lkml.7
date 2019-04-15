Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCDEC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7D20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVFpq5LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfDOU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:27:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45645 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:27:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so1230150otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gZo3DY3dSvEckoNYG/hjRK2tXSPUoU+I5ol6U8sAJCw=;
        b=RVFpq5LG3IhT1DCY5DuYRDprrHZ4hkRNSdUXQZ16GXzIBpVNcEGc2iVMr6TWd5c5Bh
         OLJ5e8iSr5Mq+Z61rtxLALMXn0YIBLlHEpsRwJ6Rcu4htyiTEOT2ZVsoinNY3TG9COs7
         PWKNlu+rxO7xt6xHwAN46GKZwKz1buK2jRddJmCXpLvE+69ll6hzX8U4BvhI1ZivZztn
         4F/Wrp233zYFvll3Tfpnr0oALoI48JW315PgYlGJYciyz8yuSAg1idWg8+OJR7Jpc7EE
         zPWW+wSFA9KKw0+EbX7VtFlpKidTpQqYdFJ0+XBSOoUL775Lp5HDmtRJAs60vdthQQcN
         l3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gZo3DY3dSvEckoNYG/hjRK2tXSPUoU+I5ol6U8sAJCw=;
        b=r18QMM6Vspx1SxGRuCGD0bzVq1FUnjovIdrhAwQ9hPVD9TZqB1xaluAKemAFlxRorH
         a/XlEFnutCR2ASDfTn7pZg0IFJ69cyN2NuzCMMyW/HMqbjsHE+U550rNQKNvlG0ywmpT
         +fXGdg8hWeQEnekWelE7CCLY+5IVh3i674/3CtxzEtMEQvqA1uTofzKgAPw/Q9pvqexv
         v3oN0vet5H2GWeTmMU81dbGkzEJHQaaBqh/uLXOZVo52l9DVHq4V+9aIiW02+7uM6iRC
         m4dnZquk7Exc9cpiitz0afnZI1WmUC0AZQYNRi0ZAzlBImgqiRbjvSOygN3Oi/G20bqV
         E0cg==
X-Gm-Message-State: APjAAAXgUHFlk39D5XLuEcLTIMC1NXlkEqaBMIUDKOXEezcIPwa7AP6F
        aOiQ0Y+ZqV84N57nCFKICW53NE/4ETs=
X-Google-Smtp-Source: APXvYqwtniSzC31fqRPDPkj4NiLS7FveFDGBJixnGpOYZ98lJaskCOsVenS2AeWVWdW9i6A32jSdfQ==
X-Received: by 2002:a9d:76d5:: with SMTP id p21mr45794418otl.308.1555360034037;
        Mon, 15 Apr 2019 13:27:14 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:95f5:9dbc:648:48d7])
        by smtp.gmail.com with ESMTPSA id n16sm18617354oic.7.2019.04.15.13.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 13:27:13 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH 2/3] Staging: rtl8723bs: Remove typedef in struct ieee_param
Date:   Mon, 15 Apr 2019 15:27:03 -0500
Message-Id: <6d39bc36c9d73455f9bce46ec3bc9c91d46457d4.1555358247.git.madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1555358247.git.madhumithabiw@gmail.com>
References: <cover.1555358247.git.madhumithabiw@gmail.com>
In-Reply-To: <cover.1555358247.git.madhumithabiw@gmail.com>
References: <cover.1555358247.git.madhumithabiw@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in struct ieee_param, as the struct that
has elements that can reasonably be directly accessed
should never be a typedef.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 8077465402c6..1327728e6dff 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -202,7 +202,7 @@ enum NETWORK_TYPE
 #define IsSupportedVHT(NetType) (((NetType) & (WIRELESS_11AC)) ? true : false)
 
 
-typedef struct ieee_param {
+struct ieee_param {
 	u32 cmd;
 	u8 sta_addr[ETH_ALEN];
 	union {
@@ -240,7 +240,7 @@ typedef struct ieee_param {
 			u8 buf[0];
 		} bcn_ie;
 	} u;
-}ieee_param;
+};
 
 struct ieee_param_ex {
 	u32 cmd;
-- 
2.17.1

