Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7619C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DED920645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTlHwJPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDST1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:27:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33352 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfDST1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:27:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so3053524pgh.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q4ev4tBKzNk0Wx8NQiQCpkJyhJH7yxAqrD0u4YHahME=;
        b=jTlHwJPHkFHrUpfyCQqENGYX5TRtaS4oikjNQslyr6MkhuJdTLAgjPRrGi4qFQl9AK
         5eNCodaEpuy/qyVmB6E1JLbuaYY6GaBFL68Vs5UISzF35e8uy8RsiowZG3+d6s6l3+yx
         HtfH32zzbmEw2dwtwezRH9TCFKKNnq2GzVYUzsC3YFb7AW7rIz7VYHs7npyBwxww3G+C
         lXZGcZ4UrrPDHl2cZDZS2j889qg/2tHR/aTOYRZWDeVPbYaUn0hG9y6UWzRLLD3Z7RLV
         oDFkDigHTEK2pDDLoWAoEgm6ciwYBA5l9CK3NEFuEVOjopg1Pg5gsaNbTpVJV8bIxVhy
         fAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q4ev4tBKzNk0Wx8NQiQCpkJyhJH7yxAqrD0u4YHahME=;
        b=SAm2vNkYbSPo+CcaJUwlcQQJOCsfvVupHWGQ5gSJX7bp+pXU7y41aa+0IF8EWtCEKG
         E5qnsIeXwsVhLr1sta3v7LmPq9CUJH0Ytu1zqb6aekg65funB4ugT0JBknEPNbYcDgBt
         rwriB1gKQlse9DtM2u0I7nSrR0XRrap1npaLIt6HqHZT5gajX/81rcqZG2C4Hi5JcNrt
         lsfWivy+sQwUQLLesoZMyK9CjeP80tz9xD16lCIc45HhdF2jk2v1rS4J9FVh7LmPAn/B
         RQHkVsO0qK/J990B2z/RqJDKmrH3NgHfXrn8dN/VDNH0eYuueIEZBEzWw129SUcnPKtE
         O8Fg==
X-Gm-Message-State: APjAAAUesthH3XHN8gVY6Eet+rQ8B15DNqwFFkyGxsWzZH9zQemwtDxa
        WkVu9Bud7BP0p36RHIfQdKcr0hZyUrQ=
X-Google-Smtp-Source: APXvYqzO3JB3DGslw05z0WyE3TCv3eQq2sLdhBbE+ijJzE8nqHqmvP7T8xUlFXDzqf4b8jsZYa6FZg==
X-Received: by 2002:a63:2262:: with SMTP id t34mr3486081pgm.202.1555674775700;
        Fri, 19 Apr 2019 04:52:55 -0700 (PDT)
Received: from bhanu-VirtualBox.danlawtech.com ([183.82.102.247])
        by smtp.gmail.com with ESMTPSA id j20sm6091228pfn.84.2019.04.19.04.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 04:52:55 -0700 (PDT)
From:   Bhanusree Pola <bhanusreemahesh@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3] Staging: rtl8723bs: Avoid typedefs for structure
Date:   Fri, 19 Apr 2019 17:22:14 +0530
Message-Id: <1555674734-20502-1-git-send-email-bhanusreemahesh@gmail.com>
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
v3:
 Included the correct patch
 drivers/staging/rtl8723bs/hal/odm.c |  2 +-
 drivers/staging/rtl8723bs/hal/odm.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 23ab160..9f9259c 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -261,7 +261,7 @@ struct odm_packet_info {
 	bool is_beacon;
 };
 
-typedef struct _ODM_Phy_Dbg_Info_ {
+struct odm_phy_dbg_info {
 	/* ODM Write, debug info */
 	s8 RxSNRdB[4];
 	u32 NumQryPhyStatus;
@@ -271,11 +271,11 @@ typedef struct _ODM_Phy_Dbg_Info_ {
 	/* Others */
 	s32 RxEVM[4];
 
-} ODM_PHY_DBG_INFO_T;
+};
 
-typedef struct _ODM_Mac_Status_Info_ {
+struct odm_mac_status_info {
 	u8 test;
-} ODM_MAC_INFO;
+};
 
 typedef enum tag_Dynamic_ODM_Support_Ability_Type {
 	/*  BB Team */
@@ -1092,11 +1092,11 @@ typedef  struct DM_Out_Source_Dynamic_Mechanism_Structure {
 	/*  Define ........... */
 
 	/*  Latest packet phy info (ODM write) */
-	ODM_PHY_DBG_INFO_T PhyDbgInfo;
+	struct odm_phy_dbg_info PhyDbgInfo;
 	/* PHY_INFO_88E		PhyInfo; */
 
 	/*  Latest packet phy info (ODM write) */
-	ODM_MAC_INFO *pMacInfo;
+	struct odm_mac_status_info *pMacInfo;
 	/* MAC_INFO_88E		MacInfo; */
 
 	/*  Different Team independt structure?? */
-- 
2.7.4

