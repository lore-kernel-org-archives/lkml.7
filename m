Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154CF2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfEVTnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:43:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfEVTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:43:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hTX93-00050n-IX; Wed, 22 May 2019 21:43:25 +0200
Date:   Wed, 22 May 2019 21:43:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
Message-ID: <20190522194322.5k52docwgp5zkdcj@linutronix.de>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
 <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-22 12:21:13 [-0700], Andrew Morton wrote:
> On Tue, 14 May 2019 17:29:55 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
> 
> > When get_user_pages*() is called with pages = NULL, the processing of
> > VM_FAULT_RETRY terminates early without actually retrying to fault-in all
> > the pages.
> > 
> > If the pages in the requested range belong to a VMA that has userfaultfd
> > registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
> > has populated the page, but for the gup pre-fault case there's no actual
> > retry and the caller will get no pages although they are present.
> > 
> > This issue was uncovered when running post-copy memory restore in CRIU
> > after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
> > copy_fpstate_to_sigframe() fails").
> > 
> > After this change, the copying of FPU state to the sigframe switched from
> > copy_to_user() variants which caused a real page fault to get_user_pages()
> > with pages parameter set to NULL.
> 
> You're saying that argument buf_fx in copy_fpstate_to_sigframe() is NULL?

buf_fx is user stack pointer and it should not be NULL.

> If so was that expected by the (now cc'ed) developers of
> d9c9ce34ed5c8923 ("x86/fpu: Fault-in user stack if
> copy_fpstate_to_sigframe() fails")?
> 
> It seems rather odd.  copy_fpregs_to_sigframe() doesn't look like it's
> expecting a NULL argument.

exactly, this is not expected.

> Also, I wonder if copy_fpstate_to_sigframe() would be better using
> fault_in_pages_writeable() rather than get_user_pages_unlocked().  That
> seems like it operates at a more suitable level and I guess it will fix
> this issue also.

It looks, like fault_in_pages_writeable() would work. If this is the
recommendation from the MM department than I can switch to that.

> > In post-copy mode of CRIU, the destination memory is managed with
> > userfaultfd and lack of the retry for pre-fault case in get_user_pages()
> > causes a crash of the restored process.
> > 
> > Making the pre-fault behavior of get_user_pages() the same as the "normal"
> > one fixes the issue.
> 
> Should this be backported into -stable trees?

Sebastian
