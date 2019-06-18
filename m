Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E06C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD85206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRncx7EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfFRS7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:59:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34157 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfFRS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:59:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so6090839plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=y+ZDxvhg6PfCf4IaZBcbrHBra9kFTGCeQt6ukY9Ho2c=;
        b=nRncx7EOSI8bpyFlXJgspqlwi28rdU1sQt1sug6gGAs+t+Uv3/uUp1NQBzrbB1ze1T
         3FCDVP3O8gLOvoMlsUwnGW7mvMH3ImxYoCpJ2o5bfigZQuRdpYRrErD+1WCq4Pkz0avG
         yjsMV/DoEDfVhs78Q7Es607e/0os41JdWxGdvLnURS/nqAMm3mELuynV0CN7DOjOwt7B
         DhKZoPEXSIb2aF3QMVhz4cOtw6ow0GR4X7xxU5G0mQANMLqzSXPgJgoFibnLp614ejQH
         ygQZEassjhjVZppc7oBha8KP9r+Ol6JbokONcyIaVd1hsS/CK06iIazzIQ1Odu4HibEY
         5qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y+ZDxvhg6PfCf4IaZBcbrHBra9kFTGCeQt6ukY9Ho2c=;
        b=WcrYMO+oT7X3WzW7uGqymaNHjgIgNuA7g+deeV2s5FSvxR2XvF1ZFkoRZcpEahG+4B
         WRdXKcchwzixHLzNYt2TBE/MpVpsfvAIFP+aGUQkpMSXjSlbnnKPak99FT6HS0uBUD8/
         VX5mfGubw/FsHGUmUJptUA0YrfhlLlZIGZ4Km+kvSoD9sqD4lATFHg4suZ4jkN3w9JCr
         dnzj3mPd96+3eaSKME1FCYHgXx0GLRjdanLvrRCVs5JQgQ73waLPjnDQIM2qlQ4hRqQB
         hk1L4xs2T/IxGPe0fBgtvFHRnD1LvHC+uvbmJKjJVHjK5GhgEpEx99PwRLxaGfAoJzdh
         lyMQ==
X-Gm-Message-State: APjAAAXw3X+Tt+Lpylg461vRtqfpXWglBwSLdfi6keeQyXEx+qg8WvX2
        qXTWzNMCZLVWaQNqNQzZa4Q=
X-Google-Smtp-Source: APXvYqwCNvxBPbmi9lBvV2rvBdNFjHetK1v0rh6W/q5yTjTULLOipHLy68oH9MJTww8Rq8taYliBfA==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr106993136plo.252.1560884371384;
        Tue, 18 Jun 2019 11:59:31 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id h62sm15489909pgc.54.2019.06.18.11.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:59:31 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:29:27 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: hal: rtl8723b_cmd: fix comparison to
 true is error prone
Message-ID: <20190618185926.GA10510@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below issues reported by checkpatch

CHECK: Using comparison to true is error prone
CHECK: Using comparison to false is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index ceb317f..48efbfd 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -73,7 +73,7 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 		goto exit;
 	}
 
-	if (padapter->bSurpriseRemoved == true)
+	if (padapter->bSurpriseRemoved)
 		goto exit;
 
 	/* pay attention to if  race condition happened in  H2C cmd setting. */
@@ -297,7 +297,7 @@ static void ConstructNullFunctionData(
 
 	SetSeqNum(pwlanhdr, 0);
 
-	if (bQoS == true) {
+	if (bQoS) {
 		struct ieee80211_qos_hdr *pwlanqoshdr;
 
 		SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
@@ -1071,7 +1071,7 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 	SET_8723B_H2CCMD_PWRMODE_PARM_PWR_STATE(u1H2CPwrModeParm, PowerState);
 	SET_8723B_H2CCMD_PWRMODE_PARM_BYTE5(u1H2CPwrModeParm, byte5);
 	if (psmode != PS_MODE_ACTIVE) {
-		if (pmlmeext->adaptive_tsf_done == false && pmlmeext->bcn_cnt > 0) {
+		if (!pmlmeext->adaptive_tsf_done && pmlmeext->bcn_cnt > 0) {
 			u8 ratio_20_delay, ratio_80_delay;
 
 			/* byte 6 for adaptive_early_32k */
@@ -1252,7 +1252,7 @@ static void rtl8723b_set_FwRemoteWakeCtrl_Cmd(struct adapter *padapter, u8 benab
 	FillH2CCmd8723B(padapter, H2C_8723B_REMOTE_WAKE_CTRL,
 		H2C_REMOTE_WAKE_CTRL_LEN, u1H2CRemoteWakeCtrlParm);
 #ifdef CONFIG_PNO_SUPPORT
-	if (ppwrpriv->wowlan_pno_enable && ppwrpriv->pno_in_resume == false) {
+	if (ppwrpriv->wowlan_pno_enable && !ppwrpriv->pno_in_resume) {
 		res = rtw_read8(padapter, REG_PNO_STATUS);
 		DBG_871X("cmd: 0x81 REG_PNO_STATUS: 0x%02x\n", res);
 		while (!(res&BIT(7)) && count < 25) {
@@ -1671,7 +1671,7 @@ static void rtl8723b_set_FwRsvdPagePkt(
 #endif /* CONFIG_WOWLAN */
 	{
 #ifdef CONFIG_PNO_SUPPORT
-		if (pwrctl->pno_in_resume == false && pwrctl->pno_inited == true) {
+		if (!pwrctl->pno_in_resume && pwrctl->pno_inited) {
 			/* Probe Request */
 			RsvdPageLoc.LocProbePacket = TotalPageNum;
 			ConstructProbeReq(
@@ -2119,7 +2119,7 @@ static void ConstructBtNullFunctionData(
 	SetDuration(pwlanhdr, 0);
 	SetSeqNum(pwlanhdr, 0);
 
-	if (bQoS == true) {
+	if (bQoS) {
 		struct ieee80211_qos_hdr *pwlanqoshdr;
 
 		SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
@@ -2307,7 +2307,7 @@ void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter)
 		} while (!bcn_valid && (poll%10) != 0 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 	} while (!bcn_valid && (DLBcnCount <= 100) && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 
-	if (true == bcn_valid) {
+	if (bcn_valid) {
 		struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 		pwrctl->fw_psmode_iface_id = padapter->iface_id;
 		DBG_8192C(ADPT_FMT": DL RSVD page success! DLBcnCount:%d, poll:%d\n",
-- 
2.7.4

