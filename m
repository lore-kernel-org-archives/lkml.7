Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2912173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558552877;
	bh=YbWw5jCdlVSPKASk0Am85SMF0LzLvtSiYq/4581+xHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1vRsWL+MSigby2aDMiwzTj//xhpdoEWDRrIUxmyh1RnbyhoDL+Bn/SR+PcE2XW4kX
	 8rWKOooMtScJRqET0/Lc+NTo4a6dWoJ+qKLc0ccK6/6bbPqdPWnXf9f6SE6wYt5tuz
	 CPxiV/Va4GW5KyMAhtWQNCzcQetvAaUaKD0VX5tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfEVTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfEVTVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:21:16 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523F120879;
        Wed, 22 May 2019 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552875;
        bh=YbWw5jCdlVSPKASk0Am85SMF0LzLvtSiYq/4581+xHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wlA5IMAkbdJJK84FwgfTk9vb9mKRpiUrE0gdmAYhRNeZdEZWLa1O+1TqMzYFFDkfR
         m8FRQRwg28nthhrzfBj+wuGjErUBKAjaQqkxYOpUwt4Yv2Q5F1PzzdjoWN+gmExmTD
         OETzWa9p/CSYA14EHx9WnsYDpghD4UP96mMh+maQ=
Date:   Wed, 22 May 2019 12:21:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
Message-Id: <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org>
In-Reply-To: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 17:29:55 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:

> When get_user_pages*() is called with pages = NULL, the processing of
> VM_FAULT_RETRY terminates early without actually retrying to fault-in all
> the pages.
> 
> If the pages in the requested range belong to a VMA that has userfaultfd
> registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
> has populated the page, but for the gup pre-fault case there's no actual
> retry and the caller will get no pages although they are present.
> 
> This issue was uncovered when running post-copy memory restore in CRIU
> after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
> copy_fpstate_to_sigframe() fails").
> 
> After this change, the copying of FPU state to the sigframe switched from
> copy_to_user() variants which caused a real page fault to get_user_pages()
> with pages parameter set to NULL.

You're saying that argument buf_fx in copy_fpstate_to_sigframe() is NULL?

If so was that expected by the (now cc'ed) developers of
d9c9ce34ed5c8923 ("x86/fpu: Fault-in user stack if
copy_fpstate_to_sigframe() fails")?

It seems rather odd.  copy_fpregs_to_sigframe() doesn't look like it's
expecting a NULL argument.

Also, I wonder if copy_fpstate_to_sigframe() would be better using
fault_in_pages_writeable() rather than get_user_pages_unlocked().  That
seems like it operates at a more suitable level and I guess it will fix
this issue also.

> In post-copy mode of CRIU, the destination memory is managed with
> userfaultfd and lack of the retry for pre-fault case in get_user_pages()
> causes a crash of the restored process.
> 
> Making the pre-fault behavior of get_user_pages() the same as the "normal"
> one fixes the issue.

Should this be backported into -stable trees?

> Fixes: d9c9ce34ed5c ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>


