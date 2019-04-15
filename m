Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B6521900
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355449;
	bh=25RIbdRpRJnFuzT0xmyUuz0bjP6Jffz4ce/FSt4R6hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZ5qo9tmlh83KxUS9pzlwcyVSm3SKIxTXen0+r+T8753IshjQjlOooxnQCIuLFhyd
	 uGewmjfIKbmQvYu/xXFMQYLZvl6fET1aYu48wxeiYdQ+7BU96rShG3bvedLOMubow6
	 9oB0i9m+MxA0RTP9b2CmmCe8fXcMJw+S1M/xlNA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfDOTKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfDOTKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E33218FF;
        Mon, 15 Apr 2019 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355445;
        bh=25RIbdRpRJnFuzT0xmyUuz0bjP6Jffz4ce/FSt4R6hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0zokWtZ7+OoJxnIJn6clnI9VBmpBmiwQq7BZmbubhTu6LfDRvKI+r4GpdmA9Lymy
         X44/UfFtGm80GjBpD8UhR+HoABIoi4gUz2QPXaK8UEYAXLX85/4KRGuktgA0CEUyfb
         QBaZ86tM+qw6+NUAl9i2zuHCLW/8KibZRW1JIlDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Crowe <mac@mcrowe.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 038/117] r8169: disable default rx interrupt coalescing on RTL8168
Date:   Mon, 15 Apr 2019 21:00:08 +0200
Message-Id: <20190415183746.975951896@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 288ac524cf70a8e7ed851a61ed2a9744039dae8d ]

It was reported that re-introducing ASPM, in combination with RX
interrupt coalescing, results in significantly increased packet
latency, see [0]. Disabling ASPM or RX interrupt coalescing fixes
the issue. Therefore change the driver's default to disable RX
interrupt coalescing. Users still have the option to enable RX
coalescing via ethtool.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=925496

Fixes: a99790bf5c7f ("r8169: Reinstate ASPM Support")
Reported-by: Mike Crowe <mac@mcrowe.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 5adb00f521db..365cddbfc684 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5333,7 +5333,7 @@ static void rtl_hw_start_8168(struct rtl8169_private *tp)
 	tp->cp_cmd |= PktCntrDisable | INTT_1;
 	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
 
-	RTL_W16(tp, IntrMitigate, 0x5151);
+	RTL_W16(tp, IntrMitigate, 0x5100);
 
 	/* Work around for RxFIFO overflow. */
 	if (tp->mac_version == RTL_GIGA_MAC_VER_11) {
-- 
2.19.1



