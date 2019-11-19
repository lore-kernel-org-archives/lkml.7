Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A60C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AA922309
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rqUBxFVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfKSG6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:58:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37355 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfKSG6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:58:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47HGqq4dKcz9sSP;
        Tue, 19 Nov 2019 17:58:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574146696;
        bh=UJDJAAoM1z5MF3IYbIZX69JmcS9dmQDJlWRDIRsZqlY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rqUBxFVHDz30tTohZ/5o4s0MG6uRLUgC+jddFLvTHOI23O6RYj6iAlN8BM6F/gpYo
         IOywwfiOTa3ViPBXLipcof5niocJACuF68pJyLl8QpMJwrdlcDTcAqModRec5sYIRl
         507+UJ5jZMm2vfIitezy+PzkfrX9WbsX7sAXilKzyR5Uz9pvbM64sIWCDifSo7PofG
         ugWVXffzUZp+5/GsmKgNDV6c0+ADGddw64qIMeDyZWb9gyTiUhSgwcI2hIuyPi9Ftm
         F6pvPmWc/7DVqqn2r7/1BSOxpSJHXP3ZncO3HX0BBu9ei54wFIrBMDrmiThfuJUj0i
         Bnhm25x1zJnuQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 15/15] powerpc/32s: Activate CONFIG_VMAP_STACK
In-Reply-To: <a99bdfb64e287b16b8cd3f7ec1abfdfb50c7cc64.1568106758.git.christophe.leroy@c-s.fr>
References: <cover.1568106758.git.christophe.leroy@c-s.fr> <a99bdfb64e287b16b8cd3f7ec1abfdfb50c7cc64.1568106758.git.christophe.leroy@c-s.fr>
Date:   Tue, 19 Nov 2019 17:58:14 +1100
Message-ID: <875zjgcpyx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> A few changes to retrieve DAR and DSISR from struct regs
> instead of retrieving them directly, as they may have
> changed due to a TLB miss.
>
> Also modifies hash_page() and friends to work with virtual
> data addresses instead of physical ones.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/entry_32.S         |  4 +++
>  arch/powerpc/kernel/head_32.S          | 19 +++++++++++---
>  arch/powerpc/kernel/head_32.h          |  4 ++-
>  arch/powerpc/mm/book3s32/hash_low.S    | 46 +++++++++++++++++++++-------------
>  arch/powerpc/mm/book3s32/mmu.c         |  9 +++++--
>  arch/powerpc/platforms/Kconfig.cputype |  2 ++
>  6 files changed, 61 insertions(+), 23 deletions(-)

This is faulting with qemu mac99 model:

  Key type id_resolver registered
  Key type id_legacy registered
  BUG: Unable to handle kernel data access on read at 0x2f0db684
  Faulting instruction address: 0x00004130
  Oops: Kernel access of bad area, sig: 11 [#1]
  BE PAGE_SIZE=4K MMU=Hash PowerMac
  Modules linked in:
  CPU: 0 PID: 65 Comm: modprobe Not tainted 5.4.0-rc2-gcc49+ #63
  NIP:  00004130 LR: 000008c8 CTR: b7eb86e0
  REGS: f106de80 TRAP: 0300   Not tainted  (5.4.0-rc2-gcc49+)
  MSR:  00003012 <FP,ME,DR,RI>  CR: 4106df38  XER: 20000000
  DAR: 2f0db684 DSISR: 40000000 
  GPR00: b7ec5d64 f106df38 00000000 bf988a70 00000000 2f0db540 b7ec3620 bf988d38 
  GPR08: 10000880 0000d032 72656773 f106df38 b7ed10ec 00000000 b7ed3d38 b7ee8900 
  GPR16: bf988d10 00000001 00000000 bf988d10 b7ec3620 bf988d50 b7ee76ec b7ee7320 
  GPR24: 10000878 00000000 b7ee8900 00000000 10029f00 10000879 b7ee7ff4 bf988d30 
  NIP [00004130] 0x4130
  LR [000008c8] 0x8c8
  Call Trace:
  [f106df38] [c0016224] ret_from_syscall+0x0/0x34 (unreliable)
  --- interrupt: c01 at 0xb7ed0f50
      LR = 0xb7ec5d64
  Instruction dump:
  db8300e0 XXXXXXXX XXXXXXXX XXXXXXXX fc00048e XXXXXXXX XXXXXXXX XXXXXXXX 
  60a52000 XXXXXXXX XXXXXXXX XXXXXXXX 80850144 XXXXXXXX XXXXXXXX XXXXXXXX 
  ---[ end trace 265da51c6d8b86c5 ]---


I think I'll have to drop this series for now.

cheers
