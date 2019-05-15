Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7314C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8977A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919819;
	bh=Z4GpA9J3EViTNKyAvolCiSzizfWdwFOlxZxX4c3O2tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fhKNinTaNwAeL4xjxcZWvj9IWF465OdAXnHFb5aI+k2kpiNRibZte8w+Wn1AOPcY5
	 7R7ICNNwyAcZAGBBNI9S8cf8StNeP8EEc3iQKVOcnucpdjvU4EQn2XdhHs/fHBpKGz
	 s+nYNAWpEvjRH3LBAN5GKD6VkARxSzxf0NMh7pw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfEOLaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfEOLaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:30:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468C22084A;
        Wed, 15 May 2019 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919812;
        bh=Z4GpA9J3EViTNKyAvolCiSzizfWdwFOlxZxX4c3O2tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+GnVcqusfSc856TGPe/cx48VQO0Ra4z/8cjFMarg7XQebMm1nBAn74XN/ieBbE0c
         Xvsfqw96zwtGRHU31FpyK0DZmA73cbNY4MkTt380gj5xt1w965lsjzC8muTYfYBqNP
         DEE+Yx1pG5xTvH59YHMMdzvutOJOI4Bz9CT27GYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.0 103/137] rtlwifi: rtl8723ae: Fix missing break in switch statement
Date:   Wed, 15 May 2019 12:56:24 +0200
Message-Id: <20190515090701.007123281@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 84242b82d81c54e009a2aaa74d3d9eff70babf56 upstream.

Add missing break statement in order to prevent the code from falling
through to case 0x1025, and erroneously setting rtlhal->oem_id to
RT_CID_819X_ACER when rtlefuse->eeprom_svid is equal to 0x10EC and
none of the cases in switch (rtlefuse->eeprom_smid) match.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: 238ad2ddf34b ("rtlwifi: rtl8723ae: Clean up the hardware info routine")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -1697,6 +1697,7 @@ static void _rtl8723e_read_adapter_info(
 					rtlhal->oem_id = RT_CID_819X_LENOVO;
 					break;
 				}
+				break;
 			case 0x1025:
 				rtlhal->oem_id = RT_CID_819X_ACER;
 				break;


