Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26669C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2F8222EA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfCXO5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:57:18 -0400
Received: from verein.lst.de ([213.95.11.211]:52885 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfCXO5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:57:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2F1A568B20; Sun, 24 Mar 2019 15:57:08 +0100 (CET)
Date:   Sun, 24 Mar 2019 15:57:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
Message-ID: <20190324145708.GA3355@lst.de>
References: <20190324110804.68555-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324110804.68555-1-anup.patel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:08:29AM +0000, Anup Patel wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Huh?  I don't think this is from Mike and me.

> +unsigned long va_pa_offset;
> +EXPORT_SYMBOL(va_pa_offset);
> +unsigned long pfn_base;
> +EXPORT_SYMBOL(pfn_base);

Can you move va_pa_offset and pfn_base next to the swapper_pg_dir
declaration?  Thats where I move them in my current nommu patchset,
as that allows to just have a single CONFIG_NOMMU in mm/init.c.

Otherwise this looks fine to me.
