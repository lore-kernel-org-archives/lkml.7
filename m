Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E2C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DDE205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfHSKQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:16:52 -0400
Received: from verein.lst.de ([213.95.11.211]:46376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfHSKQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:16:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 86B43227A81; Mon, 19 Aug 2019 12:16:48 +0200 (CEST)
Date:   Mon, 19 Aug 2019 12:16:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] riscv: provide native clint access for M-mode
Message-ID: <20190819101648.GA29645@lst.de>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-9-hch@lst.de> <20190813162958.GA27821@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813162958.GA27821@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:29:58PM +0100, Mark Rutland wrote:
> > +	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
> 
> Since the MMIO layout is that of the SiFive clint, the compatible string
> should be specific to that. e.g. "sifive,clint". That way it will be
> possible to distinguish it from other implementations.
> 
> What exactly is the "0" suffix for? Is that a version number?
> 
> If that's a CPU index, then I don't think that's the right way to encode
> this unless the programming interface actually differs across CPUs. It
> would be better to use an explicit phandle to express the affinity.

It isn't a cpu index, I suspect a version number.  These show up
in a lot of the early RISC-V DTs coming from the UCB/SiFive sphere.
They've now spread everywhere unfortunately.
