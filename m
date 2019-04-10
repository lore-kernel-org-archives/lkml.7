Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608C9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74D2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554893921;
	bh=cr8j94d885Du/l5KevVYcZmw8KiKKQE5vsfkE2tU9r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vQ34fPpT3NqiTtNgnuSc14HabSR+umfz/e5KzaZNB+olzzQR6PXuS93jjObZeLJ0v
	 DTGM1E6xnAIbRav/k/N0Ke6kzNtI/0AIuD8AGqAVfkmf+yR3kpumiBSBLBQ9yWwNq2
	 zm19fIOk8mb8LWAIw3hr5KptVx3eJpQc2Qe1oW8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfDJK6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:58:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39974 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfDJK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:58:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so2372022wre.7;
        Wed, 10 Apr 2019 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sm/tszu0J3RHjL4xyTjL1hUHUNIiZnuPvuy8orIO6bs=;
        b=CzskLsxtUxe4CgyiIC9ogpp2gn2dHmcQY4YagteI0cOWuNGhA4JvbI9Iw+0jiue2cT
         uxJnzOq4zYqBAWeXRPpHviCKRoBqGNTqq4aD4vXWl83i33kQfEYv7j/3pzdFg9Vknboc
         FpxdL012rQEt71G1wtHYBsF3G0Hgrs8iTuf+OSmfxNYhhTyZoMk2qQOV4PKcT9/Y7Zmo
         AluVufn8lsdv80KpRyFxZ4FuaAw5VSCFkEplDCsDRZk8umVKjVKNnwGoJ1og77F8FB1z
         2sumjXeliVAs7BY8LFrLBjmXEY6WNPhJqojfeHX3MDPdptVBMnAPve+RSKvJFUazX/vc
         FJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sm/tszu0J3RHjL4xyTjL1hUHUNIiZnuPvuy8orIO6bs=;
        b=WuBX1k4JYTCohZAvbUkZgBiALhkb7OgL0j40fnrKx0YcckC2y0ZLuhybwdiwT5ukx4
         g18FZj324HelJ52f71omj3j0F9qIb35HG2LnqJ4lnZznlt93UzcUYW7M51e/272ew4zX
         8J/xE3ZPWGSpKpww2kjuu1dWhA2a5IOj+kzOIiRIEDEtOpa9f9si5AXMml8gjxh4eK8S
         foqhgKzvIzYOOd5VB/Lu9pzc9xcPh9jz+SEbbThX4A9OE4O2/FTVAykpnoYZhRLN4PL7
         6Vtaj+mByb+LrZaW8GlfRq4Tk4Sh8uuD9GazitmDDHwjBZmR6PMeDF2vt0/eIzfffoqI
         2Lmw==
X-Gm-Message-State: APjAAAURosK3jOxliWyEPOggWqsQlO5JJfQJAAaE1wOsutVepGc+mHjI
        xUYRrwta24891NH4j0OEtJw=
X-Google-Smtp-Source: APXvYqzbsvMQU5DOqtWYhWwiRRDVjUBLJ+Sg+S4Jj44wxtGf/e7u0LAK4IM7FAp/86VN7Ht4TyJVfg==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr7225972wrj.16.1554893917130;
        Wed, 10 Apr 2019 03:58:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a187sm2129646wma.32.2019.04.10.03.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 03:58:36 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:58:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190410105833.GA116161@gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405135936.7266-2-will.deacon@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mostly minor grammer fixes:

* Will Deacon <will.deacon@arm.com> wrote:

> + (*) readX(), writeX():
>  
> +     The readX() and writeX() MMIO accessors take a pointer to the peripheral
> +     being accessed as an __iomem * parameter. For pointers mapped with the
> +     default I/O attributes (e.g. those returned by ioremap()), then the
> +     ordering guarantees are as follows:

s/then the
 /the

> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +	writes by the CPU to a particular device will arrive in program order.

Vertical alignment whitespace damage: some indentations are done via 
spaces, one via tabs. Please standardize to tabs.

I'd also suggest:

s/For example, this ensures
 /For example this ensures


for the rest of the text too. The comma after the 'For example,' 
introductory phrase is grammatically correct but stylistically confusing, 
because in reality there's a *second* introductory phrase via "this 
ensures".

>  
> +     2. A writeX() by the CPU to the peripheral will first wait for the
> +        completion of all prior CPU writes to memory. For example, this ensures
> +        that writes by the CPU to an outbound DMA buffer allocated by
> +        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
> +        to its MMIO control register to trigger the transfer.
>  
> +     3. A readX() by the CPU from the peripheral will complete before any
> +	subsequent CPU reads from memory can begin. For example, this ensures
> +	that reads by the CPU from an incoming DMA buffer allocated by
> +	dma_alloc_coherent() will not see stale data after reading from the DMA
> +	engine's MMIO status register to establish that the DMA transfer has
> +	completed.
>  
> +     4. A readX() by the CPU from the peripheral will complete before any
> +	subsequent delay() loop can begin execution. For example, this ensures
> +	that two MMIO register writes by the CPU to a peripheral will arrive at
> +	least 1us apart if the first write is immediately read back with readX()
> +	and udelay(1) is called prior to the second writeX().

This might be more readable via some short code sequence instead?

>  
> +     __iomem pointers obtained with non-default attributes (e.g. those returned
> +     by ioremap_wc()) are unlikely to provide many of these guarantees.

This part is a bit confusing I think, because it's so cryptic. "Unlikely" 
as in probabilistic? ;-) So I think we should at least give some scope of 
the exceptions and expected trouble, or at least direct people to those 
APIs to see what the semantics are?

>  
> + (*) readX_relaxed(), writeX_relaxed():
>  
> +     These are similar to readX() and writeX(), but provide weaker memory
> +     ordering guarantees. Specifically, they do not guarantee ordering with
> +     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
> +     but they are still guaranteed to be ordered with respect to other accesses
> +     to the same peripheral when operating on __iomem pointers mapped with the
> +     default I/O attributes.
>  
> + (*) readsX(), writesX():
>  
> +     The readsX() and writesX() MMIO accessors are designed for accessing
> +     register-based, memory-mapped FIFOs residing on peripherals that are not
> +     capable of performing DMA. Consequently, they provide only the ordering
> +     guarantees of readX_relaxed() and writeX_relaxed(), as documented above.

So is there any difference between 'X_relaxed' and 'sX' variants? What is 
the 's' about?

Thanks,

	Ingo
