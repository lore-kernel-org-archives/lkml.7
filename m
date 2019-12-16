Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09688C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF972166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520759;
	bh=5TQRcs3ecqEAJWonY7FMDAfQjZlXz7Y3PYJHeOYi2r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vu/8ID3Buw5Pvp4ewhkXsvoo7EIuvwrEUzpKeWxI7X2SyWjOq+aw/e/eAw3RFlJNG
	 qXlnc/BY6YQT+GnuJtSkTXbhpu6PX4b1l2WdpGauIedEc0QLDJKexW6FsS8IdLJn08
	 jvWx9/4Kq5twxvKAZh5Lt4U77hhf5zPIUMFVgXOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfLPSRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731659AbfLPSR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:17:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51AC207FF;
        Mon, 16 Dec 2019 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520247;
        bh=5TQRcs3ecqEAJWonY7FMDAfQjZlXz7Y3PYJHeOYi2r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZeEvJvlY70KVAcBKeGkLm5kq8FtFrDQBmXVP8jg0mGf7eCoFAnIYbhKw2LfqXneK
         SdL2Bld/h8XORBLSAGXG8ZsC0X+IukFaPF4SClEZUbRPULGomSieI5D7TgnUJY9k/n
         Yo56QtRz25OmRuZ1sBmFPdneSh4hCj+uU5cMV8VM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 075/177] rtlwifi: rtl8192de: Fix missing code to retrieve RX buffer address
Date:   Mon, 16 Dec 2019 18:48:51 +0100
Message-Id: <20191216174835.725530675@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 0e531cc575c4e9e3dd52ad287b49d3c2dc74c810 upstream.

In commit 38506ecefab9 ("rtlwifi: rtl_pci: Start modification for
new drivers"), a callback to get the RX buffer address was added to
the PCI driver. Unfortunately, driver rtl8192de was not modified
appropriately and the code runs into a WARN_ONCE() call. The use
of an incorrect array is also fixed.

Fixes: 38506ecefab9 ("rtlwifi: rtl_pci: Start modification for new drivers")
Cc: Stable <stable@vger.kernel.org> # 3.18+
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -804,13 +804,15 @@ u64 rtl92de_get_desc(struct ieee80211_hw
 			break;
 		}
 	} else {
-		struct rx_desc_92c *pdesc = (struct rx_desc_92c *)p_desc;
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_RX_DESC_OWN(pdesc);
+			ret = GET_RX_DESC_OWN(p_desc);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			ret = GET_RX_DESC_PKT_LEN(pdesc);
+			ret = GET_RX_DESC_PKT_LEN(p_desc);
+			break;
+		case HW_DESC_RXBUFF_ADDR:
+			ret = GET_RX_DESC_BUFF_ADDR(p_desc);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",


