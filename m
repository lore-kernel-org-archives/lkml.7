Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF90C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AACF2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d3LDgVcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfDHSJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:09:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37505 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDHSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:09:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so7762993pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ut52tSopTGbIMzSwLGcLJn20UHypI1Xs+LCYLMFEEOA=;
        b=d3LDgVcmJDDU8U1vlNv2RKrkTMUyiHHNQz1AtPzI0JpSXS3Y5rRQr2S7ohNB1HhAY/
         fi2WDMbVJnfpTmKWMGneixGZkSfjdDYfHw0aCfHBt7MsZMGrtrjQDRheqOMM3DjPCaxH
         Pbq0YQq1c7pur+NytOt1oWPu/1KA9PO+SfDPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ut52tSopTGbIMzSwLGcLJn20UHypI1Xs+LCYLMFEEOA=;
        b=n/lI4ffry4EoFDR/4lNsAn5OaR/cFU7J6I7XLcNcCyRnwK4O65of3JQWCmGHAauU+X
         ahLYN16EkyrIPMZ5Hc28gTNFrXN9g8eJ60BAqNk6qxg0/J5xBMifh+FBfSWOThQGXzkj
         ja7AalTefJ+ncjYGP3F4ZQm6F6tRCdFltmcf+JoTzA91Zfdqqrg6beGux0RLw9SI35ma
         WDueCMQgs0jXUtEF0RTXYG0ekA1Y0rCEXKVDnGlMb0BeaX9ba4lb5RlBx8mF9p+PKcYt
         rsW4OaQo8SxYCUoOZcL7f6mJqFPWwkM7rvC7MApHpEhTX04qJ978EZOADX9NLRlxJVO/
         Ig0w==
X-Gm-Message-State: APjAAAWRYrWlhRN9XBu+SOw7m4gtVanN2LPKMeDzX2YtTxlXfEmY40Ax
        jQj6qNwmlutsuo+UOIZwVnAI9g==
X-Google-Smtp-Source: APXvYqwugNB2cz04Srr1qkZMi+IWhXzRheu/3O3w4f4wxfSoNpwOyiWjNqe8uzo4HXO7J+nVhq/2ng==
X-Received: by 2002:a63:744b:: with SMTP id e11mr29535494pgn.327.1554746940943;
        Mon, 08 Apr 2019 11:09:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x66sm18170366pfb.78.2019.04.08.11.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 11:09:00 -0700 (PDT)
Date:   Mon, 8 Apr 2019 14:08:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com, jannh@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] doc/rcuref: Document real world examples in kernel
Message-ID: <20190408180859.GA133872@google.com>
References: <20190329140555.118463-1-joel@joelfernandes.org>
 <20190404201039.GL14111@linux.ibm.com>
 <20190406021705.GA6615@localhost>
 <20190408175213.GT14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408175213.GT14111@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:52:13AM -0700, Paul E. McKenney wrote:
> On Sat, Apr 06, 2019 at 02:17:05AM +0000, Joel Fernandes wrote:
> > On Thu, Apr 04, 2019 at 01:10:39PM -0700, Paul E. McKenney wrote:
> > > On Fri, Mar 29, 2019 at 10:05:55AM -0400, Joel Fernandes (Google) wrote:
> > > > Document similar real world examples in the kernel corresponding to the
> > > > second and third code snippets. Also correct an issue in
> > > > release_referenced() in the code snippet example.
> > > > 
> > > > Cc: oleg@redhat.com
> > > > Cc: jannh@google.com
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Good catch, thank you!
> > > 
> > > As usual, I could not resist doing a bit of wordsmithing.  Please let me
> > > know if I messed anything up in the version shown below.
> > > 
> > > 								Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit adcd92c0ab303b57b28a3cd097bd9ece824c14f6
> > > Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Date:   Fri Mar 29 10:05:55 2019 -0400
> > > 
> > >     doc/rcuref: Document real world examples in kernel
> > >     
> > >     Document similar real world examples in the kernel corresponding to the
> > >     second and third code snippets. Also correct an issue in
> > >     release_referenced() in the code snippet example.
> > >     
> > >     Cc: oleg@redhat.com
> > >     Cc: jannh@google.com
> > >     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >     [ paulmck: Do a bit of wordsmithing. ]
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > 
> > > diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
> > > index 613033ff2b9b..c0bab7fb57e7 100644
> > > --- a/Documentation/RCU/rcuref.txt
> > > +++ b/Documentation/RCU/rcuref.txt
> > > @@ -12,6 +12,7 @@ please read on.
> > >  Reference counting on elements of lists which are protected by traditional
> > >  reader/writer spinlocks or semaphores are straightforward:
> > >  
> > > +CODE LISTING A:
> > >  1.				2.
> > >  add()				search_and_reference()
> > >  {				{
> > > @@ -28,7 +29,8 @@ add()				search_and_reference()
> > >  release_referenced()			delete()
> > >  {					{
> > >      ...					    write_lock(&list_lock);
> > > -    atomic_dec(&el->rc, relfunc)	    ...
> > > +    if(atomic_dec_and_test(&el->rc))	    ...
> > > +	kfree(el);
> > >      ...					    remove_element
> > >  }					    write_unlock(&list_lock);
> > >   					    ...
> > > @@ -44,6 +46,7 @@ search_and_reference() could potentially hold reference to an element which
> > >  has already been deleted from the list/array.  Use atomic_inc_not_zero()
> > >  in this scenario as follows:
> > >  
> > > +CODE LISTING B:
> > >  1.					2.
> > >  add()					search_and_reference()
> > >  {					{
> > > @@ -79,6 +82,7 @@ search_and_reference() code path.  In such cases, the
> > >  atomic_dec_and_test() may be moved from delete() to el_free()
> > >  as follows:
> > >  
> > > +CODE LISTING C:
> > >  1.					2.
> > >  add()					search_and_reference()
> > >  {					{
> > > @@ -114,6 +118,16 @@ element can therefore safely be freed.  This in turn guarantees that if
> > >  any reader finds the element, that reader may safely acquire a reference
> > >  without checking the value of the reference counter.
> > >  
> > > +A clear advantage of the RCU-based pattern in listing C over the one
> > > +in listing B is that any call to search_and_reference() that locates
> > > +a given object will succeed in obtaining a reference to that object,
> > > +even given a concurrent invocation of delete() for that same object.
> > 
> > This part sounds good to me.
> > 
> > > +Similarly, a call to delete() is not delayed even if there are an
> > > +arbitrarily large number of calls to search_and_reference() searching
> > > +for the same object that delete() was invoked on.  Instead, all that is
> > > +delayed is the eventual invocation of kfree(), which is usually not a
> > > +problem on modern computer systems, even the small ones.
> > > +
> > 
> > small nit:
> > This part is common to both listing B and C right? The delete() is never
> > delayed due to the search_and_reference in either case, and the kfree is what
> > is delayed.  My patch was highlighting the difference between the 2
> > listings, but this text says what is common between both listings.
> > 
> > As such I am Ok with the changes you made, and thanks for this document in
> > the first place.
> 
> Good point!  How about the following patch to be merged into the current
> patch?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
> index c0bab7fb57e7..5e6429d66c24 100644
> --- a/Documentation/RCU/rcuref.txt
> +++ b/Documentation/RCU/rcuref.txt
> @@ -122,11 +122,12 @@ A clear advantage of the RCU-based pattern in listing C over the one
>  in listing B is that any call to search_and_reference() that locates
>  a given object will succeed in obtaining a reference to that object,
>  even given a concurrent invocation of delete() for that same object.
> -Similarly, a call to delete() is not delayed even if there are an
> -arbitrarily large number of calls to search_and_reference() searching
> -for the same object that delete() was invoked on.  Instead, all that is
> -delayed is the eventual invocation of kfree(), which is usually not a
> -problem on modern computer systems, even the small ones.
> +Similarly, a clear advantage of both listings B and C over listing A is
> +that a call to delete() is not delayed even if there are an arbitrarily
> +large number of calls to search_and_reference() searching for the same
> +object that delete() was invoked on.  Instead, all that is delayed is
> +the eventual invocation of kfree(), which is usually not a problem on
> +modern computer systems, even the small ones.
>  
>  In cases where delete() can sleep, synchronize_rcu() can be called from
>  delete(), so that el_free() can be subsumed into delete as follows:
> 

This one looks better to me, thanks a lot!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel

