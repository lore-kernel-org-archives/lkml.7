Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A776C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161662086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561541927;
	bh=b8yf4lmGvBB1dVa7/Twirj8FFTig4jUndq8vRGsYggw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RIxYj1dE2fSo2qzeXAxtlH8B2uKTzyMDw2Z+Zp4YUQUTcJb1guqmX9Ir4TRYLHde2
	 ss07lHV10zu827gpBslelB7DHyegYK1LoI2VYYIxB6I5Hmz3+z7yCmUhYvRKVQd5RO
	 +EfZ/0qOLa6bckjmTl+z5Du784heoyxNiWWSi5eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFZJip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfFZJin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:38:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BBA2082F;
        Wed, 26 Jun 2019 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561541922;
        bh=b8yf4lmGvBB1dVa7/Twirj8FFTig4jUndq8vRGsYggw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRlfvTtUSHB3ZCrHSBQ6nDjSFcABaixH8GhxBcZLYGVdIL3XgDxMWG0dn5lCMUqPN
         PXaoFJGnXAUmqCQ+tah3l4bWSK23B/DUTRlQn+s/+BPioJO3OI3lyzzpBFQ1vfrE45
         uIQcmJeUG7nEqXFBb7wbq3bD1cUiuAkZxpwj+Akg=
Date:   Wed, 26 Jun 2019 10:38:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
Message-ID: <20190626093836.y2lofo54rhxw3xsm@willie-the-truck>
References: <1561464964.5154.63.camel@lca.pw>
 <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
 <1561467369.5154.67.camel@lca.pw>
 <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
 <1561470705.5154.68.camel@lca.pw>
 <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
 <1561472887.5154.72.camel@lca.pw>
 <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
 <CAKwvOdmCFjunXRbninTdqoDGPNJ6b7npgXLAPYGqFZas5ofNjw@mail.gmail.com>
 <193c179e-16ca-4b4e-2584-75e8f6c1819f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193c179e-16ca-4b4e-2584-75e8f6c1819f@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:00:27PM +0100, Vincenzo Frascino wrote:
> On 25/06/2019 17:26, Nick Desaulniers wrote:
> > On Tue, Jun 25, 2019 at 7:54 AM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>> but clang 7.0 is still use in many distros by default, so maybe this commit can
> >>> be fixed by adding a conditional check to use "small" if clang version < 8.0.
> >>>
> >>
> >> Could you please verify that the patch below works for you?
> > 
> > Should it be checking against CONFIG_CLANG_VERSION, or better yet be
> > using cc-option macro?
> > 
> 
> This is what I did in my proposed patch, but I was surprised that clang-7
> generates relocations that clang-8 does not.
> 
>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
> 00000000000009d0 R_AARCH64_JUMP_SLOT  _mcount

Hmm. It would be nice to understand where the reference to _mcount is coming
from, since that sounds like ftrace is getting involved where it shouldn't
be.

Will
