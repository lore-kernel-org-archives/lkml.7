Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E710C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DA92087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="GGVpJgr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfC0AzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:55:25 -0400
Received: from one.firstfloor.org ([193.170.194.197]:45888 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfC0AzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:55:25 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 36EAA86722; Wed, 27 Mar 2019 01:55:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1553648124;
        bh=e5KTUYAp/zWOdfgp9o/FUJmC+V6y9zjimUGfc1ouzGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGVpJgr6a7plxRghA2xh6VgWjMz51maf3WgfvSd1K8B6UAqmcbDcuQLHP/1/Hulzh
         DcArYoY3ks5YutwvlDIv//IjDFSSQRHAqjmc2NiS+KalSSnpUmwJUQt8gZEpmx+ceV
         2z+jCCY2+uERKi91jiwcCSPk1rGxcpCMPT+1piuQ=
Date:   Tue, 26 Mar 2019 17:55:24 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
        x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
 <20190326213803.GN18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, we better should know the real reason for this wreckage. I mean, the
> default section for text is suprisingly .text. I don't see a reason why
> this would be any different for an assembly function implemented in a C
> file.

What happens is that when the function before the asm changes
the section, gcc only changes it back for the next function/variable
with a different section. But it doesn't change it back for the asm.


e.g. here

__attribute__((section("foo"))) void func(void)
{
}

asm("foo:\n");

gives with gcc -S (might be different with optimization):

 .section foo,"ax",@progbits <----------------- sets the section
 .globl func
 .type func, @function
func:
.LFB0:
 .cfi_startproc
 pushq %rbp
 .cfi_def_cfa_offset 16
 .cfi_offset 6, -16
 movq %rsp, %rbp
 .cfi_def_cfa_register 6
 nop
 popq %rbp
 .cfi_def_cfa 7, 8
 ret
 .cfi_endproc
.LFE0:
 .size func, .-func
<--------------------------- no section reset before the asm
#APP
 foo:

 .ident "GCC: (GNU) 8.3.1 20190223 (Red Hat 8.3.1-2)"
 .section .note.GNU-stack,"",@progbits


> So the question is whether GCC does something silly in general which gets
> 'repaired' silentely by the linker or whether it's just an LTO issue.

The linker has no idea about the boundaries between functions and toplevel
asms. So if gcc doesn't reset the section they stay in the same.

My LTO build was just unlucky I think because it ended up with
asm next to initcall function, which is likely not common.

But gcc reorders functions even without LTO inside files,
so it could eventually happen.

> 
> If it's the former, then we must backport those fixes.
> 
> Could you please verify with the GCC people as you seem to have a
> reproducer of some sort.

Okay. I filed https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89839

I thought I had already done that, but it seems I didn't.

-Andi

