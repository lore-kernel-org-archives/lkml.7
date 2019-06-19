Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9525C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771C120863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBLv4pZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfFSBma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:42:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39980 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:42:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so4026708pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=STB7h5+2Y7cU4MpOvwG2Z7A2iyL9rnqXUTWvSKVLNGE=;
        b=QBLv4pZB/j9bPAtUHIqRpmFZLnVtzbS8SwUjVbQAZdU8UNgyW/x2j60nPnhfI3PeXC
         JBX4DTLeonBSFqHh5FpPvto2MR1RKxaQKzB/ERZmV8qcnbN4vR1IVj71GCymoi2YCxZ2
         gZ+luNRPxZptjweuJJNqIF0d7ml7pSZM9g+ftk1YWW49oA0RFV4rEeOCE7lWmU9UshoC
         0j8/eeuzwtqTWi/KEc4jQZ8RzMuJrT5EZMDPW3lZ7Q4EBuNsLle1asxzQnAH1jFyU/QM
         m5dQujdlP5+BJQbEDGsrSUYUx49cZtMt8EP4KddwczQsJJuCQLeqyOaFQwe+1Z9dkBQT
         2Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=STB7h5+2Y7cU4MpOvwG2Z7A2iyL9rnqXUTWvSKVLNGE=;
        b=arT+jSZzhWpTHuNDzy2/WQ99UusG4pVnO8QohFo32+6XTJsz8Rkb5ps4UEVuRMlqX8
         AcTL0X05RmRp6TAV+RouOwftSEaGGBtwYhDHlCQZyrXMT+efbkd94Z3QJBdmfH9nNA3c
         d5liJpjnM7ElfBdDB9IqvdgbZvxQur2dOfw5nimB+5Qfy5ZwTx3G2f9WFVsO4efsQmxz
         DHtVTxcv3fvFNCSKVbPZKi/+RxFSWeV9r6dAE6J+KjS8m/6+sJFwFn5eCiB8St5hDDmL
         Kq+xoDh1OqVmXg1LRQE7oJ0EgdyhPoCjNJudMfQM3QB8d7hb6pT1td/qVsJru3JZqDFd
         lY6Q==
X-Gm-Message-State: APjAAAXlLocXEm/349OEsWUeU75C1cfMx2kIYXlUGpXW3LNBTJD68rWc
        j/f3fZDRKYwCZloGAICvQNk=
X-Google-Smtp-Source: APXvYqwv0YdviDGa8ioopDbSPw8J6EpmHfrs20Dy1AsXZ9hUEHm2dLbHybwfSC+E8xHQxJVPQGidOQ==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr8266681pje.125.1560908549332;
        Tue, 18 Jun 2019 18:42:29 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id q1sm20769182pfn.178.2019.06.18.18.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 18:42:28 -0700 (PDT)
Date:   Tue, 18 Jun 2019 18:42:26 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     shobhitkukreti@gmail.com
Subject: [PATCH] staging: rtl8723bs: hal: Fix Brace Style Issues in if/else
 statements
Message-ID: <20190619014223.GA2186@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned Up code to fix brace style issues reported by checkpatch:

-space required before the open brace '{'
-Unbalanced braces around if/else statements

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index fd0be52..342ee26 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -112,9 +112,9 @@ void DBG_BT_INFO(u8 *dbgmsg)
 /*  */
 static u8 halbtcoutsrc_IsBtCoexistAvailable(PBTC_COEXIST pBtCoexist)
 {
-	if (!pBtCoexist->bBinded || !pBtCoexist->Adapter){
+	if (!pBtCoexist->bBinded || !pBtCoexist->Adapter)
 		return false;
-	}
+
 	return true;
 }
 
@@ -256,13 +256,11 @@ static void halbtcoutsrc_AggregationCheck(PBTC_COEXIST pBtCoexist)
 	padapter = pBtCoexist->Adapter;
 	bNeedToAct = false;
 
-	if (pBtCoexist->btInfo.bRejectAggPkt)
+	if (pBtCoexist->btInfo.bRejectAggPkt) {
 		rtw_btcoex_RejectApAggregatedPacket(padapter, true);
-	else {
-
+	} else {
 		if (pBtCoexist->btInfo.bPreBtCtrlAggBufSize !=
-			pBtCoexist->btInfo.bBtCtrlAggBufSize){
-
+			pBtCoexist->btInfo.bBtCtrlAggBufSize) {
 			bNeedToAct = true;
 			pBtCoexist->btInfo.bPreBtCtrlAggBufSize = pBtCoexist->btInfo.bBtCtrlAggBufSize;
 		}
@@ -816,11 +814,10 @@ static void halbtcoutsrc_WriteLocalReg1Byte(void *pBtcContext, u32 RegAddr, u8 D
 	PBTC_COEXIST		pBtCoexist = (PBTC_COEXIST)pBtcContext;
 	struct adapter *Adapter = pBtCoexist->Adapter;
 
-	if (BTC_INTF_SDIO == pBtCoexist->chipInterface) {
+	if (BTC_INTF_SDIO == pBtCoexist->chipInterface)
 		rtw_write8(Adapter, SDIO_LOCAL_BASE | RegAddr, Data);
-	} else {
+	else
 		rtw_write8(Adapter, RegAddr, Data);
-	}
 }
 
 static void halbtcoutsrc_SetBbReg(void *pBtcContext, u32 RegAddr, u32 BitMask, u32 Data)
@@ -1196,13 +1193,13 @@ void EXhalbtcoutsrc_SpecialPacketNotify(PBTC_COEXIST pBtCoexist, u8 pktType)
 	if (pBtCoexist->bManualControl)
 		return;
 
-	if (PACKET_DHCP == pktType)
+	if (PACKET_DHCP == pktType) {
 		packetType = BTC_PACKET_DHCP;
-	else if (PACKET_EAPOL == pktType)
+	} else if (PACKET_EAPOL == pktType) {
 		packetType = BTC_PACKET_EAPOL;
-	else if (PACKET_ARP == pktType)
+	} else if (PACKET_ARP == pktType) {
 		packetType = BTC_PACKET_ARP;
-	else {
+	} else {
 		packetType = BTC_PACKET_UNKNOWN;
 		return;
 	}
-- 
2.7.4

