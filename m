Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A5DC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9AE206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFe7Yr8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEDSuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:50:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32858 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:50:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so4589397pfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UtyZyNpmNUsx6lro+Mguug/5Q9XaYaR3OJHSgo60/nU=;
        b=BFe7Yr8SsWaQOCJF56+IawK0VcD6UcmptJE1pwTjeBdbDjCwF+55m5mMeIGNINk/w0
         q+cVk/+q0/AE2111yJOHAOMDgbvRaXeMNJejtYx/pzj9mPI+Vs4dKXEJ2uPnvGZI5zFz
         xJFb9EtAs4zydNI8eWARIrwod5oe7IiH3q3LX78pNzgnhQ6yZmWNtMuMAFVOlhWpv6h5
         UIplr1ZAh4g+e1phE9JeLN69aFN4Wz/ZCVGRiyOUqoVlxgnwgdmMVtZnp51+9MUi6Yur
         GApzG/R2K9RlnCRSSiBc1cvPHpjUzhrUxGEfZgcI4odEV86PmZfKJ+uv/xThJgo8ceIJ
         8SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UtyZyNpmNUsx6lro+Mguug/5Q9XaYaR3OJHSgo60/nU=;
        b=BpUVg2gALbXQsggP9V1omsXxpOgpnY9oJsXGclsPsQA7IGlWYma3Md6UBlfXoW+16C
         OjcjUWEDita3fPKR3gP9ECCQitchnOcMg8UHo24Q7prgK7gWUkp/nSU6d2Np72K61VvR
         vRVWvr9Yx6+WtcGRRKVarzLGXo9OjVWB2S7+Q9Obeaci6PRqmtyeQdf39inriBVytPqy
         LCBEG4qbJIm1uQhB7A91m3YMcvhZblWs+WDvpXo13Kfh5oxn0xipv4i94TJWOGAh/gD/
         yCVmQPCgD9Ft5J+8KaLCD4RfsQXM8+9hO26qIL5O7T5zx7pS0BdHCdpCz0MR9DgfEuD1
         Zlzg==
X-Gm-Message-State: APjAAAWQk3K4L7aqkruyd3akj7Z9bWs66RX/J0cjeknXkj4KEYJTACFj
        MG0WD/z4xR0lEkiPXTBegbE=
X-Google-Smtp-Source: APXvYqyoVIXz0jB/uKy3yeZIWqvNO105GMUUujL0+IejxfZG1bVQ0txhJaPI35RBT8PjVeKZtjpFuA==
X-Received: by 2002:aa7:8190:: with SMTP id g16mr21492329pfi.92.1556995804996;
        Sat, 04 May 2019 11:50:04 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id b9sm315666pgj.94.2019.05.04.11.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:50:04 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 7/7] staging: rtl8723bs: core: Moved logical operator to previous line.
Date:   Sun,  5 May 2019 00:19:47 +0530
Message-Id: <20190504184947.26173-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved logical operator to previous line to get rid of checkpatch
warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 2a8ae5fd1bc5..be48a3c043e3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5650,9 +5650,9 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 	);
 	#endif
 
-	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta))
-		&& sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta)
-		&& sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
+	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta)) &&
+	    sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta) &&
+	     sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
 	) {
 		ret = false;
 	} else {
-- 
2.17.1

