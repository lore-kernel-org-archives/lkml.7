Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E59C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD862332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHUAm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:42:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:49888 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfHUAm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:42:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7L0gRWO003493;
        Tue, 20 Aug 2019 19:42:29 -0500
Message-ID: <c7f0f066ff9718bdce5f94b222526de4bc5372c2.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 05/12] powerpc/mm: rework io-workaround invocation.
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 21 Aug 2019 10:42:27 +1000
In-Reply-To: <20190820222828.GC18433@lst.de>
References: <cover.1566309262.git.christophe.leroy@c-s.fr>
         <5fa3ef069fbd0f152512afaae19e7a60161454cf.1566309262.git.christophe.leroy@c-s.fr>
         <20190820222828.GC18433@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 00:28 +0200, Christoph Hellwig wrote:
> On Tue, Aug 20, 2019 at 02:07:13PM +0000, Christophe Leroy wrote:
> > ppc_md.ioremap() is only used for I/O workaround on CELL platform,
> > so indirect function call can be avoided.
> > 
> > This patch reworks the io-workaround and ioremap() functions to
> > use the global 'io_workaround_inited' flag for the activation
> > of io-workaround.
> > 
> > When CONFIG_PPC_IO_WORKAROUNDS or CONFIG_PPC_INDIRECT_MMIO are not
> > selected, the I/O workaround ioremap() voids and the global flag is
> > not used.
> 
> Note that CONFIG_PPC_IO_WORKAROUNDS is only selected by a specific cell
> config,  and CONFIG_PPC_INDIRECT_MMIO is always selected by cell, so
> I think we can make CONFIG_PPC_IO_WORKAROUNDS depend on
> CONFIG_PPC_INDIRECT_MMIO

Or we can deprecate that old platform... not sure anybody uses it
anymore (if anybody ever did).

Cheers,
ben.


