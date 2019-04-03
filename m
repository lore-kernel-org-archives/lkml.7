Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA32C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2CC2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm5YMJ8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCAtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:49:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43963 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDCAtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:49:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so17317228qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPTC/9nTLoMKUo9Bwyy0AbQrXQ0DJB6Yw5p/VadjnpI=;
        b=nm5YMJ8C4NO8jDnytRxzndIvV2eDskTnnkFclx03h2ciIX2F7OEe4yHOzdGv3BJFDZ
         G/6bzVvh+LaC+Fbe1jTqgsEiyDf8F+401pJk5zT2ZSGBdcdA4WicITVe4zI6UxhsSEeo
         hkpt0KdFVHc9Oqor5NVVE/wVZsd9Pi+hVMidyRjdqXGZlf1bxwtlVREFGApZK1Rh/2BW
         JS19XSUNr3WmhGbp9bs2ZpSw6nmpgwXcZUExbyaszixSebvx7Hxt/GQpXYt06UocP5GN
         UufyQzE6us/2NxVHHBcNwVkSp7VlSwq/64F3Z6CBotI8X6tWCeAylxBrJyHJWr4JP4pB
         5Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPTC/9nTLoMKUo9Bwyy0AbQrXQ0DJB6Yw5p/VadjnpI=;
        b=piCKNV0Ac4n4fQqduwP0coHJaFt3xv2Jc/LIcrgoyZVSDxiVuGSnBvtRcGvQ4a0KHP
         hLR9mEl0T0TpPTQtmzqrwgzxuuzmrMGr//z4/TNwp8ra22o8217WXfNk6Baz3MEoTnQm
         OySF8o1fYwBb/JIGdluIrxX0KLzZazDhKYsQo4tKlJ14lGy3roXVm0Bn8B9RO6273U5i
         KLf4XsbOM0f60EuDo0XPtG6KyIpKbq0CYzQL6Bfdk2LbLN0vCdxnbF57GcHfuRkcXl9X
         mrrsDFYo4QxSPbjDEX5Zh0GLznXwekejVo27Vh956eYWRZNWc+9Eoe5wHFinn6CEXUOx
         FWBg==
X-Gm-Message-State: APjAAAVQrtubVwzFqoxBKTsXfiPr8DUHUyd20/yEmKA8Qlwb/OEVTB4b
        MTqofSc1/u9yI2DHt4lKpQs=
X-Google-Smtp-Source: APXvYqw3XcABIFjCCwFY9x1Dp1KgrIOwZ0yFW/iQd1PcRfhn0f3a/RGcdBRy7B4G+eSrgxqJLe0wkQ==
X-Received: by 2002:ac8:2427:: with SMTP id c36mr62658209qtc.124.1554252554301;
        Tue, 02 Apr 2019 17:49:14 -0700 (PDT)
Received: from taquaral.ic.unicamp.br (wifi-177-220-85-131.wifi.ic.unicamp.br. [177.220.85.131])
        by smtp.gmail.com with ESMTPSA id l22sm7113235qkk.83.2019.04.02.17.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 17:49:13 -0700 (PDT)
From:   =?UTF-8?q?Hildo=20Guillardi=20J=C3=BAnior?= <hildogjr@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hildogjr@gmail.com,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] Staging: rtl8192e: Fix spaces around "+"
Date:   Tue,  2 Apr 2019 17:48:53 -0700
Message-Id: <20190403004853.10194-1-hildogjr@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error:
CHECK: spaces preferred around that '+' (ctx:VxV)
99: FILE: drivers/staging/rtl8192e/rtllib_module.c:99:
+	memset(ieee, 0, sizeof(struct rtllib_device)+sizeof_priv);

Signed-off-by: Hildo Guillardi Júnior <hildogjr@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index cdf4c9060c51..a19b56320f2e 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -96,7 +96,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 		return NULL;
 	}
 	ieee = (struct rtllib_device *)netdev_priv_rsl(dev);
-	memset(ieee, 0, sizeof(struct rtllib_device)+sizeof_priv);
+	memset(ieee, 0, sizeof(struct rtllib_device) + sizeof_priv);
 	ieee->dev = dev;
 
 	err = rtllib_networks_allocate(ieee);
-- 
2.17.1

