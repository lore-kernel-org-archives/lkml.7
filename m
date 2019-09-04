Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464DDC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0128D2070C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613113;
	bh=bP67rUnQuQQMO/vk4mRw7dPx0htZlKaooFSF+6uvFV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Kq857aegoA9DL5t9B0mzOE274Ud6z0yQVhMFF3MW2O+iv1BQvJmfjxIXiFCFMPbm
	 sg4BHwK/kV1e+PY9YQyxX0am5u7M1ONB86SZA4mxXviEPUlfCtGzYbvvC5YedYOeFQ
	 EbQ4jdZeDTL7fZKZqcgZfhqvHdUW5JyVvyFkoPWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfIDQCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387508AbfIDQCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDF52070C;
        Wed,  4 Sep 2019 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612972;
        bh=bP67rUnQuQQMO/vk4mRw7dPx0htZlKaooFSF+6uvFV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RH6fW2dWkPXC3riDhkk4SBT9/5EUYMUCrEdlGME8zry0pvBAARjXWPE6REIckFcHA
         t8MXaiGdVDoag6xpp+6no01Jcb6h9Bh/Y9vG4I+5kLYh1QDoMTGYJ2OTBIOGgl5wKE
         zbnAeBy4ZTtbaRPFG6VVzsMacuHhHFDGpWH6IcH8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 21/27] ARM: 8901/1: add a criteria for pfn_valid of arm
Date:   Wed,  4 Sep 2019 12:02:14 -0400
Message-Id: <20190904160220.4545-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160220.4545-1-sashal@kernel.org>
References: <20190904160220.4545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaoyang <huangzhaoyang@gmail.com>

[ Upstream commit 5b3efa4f1479c91cb8361acef55f9c6662feba57 ]

pfn_valid can be wrong when parsing a invalid pfn whose phys address
exceeds BITS_PER_LONG as the MSB will be trimed when shifted.

The issue originally arise from bellowing call stack, which corresponding to
an access of the /proc/kpageflags from userspace with a invalid pfn parameter
and leads to kernel panic.

[46886.723249] c7 [<c031ff98>] (stable_page_flags) from [<c03203f8>]
[46886.723264] c7 [<c0320368>] (kpageflags_read) from [<c0312030>]
[46886.723280] c7 [<c0311fb0>] (proc_reg_read) from [<c02a6e6c>]
[46886.723290] c7 [<c02a6e24>] (__vfs_read) from [<c02a7018>]
[46886.723301] c7 [<c02a6f74>] (vfs_read) from [<c02a778c>]
[46886.723315] c7 [<c02a770c>] (SyS_pread64) from [<c0108620>]
(ret_fast_syscall+0x0/0x28)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4fb1474141a61..0fe4a7025e467 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -192,6 +192,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+
 	return memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
-- 
2.20.1

