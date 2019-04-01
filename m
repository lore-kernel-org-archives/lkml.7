Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709512146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yYWfiYjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfDASUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:20:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45085 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfDASUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:20:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id b18so3791211yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xawSNcb89Uo6X8oCMqaGeyypJgFbGg80AqgpmSx6PNw=;
        b=yYWfiYjksvzCycCvVISWrOF1si2tzoUTbtYRIO3Q25hQ3L8PVGgWzkv+A3Ik4Y7NNH
         V0oGUi2/jMXGFY7kaU1DmwQxMkpGlw6Dg1lwsBlmL/4u0/6HyOe2S/NddX8hbhEQn8RB
         QYOLiBL2R+6jrYtYEwQLS5JPOa0nq8qW/nrez2scZlWrPP1oQqeEG9db5heWgMskCn1q
         EGrTHOE4zVQgN+HJ3TjT4Q+Rz85tSAXJuWLGteK0d1Iq0HJw1I+c4z3r9cg6u5Lb8pMt
         +Gy1OIxomtJFU0V/FTUvs3StyivwFtk/wBRkg82gxhTwhzwnbYqHH6wzrjRAZ4bXV5tb
         YHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xawSNcb89Uo6X8oCMqaGeyypJgFbGg80AqgpmSx6PNw=;
        b=jcry7DU/urTUQQWlQzdqVnI14Z2beEtOA3Va/efPfPt/+hH9D3CX0JCqHpi1PqbsCG
         Jk3UWjD3AM9uF7wQP+tz/uqynWWN9jMgLh4dPPh9iO0jJdCFKRXEEYROFBoUCcnkUKBp
         hKucrzYO90Ig/eG0vUkJx5EefmjBZQlK+KvT2Tzrks6AB9+1+uBlKHo6J3AogigAhOtz
         z14zKLX4MwJBq55JwHzLwbzjkKDK4A6AJIArITDZ31CoEYPni87gS9VTGOKanaWA3c4u
         8S6SNYfErStX4rxPbMwFaMR5dR5lHoEz+QJ1On81/nG6qxqgHwGYgE2FA4DMhN6gkWB8
         FIuA==
X-Gm-Message-State: APjAAAWI6FnWE9teCtILg+aCIjX+++rpEWr7IQWljNEwYVhaJJmYqc3a
        rQNJ5681M9ACEz6jlx065hBrwg==
X-Google-Smtp-Source: APXvYqxl+K7Jjs97IcKCD8eAX5F/SrbeGuLebrgoG7sE8UJcNFGJoN4oL+ZPoJmgFfzdICWPWphMRw==
X-Received: by 2002:a25:99c3:: with SMTP id q3mr54775170ybo.263.1554142846659;
        Mon, 01 Apr 2019 11:20:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:8ed4])
        by smtp.gmail.com with ESMTPSA id d9sm7226304ywd.23.2019.04.01.11.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 11:20:45 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:20:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] writeback: use exact memcg dirty counts
Message-ID: <20190401182044.GA3694@cmpxchg.org>
References: <20190329174609.164344-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329174609.164344-1-gthelen@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:46:09AM -0700, Greg Thelen wrote:
> @@ -3907,10 +3923,10 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
>  
> -	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
> +	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
>  
>  	/* this should eventually include NR_UNSTABLE_NFS */
> -	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> +	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
>  	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
>  						     (1 << LRU_ACTIVE_FILE));

Andrew,

just a head-up: -mm has that LRU stat cleanup series queued ("mm:
memcontrol: clean up the LRU counts tracking") that changes the
mem_cgroup_nr_lru_pages() call here to two memcg_page_state().

I'm assuming Greg's fix here will get merged before the cleanup. When
it gets picked up, it'll conflict with "mm: memcontrol: push down
mem_cgroup_nr_lru_pages()".

"mm: memcontrol: push down mem_cgroup_nr_lru_pages()" will need to be
changed to use memcg_exact_page_state() calls instead of the plain
memcg_page_state() for *pfilepages.

Thanks
