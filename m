Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E988C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81F620872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JalEDdTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbfIJAdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 20:33:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33145 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfIJAdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 20:33:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id t11so7577302plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 17:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LdMkj9ydUpeGQz38kxhXmRjgb45ZaaFVzNT7mjTRqas=;
        b=JalEDdTDZRzhywQC2f0WOr6aN0yHO+NIVCzPWd16sAX9Xx3743FU/DqlqeKPO9oUQn
         LhQI+rSmR8nNHmr5Pcp1sjdPOdxOvGS8gejJJpcQnW7t2WPwhTvYzlgQ8h/wzX77pq/p
         A3Val6pjIKL5+cCKFWKWaKZgaw0w0kc7IIphk2/oQk2EwJTZx95hS4eOc3dAKY4QjXiK
         3tbt+oxYVCq1jFI5+juIJ5NuBIbhm4W8EswtebjLBCnbDYXKTWX4Q6XhzAfL3Egbx+VV
         99XpHqUz2Lg7xcM2xozNeHbXUFLAJ1GLUMqYvOQetxMGngcHcj92EmtBN7LMH4/WrRTk
         g5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdMkj9ydUpeGQz38kxhXmRjgb45ZaaFVzNT7mjTRqas=;
        b=PEJcyfyBuhsFO3UyBaSGBaXlzbyLT1C6x/M6USS/IdoGz7UJ7+eF1iUsW3nON5HPJB
         beG3OsFK7elj1WKpqtPhclmRNXjKiNBHyS0GEyVYRnOQcotstmJkHh+2jHOVrsrXqsxO
         kquQwPTqICi0l8NQ6gOwlR1WqASXLzdYzUYHgEv+bZcii+9qVbrRRuMBQze1zDeCzaL9
         GLRBmMYq+ywYqtoqKjmiFunQPOptNW+mrz/eCmzTKH1umdqTsR0xTpsFSnGMWQaS6mC/
         mm3eXsRmn7p2TiSYPZ8rrVkkL+4DjhKmDvUOR+blDoOfu6Kqxx6QUiam2HgowetE9Cn8
         LvFQ==
X-Gm-Message-State: APjAAAX8F7urOSEdeN4CYLbOlyC7kItOPP1nmvBEw9yNpHegl4Vx8ZEh
        URGmFNL/K//TWYPh4ifk8N0=
X-Google-Smtp-Source: APXvYqxoz8p0CnnYz2lpULO/pJTvkWfE44ItpK9zgm5aMH1SkPlm6sGG3GHzCb/wBoeqpUBjRgxvyQ==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr26545337plr.50.1568075611247;
        Mon, 09 Sep 2019 17:33:31 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id b19sm16515847pgs.10.2019.09.09.17.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 17:33:30 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:33:23 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: simplify ftrace hash lookup code
Message-ID: <20190910003321.d3q65j756z3vzhiw@mail.google.com>
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
We must add another similar function since ftrace_lookup_ip() returns a pointer.

bool ftrace_contains_ip(struct ftrace_hash *hash, unsigned long ip,
			bool empty_result)
{
	if (ftrace_hash_empty(hash))
		return empty_result;

	return !!__ftrace_lookup_ip(hash, ip);
}

But after this, it's a little overkill I think. It is not much simpler than before.
Do you still want this then?

> Then we can change the above to:
> 
> 	return ftrace_lookup_ip(hash->filter_hash, ip, true) &&
> 	       !ftrace_lookup_ip(hash->notrace_hash, ip, false);
> 
> That would probably work better.
> 
> Want to send that update?
> 
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
