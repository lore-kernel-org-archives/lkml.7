Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4500C20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402624;
	bh=UE13o5NrIZhLN81xQOZBSUABipSuNtXeuxUj/NUsRM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NC8ExKWyh0UBPrRbslCKyNc0L2heAG2IdN7z4gESZmCCeGf6dcFcgXcTxUaq8cuF2
	 vewnJNvkolgBWYHCK3HFoigx9WHwFTrPd2RDIHD6N122JriYefW1AJdjH/XonjiEdg
	 BQAv3zYA4pY2qTludhLQFvonGftb7zIkwX6C8n/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfKVGDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfKVGDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:03:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B581A20715;
        Fri, 22 Nov 2019 06:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402584;
        bh=UE13o5NrIZhLN81xQOZBSUABipSuNtXeuxUj/NUsRM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wqga1epltyBFq9b2jPmpskZDTmhcPZodQkQD7FA3n9pjnpU2dpIlm4ARGKuK/6AZU
         xML83VhEL5CnV5BcKvth/omEtA1WVO+EPfYCVNyaDtaHpJEr6oYbvj/6CCBOkCoPnE
         TaBrpnZwhHsncw6q5/QcAUDyWP7x+iHIwqo2Nrmk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 85/91] net: dev: Use unsigned integer as an argument to left-shift
Date:   Fri, 22 Nov 2019 01:01:23 -0500
Message-Id: <20191122060129.4239-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
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
index 2ecf0f32444e0..29ed5977ac041 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3565,7 +3565,7 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	if (debug_value == 0)	/* no output */
 		return 0;
 	/* set low N bits */
-	return (1 << debug_value) - 1;
+	return (1U << debug_value) - 1;
 }
 
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
-- 
2.20.1

