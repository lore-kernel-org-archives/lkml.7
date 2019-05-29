Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564AEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BD4205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXiSmLZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfE2NIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:08:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40568 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfE2NIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:08:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so1600712pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyF2JFEuH6LvGGWBbwEbtAeB7cBwyayBLAFyPW57EFQ=;
        b=QXiSmLZrPXsadPi9sgqFl2EmdrtmU6sgqdYwd4DG8RSTTpsHz9yc2PUU5Cxm5KrwPI
         vFNxS+RcwaI6Nrs70EDVi69oSk4kiTk4TS2Das9vJ6Ug6W36sHFT2dueg9e9g2et6B4U
         puFrXwJEQhlel7fKBcfhMEWHgQmXXRh2HWJfZuxYxXjRh25uMy/ZKHBIvyV0wJbQEEEN
         z1PbD82OqNEglKHyKUFk3eyJ8O9YRcyKIFarKHHOflR7R3hBgYl5pBs5olgLNqECDcZ/
         11P+LHLV6vXoTJM5jUHoObRdb0cx0I8V0gY8NIpMLe3LUMdXo2a1QxsP1dS4nMYFS15O
         87mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyF2JFEuH6LvGGWBbwEbtAeB7cBwyayBLAFyPW57EFQ=;
        b=R4foFdRPreDjg6ZXulgNK2OfmTg5C8qIxjua+8RLh1aevm9EnHx1uWVFgkxUmH5vkl
         Pyd1XLzPw1y5R+K9NwrV7iLCFFKQ/Dp0+48ftBpuVfMQNrabihzDMyWaLYwF+o5qbOur
         LUD9xEhOBCFsKGzDb7IcrbpwAyIewdRdC46mG8p8VKx8+lWN51FGVNCHhBpyJrZ0pfco
         ZCUhzVBl9udBF6gQJEcgE1AQdbH8ydcn+bbvbMbgibM81xWcExTK+oIoNnqhAFeM3xP3
         H/lHcRCDNh98xacXvy8fH1AHx/i/iS1Edox5c9auWt6fGZP8dt+VIxux7miNMRCeaEZG
         XI3Q==
X-Gm-Message-State: APjAAAU9JblpgSIWBUftir7jcVcOpsxSIEIvC7dr2DxzXM05ZCMNE+Bf
        0VNjFin78M5EAVDZutMcb64=
X-Google-Smtp-Source: APXvYqxmbxpYuATei5MreKV/zNd37hHzuon8DZgToECLdH8liCI6dxsiFM7Ok6mSGSIGbAJSjXE+2w==
X-Received: by 2002:a17:90a:d3c6:: with SMTP id d6mr11914227pjw.25.1559135333324;
        Wed, 29 May 2019 06:08:53 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id 1sm18289030pfn.165.2019.05.29.06.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:08:52 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, tsotsos@gmail.com,
        igor.stoppa@gmail.com, aaro.koskinen@iki.fi,
        himadri18.07@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: octeon-usb: Remove return variable
Date:   Wed, 29 May 2019 18:38:35 +0530
Message-Id: <20190529130835.6194-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return variable result and return the value directly.
Issue found using Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index aeec16314e0d..cd2b777073c4 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -521,8 +521,7 @@ static void octeon_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
  */
 static inline u32 cvmx_usb_read_csr32(struct octeon_hcd *usb, u64 address)
 {
-	u32 result = cvmx_read64_uint32(address ^ 4);
-	return result;
+	return cvmx_read64_uint32(address ^ 4);
 }
 
 /**
-- 
2.19.1

