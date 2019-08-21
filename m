Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662BC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C412082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfHUBaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:30:39 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:25685 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726307AbfHUBaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:30:39 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x7L1HIrU040654;
        Wed, 21 Aug 2019 09:17:18 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 21 Aug 2019
 09:29:22 +0800
Date:   Wed, 21 Aug 2019 09:29:22 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Atish Patra <Atish.Patra@wdc.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190821012921.GA30187@andestech.com>
References: <20190820004735.18518-1-atish.patra@wdc.com>
 <mvmh86cl1o3.fsf@linux-m68k.org>
 <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
 <20190820092207.GA26271@infradead.org>
 <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x7L1HIrU040654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:28:36PM +0000, Atish Patra wrote:
> On Tue, 2019-08-20 at 02:22 -0700, hch@infradead.org wrote:
> > On Tue, Aug 20, 2019 at 08:42:19AM +0000, Atish Patra wrote:
> > > cmask NULL is pretty common case and we would  be unnecessarily
> > > executing bunch of instructions everytime while not saving much.
> > > Kernel
> > > still have to make an SBI call and OpenSBI is doing a local flush
> > > anyways.
> > > 
> > > Looking at the code again, I think we can just use cpumask_weight
> > > and
> > > do local tlb flush only if local cpu is the only cpu present. 
> > > 
> > > Otherwise, it will just fall through and call
> > > sbi_remote_sfence_vma().
> > 
> > Maybe it is just time to split the different cases at a higher level.
> > The idea to multiple everything onto a single function always seemed
> > odd to me.
> > 
> > FYI, here is what I do for the IPI based tlbflush for the native S-
> > mode
> > clint prototype, which seems much easier to understand:
> > 
> > http://git.infradead.org/users/hch/riscv.git/commitdiff/ea4067ae61e20fcfcf46a6f6bd1cc25710ce3afe
> 
> This does seem a lot cleaner to me. We can reuse some of the code for
> this patch as well. Based on NATIVE_CLINT configuration, it will send
> an IPI or SBI call.

IMHO, this approach should be avoided because CLINT is compatible to but
 not mandatory in the privileged spec.  In other words, it is possible that
a Linux-capable RISC-V platform does not contain a CLINT component but
rely on some other mechanism to deal with SW/timer interrupts.

> 
> I can rebase my patch on top of yours and I can send it together or you
> can include in your series.
> 
> Let me know your preference.
> 
> -- 
> Regards,
> Atish

Best,
Alan
