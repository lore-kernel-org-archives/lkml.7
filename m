Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5AEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE2222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXmssIDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKMBg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:36:57 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37237 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKMBg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:36:56 -0500
Received: by mail-yw1-f65.google.com with SMTP id v84so175080ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PrKKmnGLiFY82EhSNnXtvqX36ioJ29LweBbxJ54AdsM=;
        b=lXmssIDOoCAk1a8ngp9xq+MAGYGZRdp9jBIDRo6MTzhnDHKcuwXCBqguD40VWJjcum
         Gy7tKclRaCbfQpd1bmbFWa+SOSZPdUFwCrG64+cgJRK3L0zXg9QeSbMq76RQzds3hG5D
         m/+E+VHwa9HoDPyRaeEeSH8tUBHw5ih2mfWW6bv2D2sbc/LtaohIW6HwA+AUd3bbxrbM
         zLIPkYiDkoq2z3Hm6pgpHB7LdjTnDqnCtfRM7UHLKoOqTw+8JjQ18sw+AOL+x4mQg4JV
         +0jHXZVFV1kFAiR8o/fE1yBDQFiMFRXwTgBmTk7LdvH/m3VnuwmwX+wy6i6Do0hd0pNj
         GJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrKKmnGLiFY82EhSNnXtvqX36ioJ29LweBbxJ54AdsM=;
        b=UQSYxGKBL2mi1N+XVfnDXxnhZ1O5Z9LWY7UwHVA6HkI0410eH5HAQf06VfpWVYJ3+o
         dCGBj3fdflgGDUNxg1ex2pdQH8X9U7tOeExCn9QNnVeVfjaUDNMc7HJvU22D4PeiydSD
         C1LVec05Yocd2/OBPdqWPf+ibNhTN2N5mh00obkPOnzdn5x591z/7iyf7LotJqgObFLt
         wrnq+EMGC4WwWjmuE71ixFJu/8cwzB9a1BTBWOAEtcrsPMpp929QrCPyPbPBRtc0EC77
         2n3TnmlsJVJ9Bwm6QzYEbeAdKsKhAw76WIOwanMdSePq0WUmP+mR6s7L5BEgBFM3AMcs
         FRIQ==
X-Gm-Message-State: APjAAAX7/SozPopUGeMHHJwUsFTBXQLQn0hP2XdHDZryZP4Uclbp8FxP
        dv4O6YFQwp1jbuETVcXNJl4EkJxHmjG64A==
X-Google-Smtp-Source: APXvYqzjnsoNdUmwpfLdnE6NXG2HRCXwota6O7uNv6at25WXnr03H7RIw5jLGouV/rcZDg3/z3gaMA==
X-Received: by 2002:a81:9251:: with SMTP id j78mr530901ywg.376.1573609016230;
        Tue, 12 Nov 2019 17:36:56 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id t15sm375190ywf.69.2019.11.12.17.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:36:55 -0800 (PST)
Date:   Tue, 12 Nov 2019 20:36:53 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] staging: rtl8723bs: Remove unnecessary conditional
 block
Message-ID: <b870c2b43c12b7a4c98413735d9c7b1d4ff8e5c5.1573605920.git.jarias.linux@gmail.com>
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a conditional block that had no effect.
It also reformat the affected lines to set the right indentation
after the removal.
Issue found by Coccinelle.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
Changes in V2:
	- No changes.

 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 0f5dd4629e6f..b4b535c66bae 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -551,18 +551,13 @@ static void HalRxAggr8723BSdio(struct adapter *padapter)
 
 	pregistrypriv = &padapter->registrypriv;
 
-	if (pregistrypriv->wifi_spec) {
-		/*  2010.04.27 hpfan */
-		/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
-		/*  Timeout value is calculated by 34 / (2^n) */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	} else {
-		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
-		/*  TX/RX Balance */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	}
+	/*  2010.04.27 hpfan */
+	/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
+	/*  Timeout value is calculated by 34 / (2^n) */
+	valueDMATimeout = 0x06;
+	valueDMAPageCount = 0x06;
+	/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
+	/*  TX/RX Balance */
 
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH + 1, valueDMATimeout);
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, valueDMAPageCount);
-- 
2.20.1

