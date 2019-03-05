Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAC220684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCEAWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:22:04 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:28879 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbfCEAWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:22:04 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x250KMj2014854;
        Tue, 5 Mar 2019 08:20:22 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 5 Mar 2019
 08:21:20 +0800
Date:   Tue, 5 Mar 2019 08:21:17 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Jim Wilson <jimw@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>
Subject: Re: [PATCH 0/3] riscv: Fix debug instruction check and support
 trap-based WARN()
Message-ID: <20190305002116.GA5887@andestech.com>
References: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
 <mhng-76c68381-da6b-4b8c-97c9-e38d503b93bc@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-76c68381-da6b-4b8c-97c9-e38d503b93bc@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x250KMj2014854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 04:35:08AM +0800, Palmer Dabbelt wrote:
> On Thu, 28 Feb 2019 02:31:28 PST (-0800), vincentc@andestech.com wrote:
> > The handler for the debug exception will call is_valid_bugaddr(bugaddr) to
> > check if the instruction in bugaddr is a real debug instruction. However,
> > the expected instruction, ebreak, is possibly translated to c.ebreak by
> > assmebler when C extension is supported. This patchset will add c.ebreak
> > into the check mechanism. In addition, BUG() is currently unable to work in
> > the kernel module due to an inappropriated condition in is_valid_bugaddr().
> > This issue will be fixed in this patchset. Finally, this patchset enables
> > WARN() related functions to trap the code to help developers debug it.
> >
> >
> >
> >
> >
> > Vincent Chen (3):
> >   riscv: Add the support for c.ebreak check in is_valid_bugaddr()
> >   riscv: Support BUG() in kernel module
> >   riscv: Make WARN() related functions able to trigger a trap exception
> 
> I'm finding this patch set a bit hard to follow, and I think it has more diff 
> than is necessary.  For example, the first patch introduces a new die() only to 
> have it removed by the third patch.  There's also some unnecessary 
> non-functional diff, like
> 
>     @@ -149,12 +161,13 @@ int is_valid_bugaddr(unsigned long pc)
>             if (probe_kernel_address((bug_insn_t *)pc, insn))
>                     return 0;
>             if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
>     -               return insn == __BUG_INSN_32;
>     +               return (insn == __BUG_INSN_32);
>             else
>     -               return (insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16;
>     +               return ((insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16);
>      }
>      #endif /* CONFIG_GENERIC_BUG */
>     
>     +
>      void __init trap_init(void)
>      {
>             /*
> 

> I like the idea of the patch set, though.  Do you have time to clean it up and 
> submit a v2?


OK, I will improve it and submit a v2 patch.
