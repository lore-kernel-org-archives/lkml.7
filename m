Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81219C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BE1206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="vB7eCzA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfLWHy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:54:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51881 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:54:26 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47hBSp6LlPz9tyVy;
        Mon, 23 Dec 2019 08:54:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=vB7eCzA7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yYpcIDcCzsSE; Mon, 23 Dec 2019 08:54:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47hBSp58wpz9tyVf;
        Mon, 23 Dec 2019 08:54:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1577087658; bh=hkKxahRiPSAEMe/USu//uOwiIXNh/xpJtVcNhRacSz4=;
        h=From:Subject:To:Cc:Date:From;
        b=vB7eCzA7rGplvY2F2ekFh/WjZgrGdfiyQUwmzn6VPp+zHfrTrENwh62td5tKITqea
         P82kgK0m3HOm56zXeiuQCNym3YmttLCru35zjuGurMcR0QC2/1Ora1qkWflqe1DsLk
         FRIh6ve/rg3bpkHHs3BYlzfCXqTgnAUR7s74921M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 552018B798;
        Mon, 23 Dec 2019 08:54:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XCcVzaFsk9zN; Mon, 23 Dec 2019 08:54:23 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 38C3C8B752;
        Mon, 23 Dec 2019 08:54:23 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0D547637C8; Mon, 23 Dec 2019 07:54:22 +0000 (UTC)
Message-Id: <0728849e826ba16f1fbd6fa7f5c6cc87bd64e097.1577087627.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: don't log user reads to 0xffffffff
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Dec 2019 07:54:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running vdsotest leaves many times the following log:

[   79.629901] vdsotest[396]: User access of kernel address (ffffffff) - exploit attempt? (uid: 0)

A pointer set to (-1) is likely a programming error similar to
a NULL pointer and is not worth logging as an exploit attempt.

Don't log user accesses to 0xffffffff.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b5047f9b5dec..d3b4d444bf3c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -354,6 +354,9 @@ static void sanity_check_fault(bool is_write, bool is_user,
 	 * Userspace trying to access kernel address, we get PROTFAULT for that.
 	 */
 	if (is_user && address >= TASK_SIZE) {
+		if ((long)address == -1)
+			return;
+
 		pr_crit_ratelimited("%s[%d]: User access of kernel address (%lx) - exploit attempt? (uid: %d)\n",
 				   current->comm, current->pid, address,
 				   from_kuid(&init_user_ns, current_uid()));
-- 
2.13.3

