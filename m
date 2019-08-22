Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED6FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785623406
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494063;
	bh=BA+UGscKPxuHl3GcdkS7m3JOxOxCmTFTvrCrso1YyF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fquQ5ZqUBblhD39YpER0LcI0Y9c0I7D+7oXMHudd2A3czDrMeJ+cjO6WioW91b0dC
	 qRhv+AeHl/LWMkYwL1XbZ1bEWmlDFvoWRkB8TpbhCwDZYQy2bO2vy3QGo6JcZfVeLx
	 QvPF4EiLJBp1wlyAFJCAM7QPFEhIp13cnI8KyE6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfHVROW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390563AbfHVRIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:53 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D222F2341E;
        Thu, 22 Aug 2019 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493733;
        bh=BA+UGscKPxuHl3GcdkS7m3JOxOxCmTFTvrCrso1YyF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eI083BEuzH/HCPTeMv4soiRT8+/F7h/ElhmtY7En4tZINdFQKmaL4p0A4q+bTsQHH
         rxpchSveDhjeUSkiylIP9UqzxHPaVRMTvl3qrHnR+2sjFKbuz94XC0hMbBkLK4EPnN
         9aEAlbEr2hA8T2RtUmDvliG+QUPDsaDIZGD4p4Fc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 071/135] riscv: Fix perf record without libelf support
Date:   Thu, 22 Aug 2019 13:07:07 -0400
Message-Id: <20190822170811.13303-72-sashal@kernel.org>
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

From: Mao Han <han_mao@c-sky.com>

[ Upstream commit b399abe7c21e248dc6224cadc9a378a2beb10cfd ]

This patch fix following perf record error by linking vdso.so with
build id.

perf.data      perf.data.old
[ perf record: Woken up 1 times to write data ]
free(): double free detected in tcache 2
Aborted

perf record use filename__read_build_id(util/symbol-minimal.c) to get
build id when libelf is not supported. When vdso.so is linked without
build id, the section size of PT_NOTE will be zero, buf size will
realloc to zero and cause memory corruption.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f1d6ffe43e428..49a5852fd07dd 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -37,7 +37,7 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 # these symbols in the kernel code rather than hand-coded addresses.
 
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
-	-Wl,--hash-style=both
+	-Wl,--build-id -Wl,--hash-style=both
 $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
 	$(call if_changed,vdsold)
 
-- 
2.20.1

