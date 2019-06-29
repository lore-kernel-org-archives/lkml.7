Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E228C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314DA2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKdmZG2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfF2K12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:27:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2K11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:27:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so3728934pgk.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ufreqsCqUEbtwakQjfPG4/XQRKe+4sPPeMiA/RmTprM=;
        b=cKdmZG2fv2FHyq/gn/WOY2fDnZNUuTcUVfnB4nLqEAMAuWtVkSOgN0EBoQFxbmI2sC
         kLg51yMJLQdyZoqoQJLsLVglMD8dhONK+dIblCpriafBpJAN3lDXcHADZsw6rXN1cIOV
         tJJi6JKUh4ybqBp8oi2KqNO4EyxOOB6aSRWsX7p9l6kqGVjz5+FjYCcUC9y0gwPM1JhE
         GrEISObJScRohTISa26+gFXHGtL4m8XVNm9sqtHvJH8gNU0bKCu7oomgNIeZjUDmMsjS
         cAHQUQMOxe4t8kJ+ZpPwTC+0hngYLr1hIlylIssQRwK7wpBMonPTgbhNija94oDUK/ST
         x71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ufreqsCqUEbtwakQjfPG4/XQRKe+4sPPeMiA/RmTprM=;
        b=AlBdaBqB6R4JnaCRIOifAG3DLyxsjTUKCiXxlB9AT6n3BsYshOeyQyi/4cbIVTKK7g
         clUlq3SVL+iRyK+WTvQf+dm8WFZthL6CFQT/Xob0B97ShkmYvbt4g46N4nRlcfET64w2
         I0QGN7/8p100swAW5RdIqE+6XFQH0DkB+/jqE40GaFHmt5W4jMU1xylbgB5xJryOjYVQ
         NfUIxzn3HuVO+Qf5qELoPOGxex2zX1jCtWhhw06tO9TH7JH0vbYTyBmSMFQyJqvTBN95
         +T96yOMkVhSfYj6AFbHs046xzq7tYFaMVfk7MZW2oChdx70hgOvIibAKjzv6nr7IlDtE
         zKqw==
X-Gm-Message-State: APjAAAXmFvWnzGl+OVH7GSqCtw+YhBleynDo/AYcGtlLAnN0hG49TIRp
        Ii1ZQFk9+PzI+8Zd2/RjUME=
X-Google-Smtp-Source: APXvYqwaG/2Dn1EssqX0/2D6nzUNtjJIVIVQ/SdduLespqMNDIkEbPkRWjTzg5DrjWSFmxl9BTJqTA==
X-Received: by 2002:a63:231c:: with SMTP id j28mr13633480pgj.430.1561804046903;
        Sat, 29 Jun 2019 03:27:26 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id b29sm11633100pfr.159.2019.06.29.03.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:27:26 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:57:22 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102722.GA15300@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index a733046..7883b26 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -221,7 +221,7 @@ void ODM_CfoTracking(void *pDM_VOID)
 		pCfoTrack->CFO_ave_pre = CFO_ave;
 
 		/* 4 1.4 Dynamic Xtal threshold */
-		if (pCfoTrack->bAdjust == false) {
+		if (!pCfoTrack->bAdjust) {
 			if (CFO_ave > CFO_TH_XTAL_HIGH || CFO_ave < (-CFO_TH_XTAL_HIGH))
 				pCfoTrack->bAdjust = true;
 		} else {
-- 
2.7.4

