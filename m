Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B96CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51485217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kKWEuING"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfDJG7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:59:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfDJG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pa9yXGXWbJBeYpUWKfQ3OcoqrYebqvpcXb3jKozmpHo=; b=kKWEuING3f2F4y1Crs43dW3di
        7Bgxl9UZq1ZWxGCBndfeH4As6FMxSHsqaBeXbGy1nKaBH4fcs4OGwRybfuk4thgRdacux+1NeL1wd
        fZ6MJ5QYy6PgmfZlZ1HuxBa2ZUuT4ynZ1HRd05tlU6w3HRdXC5FyER53UnJmZ3eODIvvVSDtMzA1o
        y0AmGJwp57NBJKxbBbCHJh4/wf99JEbw+dEwYWXttkE5YROQ6NdHe5mr0dWl2/XApRnu9i+o1aNrt
        ekUQ+YuDTPg9b5SNQIt5cFJD4lyNzNCzk4BP4gjihHO/QIWHLOmKmkyDFDaFRJut/1iiO9BJAP5q3
        475Whn/4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE7CO-0003NH-8Q; Wed, 10 Apr 2019 06:59:08 +0000
Date:   Tue, 9 Apr 2019 23:59:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 2/5] arm64, mm: Move generic mmap layout functions to
 mm
Message-ID: <20190410065908.GC2942@infradead.org>
References: <20190404055128.24330-1-alex@ghiti.fr>
 <20190404055128.24330-3-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404055128.24330-3-alex@ghiti.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:51:25AM -0400, Alexandre Ghiti wrote:
> - fix the case where stack randomization should not be taken into
>   account.

Hmm.  This sounds a bit vague.  It might be better if something
considered a fix is split out to a separate patch with a good
description.

> +config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> +	bool
> +	help
> +	  This allows to use a set of generic functions to determine mmap base
> +	  address by giving priority to top-down scheme only if the process
> +	  is not in legacy mode (compat task, unlimited stack size or
> +	  sysctl_legacy_va_layout).

Given that this is an option that is just selected by other Kconfig
options the help text won't ever be shown.  I'd just move it into a
comment bove the definition.

> +#ifdef CONFIG_MMU
> +#ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT

I don't think we need the #ifdef CONFIG_MMU here,
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should only be selected
if the MMU is enabled to start with.

> +#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
> +unsigned long arch_mmap_rnd(void)

Now that a bunch of architectures use a version in common code
the arch_ prefix is a bit mislead.  Probably not worth changing
here, but some time in the future it could use a new name.
