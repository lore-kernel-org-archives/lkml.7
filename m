Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4806C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB9E217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9vGwET7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfC3MBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:01:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35303 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfC3MBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:01:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so4261021edb.2;
        Sat, 30 Mar 2019 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nP4MXbiHp2m8P5mBk8HuUBMOHGAhobONFf01lBSeFAo=;
        b=L9vGwET764mV0cl2gi9NGrFTVHQRZIQphvfIi7NkURyLcvo2f4FihNU2BaQt8sEeLj
         uhgP8FKbVGeYJc8vYRC1kgCAvNOM/TffWt4NpWoMbdEocCnD0QsMHmT5vQnTO9gnKEsG
         +5JVaMUv4OGBDjsXAZc915Pot4vhF/lVyZULxqC2U4djTJ+fZDLIQCP1aY7LrlnQMoRE
         20A0tl8AHk9+KxQf2UAQn26k5r2Y6/R7P7Sew60z3aJ0lximEE4BjR8Xju5XIBh6XkH4
         w9zRt50iGtPYsc3C3IbQiNYhAk89AtdVTqo+MDlEmrI085D1L4xGmCk9Wj18hiX/0w0o
         Ds1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nP4MXbiHp2m8P5mBk8HuUBMOHGAhobONFf01lBSeFAo=;
        b=P5NF6CwILhNMZ8piqzuGE5LnyJSiAM8Ll6a2Qs1lH1lXyuj5O8dfBz3iSROMMLf7eO
         i718wXOuNK3LjcQlSHL5z2JKk4uVNeKLzatgLWNlIzxLcu1cVDMcYGVDRdjEKQ3uAzYq
         ORaJno68/DUlszR3m5F7FaWWH4Nt6YYFshxTlQmpo6at2vMgVfQRS4wCOK0iyYach9u7
         qaCqi49wHmxWAmGXlMqdug8gBdHBHuudhMA5FVPochkAz/VzBelwRuWjaiIwRLLkdn+o
         6zPi49ZOkzjmg8Xk2eAkfKgRxPjMQ5fn8TA+CiRzXqbTOYE1wsPNHdSrQWfR3vvCT4V6
         ZKqQ==
X-Gm-Message-State: APjAAAU8e8KRtbVDYRcoWzlZDweH/yvJcAm9/K2tDMgiyC0Xtynuv7rP
        f9bK0kYu2WRnom+axINa4dg=
X-Google-Smtp-Source: APXvYqyEDTgMBor9CvvuNZfod51SbK7jVWWtly1xRfRsxcoKlm7lxNqs+yf6oGfMlVXgrszINcplCg==
X-Received: by 2002:a50:ca0d:: with SMTP id d13mr15121011edi.72.1553947302779;
        Sat, 30 Mar 2019 05:01:42 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4079:2f00:3464:9f03:ecff:1b10])
        by smtp.gmail.com with ESMTPSA id v5sm1418105edr.2.2019.03.30.05.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 05:01:42 -0700 (PDT)
Date:   Sat, 30 Mar 2019 13:01:41 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
References: <20190325195303.GA20629@hari-Inspiron-1545>
 <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
 <20190330110747.GA3461@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330110747.GA3461@hari-Inspiron-1545>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 04:37:48PM +0530, Hariprasad Kelam wrote:
> On Sat, Mar 30, 2019 at 12:22:17AM +0100, Luc Van Oostenryck wrote:
> > On Tue, Mar 26, 2019 at 01:23:03AM +0530, Hariprasad Kelam wrote:
> > > This patch fixes below spare errors.
> > > 
> > > Sparse error:
> > > make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> > > ./include/trace/events/neigh.h:73:1: error: directive in argument list
> > > ./include/trace/events/neigh.h:78:1: error: directive in argument list
> > > ./include/trace/events/neigh.h:150:1: error: directive in argument list
> > > ./include/trace/events/neigh.h:155:1: error: directive in argument list
> > > 
> > > Changes below two lines to signle line to avoid sparse error
> > >  #if IS_ENABLED(CONFIG_IPV6)
> > >                if (n->tbl->family == AF_INET6) {
> > > to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> > > 
> > > and removes reassigning pin6 pointer when IPV6 is enabled
> > > 
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > > ---
> > >  include/trace/events/neigh.h | 19 +++++--------------
> > >  1 file changed, 5 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> > > index 0bdb085..6e310ea 100644
> > > --- a/include/trace/events/neigh.h
> > > +++ b/include/trace/events/neigh.h
> > > @@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
> > >  		else
> > >  			*p32 = 0;
> > >  
> > > -#if IS_ENABLED(CONFIG_IPV6)
> > > -		if (n->tbl->family == AF_INET6) {
> > > -			pin6 = (struct in6_addr *)__entry->primary_key6;
> > > +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> > >  			*pin6 = *(struct in6_addr *)n->primary_key;
> > 
> > Why removing the line wheer pin6 is assigned?
> > IMO, the patch should be:
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -		if (n->tbl->family == AF_INET6) {
> > +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> >  			pin6 = (struct in6_addr *)__entry->primary_key6;
> >   			*pin6 = *(struct in6_addr *)n->primary_key;
> > 
> > > @@ -147,15 +143,10 @@ DECLARE_EVENT_CLASS(neigh__update,
> > >  		else
> > >  			*p32 = 0;
> > >  
> > > -#if IS_ENABLED(CONFIG_IPV6)
> > > -		if (n->tbl->family == AF_INET6) {
> > > -			pin6 = (struct in6_addr *)__entry->primary_key6;
> >
> pin6  is already assigned.

OK, I see. IMO, it would be better to have 2 patches for this:
one for the redundant assignment to pin6 and anotther one for
the IS_ENABLED() change but feel free, if needed, to add my

  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


-- Luc
