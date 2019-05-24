Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D6AC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996C2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVggurFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404374AbfEXWXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:23:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40333 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:23:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so5760840pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uY0FrZwLMlEdvMXObP6HmMvZtV9RX+NFP32akQRMisw=;
        b=MVggurFYQAeK4LCtMHLLfWlxS4FAFp5saedV7Oi2NcERzn+8RROvvBejnnClChsW9W
         pBOFL1aquNfv7WVTo2H+pelc/8Wy8lsGa0fnHhnkLUSbb0tcunW31eYzX3piWoL/0cZg
         XIt5T68gJ6vb7GIUprFFM0bb4fWYB4o8wIheFIyLHA4MdSmLpgDUa450x1Xjj86AeoSw
         B57FIUYX2XA2geeYOW4W50aJ5NVrl6durBAZo/9pdgCGYo1t4PfaDidcu9eSoflr8v8+
         ejUZwAJUOU5m/2RG4GfquqafvZr5WyvICU0hFD6lTodsddNrj8A1AUsvzcwK0rlzq9rN
         rfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uY0FrZwLMlEdvMXObP6HmMvZtV9RX+NFP32akQRMisw=;
        b=O+6yeajZwUTFrz5NzCg7REmFuTMwWxwbD1jd6TNaLwLrlrX9O6MI75D6VVeVQMMQPC
         a4v8kDuzt2LLCgVAq4CD88jXqjTOWxptrjyOg3XW0jJEU7MzJfAPlDFInnikR0f7lV+V
         zXVvZ69SdQ9r15349ycXkPkXSgxLB8TFO9ZYyJQhduog7pW3WQQ6GhqdXxL0QQ+QO8Ik
         AuGS4aXvDs5Vy00RYAKghv4BfCcuRsqMTpMYdGWzWZvIcjqxJuFN+ccUjlhauNoP+7E5
         YsSs7rCJsE5vOsdWi58PgBclnDTi7+DeS8w7B/3aOVFQarGh7vHR/PIOHYaM+tQS27mG
         JF6Q==
X-Gm-Message-State: APjAAAV2581n3yj7GUA2uvkN94C+QP8mmp+GJ5jA2vYhisGZVs2uE4XW
        hsjHbTytA9efqYIcWgUiGeg/DA==
X-Google-Smtp-Source: APXvYqxDbCd73iBCnLO2UiphIN66gZkL06mbL5S45mv+2xbzptLRthRpgOnDbiHTKg0CjtnZnjYm5w==
X-Received: by 2002:a63:c02:: with SMTP id b2mr92431926pgl.5.1558736592337;
        Fri, 24 May 2019 15:23:12 -0700 (PDT)
Received: from [100.112.76.36] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id t18sm2906403pgm.69.2019.05.24.15.23.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:23:11 -0700 (PDT)
Date:   Fri, 24 May 2019 15:22:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
In-Reply-To: <20190522194322.5k52docwgp5zkdcj@linutronix.de>
Message-ID: <alpine.LSU.2.11.1905241429460.1141@eggly.anvils>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com> <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org> <20190522194322.5k52docwgp5zkdcj@linutronix.de>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Sebastian Andrzej Siewior wrote:
> On 2019-05-22 12:21:13 [-0700], Andrew Morton wrote:
> > On Tue, 14 May 2019 17:29:55 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
> > 
> > > When get_user_pages*() is called with pages = NULL, the processing of
> > > VM_FAULT_RETRY terminates early without actually retrying to fault-in all
> > > the pages.
> > > 
> > > If the pages in the requested range belong to a VMA that has userfaultfd
> > > registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
> > > has populated the page, but for the gup pre-fault case there's no actual
> > > retry and the caller will get no pages although they are present.
> > > 
> > > This issue was uncovered when running post-copy memory restore in CRIU
> > > after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
> > > copy_fpstate_to_sigframe() fails").

I've been getting unexplained segmentation violations, and "make" giving
up early, when running kernel builds under swapping memory pressure: no
CRIU involved.

Bisected last night to that same x86/fpu commit, not itself guilty, but
suffering from the odd behavior of get_user_pages_unlocked() giving up
too early.

(I wondered at first if copy_fpstate_to_sigframe() ought to retry if
non-negative ret < nr_pages, but no, that would be wrong: a present page
followed by an invalid area would repeatedly return 1 for nr_pages 2.)

Cc'ing Pavel, who's been having segfault trouble in emacs: maybe same?

> > > 
> > > After this change, the copying of FPU state to the sigframe switched from
> > > copy_to_user() variants which caused a real page fault to get_user_pages()
> > > with pages parameter set to NULL.
...
> > Also, I wonder if copy_fpstate_to_sigframe() would be better using
> > fault_in_pages_writeable() rather than get_user_pages_unlocked().  That
> > seems like it operates at a more suitable level and I guess it will fix
> > this issue also.
> 
> It looks, like fault_in_pages_writeable() would work. If this is the
> recommendation from the MM department than I can switch to that.

I've now run a couple of hours of load successfully with Mike's patch
to GUP, no problem; but whatever the merits of that patch in general,
I agree with Andrew that fault_in_pages_writeable() seems altogether
more appropriate for copy_fpstate_to_sigframe(), and have now run a
couple of hours of load successfully with this instead (rewrite to taste):

--- 5.2-rc1/arch/x86/kernel/fpu/signal.c
+++ linux/arch/x86/kernel/fpu/signal.c
@@ -3,6 +3,7 @@
  * FPU signal frame handling routines.
  */
 
+#include <linux/pagemap.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
 
@@ -189,15 +190,7 @@ retry:
 	fpregs_unlock();
 
 	if (ret) {
-		int aligned_size;
-		int nr_pages;
-
-		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
-		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
-
-		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
-					      NULL, FOLL_WRITE);
-		if (ret == nr_pages)
+		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}

(I did wonder whether there needs to be an access_ok() check on buf_fx;
but if so, then I think it would already have been needed before the
earlier copy_fpregs_to_sigframe(); but I didn't get deep enough into
that to be sure, nor into whether access_ok() check on buf covers buf_fx.)

Hugh

> 
> > > In post-copy mode of CRIU, the destination memory is managed with
> > > userfaultfd and lack of the retry for pre-fault case in get_user_pages()
> > > causes a crash of the restored process.
> > > 
> > > Making the pre-fault behavior of get_user_pages() the same as the "normal"
> > > one fixes the issue.
> > 
> > Should this be backported into -stable trees?
> 
> Sebastian
