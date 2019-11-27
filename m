Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC04B21775
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887540;
	bh=qt2ZaBJBkqKDo6O0kCiyXnG1cMLezHLkJkx66ql/bfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/LRIHnCKvmNKTc+XAA5BNtXLOCyNT1VB92YUxUCTtiPvshh625GoDvudD3lywWXe
	 eCpvFTmP/xrQR8q5dnRkVLNWlKUcLjdB5fpbX2KKW97j1VPHBB2YW210ifEPmCgeq2
	 i1XI+MFTJt5waFlog8xjydlVBMA9F4G1blXnNrUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfK0Upi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfK0Upg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 696D721741;
        Wed, 27 Nov 2019 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887535;
        bh=qt2ZaBJBkqKDo6O0kCiyXnG1cMLezHLkJkx66ql/bfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge01y1Q+6ZkgB+AfVwvuwJXuHC7Mhy7GPqJL+o2J94niNCOwij27DtVc6Wag7auYZ
         c8RpIo287r2d/rUzkHPkPfiKCGkLwLXTNHNb9R/K3ZDkjXgAs9f1yqT3YxagLUgbTO
         OHlFJLplPd1nsPXx9Gl1mcMblH8+ZX2GCYBm907o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 4.9 112/151] ath9k_hw: fix uninitialized variable data
Date:   Wed, 27 Nov 2019 21:31:35 +0100
Message-Id: <20191127203043.201695755@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit 80e84f36412e0c5172447b6947068dca0d04ee82 upstream.

Currently, data variable in ar9003_hw_thermo_cal_apply() could be
uninitialized if ar9300_otp_read_word() will fail to read the value.
Initialize data variable with 0 to prevent an undefined behavior. This
will be enough to handle error case when ar9300_otp_read_word() fails.

Fixes: 80fe43f2bbd5 ("ath9k_hw: Read and configure thermocal for AR9462")
Cc: Rajkumar Manoharan <rmanohar@qca.qualcomm.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -4115,7 +4115,7 @@ static void ar9003_hw_thermometer_apply(
 
 static void ar9003_hw_thermo_cal_apply(struct ath_hw *ah)
 {
-	u32 data, ko, kg;
+	u32 data = 0, ko, kg;
 
 	if (!AR_SREV_9462_20_OR_LATER(ah))
 		return;


