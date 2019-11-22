Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F54C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625F20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402290;
	bh=n+Wons8GrY+1VzeMZgkyPKXji48Eh6cjTU8tvUR/bUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hXpnLu0VzlOmfPCFUjyrwIKyP1aO3MT9wEzBP+4yyFUD4Ncu2/ffDGWJBZez8ZHuk
	 dzKPmMliIawzxI7Ix3uQDKveAnBH4/mEC6j+r+Ukb4uw7U9yceMiezo7Axu5GGizs1
	 dvYiwg7xQgQkq9/vvYMSwpaChDTeJbhD8vhAuRaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfKVF6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfKVF54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6BE420659;
        Fri, 22 Nov 2019 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402276;
        bh=n+Wons8GrY+1VzeMZgkyPKXji48Eh6cjTU8tvUR/bUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPUX5Eqr1ZD2ysyWWEJt/w6Q5Skofx7CNCG7vxQ1gDONjeysV+UaO8UXRymSHbxwD
         cER1XcQJ78bTYt+ioVPyrSrFJ7iFfxZuqlPed+XCJg+mFPHaEtUIYrxjYjfG36Cdy8
         zeBN0II9Kuh3wboXNSM2uxkyAzJ1a1oSeTlbZFFM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 115/127] net: dev: Use unsigned integer as an argument to left-shift
Date:   Fri, 22 Nov 2019 00:55:33 -0500
Message-Id: <20191122055544.3299-114-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f4d7b3e23d259c44f1f1c39645450680fcd935d6 ]

1 << 31 is Undefined Behaviour according to the C standard.
Use U type modifier to avoid theoretical overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 40b830d55fe50..4725a9d9597fc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3522,7 +3522,7 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	if (debug_value == 0)	/* no output */
 		return 0;
 	/* set low N bits */
-	return (1 << debug_value) - 1;
+	return (1U << debug_value) - 1;
 }
 
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
-- 
2.20.1

