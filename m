Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368DBC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C9320B1F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV4J5lgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDFWFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:05:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46983 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:05:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id s81so5870697qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNyqJv9l2zQDVCfVxhbX28vOpeubsz/eNlZUK/+utN8=;
        b=NV4J5lgtUUctxlW2cKRMrTQ6pZjiiKO3oGpPguPK2zLw1C0KpCqD7+HzjWttaTa5IB
         6fyrGfrJ8COO5d/rb2+p86w7TPtMfwDb4TrJBQ8pd0WBH+vaAo8RidGlyLP9HQIKGpfn
         c0K3K8RGCzrF9rn3nFHcBR/6T3PH2nfm/Nr4Qr0Wq5T1U48RYWsVrShKTGjMxh/onrSm
         l2aIOp9zMpLJ60J3Yvncw9nhyuNq21tZho8uTAh6x7LsYcIkJzUQt3ec3imD1eHzqB2L
         fb+zrzC6lUan3snsEeE82D3tKiIhCFDN2hksJYXd606oKM3PdKloaQNRLiClpCJ8bhpA
         307A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNyqJv9l2zQDVCfVxhbX28vOpeubsz/eNlZUK/+utN8=;
        b=r6/9BA5N84cnnmnYQTqq89L7/yG+VQFgzNS84Rl/LBQd6VUSQGYlvqUJoY9VW/VoSD
         diBdVjcDihhcsFct4Idi179Kw9Oj7YyPHr7D8bGBMmtNFv+fQyvVXl6v8IussMNERfXG
         brhfeEBGj1DctvzUvqYxtvxLAsIEAKa1/wrTgMQBBQhorU8k0IFpQ3dYyD/A+GxKaO/C
         NXB92kwMMF30EONM4GPKu1Yt5dya/ua0vZQjWXW+Zf/WK1tJ5Ic2PDY3BbFail3umyip
         0RsTg4d1UOJovxCPqrX/LHopQ9HUgPuHjkkazV5HrvNBUgMdQeKaWvx2447+roPNdwZy
         c79w==
X-Gm-Message-State: APjAAAUALe34XK3Lr23OVXJDjLq3nnfTUToO+G0Xpv4lIAYWlK0QgQPf
        +DT3ZLtMN/+sO9uGSAoaXX4=
X-Google-Smtp-Source: APXvYqziKr7kSNY1aRnSzQ6x5dsnoVgO7baPt+yFy5tgA4D0V2Dy1CDHykVJnSPbAyZsuujvBGf4Vg==
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr17005212qkl.112.1554588310673;
        Sat, 06 Apr 2019 15:05:10 -0700 (PDT)
Received: from localhost.localdomain ([187.104.167.160])
        by smtp.gmail.com with ESMTPSA id h24sm17454476qte.50.2019.04.06.15.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 15:05:10 -0700 (PDT)
From:   Caio Salvador Rohwedder <caiosalvador96@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        caiosalvador96@gmail.com
Subject: [PATCH v2] staging: rtl8192u: ieee80211: fix checkpatch space errors
Date:   Sat,  6 Apr 2019 19:02:23 -0300
Message-Id: <20190406220222.20331-1-caiosalvador96@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch space coding style errors, warnings and checks on rtl819x_TSProc.c

Signed-off-by: Caio Salvador Rohwedder <caiosalvador96@gmail.com>
---
Changes in v2:
	- change commit message
	- fix remaining space errors
---
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 112 +++++++++---------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index c76715ffa08b..d0c219699f68 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -37,18 +37,18 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 	IEEE80211_DEBUG(IEEE80211_DL_REORDER, "==================>%s()\n", __func__);
-	if(pRxTs->rx_timeout_indicate_seq != 0xffff) {
+	if (pRxTs->rx_timeout_indicate_seq != 0xffff) {
 		// Indicate the pending packets sequentially according to SeqNum until meet the gap.
-		while(!list_empty(&pRxTs->rx_pending_pkt_list)) {
+		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
 			pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTs->rx_pending_pkt_list.prev, RX_REORDER_ENTRY, List);
-			if(index == 0)
+			if (index == 0)
 				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
 
-			if( SN_LESS(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq) ||
-				SN_EQUAL(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq)	) {
+			if (SN_LESS(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq) ||
+				SN_EQUAL(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq)) {
 				list_del_init(&pReorderEntry->List);
 
-				if(SN_EQUAL(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq))
+				if (SN_EQUAL(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq))
 					pRxTs->rx_indicate_seq = (pRxTs->rx_indicate_seq + 1) % 4096;
 
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER, "RxPktPendingTimeout(): IndicateSeq: %d\n", pReorderEntry->SeqNum);
@@ -63,12 +63,12 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		}
 	}
 
-	if(index>0) {
+	if (index > 0) {
 		// Set rx_timeout_indicate_seq to 0xffff to indicate no pending packets in buffer now.
 		pRxTs->rx_timeout_indicate_seq = 0xffff;
 
 		// Indicate packets
-		if(index > REORDER_WIN_SIZE) {
+		if (index > REORDER_WIN_SIZE) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reorder buffer full!! \n");
 			spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 			return;
@@ -76,7 +76,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		ieee80211_indicate_packets(ieee, ieee->stats_IndicateArray, index);
 	}
 
-	if(bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
+	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
 		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
 		mod_timer(&pRxTs->rx_pkt_pending_timer,
 			  jiffies + msecs_to_jiffies(ieee->pHTInfo->RxReorderPendingTime));
@@ -105,7 +105,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(struct tspec_body));
-	memset(&pTsCommonInfo->t_class, 0, sizeof(union qos_tclas)*TCLAS_NUM);
+	memset(&pTsCommonInfo->t_class, 0, sizeof(union qos_tclas) * TCLAS_NUM);
 	pTsCommonInfo->t_clas_proc = 0;
 	pTsCommonInfo->t_clas_num = 0;
 }
@@ -141,7 +141,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 	INIT_LIST_HEAD(&ieee->Tx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Unused_List);
 
-	for(count = 0; count < TOTAL_TS_NUM; count++) {
+	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		//
 		pTxTS->num = count;
 		// The timers for the operation of Traffic Stream and Block Ack.
@@ -164,7 +164,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 	INIT_LIST_HEAD(&ieee->Rx_TS_Admit_List);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
-	for(count = 0; count < TOTAL_TS_NUM; count++) {
+	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pRxTS->num = count;
 		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
 		timer_setup(&pRxTS->ts_common_info.setup_timer, TsSetupTimeOut,
@@ -181,11 +181,11 @@ void TSInitialize(struct ieee80211_device *ieee)
 	// Initialize unused Rx Reorder List.
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
 //#ifdef TO_DO_LIST
-	for(count = 0; count < REORDER_ENTRY_NUM; count++) {
-		list_add_tail( &pRxReorderEntry->List,&ieee->RxReorder_Unused_List);
-		if(count == (REORDER_ENTRY_NUM-1))
+	for (count = 0; count < REORDER_ENTRY_NUM; count++) {
+		list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
+		if (count == (REORDER_ENTRY_NUM - 1))
 			break;
-		pRxReorderEntry = &ieee->RxReorderEntry[count+1];
+		pRxReorderEntry = &ieee->RxReorderEntry[count + 1];
 	}
 //#endif
 }
@@ -196,7 +196,7 @@ static void AdmitTS(struct ieee80211_device *ieee,
 	del_timer_sync(&pTsCommonInfo->setup_timer);
 	del_timer_sync(&pTsCommonInfo->inact_timer);
 
-	if(InactTime!=0)
+	if (InactTime != 0)
 		mod_timer(&pTsCommonInfo->inact_timer,
 			  jiffies + msecs_to_jiffies(InactTime));
 }
@@ -211,55 +211,55 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 	bool				search_dir[4] = {0};
 	struct list_head		*psearch_list; //FIXME
 	struct ts_common_info	*pRet = NULL;
-	if(ieee->iw_mode == IW_MODE_MASTER) { //ap mode
-		if(TxRxSelect == TX_DIR) {
+	if (ieee->iw_mode == IW_MODE_MASTER) { //ap mode
+		if (TxRxSelect == TX_DIR) {
 			search_dir[DIR_DOWN] = true;
-			search_dir[DIR_BI_DIR]= true;
+			search_dir[DIR_BI_DIR] = true;
 		} else {
 			search_dir[DIR_UP]	= true;
-			search_dir[DIR_BI_DIR]= true;
+			search_dir[DIR_BI_DIR] = true;
 		}
-	} else if(ieee->iw_mode == IW_MODE_ADHOC) {
-		if(TxRxSelect == TX_DIR)
+	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
+		if (TxRxSelect == TX_DIR)
 			search_dir[DIR_UP]	= true;
 		else
 			search_dir[DIR_DOWN] = true;
 	} else {
-		if(TxRxSelect == TX_DIR) {
+		if (TxRxSelect == TX_DIR) {
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
 
-	if(TxRxSelect == TX_DIR)
+	if (TxRxSelect == TX_DIR)
 		psearch_list = &ieee->Tx_TS_Admit_List;
 	else
 		psearch_list = &ieee->Rx_TS_Admit_List;
 
 	//for(dir = DIR_UP; dir <= DIR_BI_DIR; dir++)
-	for(dir = 0; dir <= DIR_BI_DIR; dir++) {
+	for (dir = 0; dir <= DIR_BI_DIR; dir++) {
 		if (!search_dir[dir])
 			continue;
-		list_for_each_entry(pRet, psearch_list, list){
+		list_for_each_entry(pRet, psearch_list, list) {
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.ts_info.ucTSID, pRet->TSpec.ts_info.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) == 0)
 				if (pRet->t_spec.ts_info.uc_tsid == TID)
-					if(pRet->t_spec.ts_info.uc_direction == dir) {
+					if (pRet->t_spec.ts_info.uc_direction == dir) {
 	//					printk("Bingo! got it\n");
 						break;
 					}
 		}
-		if(&pRet->list  != psearch_list)
+		if (&pRet->list  != psearch_list)
 			break;
 	}
 
-	if(&pRet->list  != psearch_list)
-		return pRet ;
+	if (&pRet->list  != psearch_list)
+		return pRet;
 	else
 		return NULL;
 }
@@ -270,15 +270,15 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 {
 	u8	count;
 
-	if(pTsCommonInfo == NULL)
+	if (pTsCommonInfo == NULL)
 		return;
 
 	memcpy(pTsCommonInfo->addr, Addr, 6);
 
-	if(pTSPEC != NULL)
+	if (pTSPEC != NULL)
 		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(struct tspec_body));
 
-	for(count = 0; count < TCLAS_Num; count++)
+	for (count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(union qos_tclas));
 
 	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
@@ -342,7 +342,7 @@ bool GetTs(
 			Addr,
 			UP,
 			TxRxSelect);
-	if(*ppTS != NULL) {
+	if (*ppTS != NULL) {
 		return true;
 	} else {
 		if (!bAddNewTs) {
@@ -357,23 +357,23 @@ bool GetTs(
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
+								((TxRxSelect == TX_DIR) ? DIR_DOWN : DIR_UP) :
+								((TxRxSelect == TX_DIR) ? DIR_UP : DIR_DOWN);
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
-			if(!list_empty(pUnusedList)) {
+			if (!list_empty(pUnusedList)) {
 				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
 				list_del_init(&(*ppTS)->list);
-				if(TxRxSelect==TX_DIR) {
+				if (TxRxSelect == TX_DIR) {
 					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, ts_common_info);
 					ResetTxTsEntry(tmp);
 				} else {
@@ -416,14 +416,14 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 	del_timer_sync(&pTs->inact_timer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
-	if(TxRxSelect == RX_DIR) {
+	if (TxRxSelect == RX_DIR) {
 //#ifdef TO_DO_LIST
 		PRX_REORDER_ENTRY	pRxReorderEntry;
 		struct rx_ts_record     *pRxTS = (struct rx_ts_record *)pTs;
-		if(timer_pending(&pRxTS->rx_pkt_pending_timer))
+		if (timer_pending(&pRxTS->rx_pkt_pending_timer))
 			del_timer_sync(&pRxTS->rx_pkt_pending_timer);
 
-		while(!list_empty(&pRxTS->rx_pending_pkt_list)) {
+		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 			//pRxReorderEntry = list_entry(&pRxTS->rx_pending_pkt_list.prev,RX_REORDER_ENTRY,List);
 			pRxReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTS->rx_pending_pkt_list.prev, RX_REORDER_ENTRY, List);
@@ -435,13 +435,13 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 					spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 					return;
 				}
-				for(i =0; i < prxb->nr_subframes; i++)
+				for (i = 0; i < prxb->nr_subframes; i++)
 					dev_kfree_skb(prxb->subframes[i]);
 
 				kfree(prxb);
 				prxb = NULL;
 			}
-			list_add_tail(&pRxReorderEntry->List,&ieee->RxReorder_Unused_List);
+			list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
 			spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 		}
 
@@ -522,15 +522,15 @@ void RemoveAllTS(struct ieee80211_device *ieee)
 
 void TsStartAddBaProcess(struct ieee80211_device *ieee, struct tx_ts_record *pTxTS)
 {
-	if(!pTxTS->add_ba_req_in_progress) {
+	if (!pTxTS->add_ba_req_in_progress) {
 		pTxTS->add_ba_req_in_progress = true;
-		if(pTxTS->add_ba_req_delayed)	{
+		if (pTxTS->add_ba_req_delayed)	{
 			IEEE80211_DEBUG(IEEE80211_DL_BA, "TsStartAddBaProcess(): Delayed Start ADDBA after 60 sec!!\n");
 			mod_timer(&pTxTS->ts_add_ba_timer,
 				  jiffies + msecs_to_jiffies(TS_ADDBA_DELAY));
 		} else {
 			IEEE80211_DEBUG(IEEE80211_DL_BA, "TsStartAddBaProcess(): Immediately Start ADDBA now!!\n");
-			mod_timer(&pTxTS->ts_add_ba_timer, jiffies+10); //set 10 ticks
+			mod_timer(&pTxTS->ts_add_ba_timer, jiffies + 10); //set 10 ticks
 		}
 	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s()==>BA timer is already added\n", __func__);
-- 
2.21.0

