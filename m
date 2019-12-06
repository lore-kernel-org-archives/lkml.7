Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC37C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4277E2466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="ZNTduqWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLFII3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:08:29 -0500
Received: from fd.dlink.ru ([178.170.168.18]:46680 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfLFII3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:08:29 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 2F0681B213C1; Fri,  6 Dec 2019 11:08:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 2F0681B213C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1575619705; bh=yP/DvRvL4/1xFi/3tlVzIwybTzEF1V/Jx1psIQGwiH8=;
        h=From:To:Cc:Subject:Date;
        b=ZNTduqWxtf2Gt6BH5XDH65W6DhGseMz1VwA7+66KYc2ZB9BklG9NaXIc8vyZ1/pQ2
         hHwbjFF3uPE+QUfY2ZG0Nsj6M0gUSaebY/P5jQQ0QlQ7qZirr1Xaq9zENJs3phGXoL
         Tdbv/dGCsi57EUvue+0LkVfNy7vssGLIYLwZp01E=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 775501B201E7;
        Fri,  6 Dec 2019 11:08:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 775501B201E7
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 53B3C1B2277A;
        Fri,  6 Dec 2019 11:08:14 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Fri,  6 Dec 2019 11:08:14 +0300 (MSK)
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH mips-fixes] MIPS: BPF: eBPF JIT: check for MIPS ISA compliance in Kconfig
Date:   Fri,  6 Dec 2019 11:07:41 +0300
Message-Id: <20191206080741.12306-1-alobakin@dlink.ru>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is completely wrong to check for compile-time MIPS ISA revision in
the body of bpf_int_jit_compile() as it may lead to get MIPS JIT fully
omitted by the CC while the rest system will think that the JIT is
actually present and works [1].
We can check if the selected CPU really supports MIPS eBPF JIT at
configure time and avoid such situations when kernel can be built
without both JIT and interpreter, but with CONFIG_BPF_SYSCALL=y.

[1] https://lore.kernel.org/linux-mips/09d713a59665d745e21d021deeaebe0a@dlink.ru/

Fixes: 716850ab104d ("MIPS: eBPF: Initial eBPF support for MIPS32 architecture.")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 arch/mips/Kconfig        | 2 +-
 arch/mips/net/ebpf_jit.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index add388236f4e..407b85ee93e4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -47,7 +47,7 @@ config MIPS
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_EBPF_JIT if (!CPU_MICROMIPS)
+	select HAVE_EBPF_JIT if !CPU_MICROMIPS && TARGET_ISA_REV >= 2
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 46b76751f3a5..a2405d5f7d1e 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1803,7 +1803,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	unsigned int image_size;
 	u8 *image_ptr;
 
-	if (!prog->jit_requested || MIPS_ISA_REV < 2)
+	if (!prog->jit_requested)
 		return prog;
 
 	tmp = bpf_jit_blind_constants(prog);
-- 
2.24.0

