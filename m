Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC59C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB6233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494210;
	bh=BWSg0UCL/CYbHa+qf299qaAaQB4/DqDBrwqYITlh1bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzNy4BxjdcaDfFIemF0w7TyaP49iZZ6Ute3MtZF4PUWOGwUKMDR5Ep0KqTRdo4WbR
	 XF8C/pPVeE9YEIoEhLslJDvVS+0F37XpfZft/kthU/a6izvrrOToF2YDv4I9vHpVqx
	 YTqLYbCrf5gkQIpJ0nWurKniDiBLgLYZB/JeJQNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbfHVRQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390375AbfHVRId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:33 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12FE233FC;
        Thu, 22 Aug 2019 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493712;
        bh=BWSg0UCL/CYbHa+qf299qaAaQB4/DqDBrwqYITlh1bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekWEja1U0BFCmG5/CuFAbROlXJXd2Uga26Gf9b+MBQ6+VsfxfrudQMyJkbvh6nbsO
         ClnUuOto6zM2CCNifA2XNx7ZiXArC+6zRFpsThAx/+CLTTE1hEwtFSbkzUYr9xPmbs
         rtyREBFMN4ZHp8SlDiBIfYCMqtOLac+d48gNr9dA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 033/135] riscv: Make __fstate_clean() work correctly.
Date:   Thu, 22 Aug 2019 13:06:29 -0400
Message-Id: <20190822170811.13303-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

commit 69703eb9a8ae28a46cd5bce7d69ceeef6273a104 upstream.

Make the __fstate_clean() function correctly set the
state of sstatus.FS in pt_regs to SR_FS_CLEAN.

Fixes: 7db91e57a0acd ("RISC-V: Task implementation")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[paul.walmsley@sifive.com: expanded "Fixes" commit ID]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/switch_to.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 949d9cd91dec4..f0227bdce0f06 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
 
 static inline void __fstate_clean(struct pt_regs *regs)
 {
-	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
+	regs->sstatus = (regs->sstatus & ~SR_FS) | SR_FS_CLEAN;
 }
 
 static inline void fstate_off(struct task_struct *task,
-- 
2.20.1

