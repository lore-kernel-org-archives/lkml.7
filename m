Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8730ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C82086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUQkRGtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfJOQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:26:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfJOQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZypuQh7t9PSVnbgbqJqaj9CAuSfysI8ltXj5dIpJ8G0=; b=sUQkRGtMMKhj+o8Na0PSwNgFi
        KYfWXWqFNAwHhz0Tl6vVI1jKcsQQ9DEjLiWfgTxj6L88kCspWFYdU3UsYjJIPa3wO/JOXxRlhyTG1
        r/+Uwzd/wOUZGP2id3Tah0Otv9oUx2flap59++DMFxNZ257Clvx8zl5Cm6nJ4zwc0Qg30qe10XpEq
        6V5YEUgeR8MQXT8cS8h9YsmFQdo1o9VeBXI8RNZqtdRbT6nr3gsbfBYKr09iSESV7n+axCAuVCb9H
        vTQQrNYEII2TjJPN3XSTKnZKmW16sKwqS7NrT6TOHVs6QyhDxad/ESgYcViL4RdGChwjDtUEbsO0g
        OyPy0SVyg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKPeD-0005yz-Lt; Tue, 15 Oct 2019 16:26:09 +0000
Date:   Tue, 15 Oct 2019 09:26:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Frank Rowand <frank.rowand@am.sony.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] Revert "ARM: Initialize split page table locks for
 vector page"
Message-ID: <20191015162609.GH32665@bombadil.infradead.org>
References: <20191014160238.enawbbfcxnbdrlch@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014160238.enawbbfcxnbdrlch@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:02:38PM +0200, Sebastian Andrzej Siewior wrote:
> I'm dropping this patch, with its original description:
> 
> |ARM: Initialize split page table locks for vector page
> |
> |Without this patch, ARM can not use SPLIT_PTLOCK_CPUS if
> |PREEMPT_RT_FULL=y because vectors_user_mapping() creates a
> |VM_ALWAYSDUMP mapping of the vector page (address 0xffff0000), but no
> |ptl->lock has been allocated for the page.  An attempt to coredump
> |that page will result in a kernel NULL pointer dereference when
> |follow_page() attempts to lock the page.
> |
> |The call tree to the NULL pointer dereference is:
> |
> |   do_notify_resume()
> |      get_signal_to_deliver()
> |         do_coredump()
> |            elf_core_dump()
> |               get_dump_page()
> |                  __get_user_pages()
> |                     follow_page()
> |                        pte_offset_map_lock() <----- a #define
> |                           ...
> |                              rt_spin_lock()
> |
> |The underlying problem is exposed by mm-shrink-the-page-frame-to-rt-size.patch.
> 
> The patch named mm-shrink-the-page-frame-to-rt-size.patch was dropped
> from the RT queue once the SPLIT_PTLOCK_CPUS feature (in a slightly
> different shape) went upstream (somewhere between v3.12 and v3.14).
> 
> I can see that the patch still allocates a lock which wasn't there
> before. However I can't trigger a kernel oops like described in the
> patch by triggering a coredump.

Did your test build have ALLOC_SPLIT_PTLOCKS defined?
