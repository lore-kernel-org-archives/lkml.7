Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F67D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Askw2Dy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbfETQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:50:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37153 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbfETQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:50:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so6985391pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2nbzJiUbqitAe/vmw6KZ2Et+OZPFA/JK7MysTmH6vQ=;
        b=Askw2Dy/VRvGu3WZOwFDDolHJLJQt0vmzbsQp+Cjadu48CZiIfEEWpPzeAsy+nTPKB
         dxNDUb0wvk/qMauQPlQYiE42IIUFK/X03vC1FsrQq+WsvryUhA6Ck09WMQ4YcNObgZLa
         AboM37uBqIjpZkwpxIiSLmjQvtILHebnGIiVjR/T4vvoLW/fpf+DMRHo3PyAls280rCk
         diEfGB4rl1Wux2CUZgkLXXhjDcTUA77lH2bA7yJWzP/gcd5z1uBjzRvqxd1E6oNgkDQJ
         V6ZZfwHikUzlUzCd7k8rNRRas8HAsxHgcf30hCZn3tuGUTWvKoIYNfP3MJ9NtSHZ7cx+
         QnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2nbzJiUbqitAe/vmw6KZ2Et+OZPFA/JK7MysTmH6vQ=;
        b=fiwbPqy5SgzrFTO4lP9YZ0kEZlMCR2FcZczJOS5j2AWAynCZ6wUTsHRCLt2GrEArx9
         7TJIHWjn5uW8Mgy4weHbBDGL482efCqmYu/0IOsr2yB9oXs2dacXGMdQazTQZQ2ZcDg1
         fwPrhrzVD8b/r2HHfdb57HV1jw75CYtKxF2CiOePKcPcaiEQiZeLQjwAnI+tRpmlljgv
         jyswhljJ5UisFjdfoftC16JguI8/ivyLVjSFT5y2/QdovhJLE1POx/h6d4Bzlb028dSq
         TJfXYZNzInrlI17Kj0oW9e0yAecW3SlzpXzPZcxWI+O7fQAmHmb8Zkm7yTrlhLox+Kj1
         kOVw==
X-Gm-Message-State: APjAAAXr2L5WF9zKlKwlJVDL3GTDDd/zsDU0mk6ma3MhDexL2NJofe+c
        bydOruVFJzs9/qSk0T/Dh/4qjQ==
X-Google-Smtp-Source: APXvYqyAP5erzaLtIGoxn8EHRf6PIwFDu2SBNbb4v+K+AAUyEPJ5bcPtDafLb6k1FMVQiJbhcbpi6A==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr63146469pls.52.1558371016198;
        Mon, 20 May 2019 09:50:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:df5f])
        by smtp.gmail.com with ESMTPSA id 19sm21507630pfz.84.2019.05.20.09.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 09:50:15 -0700 (PDT)
Date:   Mon, 20 May 2019 12:50:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 2/7] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Message-ID: <20190520165013.GB11665@cmpxchg.org>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-3-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-3-minchan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:52:49PM +0900, Minchan Kim wrote:
> The local variable references in shrink_page_list is PAGEREF_RECLAIM_CLEAN
> as default. It is for preventing to reclaim dirty pages when CMA try to
> migrate pages. Strictly speaking, we don't need it because CMA didn't allow
> to write out by .may_writepage = 0 in reclaim_clean_pages_from_list.
>
> Moreover, it has a problem to prevent anonymous pages's swap out even
> though force_reclaim = true in shrink_page_list on upcoming patch.
> So this patch makes references's default value to PAGEREF_RECLAIM and
> rename force_reclaim with skip_reference_check to make it more clear.
> 
> This is a preparatory work for next patch.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Looks good to me, just one nit below.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  mm/vmscan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d9c3e873eca6..a28e5d17b495 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1102,7 +1102,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  				      struct scan_control *sc,
>  				      enum ttu_flags ttu_flags,
>  				      struct reclaim_stat *stat,
> -				      bool force_reclaim)
> +				      bool skip_reference_check)

"ignore_references" would be better IMO
