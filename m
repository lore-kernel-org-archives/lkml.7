Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4792146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDKWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:13:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:44474 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfDKWNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3BMCQgr007560;
        Thu, 11 Apr 2019 17:12:27 -0500
Message-ID: <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Date:   Fri, 12 Apr 2019 08:12:26 +1000
In-Reply-To: <20190405135936.7266-2-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
         <20190405135936.7266-2-will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-05 at 14:59 +0100, Will Deacon wrote:
> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +       writes by the CPU to a particular device will arrive in program order.

Minor nit... I would have said "All readX() and writeX() accesses _from
the same CPU_ to the same peripheral... and then s/the CPU/this CPU.

> -     Accesses to this space may be fully synchronous (as on i386), but
> -     intermediary bridges (such as the PCI host bridge) may not fully honour
> -     that.
> +     2. A writeX() by the CPU to the peripheral will first wait for the
> +        completion of all prior CPU writes to memory. For example, this ensures
> +        that writes by the CPU to an outbound DMA buffer allocated by
> +        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
> +        to its MMIO control register to trigger the transfer.

Similarily "the CPU" -> "a CPU"
>  
> -     They are guaranteed to be fully ordered with respect to each other.
> +     3. A readX() by the CPU from the peripheral will complete before any
> +       subsequent CPU reads from memory can begin. For example, this ensures
> +       that reads by the CPU from an incoming DMA buffer allocated by
> +       dma_alloc_coherent() will not see stale data after reading from the DMA
> +       engine's MMIO status register to establish that the DMA transfer has
> +       completed.
>  
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +     4. A readX() by the CPU from the peripheral will complete before any
> +       subsequent delay() loop can begin execution. For example, this ensures
> +       that two MMIO register writes by the CPU to a peripheral will arrive at
> +       least 1us apart if the first write is immediately read back with readX()
> +       and udelay(1) is called prior to the second writeX().
>  
> - (*) readX(), writeX():
> +     __iomem pointers obtained with non-default attributes (e.g. those returned
> +     by ioremap_wc()) are unlikely to provide many of these guarantees.

So we give up on defining _wc semantics ? :-) Fair enough, it's a
mess...

 .../...

> +All of these accessors assume that the underlying peripheral is little-endian,
> +and will therefore perform byte-swapping operations on big-endian architectures.

This is not true of readsX/writesX, those will perform native accesses and are
intrinsically endian neutral.

> +Composing I/O ordering barriers with SMP ordering barriers and LOCK/UNLOCK
> +operations is a dangerous sport which may require the use of mmiowb(). See the
> +subsection "Acquires vs I/O accesses" for more information.

Cheers,
Ben.

