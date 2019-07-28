Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C765C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B55C2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXZ+E676"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfG1LT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:19:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44926 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfG1LT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:19:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so26821054pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=B6TX782w2nBGeMiqESzq7NZYdapmEI2iIuDzWwvD73U=;
        b=MXZ+E676Ntw3aSNHqfnVD+vV93kAQFhnjN7v5+bVIai1HEiJ9IdyRrMQj6g7+npQTL
         To7doQ5Skx9J7FxAUX7BdrvD5EX+ReNYmjeMpEDQ/APqAaTMJNpsRVoid+drvHj7oGwh
         BCpSC0QOV1+0uqSypplKpllUII17eXJkASlpUYFSKjRx3cv67eog3bwtAw7ma1klYER0
         HPJZQzppsp/9xG3gC7dC8/vcStTfOt7PI+fAkd+dCRl3/5HqyJYoHKyY+JYk4DxO4k9q
         MqZxpgHVpO4+pTOlDCe5T/Wfca6MvRt2Zmx1HqWSxoYQtAgw7BQj8A2OdTAzZUAEtehM
         xNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B6TX782w2nBGeMiqESzq7NZYdapmEI2iIuDzWwvD73U=;
        b=Du68i8JJprV5TmKVzic9ay2DbJpgwQrfLjJu7+rK4i8+NwMtAXyaGrXm+XBEbfxtjN
         Ur/mE7IOhIOUWZAS7E8mjD3WrkFT8/2KVBQaClkbtS3e62iv15TPNMX5jK+AJocfDG0D
         Lxy0dGPqwhZAXsjIp2Hsh+1PWzkRCq/TOkgq+bI/2H/QiBbJZlXt25/j7wFVcnc4mBBj
         nzhdQXBD8N5v9MoE6Qx5leNh692fD4Xve3CRsJLmevdpZy9r5XcgOmnEl+vjSTHIKqZe
         mv/4O+CvHWDxB8kH0URY64sciiCztLCb5fK0gMnvOb1CjLhf1ZCI0ktZskDMA6Hl1HOt
         qXJw==
X-Gm-Message-State: APjAAAW6mepk96udwxYrctI7qe0JfZzUTJmgbYWVHKOggA/FDPblOhLl
        0OAdW+XNSyfwAuz7GJHSXAo=
X-Google-Smtp-Source: APXvYqxxfgP0hAWjsHS3mvtNIYhn4ZiY0lxJaD8PKrUgtK38LgU7uiI2Z+xjPs4VKbPFdF41titAYg==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr85384058pgp.118.1564312767754;
        Sun, 28 Jul 2019 04:19:27 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id s11sm56220185pgv.13.2019.07.28.04.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 04:19:26 -0700 (PDT)
Date:   Sun, 28 Jul 2019 16:49:18 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, hdegoede@redhat.com
Subject: [PATCH] staging: rtl8723bs: core: Remove unneeded extern WFD_OUI
Message-ID: <20190728111918.GA24278@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded extern variable "extern unsigned char WFD_OUI"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 7bd5c61..2bb20762 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -13,7 +13,6 @@ extern unsigned char RTW_WPA_OUI[];
 extern unsigned char WMM_OUI[];
 extern unsigned char WPS_OUI[];
 extern unsigned char P2P_OUI[];
-extern unsigned char WFD_OUI[];
 
 void init_mlme_ap_info(struct adapter *padapter)
 {
-- 
2.7.4

