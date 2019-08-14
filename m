Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A446C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F21D204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tDKSVHbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfHNJZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:25:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16000 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfHNJZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:25:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467khv4p4bz9v0GZ;
        Wed, 14 Aug 2019 11:25:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=tDKSVHbM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id npt1ratVQikb; Wed, 14 Aug 2019 11:25:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467khv3lsvz9v0GY;
        Wed, 14 Aug 2019 11:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565774751; bh=AnAI6eOBmIzFT0vPN6Zr0av8nS7BjNoeKOZuIxTShO0=;
        h=From:Subject:To:Cc:Date:From;
        b=tDKSVHbMwzDrWOYdWHa0XmSb0QD9j9TeNf895KleI+g1tGRGYfdLh2EKXtGh6960E
         zuM5VevsUXrbRej0XC46libkHIWfcnr3yc7evL3GPQMN5LQBL46tO+yir9mLHJZqmS
         VUNqMCpHDYU6CNAOtz6ZmzNJyIhhZWyunfSTofSU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C16B28B7A3;
        Wed, 14 Aug 2019 11:25:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 99Q4-iUKg2Gg; Wed, 14 Aug 2019 11:25:52 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1C2B8B761;
        Wed, 14 Aug 2019 11:25:52 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6D3DC69632; Wed, 14 Aug 2019 09:25:52 +0000 (UTC)
Message-Id: <86b72f0c134367b214910b27b9a6dd3321af93bb.1565774657.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/futex: fix warning: 'oldval' may be used
 uninitialized in this function
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 14 Aug 2019 09:25:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      kernel/futex.o
kernel/futex.c: In function 'do_futex':
kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
   return oldval == cmparg;
                 ^
kernel/futex.c:1651:6: note: 'oldval' was declared here
  int oldval, ret;
      ^

This is because arch_futex_atomic_op_inuser() only sets *oval
if ret is NUL and GCC doesn't see that it will use it only when
ret is NUL.

Anyway, the non-NUL ret path is an error path that won't suffer from
setting *oval, and as *oval is a local var in futex_atomic_op_inuser()
it will have no impact.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/futex.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 3a6aa57b9d90..eea28ca679db 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -60,8 +60,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 
 	pagefault_enable();
 
-	if (!ret)
-		*oval = oldval;
+	*oval = oldval;
 
 	prevent_write_to_user(uaddr, sizeof(*uaddr));
 	return ret;
-- 
2.13.3

