Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDE3C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D420659
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcEdk6vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbfG0LGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 07:06:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34021 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG0LGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:06:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so25709388pfo.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YYitJm/LwHhp29cVtN6Nj2n/w6bD2omxDxt7bEyLK9k=;
        b=FcEdk6vi7RsiOvNDxGhLvuE4EP+Nvkv8RoKdQHwrHehrmtp2o7zHXAWuTIkCPLBWQv
         r0d6h2PJJ9DOXIKkd+R5kUV3rmAMdx4ibjMQHuFyGWpoBdUERRLKex/36MPDO2VqnSYc
         5zutKUTvmdWQE5RIp/prQ/q3VFByw/sveHDMfSdZ5kOtKPBLW/+V2jvmDso51DwoQtDJ
         hqQdkgvkf6rXnEQqK6b1WL7hZ0bIMsu8DyrH4v9l9tqk3wM18w9VPCE9u5Mj5Y9S7cgz
         yNAQfkc/oXkAGl7umAjR7maOtAUvDVmxku8hWmYZXKEBvyj9od238g5+01mfrVZP5x2I
         sClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YYitJm/LwHhp29cVtN6Nj2n/w6bD2omxDxt7bEyLK9k=;
        b=DuvJvm7Jp8RX4J35/d7w2ubZy0j5cP5FcReS8M3A3EdgDHtDglBrcpziCJMvU96ICi
         Pe5N21Ck2b3z1iU+OC2+k4Ztn11JHJkprjFNUhCkgOt7DWeX41KtsK23OkOsyiKfQ0FM
         vOENrqypoFcQ7qs9OdDMqWFR74IXvVCFS94lUj+b1fRol2WYhzxuRBE/UyBlj7hPi6tf
         WAm/4p916m8bnmqhw6VpCQTJPaX+B9wsmeiL4ZSYk7ydGWr02MFVSsGaOQb7xOh45qAN
         uSDHeH/dRmXKPzguOhfRU/Kno2mbDNz2QpFphC2FNlMrZioCmMcPuJrhny61h6pz0A6W
         kLTw==
X-Gm-Message-State: APjAAAXlJj4NbNQm9LN/kii5KNttdRN7L4EHpsiPM4cJkDhKXnUbs9Os
        l0giFsJFPbqxfa1P9adZcMI=
X-Google-Smtp-Source: APXvYqztG7Stf1/2oLY9RCeWsCRmoWJbRTy8Vwz0dyVWtsegBjSwJbT7LGIZiFst3DaFwOfIQ964vw==
X-Received: by 2002:a63:f926:: with SMTP id h38mr6232479pgi.80.1564225581049;
        Sat, 27 Jul 2019 04:06:21 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id h1sm73716579pfo.152.2019.07.27.04.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 04:06:19 -0700 (PDT)
Date:   Sat, 27 Jul 2019 16:36:14 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: Remove unused function argument
 sdio_device_id
Message-ID: <20190727110614.GA4605@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove passing pdid as function argument to rtw_sdio_if1_init as it is
not being used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 540a7ee..cefff1e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -315,7 +315,7 @@ static void sd_intf_stop(struct adapter *padapter)
 }
 
 
-static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct sdio_device_id  *pdid)
+static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj)
 {
 	int status = _FAIL;
 	struct net_device *pnetdev;
@@ -473,7 +473,7 @@ static int rtw_drv_init(
 		goto exit;
 	}
 
-	if1 = rtw_sdio_if1_init(dvobj, id);
+	if1 = rtw_sdio_if1_init(dvobj);
 	if (if1 == NULL) {
 		DBG_871X("rtw_init_primarystruct adapter Failed!\n");
 		goto free_dvobj;
-- 
2.7.4

