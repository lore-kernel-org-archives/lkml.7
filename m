Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7033206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568666603;
	bh=xAmdIKxn1vlp7D2ukzr9l0i4qp4XEa+oNjtGZw6WZaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uwOES/MU/yLofCtES1t4x71bSUFibYPgrjIAJOUXk799OU9Fcx7ClvnS1t4bMGUQy
	 QxSnw3OMeJ/8Hl+sYub0GTYJ7qtXD0PNBXMSdZ5Sp2YKXDq1MZHZI3l6ad+/ScUsMb
	 RZ09KUBJsvXn15No20n873T6tU4LOhROIxMkxg40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391441AbfIPUnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbfIPUnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:43:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B88920644;
        Mon, 16 Sep 2019 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568666601;
        bh=xAmdIKxn1vlp7D2ukzr9l0i4qp4XEa+oNjtGZw6WZaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpm6TZBpHuTrr8ztMUu/YYPHUYmg7DHismsZGJAUlj5f3XxO1HV5E8pXSsh4prrdr
         seUB/1cHIFxAu2CVN0s/IryssXDKtLynvuFJdWdy93t+Q2gWQ9bw4Jx6WIFXlxh2MT
         tgtPh0YgHLcWtayEArECdhSdRFEmlLXc0ZmygRSg=
Date:   Mon, 16 Sep 2019 21:43:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, will.deacon@arm.com,
        mark.rutland@arm.com
Subject: Re: [PATCH 3/4] x86: use the correct function type for sys_ni_syscall
Message-ID: <20190916204315.vtvlddghswbwlfkg@willie-the-truck>
References: <20190913210018.125266-1-samitolvanen@google.com>
 <20190913210018.125266-4-samitolvanen@google.com>
 <CALCETrWquNJJ6yXdHA_F3h71hVrFjnpwmdH2NmGZyFu-V6Lnfg@mail.gmail.com>
 <CABCJKud9ikdsfy9-bugbqKb-C7VXEEPJ_P1bO5KpGqv62Wuc7Q@mail.gmail.com>
 <9E76DD0A-7FB0-4BDB-A8B5-920265337ACB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E76DD0A-7FB0-4BDB-A8B5-920265337ACB@amacapital.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 05:27:40PM -0700, Andy Lutomirski wrote:
> > On Sep 13, 2019, at 4:26 PM, Sami Tolvanen <samitolvanen@google.com> wrote:
> >> On Fri, Sep 13, 2019 at 3:45 PM Andy Lutomirski <luto@kernel.org> wrote:
> >> Should this be SYSCALL_DEFINE0?
> > 
> > It can be, and that would also fix the issue. However, it does result
> > in unnecessary error injection to be hooked up here, which is why
> > arm64 preferred to avoid the macro when I fixed it there. S390 uses
> > SYSCALL_DEFINE0 for this though and since sys_ni_syscall always
> > returns -ENOSYS, it shouldn't be a huge problem. Thoughts?
> > 
> 
> I don’t see why all syscalls except these  few should have error injection
> hooked up.  It’s also IMO nicer from a maintenance perspective to have all
> syscalls use the same macros.
> 
> Will, is there something I’m missing?

There was a reasonable request from Mark (CC'd) not to allow error injection
for unimplemented system calls, so that's why we took the approach that we
did. There was also a vague plan to fix this for everybody [1] but evidently
nobody found the time :(

Will

[1] https://lore.kernel.org/lkml/20190524215821.GA37129@google.com/T/#m6519b2aad06d8c384de1f55256f08687c83d8796
