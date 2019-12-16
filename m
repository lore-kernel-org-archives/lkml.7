Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A36C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C7F206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521782;
	bh=THkWYfbYqwMUh/V+4lMLpITaj51ocDZHj/jxhLPmitI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ByRgYSN0VHtyFT5ZOnRMFHNrt/lTJvR9XmN5V8dxOu07/qBL45/WHcxcVtTsiW0EU
	 Q6Xx+vEkm6++kG4/bzFgaynnzik3sMeSs3yyVqWklBr2lUa1nofkyOCXCSHouJWOYS
	 oGo27gvBEph7xibI9m/dRzVYlW8hy7Ze83qCHAzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfLPSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfLPR7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:59:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F17205ED;
        Mon, 16 Dec 2019 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519194;
        bh=THkWYfbYqwMUh/V+4lMLpITaj51ocDZHj/jxhLPmitI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zg1DaK1c1L9iXswPK7mBnFbtTbEZwtnd2H6E/tkOE7uC4SGMpSu/xhgVoRba09mtN
         wHFsTJf0KpBZvR1goXn6kHEk5Cd56gTtsRBhQ+j1yb1fw+rBT+1mt/aLBqjLcfJXQy
         G2zB8P54QXMQWOUZ78rS0PD3k/GebSelN2kX7UEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 193/267] rtlwifi: rtl8192de: Fix missing enable interrupt flag
Date:   Mon, 16 Dec 2019 18:48:39 +0100
Message-Id: <20191216174913.100077078@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 330bb7117101099c687e9c7f13d48068670b9c62 upstream.

In commit 38506ecefab9 ("rtlwifi: rtl_pci: Start modification for
new drivers"), the flag that indicates that interrupts are enabled was
never set.

In addition, there are several places when enable/disable interrupts
were commented out are restored. A sychronize_interrupts() call is
removed.

Fixes: 38506ecefab9 ("rtlwifi: rtl_pci: Start modification for new drivers")
Cc: Stable <stable@vger.kernel.org>	# v3.18+
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -1198,6 +1198,7 @@ void rtl92de_enable_interrupt(struct iee
 
 	rtl_write_dword(rtlpriv, REG_HIMR, rtlpci->irq_mask[0] & 0xFFFFFFFF);
 	rtl_write_dword(rtlpriv, REG_HIMRE, rtlpci->irq_mask[1] & 0xFFFFFFFF);
+	rtlpci->irq_enabled = true;
 }
 
 void rtl92de_disable_interrupt(struct ieee80211_hw *hw)
@@ -1207,7 +1208,7 @@ void rtl92de_disable_interrupt(struct ie
 
 	rtl_write_dword(rtlpriv, REG_HIMR, IMR8190_DISABLED);
 	rtl_write_dword(rtlpriv, REG_HIMRE, IMR8190_DISABLED);
-	synchronize_irq(rtlpci->pdev->irq);
+	rtlpci->irq_enabled = false;
 }
 
 static void _rtl92de_poweroff_adapter(struct ieee80211_hw *hw)
@@ -1378,7 +1379,7 @@ void rtl92de_set_beacon_related_register
 
 	bcn_interval = mac->beacon_interval;
 	atim_window = 2;
-	/*rtl92de_disable_interrupt(hw);  */
+	rtl92de_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_ATIMWND, atim_window);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	rtl_write_word(rtlpriv, REG_BCNTCFG, 0x660f);
@@ -1398,9 +1399,9 @@ void rtl92de_set_beacon_interval(struct
 
 	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
 		 "beacon_interval:%d\n", bcn_interval);
-	/* rtl92de_disable_interrupt(hw); */
+	rtl92de_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
-	/* rtl92de_enable_interrupt(hw); */
+	rtl92de_enable_interrupt(hw);
 }
 
 void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,


