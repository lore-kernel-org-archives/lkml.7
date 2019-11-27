Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B540C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668CF2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890435;
	bh=s6M5Jct3ZzhxrZHKNxFihAJ8CG7qRPPEX72qQEc/axw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PpkjHPaiYoHNGYpcxUDcRfPNNjqSt9aUloCMonlhFy3X2BtaKM2YeOWXLGmpZkvbd
	 IlYDo9d5iLLjiXIgFo0z/Dft/oR7gnYdJKY1ecbxGDXB1mKxoF0MwqDk83BFNQreVM
	 AyCdnsPWmoqH35MTTwC2kM1tfnGSBNzcgRNispQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfK0Vdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbfK0Uvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:51:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2071621774;
        Wed, 27 Nov 2019 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887898;
        bh=s6M5Jct3ZzhxrZHKNxFihAJ8CG7qRPPEX72qQEc/axw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uk3wV8MNb+axnutUxxrzYjH2kCwoJQ6xKC5F7cRrLTdE+tsA7Q+jHhSBtftOondA+
         2xkpo5CXPN2owA0LPQydQ0KhqN14xEFw94kuyoD/CnAVDIIz/JtrtUMcEXuGg8Mta8
         i5GZRYmfQj/k43aHgp4q+ioDu+8nM/jREf+xvdhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 135/211] rtl8xxxu: Fix missing break in switch
Date:   Wed, 27 Nov 2019 21:31:08 +0100
Message-Id: <20191127203106.787142086@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit 307b00c5e695857ca92fc6a4b8ab6c48f988a1b1 ]

Add missing break statement in order to prevent the code from falling
through to the default case.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7806a4d2b1fcd..91b01ca32e752 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5691,6 +5691,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.20.1



