Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA9CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B128521852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437076;
	bh=2wCmBqoCUtQczstuSu+E79NktzrLM54hbOybIdGj5sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvRu6wWEdrXjcoxQjNIf1/mNmynhUPQ5UkjlRy2sPmvJXHeEV1uhiYsYQZr3GYlNY
	 efBG0u/Azb/mjwpqu/iX8J3ZO+V1m/jb0cVHnoz1e43teke+XXP1Qab3KdTYPpXr0w
	 fPH1NDPpXMdeirKvmBmK35zB1klmjrf5yIDedGiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfJRWHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732905AbfJRWHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288C422468;
        Fri, 18 Oct 2019 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436449;
        bh=2wCmBqoCUtQczstuSu+E79NktzrLM54hbOybIdGj5sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5S0hM185r9EjWnnSCmP5pAUsrDXR0TMVmFvxSwsmgq85j0AXVuS6dplUqr64VZA1
         LMMBZ1gPQhy2UWzHJDhBPCkk25MEB/QE89MD8AH0NSqA56wycUurQr1HS385T7s6Lo
         479GwDi2MXJkz5QggBKBDChMIVUn2lU/5edlSB+E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 084/100] arm64: armv8_deprecated: Checking return value for memory allocation
Date:   Fri, 18 Oct 2019 18:05:09 -0400
Message-Id: <20191018220525.9042-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit 3e7c93bd04edfb0cae7dad1215544c9350254b8f ]

There are no return value checking when using kzalloc() and kcalloc() for
memory allocation. so add it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/armv8_deprecated.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 92be1d12d5908..39dc98dd78ebf 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -177,6 +177,9 @@ static void __init register_insn_emulation(struct insn_emulation_ops *ops)
 	struct insn_emulation *insn;
 
 	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
+	if (!insn)
+		return;
+
 	insn->ops = ops;
 	insn->min = INSN_UNDEF;
 
@@ -236,6 +239,8 @@ static void __init register_insn_emulation_sysctl(void)
 
 	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
 			       GFP_KERNEL);
+	if (!insns_sysctl)
+		return;
 
 	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
 	list_for_each_entry(insn, &insn_emulation, node) {
-- 
2.20.1

