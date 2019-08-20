Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6158A22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfHTW2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:28:32 -0400
Received: from verein.lst.de ([213.95.11.211]:60449 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbfHTW2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:28:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEB5868B20; Wed, 21 Aug 2019 00:28:28 +0200 (CEST)
Date:   Wed, 21 Aug 2019 00:28:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 05/12] powerpc/mm: rework io-workaround invocation.
Message-ID: <20190820222828.GC18433@lst.de>
References: <cover.1566309262.git.christophe.leroy@c-s.fr> <5fa3ef069fbd0f152512afaae19e7a60161454cf.1566309262.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa3ef069fbd0f152512afaae19e7a60161454cf.1566309262.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:07:13PM +0000, Christophe Leroy wrote:
> ppc_md.ioremap() is only used for I/O workaround on CELL platform,
> so indirect function call can be avoided.
> 
> This patch reworks the io-workaround and ioremap() functions to
> use the global 'io_workaround_inited' flag for the activation
> of io-workaround.
> 
> When CONFIG_PPC_IO_WORKAROUNDS or CONFIG_PPC_INDIRECT_MMIO are not
> selected, the I/O workaround ioremap() voids and the global flag is
> not used.

Note that CONFIG_PPC_IO_WORKAROUNDS is only selected by a specific cell
config,  and CONFIG_PPC_INDIRECT_MMIO is always selected by cell, so
I think we can make CONFIG_PPC_IO_WORKAROUNDS depend on
CONFIG_PPC_INDIRECT_MMIO

>  #define _IO_WORKAROUNDS_H
>  
> +#ifdef CONFIG_PPC_IO_WORKAROUNDS
>  #include <linux/io.h>
>  #include <asm/pci-bridge.h>
>  
> @@ -32,4 +33,23 @@ extern int spiderpci_iowa_init(struct iowa_bus *, void *);
>  #define SPIDER_PCI_DUMMY_READ		0x0810
>  #define SPIDER_PCI_DUMMY_READ_BASE	0x0814
>  
> +#endif
> +
> +#if defined(CONFIG_PPC_IO_WORKAROUNDS) && defined(CONFIG_PPC_INDIRECT_MMIO)

and simplify the ifdefs here a bit.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
