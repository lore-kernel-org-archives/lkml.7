Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8EC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06162086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj5dIYRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408442AbfFLCaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:30:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35490 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405046AbfFLCaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:30:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so5958666plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t/rKc3UZZprCkI3wfeBbbL1oVUA4HMdb6pTNv5jLyR8=;
        b=Cj5dIYRv5xHkfWnoRUxXfl7u999Son8N/lGdopdqLfG+VmK+JRrGtBGsqlwTBFXbDZ
         5VXTbjdmESfdMiySOW9wvkUQA98dtrx8sh46BmlJL9MjqgYCzfP+rmIADR6cFeeqCUyM
         LVf0IOmzRiUKk+HjDtGhmM9GENkBKdmNuNfa7R4S0bSrAbqYOttG5cvIczCBYW5BOlpw
         DnE9pLo8tPSjIKmwcY24WLMCt9e7xaKqpl/iusfIuVZ2ld43WEzvlk6+w/M2+JWmo2ti
         tgG1gCC556flN8mvNBdNZNgTkbEGpzJie3a3Ih9gJM+yZSkgvtauMKaJiIRSQH4smUiA
         ITxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t/rKc3UZZprCkI3wfeBbbL1oVUA4HMdb6pTNv5jLyR8=;
        b=I1kIkj2zjY+nIuHe6p8gJ+8cmZhrhusCHJvpZWbsj9vC7OZlQClnIm4p/aciUkNFZg
         bXlTIOxFWKxJKUprtyq58dN+ximiVsXBRn1LuLzjv01Kx4UHr/f3trIUYXiN7ToGctVu
         /sSjT9cVWKwznbMyx/02V/0aaiw+OJmfhB9MMt+aujUSv3czdJR8g8NELW7boWT8eHEd
         hDslTA9D8NFYhMacpW46vblP1xWlG+Kr/vwj3kQ+ZSxB5AkfS4KBJef0oVdiuK9BY+Vo
         ehHO8eAnf/Kk8C+d1FGVNa92RohKW0+1bCGnM4697k0fX57XIXxiqe1EdcH3R4Uejl3H
         LaVQ==
X-Gm-Message-State: APjAAAWqcddtEv2ib0OWjMV14CX+OmC/OacN7hCkS4e05YhgzJi1dWC8
        +G0BfkCYImCUgWUdbC0gJi/wH90t
X-Google-Smtp-Source: APXvYqwf7Zp29rxomvSWiSoF/w4ki3aL363oWnSRiCls9jLx8X+BkZoR17yHp8KcSZoNLMHApQzbcA==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16mr12324750pls.54.1560306602272;
        Tue, 11 Jun 2019 19:30:02 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id x17sm15448463pgk.72.2019.06.11.19.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:30:01 -0700 (PDT)
Date:   Wed, 12 Jun 2019 07:59:57 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: hal: sdio_halinit: fix comparison to
 true/false is error prone
Message-ID: <20190612022956.GA23698@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 3c65a9c..70f9e1d 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -26,7 +26,7 @@ static u8 CardEnable(struct adapter *padapter)


	rtw_hal_get_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
-	if (bMacPwrCtrlOn == false) {
+	if (!bMacPwrCtrlOn) {
		/*  RSV_CTRL 0x1C[7:0] = 0x00 */
		/*  unlock ISO/CLK/Power control register */
		rtw_write8(padapter, REG_RSV_CTRL, 0x0);
@@ -127,7 +127,7 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)

	/*  only cmd52 can be used before power on(card enable) */
	ret = CardEnable(padapter);
-	if (ret == false) {
+	if (!ret) {
		RT_TRACE(
			_module_hci_hal_init_c_,
			_drv_emerg_,
@@ -838,7 +838,7 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)

 /*	SIC_Init(padapter); */

-	if (pwrctrlpriv->reg_rfoff == true)
+	if (pwrctrlpriv->reg_rfoff)
		pwrctrlpriv->rf_pwrstate = rf_off;

	/*  2010/08/09 MH We need to check if we need to turnon or off RF after detecting */
@@ -1081,7 +1081,7 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
	ret = false;
	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
-	if (ret == false) {
+	if (!ret) {
		DBG_8192C(KERN_ERR "%s: run CARD DISABLE flow fail!\n", __func__);
	}
 }
@@ -1091,9 +1091,9 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
	struct dvobj_priv *psdpriv = padapter->dvobj;
	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;

-	if (padapter->hw_init_completed == true) {
+	if (padapter->hw_init_completed) {
		if (adapter_to_pwrctl(padapter)->bips_processing == true) {
-			if (padapter->netif_up == true) {
+			if (padapter->netif_up) {
				int cnt = 0;
				u8 val8 = 0;

@@ -1387,7 +1387,7 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+_ReadAdapterInfo8723BS\n"));

	/*  before access eFuse, make sure card enable has been called */
-	if (padapter->hw_init_completed == false)
+	if (!padapter->hw_init_completed)
		_InitPowerOn_8723BS(padapter);


@@ -1404,7 +1404,7 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
	_ReadPROMContent(padapter);
	_InitOtherVariable(padapter);

-	if (padapter->hw_init_completed == false) {
+	if (!padapter->hw_init_completed) {
		rtw_write8(padapter, 0x67, 0x00); /*  for BT, Switch Ant control to BT */
		CardDisableRTL8723BSdio(padapter);/* for the power consumption issue,  wifi ko module is loaded during booting, but wifi GUI is off */
	}
--
2.7.4

