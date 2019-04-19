Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D77420663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQqxB4Jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfDSSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:53:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37824 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfDSSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:53:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so3017395pgc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ABjKbsKS89ab0w5qLsKCXnPeDLkUJ8jMCwLjkL2i1h0=;
        b=GQqxB4JzuX0VR1gLQiG6g9rOvWu1e247YrDS+w3LB0vs3i5KfMT130j5yHKxDC5I0f
         k6EZcSGElKhWbrqZPh7GTsY+qpDb4ifh9qIA9vpjNA62MElr/NhL1ssDMTtHIoI5IvIr
         AepH8COeogfVBxGf5rysNEkUiDqAUHj6hYYrxU+XFO9xRvy5PFvx6n2t0/VZCgT3gNUr
         lpNXIRVvMfyqpB9AMumohJMjQEpinxtvT5J2KsaZzjsGqAuIjz+Fja8NSAG6P0wd1HbU
         HNra6qusbWEAI4WPRP0/ADyl8T4HuJOUugoWvwChrROF1D9eplmWFDe5y2MIUvqEddY/
         LW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ABjKbsKS89ab0w5qLsKCXnPeDLkUJ8jMCwLjkL2i1h0=;
        b=QlPUvI5T/YhV3Z2EDA803hqO2u+rpavFKDqc5h3L8NGaiNygYsvNrDZ3mpvTVH3oQg
         1dJgkSFhPCZOO6a5DGX7ZyeGvJgM06PwRisXNASgo+rYV744XTmi4ERyBLDui+MLpqAC
         1iaD3GLNVVLbG1es743IErtJNjVectctvUxklZTjTBbg0nJ5MTuG7v4ayWhuAtN9HFh5
         odhXx/+pVZyurU22dNK0AQgJ4kHoZxAkn7BnkSjpX8rvzlXl0jE8Eo1yq054osQhryNk
         bVfLh541Gr1Jv4cuSWgCYVtty8KZBXpPb3qXokSboIppROx+USy1m6Gvpv4Y2muBbsay
         kWIg==
X-Gm-Message-State: APjAAAXuxnZgyTzX2h8pLPr2UwxPQx2SML48GX5z50bkYElOvB+uUVcD
        IVuQceUVOGBsf1F2sM2zOEdZAOkjXRs=
X-Google-Smtp-Source: APXvYqyMkF5oMGsYFcjmLGmBb5nT1M295t4Ue5AFNuFqK3UDGx6gYKV2KD4HANAKdfzFZkSgByBZLg==
X-Received: by 2002:a63:165f:: with SMTP id 31mr3339022pgw.321.1555672417424;
        Fri, 19 Apr 2019 04:13:37 -0700 (PDT)
Received: from bhanu-VirtualBox.danlawtech.com ([183.82.102.247])
        by smtp.gmail.com with ESMTPSA id 6sm6223470pfj.95.2019.04.19.04.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 04:13:36 -0700 (PDT)
From:   Bhanusree Pola <bhanusreemahesh@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v2] Staging: rtl8723bs: Avoid typedefs for structure
Date:   Fri, 19 Apr 2019 16:42:56 +0530
Message-Id: <1555672376-20268-1-git-send-email-bhanusreemahesh@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid typedefs for structure types to maintain kernel coding style.
Remove typedefs for _ODM_Phy_Dbg_Info and _ODM_Mac_Status_Info_.
This part is done by the following semantic patch:

<smpl>
@r1@
identifier i;
type t;
@@
typedef struct i {
...
}t;

@r2@
type r1.t;
identifier v;
@@
t v;

@script:python match@
i << r1.i;
x;
@@
coccinelle.x = i;

@r4@
identifier match.x;
type r1.t;
@@
- typedef struct x
+ struct x
{ ... }
- t
;

@r5@
type r1.t;
identifier r2.v, match.x;
@@
- t v;
+ struct x v;
</smpl>

Change Structure name _ODM_Phy_Dbg_Info and _ODM_Mac_Status_Info_ to maintain Linux kernel Coding Style.
Replace occurences of ODM_PHY_DBG_INFO_T to odm_phy_dbg_info and ODM_MAC_INFO to odm_mac_status_info.

Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
---
v2:
 Changed the occurence of (ODM_MAC_INFO *) to (struct odm_mac_status_info *) in the commented code

 drivers/staging/rtl8723bs/hal/odm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 7de5161..9db9f17 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -691,7 +691,7 @@ void ODM_CmnInfoHook(PDM_ODM_T pDM_Odm, ODM_CMNINFO_E CmnInfo, void *pValue)
 	/* break; */
 
 	/* case ODM_CMNINFO_MAC_STATUS: */
-	/* pDM_Odm->pMacInfo = (ODM_MAC_INFO *)pValue; */
+	/* pDM_Odm->pMacInfo = (struct odm_mac_status_info *)pValue; */
 	/* break; */
 	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
-- 
2.7.4

