Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60953C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A03E21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfIDCG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 22:06:28 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:28352 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727805AbfIDCG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:06:27 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x841qSq9066455;
        Wed, 4 Sep 2019 09:52:28 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 4 Sep 2019
 10:05:39 +0800
Date:   Wed, 4 Sep 2019 10:05:39 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     Christoph Hellwig <hch@lst.de>, <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 08/15] riscv: provide native clint access for M-mode
Message-ID: <20190904020539.GA18202@andestech.com>
References: <20190828061146.GA21670@lst.de>
 <mhng-e03fb9a6-73ee-437e-aee1-e30427f5d644@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-e03fb9a6-73ee-437e-aee1-e30427f5d644@palmer-si-x1e>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x841qSq9066455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:48:52AM -0700, Palmer Dabbelt wrote:
> On Tue, 27 Aug 2019 23:11:46 PDT (-0700), Christoph Hellwig wrote:
> >On Tue, Aug 27, 2019 at 04:37:16PM -0700, Palmer Dabbelt wrote:
> >>clint0 would be version 0 of the clint, with is the core-local interrupt
> >>controller in rocket chip.  It should be "sifive,clint-1.0.0", not
> >>"riscv,clint0", as it's a SiFive widget.  Unfortunately there are a lot of
> >>legacy device trees floating around, but I'm only considering what's been
> >>upstream to be actually part of the spec.
> >>
> >>In this case the code should match on a "sifive,clint-1.0.0", and the
> >>device trees should be fixed up to match.  We match on "riscv,plic0" for
> >>legacy systems, and I guess it makes sense to do something similar here.
> >
> >IFF we decided to change it I'd rather separate DT noes for the ipi
> >bank vs timecmp register vs timeval to support variable layouts.  The
> >downside is that we can't just boot on unmodified upstream qemu, which
> >has used the "riscv,clint0" for years.
> 
> Like I alluded to above, matching on "riscv,clint0" seems reasonable to me
> as it's a defacto standard -- we'll just have to make sure that if we ever
> end up with a RISC-V CLINT that the DT entry is something else.

De facto, but not mandatory.

> 
> As far as splitting the memory maps goes, I don't have a strong opinion but
> it seems like that'll introduce more complexity than it's worth.
> 

At least the splitting can keep reminding us and any new comers in the future
that CLINT is not (yet) a must in RISC-V landscape.  A previous discussion
FYI: ( https://lkml.org/lkml/2019/8/20/1361 )

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
