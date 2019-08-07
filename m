Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA838C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA47421880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ltUuSGLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbfHGVbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:31:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37348 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbfHGVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:31:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so10026152pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQJ8f3sbtpxQFwytiN3eHpksnWvvNOcO2e4/JMupkqc=;
        b=ltUuSGLnwli7uHEKMbcJ+YOm7vx0HT8aK0FqET7xYC6vzOpSEUHRN/AATglHk0+0p+
         zSnAx29U8WuLTI9ExqxwFzPZmo0mHUqAjMn2RgZOIpvSFf2FTljKhjOmlz/PX2bEMaRC
         lFE+Jq8IidL4IM+nVDmMMflaOTHFIJmzC3aOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQJ8f3sbtpxQFwytiN3eHpksnWvvNOcO2e4/JMupkqc=;
        b=KJFsRNc0+qTJSOVOHiho85os549D01f+M8sieD1m0lhWSinstKXj70yKYYASXIR0A9
         FNLQhkvi5L4GjDKZ5xN5jUkeIb/eww0700vTui2xwvsxmroIzB63nrSPlt4qHxDNL1Ep
         DP2D9pAhOGBH6jFLPVvPsw2n5QwHF3sOP+hOMYZzalyIs5MonwiEtoY9eUyaocKcUO1F
         icuS2G2Ovb6sHftzm0pqFVmA/Le+MrIJyPBYDGZxC7ZzFw13NBuySNVa/zdR9ctU2DQo
         eDv7YKDraZJoW9JjteTYrjT+mrL8ChxAdBfCZrH8GAvV3Y3zK8eF/YqYas3b9RMm8QZf
         cqpg==
X-Gm-Message-State: APjAAAWU9gZhpuesVHJu70glH3alQOqTRnSrYdO84PG9j/vVTa+AfwDx
        k6VwPd+eNYSO+7A0tqXrvdmmkw==
X-Google-Smtp-Source: APXvYqycwCSZRxiQZg5b6w8u5vo5c0fzV5zhn+ILS/tJqsI66etCit/pYaYlIq/y8q2Rld0VAf6CWw==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr11549407pfa.76.1565213468077;
        Wed, 07 Aug 2019 14:31:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a6sm92456750pfa.162.2019.08.07.14.31.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 14:31:07 -0700 (PDT)
Date:   Wed, 7 Aug 2019 17:31:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-ID: <20190807213105.GA14622@google.com>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807130402.49c9ea8bf144d2f83bfeb353@linux-foundation.org>
 <20190807204530.GB90900@google.com>
 <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:58:40PM -0700, Andrew Morton wrote:
> On Wed, 7 Aug 2019 16:45:30 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Wed, Aug 07, 2019 at 01:04:02PM -0700, Andrew Morton wrote:
> > > On Wed,  7 Aug 2019 13:15:54 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > > 
> > > > In Android, we are using this for the heap profiler (heapprofd) which
> > > > profiles and pin points code paths which allocates and leaves memory
> > > > idle for long periods of time. This method solves the security issue
> > > > with userspace learning the PFN, and while at it is also shown to yield
> > > > better results than the pagemap lookup, the theory being that the window
> > > > where the address space can change is reduced by eliminating the
> > > > intermediate pagemap look up stage. In virtual address indexing, the
> > > > process's mmap_sem is held for the duration of the access.
> > > 
> > > So is heapprofd a developer-only thing?  Is heapprofd included in
> > > end-user android loads?  If not then, again, wouldn't it be better to
> > > make the feature Kconfigurable so that Android developers can enable it
> > > during development then disable it for production kernels?
> > 
> > Almost all of this code is already configurable with
> > CONFIG_IDLE_PAGE_TRACKING. If you disable it, then all of this code gets
> > disabled.
> > 
> > Or are you referring to something else that needs to be made configurable?
> 
> Yes - the 300+ lines of code which this patchset adds!
> 
> The impacted people will be those who use the existing
> idle-page-tracking feature but who will not use the new feature.  I
> guess we can assume this set is small...

Yes, I think this set should be small. The code size increase of page_idle.o
is from ~1KB to ~2KB. Most of the extra space is consumed by
page_idle_proc_generic() function which this patch adds. I don't think adding
another CONFIG option to disable this while keeping existing
CONFIG_IDLE_PAGE_TRACKING enabled, is worthwhile but I am open to the
addition of such an option if anyone feels strongly about it. I believe that
once this patch is merged, most like this new interface being added is what
will be used more than the old interface (for some of the usecases) so it
makes sense to keep it alive with CONFIG_IDLE_PAGE_TRACKING.

thanks,

 - Joel

