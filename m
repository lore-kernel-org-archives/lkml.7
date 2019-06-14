Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A8C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BCF20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7HSY7Ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfFNCym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:54:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41754 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFNCyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:54:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so642694pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jZ4MKy9YxFUhqGFBTxUT54NN/xTa5W9Uj5g9ozrgptI=;
        b=Q7HSY7EjZQGQ9Ik/MhnqXQKFZ1HJLMJYroXRmjlLJiKzhIVleX5aslqolb/ew30xaM
         Wlm4fqGahygpGiVioY9RFEeyY1d5cCDRkirAEY6Nir+L3ntcgAykS0q0HyR7rjMxFQKt
         PSm2n/0Pz7jPoONTlL9bnN/g77+Ncx2kXJTFuZvo0fEt2g1ZDosIw8KfVOvsmJ18AA52
         6YCZXFvpoQKFTVkaTO0ZHO+Jg2gQcniXTRAEYAHfudN2UBJoKzZaPVd+HBg0xQd2txIA
         tqqgWB+zASyZW4n+gKDOSYmDg72ygT17Iy5bziFmZGFA89UNW3Ig+U4xGdRwe84irubg
         eLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jZ4MKy9YxFUhqGFBTxUT54NN/xTa5W9Uj5g9ozrgptI=;
        b=UOymInCtT3j6NkLL9e2lZaeONbDwVfLthCuecWs7PAAcdwgg+/5wv6pS3QNFxHwPfX
         3rh60Rrc/rmYN+qiy/1eZNQdP6/ByRsXpTN1RQhlkTicXKjztamEW4noUZwQyq6yZYQq
         2TzpfXg8m3nYmtajJGMI4iybSqwoFgIzi9nPAhoujpmT/XRjSCQ+LL3SUvx1gXPEHUy/
         hcXa5XTLtTy2wVEZgf7UwYgvhl1tN7GahOZe6MWCv/f9GBssEcKfuB3sZ28ZWZDQ3ock
         MEpkSQz+i68SzwhDqmoQ8u1SnNMeQC+JLg0rGwLrWk1oZbXtOBYTNioHAQYDq07OGDgt
         pQtA==
X-Gm-Message-State: APjAAAWjbNaDf1eNYEUU0nEcKIRYUbAFiEOD61CW8wn5mtCqY04YPNUu
        7hriudnYeGrneXnw4cCMH+c=
X-Google-Smtp-Source: APXvYqybA+iWIZjbf7ta+ltJQot2TZ9pQmvj4Z1cPVeC9gfppYWgN4MB4WNMREeDrSs9w+LaH36aiQ==
X-Received: by 2002:aa7:921a:: with SMTP id 26mr52507472pfo.99.1560480879482;
        Thu, 13 Jun 2019 19:54:39 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id p3sm1096076pgh.90.2019.06.13.19.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 19:54:38 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:24:34 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 1/3] staging: rtl8723bs: hal: sdio_halinit: fix comparison
 to true/false is error prone
Message-ID: <20190614025433.GA3419@hari-Inspiron-1545>
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
----
changes in v2:      send proper patch without corruption
----
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 3c65a9c..4db3211 100644
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
 
 /* 	SIC_Init(padapter); */
 
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
-		if (adapter_to_pwrctl(padapter)->bips_processing == true) {
-			if (padapter->netif_up == true) {
+	if (padapter->hw_init_completed) {
+		if (adapter_to_pwrctl(padapter)->bips_processing) {
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

