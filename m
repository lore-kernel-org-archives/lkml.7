Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1AC606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770022166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562651997;
	bh=8H9DxfUP055AjEkmlAvjXMvI3VeCVnuumQ1UZuDs62Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KyGWxO4KHVXYcJd/B7SWUoeJ8+5rDtUOEtfw688glOQLzbvmrbtuBASABbRCh3iNc
	 jf8vVDwKZLOfFhqktVpP1Ta2PIm6OwN+JlXEmdOBkXf580LfKbCfIPLeboz38bO9yM
	 CJt1+Bji+yHF6oZ9m8GSOkxjR4Z1W8rNlfmbtxpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGIF74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:59:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40272 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIF74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:59:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so8812000lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 22:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8H9DxfUP055AjEkmlAvjXMvI3VeCVnuumQ1UZuDs62Q=;
        b=d8xjMBKmmDRFn7+ikdO8/b7UmrRpaK/8Jlh9VFTc84aBRQV4besDbiOEsvtfjQAzpN
         vjoV8uySw+83bf64HkQXsbnniLjswVRT0AT6wZ1tOWjC8Mq3OSfaJIV8gHPCO8VRK6AQ
         FFQdGFi39QY07bY5qVQuAQ+sm+rgLmG/LiF8QYD8n8o4ng9aYVE/6zSSOerCpEcNQtiM
         s2OFCsirGiXTQvnLg9pkCaeRI9uUueHeguuz9BdtiFrNls+RHkXz8YxlTG7cnOGEyyyp
         +WAeHZlKSL7+PVn79daEk6dOnTnPv475tsqRt8bfO1QG8UpC2JOulxuMKhcv7pAHz2y5
         bjAg==
X-Gm-Message-State: APjAAAWkwmfFqxLGNAqHTFd1KyHj1ECmHB9SP+PSkdFwCcH3OYvwp9XC
        npd+UkyguqVvbDkhsPt/+r3kd5e/wq4fknFYUD8=
X-Google-Smtp-Source: APXvYqzKL887cT/bh4p0A5cne2WzyPyCoDGHmgwY4o+MX+s9ZkgCmZ3VV5ott+JGpAo4pHvsp3LZuyf6VcE0SI3VnDo=
X-Received: by 2002:a2e:9d18:: with SMTP id t24mr13065996lji.2.1562651993947;
 Mon, 08 Jul 2019 22:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190514235111.2817276-1-guro@fb.com> <20190514235111.2817276-2-guro@fb.com>
In-Reply-To: <20190514235111.2817276-2-guro@fb.com>
From:   Minchan Kim <minchan@kernel.org>
Date:   Tue, 9 Jul 2019 14:59:42 +0900
Message-ID: <CAEwNFnALK=aAnyBypHbvw4khRwbOeMN=5gtgLWY+3F3HEpb2Ng@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm: show number of vmalloc pages in /proc/meminfo
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,


On Wed, May 15, 2019 at 8:51 AM Roman Gushchin <guro@fb.com> wrote:
>
> Vmalloc() is getting more and more used these days (kernel stacks,
> bpf and percpu allocator are new top users), and the total %
> of memory consumed by vmalloc() can be pretty significant
> and changes dynamically.
>
> /proc/meminfo is the best place to display this information:
> its top goal is to show top consumers of the memory.
>
> Since the VmallocUsed field in /proc/meminfo is not in use
> for quite a long time (it has been defined to 0 by the
> commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
> /proc/meminfo")), let's reuse it for showing the actual
> physical memory consumption of vmalloc().
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Minchan Kim <minchan@kernel.org>

How it's going on?
Android needs this patch since it has gathered vmalloc pages from
/proc/vmallocinfo. It's too slow.
