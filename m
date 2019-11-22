Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9400DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692CC20637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419826;
	bh=aR/t5YCcCHV0IFWZ+c2GSkzd6RjwinwwAH6PYhNmBXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XzMOE3h4skuRrCAipDpzcH0rLI2zMC/XocH7+c4MW2rYC/y5MZ72gmaE6nUyCJ12Y
	 pu/FuesCLwVUK2QThsNUaEj8mSmzalJ/cEL/hRScpOFtTZADc/dkU4y/SFfXygFCzV
	 pQgyOiUUIsEwrQmdBFTdhdic2aSokHclZFN0U0Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfKVKuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfKVKuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:50:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E6320637;
        Fri, 22 Nov 2019 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419821;
        bh=aR/t5YCcCHV0IFWZ+c2GSkzd6RjwinwwAH6PYhNmBXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDbTStZD+H/Lh6QF6Pb1aZaqm+oSlAN4GejANE4yfP9dc/ih8+SpHQNdLX4ZyVpGI
         YBLR5/dvW9JwnhaxdE/FXVnwAKiP7MfdacR6JxGUc5BA+CYoKeGcvEzb9Uer/1Yi3u
         gpwZ3CxuAR87M5CNuPJ0LxtytXpUr9Mfj7dw4Kmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoffer Dall <cdall@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/122] kvm: arm/arm64: Fix stage2_flush_memslot for 4 level page table
Date:   Fri, 22 Nov 2019 11:27:53 +0100
Message-Id: <20191122100737.057660065@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit d2db7773ba864df6b4e19643dfc54838550d8049 ]

So far we have only supported 3 level page table with fixed IPA of
40bits, where PUD is folded. With 4 level page tables, we need
to check if the PUD entry is valid or not. Fix stage2_flush_memslot()
to do this check, before walking down the table.

Acked-by: Christoffer Dall <cdall@kernel.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 1f4cac53b9234..9f69202d8e49b 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -375,7 +375,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
 	do {
 		next = stage2_pgd_addr_end(addr, end);
-		stage2_flush_puds(kvm, pgd, addr, next);
+		if (!stage2_pgd_none(*pgd))
+			stage2_flush_puds(kvm, pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
 
-- 
2.20.1



