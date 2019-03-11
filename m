Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C076C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE62214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335183;
	bh=JxMTyJINnJiqScPY2YU4jPgqbVdf9zIkUK3Z0F2Bsj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=efYFg69jvZgMRf82AsTh8OOWJpoNWvbM66it3JMEk2Ejbg3XOsXvb8iDlXYb1HIa7
	 iuJoLZfByIWu7miW5gHbC2yim9Slx9AXHuAOGJ1DkGkWu3l92JQHo9cFRpxNX86J+R
	 n37D2Bxq8ZlzByiIZSuXqMQ5DZvvbJbSqczIxjBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfCKUM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfCKTz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3002173C;
        Mon, 11 Mar 2019 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334155;
        bh=JxMTyJINnJiqScPY2YU4jPgqbVdf9zIkUK3Z0F2Bsj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Q4Gq5pafigla/ohJ2k6luKieioiZuvGmgrsCKonG8vEMY4+v5CLugbaOuWEyRKkU
         2BJ/zfmbCeUWzxx06AuHKJQDokpb//3OTQY1dICRYNvkygbDKrawNOkue4c+SifrNG
         eG6GR4t10BFTE9kpP6RfKbMm6AXWidzJOm/BuMNg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.20 20/52] arm/arm64: KVM: Don't panic on failure to properly reset system registers
Date:   Mon, 11 Mar 2019 15:54:44 -0400
Message-Id: <20190311195516.137772-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 20589c8cc47dce5854c8bf1b44a9fc63d798d26d ]

Failing to properly reset system registers is pretty bad. But not
quite as bad as bringing the whole machine down... So warn loudly,
but slightly more gracefully.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kvm/coproc.c     | 4 ++--
 arch/arm64/kvm/sys_regs.c | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index cb094e55dc5f..fd6cde23bb5d 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -1450,6 +1450,6 @@ void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
 	reset_coproc_regs(vcpu, table, num);
 
 	for (num = 1; num < NR_CP15_REGS; num++)
-		if (vcpu_cp15(vcpu, num) == 0x42424242)
-			panic("Didn't reset vcpu_cp15(vcpu, %zi)", num);
+		WARN(vcpu_cp15(vcpu, num) == 0x42424242,
+		     "Didn't reset vcpu_cp15(vcpu, %zi)", num);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22fbbdbece3c..fe18e68f9a20 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2586,7 +2586,9 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	table = get_target_table(vcpu->arch.target, true, &num);
 	reset_sys_reg_descs(vcpu, table, num);
 
-	for (num = 1; num < NR_SYS_REGS; num++)
-		if (__vcpu_sys_reg(vcpu, num) == 0x4242424242424242)
-			panic("Didn't reset __vcpu_sys_reg(%zi)", num);
+	for (num = 1; num < NR_SYS_REGS; num++) {
+		if (WARN(__vcpu_sys_reg(vcpu, num) == 0x4242424242424242,
+			 "Didn't reset __vcpu_sys_reg(%zi)\n", num))
+			break;
+	}
 }
-- 
2.19.1

