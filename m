Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E562173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfH1GLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:11:50 -0400
Received: from verein.lst.de ([213.95.11.211]:34559 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:11:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D25A168AFE; Wed, 28 Aug 2019 08:11:46 +0200 (CEST)
Date:   Wed, 28 Aug 2019 08:11:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] riscv: provide native clint access for M-mode
Message-ID: <20190828061146.GA21670@lst.de>
References: <20190819101648.GA29645@lst.de> <mhng-6c980844-cfea-4aaa-ac86-3c99ce6a6d14@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6c980844-cfea-4aaa-ac86-3c99ce6a6d14@palmer-si-x1e>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:37:16PM -0700, Palmer Dabbelt wrote:
> clint0 would be version 0 of the clint, with is the core-local interrupt 
> controller in rocket chip.  It should be "sifive,clint-1.0.0", not 
> "riscv,clint0", as it's a SiFive widget.  Unfortunately there are a lot of 
> legacy device trees floating around, but I'm only considering what's been 
> upstream to be actually part of the spec.
>
> In this case the code should match on a "sifive,clint-1.0.0", and the 
> device trees should be fixed up to match.  We match on "riscv,plic0" for 
> legacy systems, and I guess it makes sense to do something similar here.

IFF we decided to change it I'd rather separate DT noes for the ipi
bank vs timecmp register vs timeval to support variable layouts.  The
downside is that we can't just boot on unmodified upstream qemu, which
has used the "riscv,clint0" for years.
