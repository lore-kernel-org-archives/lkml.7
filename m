Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F4C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD3A206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575367937;
	bh=njEa6+IrLjuvJPILzHBnWSOeMyzbeQ4z6Q3+166H/eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/pEChyp/rl2cFdbnfyCgN8CBFzZ7B5LdtTTMTgqEEjyMO+PoPZRQWsiw9ksmRj2H
	 1VapZAatNpzUNXQjCHrwrorI5Bi4ECIYBEp4plOBSrvBqXT5VWUDWGlPO2wquU8H7a
	 ake5HfOhv8Em7PXCeBWiehRbNHCldtsyphYo8jVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:12:16 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD68A206DF;
        Tue,  3 Dec 2019 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575367935;
        bh=njEa6+IrLjuvJPILzHBnWSOeMyzbeQ4z6Q3+166H/eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwECi3FPLB/gvnYoP5ns47k1Roo8LLto0gKhd1RbDt8bHESwF/OS5NpOW/mDzvbBU
         aNAi2vigGNx3RvjT6bsRLY06FdN/918p4dNXEvOAMkx+FqMjBl+PWB3UrR7P1cM92U
         sGuAtpf5TUSO3fHv9ZfheiDtJ8l0aAS48yG5iCLU=
Date:   Tue, 3 Dec 2019 10:12:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191203101202.GA6815@willie-the-truck>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
 <20191129102421.GA28322@willie-the-truck>
 <CACi5LpNQPw41kGsW+d0PyZaC7gSrbgwT2VxwyO5r3j83h-mkEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpNQPw41kGsW+d0PyZaC7gSrbgwT2VxwyO5r3j83h-mkEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 01:35:36AM +0530, Bhupesh Sharma wrote:
> On Fri, Nov 29, 2019 at 3:54 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> > > Changes since v4:
> > > ----------------
> > > - v4 can be seen here:
> > >   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> > > - Addressed comments from Dave and added patches for documenting
> > >   new variables appended to vmcoreinfo documentation.
> > > - Added testing report shared by Akashi for PATCH 2/5.
> >
> > Please can you fix your mail setup? The last two times you've sent this
> > series it seems to get split into two threads, which is really hard to
> > track in my inbox:
> >
> > First thread:
> >
> > https://lore.kernel.org/lkml/1574972621-25750-1-git-send-email-bhsharma@redhat.com/
> >
> > Second thread:
> >
> > https://lore.kernel.org/lkml/1574972716-25858-1-git-send-email-bhsharma@redhat.com/
> 
> There seems to be some issue with my server's msmtp settings. I have
> tried resending the v5 (see
> <http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/696833.html>).
> 
> I hope the threading is ok this time.

Much better now, thanks for sorting it out.

Will
