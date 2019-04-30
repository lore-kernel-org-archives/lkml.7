Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB43820835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgXdMc4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfD3SaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:30:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44220 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:30:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id l2so4360108plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wLmcV6OdISQ/+3ScE9BnR0d+4OBZ1HSPXUDnV21ajrU=;
        b=BgXdMc4KN0WDtxc2YK4QdpJXGT2nbdBI56zgqQP16hyHntbQsTvhw3bFMS9IorQPhA
         OVi5snL6CAkTBPH3+5KQlQoKLVMiQ+T17E8N5XBXb949JlAmYGqH19BRyjbErm4f221M
         G2hBUbddddHCHM6h+paXlx5uBRQBiXy3oII0pYbtWZzs9vhKNDw32lLtpgbpP+Mzt1dw
         ouNpYl1Yo5aU2FClXCwh6F5//kzqAFkIykMtAOBBNUKBvuBOgfhy3+m+9fTn8rNx5tmU
         x/n64ziMwkMnlM6X7pzpyrSYnxExP+iSpcN6hZPYfURfmpeeJyzlU5qFE8p8wxp8GASw
         n1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wLmcV6OdISQ/+3ScE9BnR0d+4OBZ1HSPXUDnV21ajrU=;
        b=si5Es1KyftWr0E0vVFiq5EWRlvfe2AFMez5jDgEVjiod4BhL39WK//TEfwOi0feAcS
         ya/SDJI1QChgd3Z9sNpk9NFojyEIkapwewvjqea124ZZMXSHb0bLQaeX4LN0EBRNMRsL
         kwmXFVsyyX2iZbsvYrnZw/zXj7X/q8RdSeu82KTc70RGT7sXVowpu79P2UoSMJBT7BZH
         9nyPlZzTzRUhHm9aI7DLwjOXfxmTMvt876Gf13zYDiMTT0EzyWnWT3+iG1cs//qkreHi
         trc3L7atIG6HWazBNPDrI2KrxcGMkFE3Ug8Kou02ZDnSD7Wx5X84PQmeLBPCvnjTKinF
         8lnQ==
X-Gm-Message-State: APjAAAUbWXl8m6Cv/snd1stemFiL1wotKI1uX5YGgDdz2lgxXOAMVcyF
        hutX/CVqBLomVzaseFLJifk=
X-Google-Smtp-Source: APXvYqx6o6eRsZD7oUBVRSvHJ9DrPiA5NSUQ0g9U3QZjKGEpxfx0PtStpoCQhpNEEdxBWA4yBmVJiA==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr71625208ple.62.1556649020038;
        Tue, 30 Apr 2019 11:30:20 -0700 (PDT)
Received: from localhost.localdomain ([49.206.11.25])
        by smtp.gmail.com with ESMTPSA id a3sm58566704pfn.182.2019.04.30.11.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:30:19 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH] staging: rtl8192u: ieee80211: Resolve ERROR reported by checkpatch
Date:   Tue, 30 Apr 2019 23:59:44 +0530
Message-Id: <20190430182944.9539-1-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves coding style space ERRORs reported by checkpatch

ERROR: spaces required around that '>' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxO)
ERROR: space required before that '&' (ctx:OxV)
ERROR: spaces required around that '!=' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: space required before the open parenthesis '('
ERROR: spaces required around that '?' (ctx:VxE)
ERROR: spaces required around that ':' (ctx:VxE)
ERROR: spaces required around that '==' (ctx:VxV)
Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 418c92403904..7cac668bfb0b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -63,7 +63,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		}
 	}
 
-	if (index>0) {
+	if (index > 0) {
 		// Set rx_timeout_indicate_seq to 0xffff to indicate no pending packets in buffer now.
 		pRxTs->rx_timeout_indicate_seq = 0xffff;
 
@@ -182,7 +182,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
 //#ifdef TO_DO_LIST
 	for (count = 0; count < REORDER_ENTRY_NUM; count++) {
-		list_add_tail(&pRxReorderEntry->List,&ieee->RxReorder_Unused_List);
+		list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
 		if (count == (REORDER_ENTRY_NUM-1))
 			break;
 		pRxReorderEntry = &ieee->RxReorderEntry[count+1];
@@ -196,7 +196,7 @@ static void AdmitTS(struct ieee80211_device *ieee,
 	del_timer_sync(&pTsCommonInfo->setup_timer);
 	del_timer_sync(&pTsCommonInfo->inact_timer);
 
-	if (InactTime!=0)
+	if (InactTime != 0)
 		mod_timer(&pTsCommonInfo->inact_timer,
 			  jiffies + msecs_to_jiffies(InactTime));
 }
@@ -214,25 +214,25 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 	if (ieee->iw_mode == IW_MODE_MASTER) { //ap mode
 		if (TxRxSelect == TX_DIR) {
 			search_dir[DIR_DOWN] = true;
-			search_dir[DIR_BI_DIR]= true;
+			search_dir[DIR_BI_DIR] = true;
 		} else {
 			search_dir[DIR_UP]	= true;
-			search_dir[DIR_BI_DIR]= true;
+			search_dir[DIR_BI_DIR] = true;
 		}
 	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
-		if(TxRxSelect == TX_DIR)
+		if (TxRxSelect == TX_DIR)
 			search_dir[DIR_UP]	= true;
 		else
 			search_dir[DIR_DOWN] = true;
 	} else {
 		if (TxRxSelect == TX_DIR) {
 			search_dir[DIR_UP]	= true;
-			search_dir[DIR_BI_DIR]= true;
-			search_dir[DIR_DIRECT]= true;
+			search_dir[DIR_BI_DIR] = true;
+			search_dir[DIR_DIRECT] = true;
 		} else {
 			search_dir[DIR_DOWN] = true;
-			search_dir[DIR_BI_DIR]= true;
-			search_dir[DIR_DIRECT]= true;
+			search_dir[DIR_BI_DIR] = true;
+			search_dir[DIR_DIRECT] = true;
 		}
 	}
 
@@ -357,20 +357,20 @@ bool GetTs(
 			struct tspec_body	TSpec;
 			struct qos_tsinfo	*pTSInfo = &TSpec.ts_info;
 			struct list_head	*pUnusedList =
-								(TxRxSelect == TX_DIR)?
-								(&ieee->Tx_TS_Unused_List):
+								(TxRxSelect == TX_DIR) ?
+								(&ieee->Tx_TS_Unused_List) :
 								(&ieee->Rx_TS_Unused_List);
 
 			struct list_head	*pAddmitList =
-								(TxRxSelect == TX_DIR)?
-								(&ieee->Tx_TS_Admit_List):
+								(TxRxSelect == TX_DIR) ?
+								(&ieee->Tx_TS_Admit_List) :
 								(&ieee->Rx_TS_Admit_List);
 
-			enum direction_value	Dir =		(ieee->iw_mode == IW_MODE_MASTER)?
-								((TxRxSelect==TX_DIR)?DIR_DOWN:DIR_UP):
-								((TxRxSelect==TX_DIR)?DIR_UP:DIR_DOWN);
+			enum direction_value	Dir =		(ieee->iw_mode == IW_MODE_MASTER) ?
+								((TxRxSelect == TX_DIR)?DIR_DOWN:DIR_UP) :
+								((TxRxSelect == TX_DIR)?DIR_UP:DIR_DOWN);
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
-			if(!list_empty(pUnusedList)) {
+			if (!list_empty(pUnusedList)) {
 				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
 				list_del_init(&(*ppTS)->list);
 				if (TxRxSelect == TX_DIR) {
@@ -435,13 +435,13 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 					spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 					return;
 				}
-				for(i =0; i < prxb->nr_subframes; i++)
+				for (i =  0; i < prxb->nr_subframes; i++)
 					dev_kfree_skb(prxb->subframes[i]);
 
 				kfree(prxb);
 				prxb = NULL;
 			}
-			list_add_tail(&pRxReorderEntry->List,&ieee->RxReorder_Unused_List);
+			list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
 			spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 		}
 
-- 
2.17.1

