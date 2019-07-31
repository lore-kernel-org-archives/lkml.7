Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28642C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35B9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2F2EXpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfGaSWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:22:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44813 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfGaSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:22:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so32301966pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=42JWHwYF6z9j3TvaHmVrJBlG7DPxjQN9Be0ZUa3qbmg=;
        b=R2F2EXpUAMh7XS98+4i+ms4XMAGWEvWnEmnfc/YngAEPMUHJ1W1UxHEgJjfmreodRa
         ROi1q98tUEzE/WqSKH17NAd+Vtk5RABmT2JgucXCC7oVhBFqGovVeH/FIbKcsTbtssBM
         ZEGm1XX3rO78/RwGGZ2sUtHfGzy4o0GvcxNKbrNU3qlnWmEiRjEOhNNgwR2VcNr1KkZD
         VEKIqM9pq3PsQDjdRUasKfL/I8xvGI7I0RsFsggpWeFhWOQC2v86obyQ0IINBIaMVRCg
         NyDfE0wA0Pm6sLaijcTkRTFC9+dlYv9urtBcC3FKXBvI0DpTKpDiooAwBQfij4YiB6zw
         cIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=42JWHwYF6z9j3TvaHmVrJBlG7DPxjQN9Be0ZUa3qbmg=;
        b=HTU4kVH2eIJ2j0kwS87ePckzYKmIJzYuYv5Q4uW1VcvFr7EAqRzpbzblCqBQaHXbOW
         x7HPzxIwoYBKfFmaPgiwDrZ97E2lg+Aps6DTkQ7RWKxtNdz6FA/ppddJfDjsxhSTlyoI
         eNeAu3+UM3GEEgMjPi6qnlnQ9z11xR3jIJ+a3p6t8cBQtsN0PzowUGRJQfXQNsfiFQJH
         zIBzKrqxsRh+TqonB9Py5pxZb1gfpjsJ/LHgPTLvec5EXC5kVLtU8Q+wJWio8FJvaBZG
         Zf9rsFmh9+19SeYF/JTGIXL/v4v3qJ9bIMld4GSu9CcUlleIP4B7xVje7152H/+rGvhz
         afQg==
X-Gm-Message-State: APjAAAXnAO/cAXJVjcPa6eKN2w8AfE6f0WsE+qLwHLiA5qo3yumRIprU
        3jp4P5+S8RF3s1gaF+vOdZI=
X-Google-Smtp-Source: APXvYqx1ecLNRIsJBPPbf0M4/qluK0H6x8/0Y5NtcjCLCADGkSQ82Io8Ra/zGXzZ1j9nUZkchKX9og==
X-Received: by 2002:a65:5188:: with SMTP id h8mr4221297pgq.294.1564597358645;
        Wed, 31 Jul 2019 11:22:38 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id r2sm87175611pfl.67.2019.07.31.11.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:22:38 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:52:32 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [Patch v2 08/10] staging: rtl8723bs: core: Remove unneeded extern
 WFD_OUI
Message-ID: <20190731182232.GA9713@hari-Inspiron-1545>
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
v2 - Add patch number

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

