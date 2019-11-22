Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C9BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFF22068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403314;
	bh=884x5ShrfFbzeDpMRlDucGW/FgT0RTwPFiSeSuVL/Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=puXuHTuRbmynjZ5hlknBgWQM3k44xj28BxNUGD7AXgbfTBfnw8snLr8AA8iNoLGNl
	 7pl/SPcFiNqwKqCt3FRZxGfC1SJBjYFakauD4xPTeRjCqtezMg0aYE3g64fWg/Zn7d
	 3qrtb3FgcBBgXkyDKuBfJYxMVkFxArPTNyCE/7n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfKVGPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfKVGOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:14:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704B620726;
        Fri, 22 Nov 2019 06:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403254;
        bh=884x5ShrfFbzeDpMRlDucGW/FgT0RTwPFiSeSuVL/Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msY36olfH4tHsMTGp99z+K8z8Vhqm/Nf6OVhhdZhz9jEQRlci8gmVEd4zQf20+Y7A
         qspx3GUbiOT+G/0xM95alumlJHCpBDGAgegzN4LrNCKVFSZZXyE4ozaw32o6MVWgxh
         vfF0YhWz0llTomAl4mv2/0dZvzgaYa+FlowwV5LE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 63/68] net: dev: Use unsigned integer as an argument to left-shift
Date:   Fri, 22 Nov 2019 01:12:56 -0500
Message-Id: <20191122061301.4947-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
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
index 0b211d482c961..861b71377e5e1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3298,7 +3298,7 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	if (debug_value == 0)	/* no output */
 		return 0;
 	/* set low N bits */
-	return (1 << debug_value) - 1;
+	return (1U << debug_value) - 1;
 }
 
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
-- 
2.20.1

