Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0958C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B555620869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="H3Ys3Y9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfKGSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:07:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39185 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfKGSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:07:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so2035292plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOLEs/Ylzowrvsp32OIANhzhopJpqXzqpob5e3gHNYE=;
        b=H3Ys3Y9iSkfRE4KsxqlDsTsW3qNKk0mS3MI3wfGz6aXqLvHeUsP3V+2MyZPPJnhqYY
         x5r39yYrIrLDhMygYIe+zjcDQpNQfKxonbdBQ2vYPGTwQXLh0SHQx86n5ZuVyxjx0B6e
         EQZUi+Dra8zss3AFzJYiPWDxR1wCG4vsDwNm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOLEs/Ylzowrvsp32OIANhzhopJpqXzqpob5e3gHNYE=;
        b=AbmI8jsR7kArTdIWl4iGJW7XSyzDs0SZXEKG0yF/wXoAyqs7f5X5DmsG72dz7sbQVh
         xWsefB0GMEIA0StL9yFtqNmBIpMSrrf49QInOj2uWAhSaq00AMo5zDXah1ZhCaDVLe3l
         ZtVT3Xx5Rvh2DlUKBIhgIwx0NJpvKWHRETLyrSB0l1mgu1lpISYG35PWPepjUT6N1aHc
         OG6YJwB/O+bfZy34OC7EKhU3tmMBO8f+feHk0K+7/aqlW61uQRYR8b0LzspIf2Ndwr97
         HYczKyLWPfJkpMXol4OUr5NqT+ALvePRGfWCi4qB2nd+RND/+ybI1msGeYtHuIk93doo
         nB2A==
X-Gm-Message-State: APjAAAWM2Qd9OG68J35lz5XiYI4AqP7JzEC0hkx61vgLr830Ep2bzWgE
        19q7/RNg9qtu6j/I6YnXB75icA==
X-Google-Smtp-Source: APXvYqwl5+VGy63KgJVXB72ntOstsTKhQwWdAblR1MU+HZBKAOz0xs7UVTy3IO4zfFPaOVDD44GKtA==
X-Received: by 2002:a17:90a:80cc:: with SMTP id k12mr7125259pjw.58.1573150073574;
        Thu, 07 Nov 2019 10:07:53 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f24sm2777882pjp.12.2019.11.07.10.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:07:52 -0800 (PST)
Date:   Thu, 7 Nov 2019 13:07:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Ioannis Ilkos <ilkos@google.com>,
        minchan@google.com, primiano@google.com, fmayer@google.com,
        hjd@google.com, joaodias@google.com, lalitm@google.com,
        rslawik@google.com, sspatil@google.com, timmurray@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rss_stat: Add support to detect RSS updates of external
 mm
Message-ID: <20191107180751.GA3846@google.com>
References: <20191106024452.81923-1-joel@joelfernandes.org>
 <20191106085959.ae2dgvmny3njnk7n@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106085959.ae2dgvmny3njnk7n@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 09:59:59AM +0100, Petr Mladek wrote:
> On Tue 2019-11-05 21:44:51, Joel Fernandes (Google) wrote:
> > Also vsprintf.c is refactored a bit to allow reuse of hashing code.
> 
> I agree with Sergey that it would make sense to move this outside
> vsprintf.c.

I am of the opinion that its Ok to have it this way and I am not sure if
another translation unit is worth it just for this. If we have more users,
then yes we can consider splitting into its own translation unit at that
time.

If Andrew Morton objects, then I'll do it since the intention was for this
patch to go through his tree and I believe he is Ok with it this way.

> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index dee8fc467fcf..401baaac1813 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -761,11 +761,34 @@ static int __init initialize_ptr_random(void)
> >  early_initcall(initialize_ptr_random);
> >  
> >  /* Maps a pointer to a 32 bit unique identifier. */
> > +int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
> > +{
> > +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> 
> str is unused.

I believe Andrew has already fixed this in his tree.

linux-next has local variable removed now:
7422993b4f8e ("rss_stat-add-support-to-detect-rss-updates-of-external-mm-fix")

> > +	unsigned long hashval;
> 
> IMHO, this local variable unnecessarily complicates the code.
> I would use the pointer directly and let compiler to optimize.

Agreed.

thanks,

 - Joel


> > +	if (static_branch_unlikely(&not_filled_random_ptr_key))
> > +		return -EAGAIN;
> > +
> > +#ifdef CONFIG_64BIT
> > +	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> > +	/*
> > +	 * Mask off the first 32 bits, this makes explicit that we have
> > +	 * modified the address (and 32 bits is plenty for a unique ID).
> > +	 */
> > +	hashval = hashval & 0xffffffff;
> > +#else
> > +	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
> > +#endif
> > +	*hashval_out = hashval;
> > +	return 0;
> > +}
> 
> Best Regards,
> Petr
