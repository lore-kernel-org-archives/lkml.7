Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1949EC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5621849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563410830;
	bh=W75bCKZNMgpUlO+V+opZiBCph5GTZ6ObUVcMIHF/NkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8HrgTkuc3hKr0VcvgXlyESeFbgtVQVAVx3RGk+Q8kKB3sw4u6BtH9niadgWu/T5C
	 wKLy1h0jNSpMdqjW1hpoFsoM3QwyD6PP5ZEqKFE7qg0oZXW2F5XjGVoRUjZ1SwrQly
	 elHJSSo+uTNAECh3PzODtUBsF6g2Ib/BfkKKaYs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfGRArJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 20:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbfGRArI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:47:08 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50209217F4;
        Thu, 18 Jul 2019 00:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563410828;
        bh=W75bCKZNMgpUlO+V+opZiBCph5GTZ6ObUVcMIHF/NkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MuqZ1hdyNcp2wA0D3+/Pg9o8mYORG7g0K6HNTysmfymA35uJH9+qa68CxtuUZbPzU
         XX8XkGbz5PVwwBFZWjfrZdEoD97D98qZZq88OffMU6dzNLtxx5EtpdgViqnj0cwTXW
         wo9JPYbqADfbInEGyafrxvyGZUYKuEtHOr4VfRlk=
Date:   Thu, 18 Jul 2019 09:47:05 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/purgatory: add -mno-sse, -mno-mmx, -mno-sse2 to
 Makefile
Message-ID: <20190718004705.GA31085@kroah.com>
References: <20190718000206.121392-1-vaibhavrustagi@google.com>
 <20190718000206.121392-2-vaibhavrustagi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718000206.121392-2-vaibhavrustagi@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 05:02:05PM -0700, Vaibhav Rustagi wrote:
> Compiling the purgatory code with clang results in using of mmx
> registers.
> 
> $ objdump -d arch/x86/purgatory/purgatory.ro | grep xmm
> 
>      112:	0f 28 00             	movaps (%rax),%xmm0
>      115:	0f 11 07             	movups %xmm0,(%rdi)
>      122:	0f 28 00             	movaps (%rax),%xmm0
>      125:	0f 11 47 10          	movups %xmm0,0x10(%rdi)
> 
> Add -mno-sse, -mno-mmx, -mno-sse2 to avoid generating SSE instructions.
> 
> Signed-off-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> ---
>  arch/x86/purgatory/Makefile | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
