Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63087C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 23:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DD921670
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 23:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4MyA1FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390141AbfIIXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 19:40:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36978 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfIIXkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 19:40:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so7594385pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lsAY+sKesJo6X+9Y7r1jhC7N0L/3nQaG5JDxGGcqtrE=;
        b=o4MyA1FNVxeZf4lS2Hniu9EDwKX+uCC8ifCiyfx5wqdGJiCl0z8rgNIqocSF9bVmtW
         se4ZzusnW7O7nxlAvL0p2RhCsqeyOBhWbebOJrVd5hAwaSn6NnwvgCq6hqWOUjTPh9Fx
         GWn375ILoQ4dOAxWt789cKH7IdybL3P2KjMraseXaFXUYq3h+po/+dijUxOhG1aGB9Bt
         kxXcoc16rQwiRs1bptNz58aA487q6Lv7cm4GjthOI+ylBFQYRIipVXoUvxPeoaTetjgo
         MVH9PiVJZe4V3wcZUhXqp5nuYBNjsC1muQBI2fooLDpxbnreYHS9mWE2XGzRYePRn6Oy
         BFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsAY+sKesJo6X+9Y7r1jhC7N0L/3nQaG5JDxGGcqtrE=;
        b=Ymr71AhmlPtLbb9eF50xowuh/WnDMYMbmD54cMLxzECuO3vtNw0RONnd36VUrehlsP
         T8ByczLLsidRIKMGQWznpec52WbmfXl59eyE2XEfmUJNxoAtdSJSydpS5Vk0bzncgsff
         R91Gb5kPBjv27AuAxB2sWNpLZgE9rVaJVOq2KQqpsnau8B8pW4KadKwOYrXbY0Sy+5B7
         1JW23626FiyXXnjKwz8gCbLmOb4AOKBpMg20e8VIk73g43yMI+YtwwcQIOuNb4qpgdIQ
         9yCC2ZU3UC5jNPDdQ5e6mYNe9+VOE+8Ce7dAchHW/fh2+dDmynDdveVtvQdEQgxjpqoZ
         8GeQ==
X-Gm-Message-State: APjAAAVz0nu9mSUvhOBNlccU6a4VM7kQ+tgKDOaVH+202Va1ev2IAh5k
        SalFrLvNpJvJ+nm4zSonwQ1bAhePjmLhuA==
X-Google-Smtp-Source: APXvYqxdL3R2Olk6Zx4BmjokrnBXacU2oQU1j/LyH1UrjfeCisIVwW+i/aQeZ3G8PBHKmSCS6GFtsw==
X-Received: by 2002:a63:4c46:: with SMTP id m6mr25353248pgl.59.1568072405177;
        Mon, 09 Sep 2019 16:40:05 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id r28sm30906266pfg.62.2019.09.09.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 16:40:04 -0700 (PDT)
Date:   Tue, 10 Sep 2019 07:39:58 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: simplify ftrace hash lookup code
Message-ID: <20190909233956.4gqs6u4i4siaf6mf@mail.google.com>
References: <20190909003159.10574-1-changbin.du@gmail.com>
 <20190909105424.6769b552@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909105424.6769b552@oasis.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:54:24AM -0400, Steven Rostedt wrote:
> On Mon,  9 Sep 2019 08:31:59 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Function ftrace_lookup_ip() will check empty hash table. So we don't
> > need extra check outside.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > 
> > ---
> > v2: fix incorrect code remove.
> > ---
> >  kernel/trace/ftrace.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f9821a3374e9..92aab854d3b1 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1463,8 +1463,7 @@ static bool hash_contains_ip(unsigned long ip,
> >  	 */
> >  	return (ftrace_hash_empty(hash->filter_hash) ||
> >  		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
> > -		(ftrace_hash_empty(hash->notrace_hash) ||
> > -		 !__ftrace_lookup_ip(hash->notrace_hash, ip));
> > +	       !ftrace_lookup_ip(hash->notrace_hash, ip);
> 
> I don't care for this part. I've nacked this change in the past. Why?
> let's compare the changes:
> 
> 	return (ftrace_hash_empty(hash->filter_hash) ||
> 		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
> 		(ftrace_hash_empty(hash->notrace_hash) ||
> 		 !__ftrace_lookup_ip(hash->notrace_hash, ip));
> 
>  vs:
> 
> 	return (ftrace_hash_empty(hash->filter_hash) ||
> 		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
> 		!ftrace_lookup_ip(hash->notrace_hash, ip);
> 
> The issue I have with this is that it abstracts out the difference
> between the filter_hash and the notrace_hash. Sometimes open coded
> works better if it is compared to something that is similar.
> 
> The current code I see:
> 
> 	Return true if (filter_hash is empty or ip exists in filter_hash
> 		 and notrace_hash is empty or it does not exist in notrace_hash
> 
> With your update I see:
> 
> 	Return true if filter_hash is empty or ip exists in filter_hash
>                 and ip does not exist in notrace_hash
> 
> It makes it not easy to see if what happens if notrace_hash is empty
>
Yes, I agree with you entirly.

> Hmm, come to think of it, perhaps we should change ftrace_lookup_ip()
> to include what to do on empty.
> 
> Maybe:
> 
> bool ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip, bool empty_result)
> {
> 	if (ftrace_hash_empty(hash))
> 		return empty_result;
> 
> 	return __ftrace_lookup_ip(hash, ip);
> }
> 
> Then we can change the above to:
> 
> 	return ftrace_lookup_ip(hash->filter_hash, ip, true) &&
> 	       !ftrace_lookup_ip(hash->notrace_hash, ip, false);
> 
> That would probably work better.
> 
> Want to send that update?
> 
Yes, let me update it with your idea. Thanks!

> -- Steve
> 
> 
> >  }
> >  
> >  /*
> > @@ -6036,11 +6035,7 @@ clear_func_from_hash(struct ftrace_init_func
> > *func, struct ftrace_hash *hash) {
> >  	struct ftrace_func_entry *entry;
> >  
> > -	if (ftrace_hash_empty(hash))
> > -		return;
> > -
> > -	entry = __ftrace_lookup_ip(hash, func->ip);
> > -
> > +	entry = ftrace_lookup_ip(hash, func->ip);
> >  	/*
> >  	 * Do not allow this rec to match again.
> >  	 * Yeah, it may waste some memory, but will be removed
> 

-- 
Cheers,
Changbin Du
