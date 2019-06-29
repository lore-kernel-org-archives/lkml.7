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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC9C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F193C214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEwDpIdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfF2KUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:20:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41888 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:20:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so2234757pgj.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JuxDh70JECXFKJRKv7MNIrxvDmNJyfZDTwgCL5FZyeM=;
        b=aEwDpIdt+k+hiRpgeN6ohD2zXTHZx5iwFL3RNV1eipQg50RjEtiHs9RN5YtjYGI+ln
         y2xuAzbrUCQ3ffKdbcMPq0dX05zdM/Ui9p4n+HQOm2mBaZqWKPxpYhufJZ5Pv2Ik7NPZ
         SuDS5nj6ENM6IaIg1/bHrRMdb2scNzC3DsvYnEqnbqUG5a4OEr608MM/ZsrQ5D1xh2nF
         xby554va50gchEf/wqEykFmL4o1hclRfeIii0DKymI9V/hx+hh8WZxrVQMX5lTCuzDCC
         xuL11tMFG+qu1+bnzgmsr2j55x+6Z+ZBDjqiVTrleIs1lgGP4aCI1gGmCOSjSLN3jbx+
         EAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JuxDh70JECXFKJRKv7MNIrxvDmNJyfZDTwgCL5FZyeM=;
        b=BYP4efj68px8LfyiwlBazifCiOg+A0GGBZgD2Dyeub1i2FPA3t78vCL9zOo3Z1CQL2
         E5CKzihMQSeLeiF/f3uVkz60FKM5bbimEQDZlVLm4Y/h81Ah1pnmKhGLQkw1dqDi4bgx
         tjzJLAHKGya/OvzZzFEfdpACvrgL0YfYHQxr5gyJV3WQh+AoCJLUu1iF/8g5+qBaIB8F
         IqaWaeMTsCOvXi4p5hGY0MvBC2nYwZQqZkMIunyYfPBv6B9+s2FFrlOjc8hQ+c6gD+nT
         9d5wmEMR4jT3EU7I78JqJ+UVxYrGJU+olEWICbyu6hgT2hFaDxP3GzE3XdFGTM0dZBR7
         JHMg==
X-Gm-Message-State: APjAAAWh9RspHTrvNgDjW1R919YyMysoIu1R41YFK5jDzk1pNDLByt+C
        KpuZdLEc11qqPoKn/GKlEZw=
X-Google-Smtp-Source: APXvYqygsTI5Cw3FhDha3cPCG/16M/SP8PufHyL4kq3Fz6XUvcLOeNgLi8IOIlzk4QJYbyzsZ9gV9A==
X-Received: by 2002:a17:90a:9bc5:: with SMTP id b5mr18790987pjw.109.1561803643676;
        Sat, 29 Jun 2019 03:20:43 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id u20sm4969600pfm.145.2019.06.29.03.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:20:43 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:50:39 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102039.GA14936@hari-Inspiron-1545>
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
 drivers/staging/rtl8723bs/hal/odm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index e3f4307..dd97a6a 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1238,7 +1238,7 @@ static void FindMinimumRSSI(struct adapter *padapter)
 	/* 1 1.Determine the minimum RSSI */
 
 	if (
-		(pDM_Odm->bLinked != true) &&
+		(!pDM_Odm->bLinked) &&
 		(pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0)
 	) {
 		pdmpriv->MinUndecoratedPWDBForDM = 0;
@@ -1262,7 +1262,7 @@ void odm_RSSIMonitorCheckCE(PDM_ODM_T pDM_Odm)
 	bool FirstConnect = false;
 	pRA_T pRA_Table = &pDM_Odm->DM_RA_Table;
 
-	if (pDM_Odm->bLinked != true)
+	if (!pDM_Odm->bLinked)
 		return;
 
 	FirstConnect = (pDM_Odm->bLinked) && (pRA_Table->firstconnect == false);
@@ -1296,7 +1296,7 @@ void odm_RSSIMonitorCheckCE(PDM_ODM_T pDM_Odm)
 
 		for (i = 0; i < sta_cnt; i++) {
 			if (PWDB_rssi[i] != (0)) {
-				if (pHalData->fw_ractrl == true)/*  Report every sta's RSSI to FW */
+				if (pHalData->fw_ractrl)/*  Report every sta's RSSI to FW */
 					rtl8723b_set_rssi_cmd(Adapter, (u8 *)(&PWDB_rssi[i]));
 			}
 		}
-- 
2.7.4

