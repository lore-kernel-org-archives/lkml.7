Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAFCC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F01020844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfHMPkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:40:15 -0400
Received: from verein.lst.de ([213.95.11.211]:58178 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfHMPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:40:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A99E68C4E; Tue, 13 Aug 2019 17:40:09 +0200 (CEST)
Date:   Tue, 13 Aug 2019 17:40:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>, linux-mm@kvack.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] riscv: clear the instruction cache and all
 registers when booting
Message-ID: <20190813154008.GB8686@lst.de>
References: <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com> <mhng-3f43f4b8-473d-429d-9a09-12d3542e33bc@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-3f43f4b8-473d-429d-9a09-12d3542e33bc@palmer-si-x1e>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 01:26:33AM -0700, Palmer Dabbelt wrote:
>>> +	csrs	sstatus, t1
>
> You need to check that the write stuck and branch around the FP instructions.
> Specifically, CONFIG_FPU means there may be an FPU, not there's definately an
> FPU.  You should also turn the FPU back off after zeroing the state.

Well, that is why we check the hwcaps from misa just above and skip
this fp reg clearing if it doesn't contain the 'F' or 'D' extension.

The caller disables the FPU a few instructions later:

	/*
         * Disable FPU to detect illegal usage of
	 * floating point in kernel space
	 */
	li t0, SR_FS
	csrc CSR_XSTATUS, t0
