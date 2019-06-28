Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15537C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F70205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="aOPp1i7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF1OW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:22:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41862 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:22:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so6439675qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVmn8V88QNGADn+4BzJOKwnY0rFHsOXAlq7BOgZNCGc=;
        b=aOPp1i7+egoyuX5dPs0fEwpuD7ncaPsKMaTb1fJp8cn029yB84Cj38CXVf1K4HPO4m
         krk0DXWdBm48vEnib3lJ9PqOpql7Ei1s0A/1v8zu9VR0yqF2cFObMA+mxywr/6B3Rm2O
         tdSuJRsaGxJqDExu234qVW3Y/4KtiQ7+a+wY3I2ERadQD79lz8xKYQhi6xQ2Qsi5rNOJ
         qSQT3jk9apBhR+XgkF94YcowU2zU1m4lrnwKy4HXqzHIyEQo69uoV6QhrWXESQhqlaqZ
         EQlOfVcrLWqq5Q83LbfyVq7+xFnyE8uJBirXQHeY7ZfeByGsXRD9k0uf4i1lhCmNojoZ
         XkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVmn8V88QNGADn+4BzJOKwnY0rFHsOXAlq7BOgZNCGc=;
        b=X3r9bwXromYHvZKndY3qL0ALpDnyJOkJeYDog2OdDD8Gtrj+QW5/DkpSLGmi2c3/pm
         i+CeQefRCyLio2XD7pzX5FKEzbLuZqf+VbQnzsuBOhBmsHhzLX01S79R+j6l2tIoB0tk
         2dBOR/Gc8EFYgVQDNAnAlsrdpPqRGuQ0ewne9gXtQ8h/G/tcio+Ha/HdOgtS9Zhou7J9
         GZ7tZH+H/Zyl1O0jYLMB0uUoyaGoQS2qpQk5YKTfZqYZbERUd3S4HM7H5vu8WBkK4hlQ
         p54daJFT4ICwyME403WQm2gM61UDjJo9XwTOrT48w85hV7wpe/JYHDn66urkD2AaYG8z
         WXTA==
X-Gm-Message-State: APjAAAU2mLz6U/uSBTQgq62Y/vAUQoujv9cz5tYRFkdd0f2wKY6cOCDJ
        DhL8DBHI/YnUAB7YdS92BioUYw==
X-Google-Smtp-Source: APXvYqwlKuuePWTEY5Qzqm6s281P+8lxu1QGtHORWcJsC2Yq1uv3z28Uf6CKqeoG1nDZmsyvrE+hiA==
X-Received: by 2002:ac8:2ae8:: with SMTP id c37mr8359022qta.267.1561731774569;
        Fri, 28 Jun 2019 07:22:54 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id x205sm1049020qka.56.2019.06.28.07.22.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 07:22:53 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:22:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190628142252.GA17212@cmpxchg.org>
References: <20190619080835.GA68312@google.com>
 <20190627184123.GA11181@cmpxchg.org>
 <20190628065138.GA251482@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628065138.GA251482@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On Fri, Jun 28, 2019 at 03:51:38PM +0900, Minchan Kim wrote:
> On Thu, Jun 27, 2019 at 02:41:23PM -0400, Johannes Weiner wrote:
> > On Wed, Jun 19, 2019 at 04:08:35PM +0800, Kuo-Hsin Yang wrote:
> > > Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> > > Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> > 
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Your change makes sense - we should indeed not force cache trimming
> > only while the page cache is experiencing refaults.
> > 
> > I can't say I fully understand the changelog, though. The problem of
> 
> I guess the point of the patch is "actual_reclaim" paramter made divergency
> to balance file vs. anon LRU in get_scan_count. Thus, it ends up scanning
> file LRU active/inactive list at file thrashing state.

Look at the patch again. The parameter was only added to retain
existing behavior. We *always* did file-only reclaim while thrashing -
all the way back to the two commits I mentioned below.

> So, Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> would make sense to me since it introduces the parameter.

What is the observable behavior problem that this patch introduced?

> > forcing cache trimming while there is enough page cache is older than
> > the commit you refer to. It could be argued that this commit is
> > incomplete - it could have added refault detection not just to
> > inactive:active file balancing, but also the file:anon balancing; but
> > it didn't *cause* this problem.
> > 
> > Shouldn't this be
> > 
> > Fixes: e9868505987a ("mm,vmscan: only evict file pages when we have plenty")
> > Fixes: 7c5bd705d8f9 ("mm: memcg: only evict file pages when we have plenty")
> 
> That would affect, too but it would be trouble to have stable backport
> since we don't have refault machinery in there.

Hm? The problematic behavior is that we force-scan file while file is
thrashing. We can obviously only solve this in kernels that can
actually detect thrashing.
