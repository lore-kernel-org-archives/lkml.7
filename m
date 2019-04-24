Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gTPqPuJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfDXT2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:28:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDXT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hEWT6gPnYwEoKNDjpGEQFJKxFxQoG9b2gItqJSpRFRI=; b=gTPqPuJQaC+T3y8pejBbLw8v7
        vQRyhDc42Dm4v9Igf2CosDg9XMSe4Vupf6EGCqRRnWg0zCkfceJoNemUlXlWgVZGCjrlzbsC7A5mq
        J0KJ5AraOZaqi0lpdSinnsGv+j5fpa/rrHZWiw31Cr0yJWR69eNNa4W5BuNr6um/Jj/Kfd8HtIGfK
        lOrO5FmvHIo8Hy/QeX1IDDY1Hv8Mci/N3Dxtoo/lRZo4IddNo0lb9djQs9fhO9F3WVeXUqcA2YXQe
        oKzpAtZYJW/gdDKjUYELAZ6pVgbzlU0YCG3VcucMFdOmjv0DwnC07Ctz3xq/u/N28BIf9ZiFo4bW0
        CLJZDcLSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJNYz-00085z-2L; Wed, 24 Apr 2019 19:28:13 +0000
Date:   Wed, 24 Apr 2019 12:28:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190424192812.GG19031@bombadil.infradead.org>
References: <20190424191440.170422-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424191440.170422-1-matthewgarrett@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:14:40PM -0700, Matthew Garrett wrote:
> Unfortunately, if an application exits uncleanly, its secrets may still be
> present in RAM. This can't be easily fixed in userland (eg, if the OOM
> killer decides to kill a process holding secrets, we're not going to be able
> to avoid that), so this patch adds a new flag to madvise() to allow userland
> to request that the kernel clear the covered pages whenever the page
> reference count hits zero. Since vm_flags is already full on 32-bit, it
> will only work on 64-bit systems.

Your request seems reasonable to me.

> +++ b/include/linux/page-flags.h
> @@ -118,6 +118,7 @@ enum pageflags {
>  	PG_reclaim,		/* To be reclaimed asap */
>  	PG_swapbacked,		/* Page is backed by RAM/swap */
>  	PG_unevictable,		/* Page is "unevictable"  */
> +	PG_wipeonrelease,

But you can't have a new PageFlag.  Can you instead zero the memory in
unmap_single_vma() where we call uprobe_munmap() and untrack_pfn() today?

