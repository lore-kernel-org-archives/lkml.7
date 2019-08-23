Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33E6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01A522CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="CpwXQj1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436724AbfHWQYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:24:40 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21499 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436711AbfHWQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:24:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566577459; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=d44TyERSDniRgfkarAZXKficKhfoK9cxRKWY5DpkAJ68NvF7h5Ky3mtVWGO3g2pkYQAb6yq/jG6YG+jvqGsMWNbbt2TP35gZvZstDhSu4fufEPcMBD0/jxYGR53gCuGGxMztXvBrzj/Cw0A84E2IQHg7+7uvGjEqL4q44zF+/CA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566577459; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=oTEca0+JkMwmTD2K3n6tenNXccXxTKkMAL8MDDry6+c=; 
        b=hFjzJ++tR91MvvFdt+Fkozp3JXMQfx67GhqmF2nMZeELL02qv+gKI8uYS5PX0x3jqhMPYNRtVvnGHeljFy+nob7g1S3iVGDlB9nRLbP1hsjYZafUMPocxaFD4fVfUMZhJZ29O2IxSWwxrIaoK5Ki1wZ6fuKeO+l0JMQF1+mXFxM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566577459;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=13989; bh=oTEca0+JkMwmTD2K3n6tenNXccXxTKkMAL8MDDry6+c=;
        b=CpwXQj1G2/dWJuSd2tVlwWEDDLydCXbndDMWVS7N8RAnzJPKo/V0Q7cO8mfXTpKT
        OB99WeCCgXEzsgw/qN/ZNXtkati+P2fdZLd4fVvmDRhoXAKb+g9ITBwcqN5GFntUJ89
        Cxkt+WfevKuB8/D2huwqR2V3Zh12JAbF//bGuhwc=
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2]) by mx.zohomail.com
        with SMTPS id 1566577455386750.6789979443778; Fri, 23 Aug 2019 09:24:15 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20190823162410.10038-1-stephen@brennan.io>
Subject: [PATCH] staging: rtl8192u: remove code under TO_DO_LIST
Date:   Fri, 23 Aug 2019 09:24:10 -0700
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several blocks of code are guarded by #ifdef TO_DO_LIST. If this is
defined, compilation fails. No machinery exists to define this, and no
documenation on the in-progress feature exists. Since this code is dead,
let's delete it.

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---

Sorry, I know you're giving a keynote right now Greg :)

 .../staging/rtl8192u/ieee80211/ieee80211.h    |   2 -
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  21 ----
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       |   4 -
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |   4 -
 drivers/staging/rtl8192u/r8192U_core.c        | 101 +-----------------
 drivers/staging/rtl8192u/r819xU_phy.c         |  59 ----------
 6 files changed, 4 insertions(+), 187 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stagi=
ng/rtl8192u/ieee80211/ieee80211.h
index daebbbd8f4dd..9576b647f6b1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1649,10 +1649,8 @@ struct ieee80211_device {
 =09struct list_head=09=09Rx_TS_Pending_List;
 =09struct list_head=09=09Rx_TS_Unused_List;
 =09struct rx_ts_record=09=09RxTsRecord[TOTAL_TS_NUM];
-//#ifdef TO_DO_LIST
 =09struct rx_reorder_entry=09RxReorderEntry[128];
 =09struct list_head=09=09RxReorder_Unused_List;
-//#endif
 =09// Qos related. Added by Annie, 2005-11-01.
 //=09PSTA_QOS=09=09=09pStaQos;
 =09u8=09=09=09=09ForcedPriority;=09=09// Force per-packet priority 1~7. (d=
efault: 0, not to force it.)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_tx.c
index e76bdedc8409..140e3cb66a2e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -302,13 +302,6 @@ static void ieee80211_tx_query_agg_cap(struct ieee8021=
1_device *ieee,
 =09if (is_multicast_ether_addr(hdr->addr1))
 =09=09return;
 =09//check packet and mode later
-#ifdef TO_DO_LIST
-=09if (pTcb->PacketLength >=3D 4096)
-=09=09return;
-=09// For RTL819X, if pairwisekey =3D wep/tkip, we don't aggrregation.
-=09if (!Adapter->HalFunc.GetNmodeSupportBySecCfgHandler(Adapter))
-=09=09return;
-#endif
 =09if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
 =09=09return;
 =09}
@@ -509,20 +502,6 @@ static void ieee80211_query_protectionmode(struct ieee=
80211_device *ieee,
 static void ieee80211_txrate_selectmode(struct ieee80211_device *ieee,
 =09=09=09=09=09struct cb_desc *tcb_desc)
 {
-#ifdef TO_DO_LIST
-=09if (!IsDataFrame(pFrame)) {
-=09=09pTcb->bTxDisableRateFallBack =3D true;
-=09=09pTcb->bTxUseDriverAssingedRate =3D true;
-=09=09pTcb->RATRIndex =3D 7;
-=09=09return;
-=09}
-
-=09if (pMgntInfo->ForcedDataRate !=3D 0) {
-=09=09pTcb->bTxDisableRateFallBack =3D true;
-=09=09pTcb->bTxUseDriverAssingedRate =3D true;
-=09=09return;
-=09}
-#endif
 =09if (ieee->bTxDisableRateFallBack)
 =09=09tcb_desc->bTxDisableRateFallBack =3D true;
=20
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/=
staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c73a8058cf87..dba3f2db9f48 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -93,10 +93,6 @@ void HTUpdateDefaultSetting(struct ieee80211_device *iee=
e)
 =09ieee->bTxDisableRateFallBack =3D 0;
 =09ieee->bTxUseDriverAssingedRate =3D 0;
=20
-#ifdef=09TO_DO_LIST
-=09// 8190 only. Assign duration operation mode to firmware
-=09pMgntInfo->bTxEnableFwCalcDur =3D (BOOLEAN)pNdisCommon->bRegTxEnableFwC=
alcDur;
-#endif
 =09/*
 =09 * 8190 only, Realtek proprietary aggregation mode
 =09 * Set MPDUDensity=3D2,   1: Set MPDUDensity=3D2(32k)  for Realtek AP a=
nd set MPDUDensity=3D0(8k) for others
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/=
staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index f4e5aa07421f..5cee1031a27c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -180,14 +180,12 @@ void TSInitialize(struct ieee80211_device *ieee)
 =09}
 =09// Initialize unused Rx Reorder List.
 =09INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
-//#ifdef TO_DO_LIST
 =09for (count =3D 0; count < REORDER_ENTRY_NUM; count++) {
 =09=09list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
 =09=09if (count =3D=3D (REORDER_ENTRY_NUM - 1))
 =09=09=09break;
 =09=09pRxReorderEntry =3D &ieee->RxReorderEntry[count + 1];
 =09}
-//#endif
 }
=20
 static void AdmitTS(struct ieee80211_device *ieee,
@@ -417,7 +415,6 @@ static void RemoveTsEntry(struct ieee80211_device *ieee=
, struct ts_common_info *
 =09TsInitDelBA(ieee, pTs, TxRxSelect);
=20
 =09if (TxRxSelect =3D=3D RX_DIR) {
-//#ifdef TO_DO_LIST
 =09=09struct rx_reorder_entry=09*pRxReorderEntry;
 =09=09struct rx_ts_record     *pRxTS =3D (struct rx_ts_record *)pTs;
 =09=09if (timer_pending(&pRxTS->rx_pkt_pending_timer))
@@ -445,7 +442,6 @@ static void RemoveTsEntry(struct ieee80211_device *ieee=
, struct ts_common_info *
 =09=09=09spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 =09=09}
=20
-//#endif
 =09} else {
 =09=09struct tx_ts_record *pTxTS =3D (struct tx_ts_record *)pTs;
 =09=09del_timer_sync(&pTxTS->ts_add_ba_timer);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl81=
92u/r8192U_core.c
index 569d02240bf5..2821411878ce 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2076,14 +2076,6 @@ static void rtl8192_SetWirelessMode(struct net_devic=
e *dev, u8 wireless_mode)
 =09=09=09wireless_mode =3D WIRELESS_MODE_B;
 =09=09}
 =09}
-#ifdef TO_DO_LIST
-=09/* TODO: this function doesn't work well at this time,
-=09 * we should wait for FPGA
-=09 */
-=09ActUpdateChannelAccessSetting(
-=09=09=09pAdapter, pHalData->CurrentWirelessMode,
-=09=09=09&pAdapter->MgntInfo.Info8185.ChannelAccessSetting);
-#endif
 =09priv->ieee80211->mode =3D wireless_mode;
=20
 =09if (wireless_mode =3D=3D WIRELESS_MODE_N_24G ||
@@ -2159,12 +2151,6 @@ static int rtl8192_init_priv_variable(struct net_dev=
ice *dev)
=20
 =09priv->ieee80211->InitialGainHandler =3D InitialGain819xUsb;
 =09priv->card_type =3D USB;
-#ifdef TO_DO_LIST
-=09if (Adapter->bInHctTest) {
-=09=09pHalData->ShortRetryLimit =3D 7;
-=09=09pHalData->LongRetryLimit =3D 7;
-=09}
-#endif
 =09priv->ShortRetryLimit =3D 0x30;
 =09priv->LongRetryLimit =3D 0x30;
 =09priv->EarlyRxThreshold =3D 7;
@@ -2180,34 +2166,6 @@ static int rtl8192_init_priv_variable(struct net_dev=
ice *dev)
 =09=09 * TRUE: SW provides them
 =09=09 */
 =09=09(false ? TCR_SAT : 0);
-#ifdef TO_DO_LIST
-=09if (Adapter->bInHctTest)
-=09=09pHalData->ReceiveConfig =3D
-=09=09=09pHalData->CSMethod |
-=09=09=09/* accept management/data */
-=09=09=09RCR_AMF | RCR_ADF |
-=09=09=09/* accept control frame for SW
-=09=09=09 * AP needs PS-poll
-=09=09=09 */
-=09=09=09RCR_ACF |
-=09=09=09/* accept BC/MC/UC */
-=09=09=09RCR_AB | RCR_AM | RCR_APM |
-=09=09=09/* accept ICV/CRC error
-=09=09=09 * packet
-=09=09=09 */
-=09=09=09RCR_AICV | RCR_ACRC32 |
-=09=09=09/* Max DMA Burst Size per Tx
-=09=09=09 * DMA Burst, 7: unlimited.
-=09=09=09 */
-=09=09=09((u32)7 << RCR_MXDMA_OFFSET) |
-=09=09=09/* Rx FIFO Threshold,
-=09=09=09 * 7: No Rx threshold.
-=09=09=09 */
-=09=09=09(pHalData->EarlyRxThreshold << RCR_FIFO_OFFSET) |
-=09=09=09(pHalData->EarlyRxThreshold =3D=3D 7 ? RCR_OnlyErlPkt : 0);
-=09else
-
-#endif
 =09priv->ReceiveConfig=09=3D
 =09=09/* accept management/data */
 =09=09RCR_AMF | RCR_ADF |
@@ -2665,19 +2623,10 @@ static void rtl8192_hwconfig(struct net_device *dev=
)
 =09=09regRRSR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG;
 =09=09break;
 =09case WIRELESS_MODE_AUTO:
-#ifdef TO_DO_LIST
-=09=09if (Adapter->bInHctTest) {
-=09=09=09regBwOpMode =3D BW_OPMODE_20MHZ;
-=09=09=09regRATR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG;
-=09=09=09regRRSR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG;
-=09=09} else
-#endif
-=09=09{
-=09=09=09regBwOpMode =3D BW_OPMODE_20MHZ;
-=09=09=09regRATR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG |
-=09=09=09=09  RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
-=09=09=09regRRSR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG;
-=09=09}
+=09=09regBwOpMode =3D BW_OPMODE_20MHZ;
+=09=09regRATR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG |
+=09=09=09  RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
+=09=09regRRSR =3D RATE_ALL_CCK | RATE_ALL_OFDM_AG;
 =09=09break;
 =09case WIRELESS_MODE_N_24G:
 =09=09/* It support CCK rate by default. CCK rate will be filtered
@@ -2848,48 +2797,6 @@ static bool rtl8192_adapter_start(struct net_device =
*dev)
 =09}
 =09RT_TRACE(COMP_INIT, "%s():after firmware download\n", __func__);
=20
-#ifdef TO_DO_LIST
-=09if (Adapter->ResetProgress =3D=3D RESET_TYPE_NORESET) {
-=09=09if (pMgntInfo->RegRfOff) { /* User disable RF via registry. */
-=09=09=09RT_TRACE((COMP_INIT | COMP_RF), DBG_LOUD,
-=09=09=09=09 ("InitializeAdapter819xUsb(): Turn off RF for RegRfOff ------=
----\n"));
-=09=09=09MgntActSet_RF_State(Adapter, eRfOff, RF_CHANGE_BY_SW);
-=09=09=09/* Those actions will be discard in MgntActSet_RF_State
-=09=09=09 * because of the same state
-=09=09=09 */
-=09=09=09for (eRFPath =3D 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++=
)
-=09=09=09=09PHY_SetRFReg(Adapter,
-=09=09=09=09=09     (enum rf90_radio_path_e)eRFPath,
-=09=09=09=09=09     0x4, 0xC00, 0x0);
-=09=09} else if (pMgntInfo->RfOffReason > RF_CHANGE_BY_PS) {
-=09=09=09/* H/W or S/W RF OFF before sleep. */
-=09=09=09RT_TRACE((COMP_INIT | COMP_RF), DBG_LOUD,
-=09=09=09=09 ("InitializeAdapter819xUsb(): Turn off RF for RfOffReason(%d)=
 ----------\n",
-=09=09=09=09  pMgntInfo->RfOffReason));
-=09=09=09MgntActSet_RF_State(Adapter,
-=09=09=09=09=09    eRfOff,
-=09=09=09=09=09    pMgntInfo->RfOffReason);
-=09=09} else {
-=09=09=09pHalData->eRFPowerState =3D eRfOn;
-=09=09=09pMgntInfo->RfOffReason =3D 0;
-=09=09=09RT_TRACE((COMP_INIT | COMP_RF), DBG_LOUD,
-=09=09=09=09 ("InitializeAdapter819xUsb(): RF is on ----------\n"));
-=09=09}
-=09} else {
-=09=09if (pHalData->eRFPowerState =3D=3D eRfOff) {
-=09=09=09MgntActSet_RF_State(Adapter,
-=09=09=09=09=09    eRfOff,
-=09=09=09=09=09    pMgntInfo->RfOffReason);
-=09=09=09/* Those actions will be discard in MgntActSet_RF_State
-=09=09=09 * because of the same state
-=09=09=09 */
-=09=09=09for (eRFPath =3D 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++=
)
-=09=09=09=09PHY_SetRFReg(Adapter,
-=09=09=09=09=09     (enum rf90_radio_path_e)eRFPath,
-=09=09=09=09=09     0x4, 0xC00, 0x0);
-=09=09}
-=09}
-#endif
 =09/* config RF. */
 =09if (priv->ResetProgress =3D=3D RESET_TYPE_NORESET) {
 =09=09rtl8192_phy_RFConfig(dev);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl819=
2u/r819xU_phy.c
index 5f04afe53d69..c04d8eca0cfb 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -516,16 +516,6 @@ static void rtl8192_phyConfigBB(struct net_device *dev=
,
 {
 =09u32 i;
=20
-#ifdef TO_DO_LIST
-=09u32 *rtl8192PhyRegArrayTable =3D NULL, *rtl8192AgcTabArrayTable =3D NUL=
L;
-
-=09if (Adapter->bInHctTest) {
-=09=09PHY_REGArrayLen =3D PHY_REGArrayLengthDTM;
-=09=09AGCTAB_ArrayLen =3D AGCTAB_ArrayLengthDTM;
-=09=09Rtl8190PHY_REGArray_Table =3D Rtl819XPHY_REGArrayDTM;
-=09=09Rtl8190AGCTAB_Array_Table =3D Rtl819XAGCTAB_ArrayDTM;
-=09}
-#endif
 =09if (ConfigType =3D=3D BASEBAND_CONFIG_PHY_REG) {
 =09=09for (i =3D 0; i < PHY_REG_1T2RArrayLength; i +=3D 2) {
 =09=09=09rtl8192_setBBreg(dev, Rtl8192UsbPHY_REG_1T2RArray[i],
@@ -1059,10 +1049,6 @@ static void rtl8192_SetTxPowerLevel(struct net_devic=
e *dev, u8 channel)
=20
 =09switch (priv->rf_chip) {
 =09case RF_8225:
-#ifdef TO_DO_LIST
-=09=09PHY_SetRF8225CckTxPower(Adapter, powerlevel);
-=09=09PHY_SetRF8225OfdmTxPower(Adapter, powerlevelOFDM24G);
-#endif
 =09=09break;
=20
 =09case RF_8256:
@@ -1160,48 +1146,6 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
 =09=09RT_TRACE(COMP_ERR, "Not support rf_chip(%x)\n", priv->rf_chip);
 =09=09break;
 =09}
-#ifdef TO_DO_LIST
-=09if (bResult) {
-=09=09/* Update current RF state variable. */
-=09=09pHalData->eRFPowerState =3D eRFPowerState;
-=09=09switch (pHalData->RFChipID) {
-=09=09case RF_8256:
-=09=09=09switch (pHalData->eRFPowerState) {
-=09=09=09case eRfOff:
-=09=09=09=09/* If Rf off reason is from IPS,
-=09=09=09=09 * LED should blink with no link
-=09=09=09=09 */
-=09=09=09=09if (pMgntInfo->RfOffReason =3D=3D RF_CHANGE_BY_IPS)
-=09=09=09=09=09Adapter->HalFunc.LedControlHandler(Adapter, LED_CTL_NO_LINK=
);
-=09=09=09=09else
-=09=09=09=09=09/* Turn off LED if RF is not ON. */
-=09=09=09=09=09Adapter->HalFunc.LedControlHandler(Adapter, LED_CTL_POWER_O=
FF);
-=09=09=09=09break;
-
-=09=09=09case eRfOn:
-=09=09=09=09/* Turn on RF we are still linked, which might
-=09=09=09=09 * happen when we quickly turn off and on HW RF.
-=09=09=09=09 */
-=09=09=09=09if (pMgntInfo->bMediaConnect)
-=09=09=09=09=09Adapter->HalFunc.LedControlHandler(Adapter, LED_CTL_LINK);
-=09=09=09=09else
-=09=09=09=09=09/* Turn off LED if RF is not ON. */
-=09=09=09=09=09Adapter->HalFunc.LedControlHandler(Adapter, LED_CTL_NO_LINK=
);
-=09=09=09=09break;
-
-=09=09=09default:
-=09=09=09=09break;
-=09=09=09}
-=09=09=09break;
-
-=09=09default:
-=09=09=09RT_TRACE(COMP_RF, DBG_LOUD, "%s(): Unknown RF type\n",
-=09=09=09=09 __func__);
-=09=09=09break;
-=09=09}
-
-=09}
-#endif
 =09priv->SetRFPowerStateInProgress =3D false;
=20
 =09return bResult;
@@ -1628,9 +1572,6 @@ void rtl8192_SetBWModeWorkItem(struct net_device *dev=
)
 =09/* <3> Set RF related register */
 =09switch (priv->rf_chip) {
 =09case RF_8225:
-#ifdef TO_DO_LIST
-=09=09PHY_SetRF8225Bandwidth(Adapter, pHalData->CurrentChannelBW);
-#endif
 =09=09break;
=20
 =09case RF_8256:
--=20
2.22.0



