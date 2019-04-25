Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E83C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897E620717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ba/RHj2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbfDYUi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:38:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfDYUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Getn4cTZ4pFTdmhspLn2WdzsbNKww/5YNBDIeCXTUdc=; b=Ba/RHj2PKqwoRzj/7lCLAnOuc
        JR5I1Rltif9/m0BwLlHtq/xarEqQQzk7NYCfDBIFvwfaeW73JGyno4/3sXKiM/OeGLP12PzYHWyD7
        mXYxKYSYIxOUsW/jb8kq4c0NOrkpvblGi+CQpZtEBwhz5eX1pNNs45/xq+6NdRpYyuAatYAgkHKaP
        16qrHHWC5VV8gXJ+KWpbt/jLiTI22b4SYcU6cE192rn8HQRcxLlRJH9dcswMmfsSE3mGgF+VAHCq9
        i8s4L9KvR6Oox3+8S6kfvlGEEzzNDD49oVHCCT97bAmfxpN02nxLIgmOQdqDO0rgM8CpsRocAJ7M0
        /sPr8h5vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJl8p-0006Vb-2T; Thu, 25 Apr 2019 20:38:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B5C9200D2F43; Thu, 25 Apr 2019 22:38:45 +0200 (CEST)
Date:   Thu, 25 Apr 2019 22:38:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com
Subject: Re: [PATCH v4 16/23] vmalloc: Add flag for free of special
 permsissions
Message-ID: <20190425203845.GA12232@hirez.programming.kicks-ass.net>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
 <20190422185805.1169-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422185805.1169-17-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:57:58AM -0700, Rick Edgecombe wrote:
> Add a new flag VM_FLUSH_RESET_PERMS, for enabling vfree operations to
> immediately clear executable TLB entries before freeing pages, and handle
> resetting permissions on the directmap. This flag is useful for any kind
> of memory with elevated permissions, or where there can be related
> permissions changes on the directmap. Today this is RO+X and RO memory.
> 
> Although this enables directly vfreeing non-writeable memory now,
> non-writable memory cannot be freed in an interrupt because the allocation
> itself is used as a node on deferred free list. So when RO memory needs to
> be freed in an interrupt the code doing the vfree needs to have its own
> work queue, as was the case before the deferred vfree list was added to
> vmalloc.
> 
> For architectures with set_direct_map_ implementations this whole operation
> can be done with one TLB flush when centralized like this. For others with
> directmap permissions, currently only arm64, a backup method using
> set_memory functions is used to reset the directmap. When arm64 adds
> set_direct_map_ functions, this backup can be removed.
> 
> When the TLB is flushed to both remove TLB entries for the vmalloc range
> mapping and the direct map permissions, the lazy purge operation could be
> done to try to save a TLB flush later. However today vm_unmap_aliases
> could flush a TLB range that does not include the directmap. So a helper
> is added with extra parameters that can allow both the vmalloc address and
> the direct mapping to be flushed during this operation. The behavior of the
> normal vm_unmap_aliases function is unchanged.

> +static inline void set_vm_flush_reset_perms(void *addr)
> +{
> +	struct vm_struct *vm = find_vm_area(addr);
> +
> +	if (vm)
> +		vm->flags |= VM_FLUSH_RESET_PERMS;
> +}

So, previously in the series we added NX to module_alloc() and fixed up
all the usage site. And now we're going through those very same sites to
add set_vm_flush_reset_perms().

Why isn't module_alloc() calling the above function and avoid sprinkling
it all over the place again?
