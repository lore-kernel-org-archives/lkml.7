Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA9DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53512183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKE7oOSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfC3LHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:07:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43079 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbfC3LHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:07:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so2204424plt.10;
        Sat, 30 Mar 2019 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hEzqti2at/SdXPxvZZZcw5JS0bkMUItsjBSbx22Zqgs=;
        b=NKE7oOSxwW2EatecRzi2gLjJym8Czl4k2QQC0tKWp2LfnV9PmhpGkXxDd1nlpwdsUf
         R5Vp3BL4kaWG4RmN3k/J2Tc8jbi1HWB2VO5ABbefhXMsyPUnNi+LTSuIHWvWU3/tAGzX
         qaj9RMHXI9DHfsnr+rRVc69HktJsr6Qp1Gh3G559pHfdbstG0I+7F3ThqWQXwWTXL0M6
         46VUf/2DmMuQyHx1on8AlS6iM79AEaxebSM058V6H67hXaOuJAD5y00YnbRWemTEAjCi
         /iQGfFyQD+85bCb/x5liSw8bQAbDe0IcMOVKkNZFEiRiALDilb7aAJWr3D6BfcQHgpBW
         Yrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEzqti2at/SdXPxvZZZcw5JS0bkMUItsjBSbx22Zqgs=;
        b=BwT+ZkS1+Q0eDMy2gNrqYMGPCTB8/Che8yEju7FkkyIk2AAlnyHe9dCaLZ3kEq7WrN
         /dzkKUUEneWldOvHa5PJmA0ycmXS6uC5/qa+90dmLFFDbhz/L96zJHvQRAQf0NobFcRO
         7rcSkRbXTrwK33FV9JKlYAjwW81vitfu0/EDfOyTNnAwCYIcMePv6M5/tYzjMMM/PPhK
         LehDPRGanDAAMwas4NLERzyIe6zyoeXfZJBnizmjfHrAY/RXzWljsRG8MCJvwC32LawX
         /fPOzt0yNQUO29RSNoZpxMZr8ap+aCR3znBPxCtH/qC/szAUZVO0vxOQXY72VdBTOY4b
         31bQ==
X-Gm-Message-State: APjAAAVAVa2/WLc9MuDRL7QmoO6959gNspiggNDVgl1/9nCzm7+d2aRs
        egX4cV4DFeqmgr77/o2M9SE=
X-Google-Smtp-Source: APXvYqxgbR7KwhzHo2g4x9GkLgA7PVDsRhC3jnWKPaMy1pDxB8cQEAKUeYsg0ihi2y7FKd9CTthDcQ==
X-Received: by 2002:a17:902:be09:: with SMTP id r9mr1224529pls.215.1553944073212;
        Sat, 30 Mar 2019 04:07:53 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id h3sm5480109pgv.38.2019.03.30.04.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:07:52 -0700 (PDT)
Date:   Sat, 30 Mar 2019 16:37:48 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190330110747.GA3461@hari-Inspiron-1545>
References: <20190325195303.GA20629@hari-Inspiron-1545>
 <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:22:17AM +0100, Luc Van Oostenryck wrote:
> On Tue, Mar 26, 2019 at 01:23:03AM +0530, Hariprasad Kelam wrote:
> > This patch fixes below spare errors.
> > 
> > Sparse error:
> > make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> > ./include/trace/events/neigh.h:73:1: error: directive in argument list
> > ./include/trace/events/neigh.h:78:1: error: directive in argument list
> > ./include/trace/events/neigh.h:150:1: error: directive in argument list
> > ./include/trace/events/neigh.h:155:1: error: directive in argument list
> > 
> > Changes below two lines to signle line to avoid sparse error
> >  #if IS_ENABLED(CONFIG_IPV6)
> >                if (n->tbl->family == AF_INET6) {
> > to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> > 
> > and removes reassigning pin6 pointer when IPV6 is enabled
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  include/trace/events/neigh.h | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> > index 0bdb085..6e310ea 100644
> > --- a/include/trace/events/neigh.h
> > +++ b/include/trace/events/neigh.h
> > @@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
> >  		else
> >  			*p32 = 0;
> >  
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -		if (n->tbl->family == AF_INET6) {
> > -			pin6 = (struct in6_addr *)__entry->primary_key6;
> > +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> >  			*pin6 = *(struct in6_addr *)n->primary_key;
> 
> Why removing the line wheer pin6 is assigned?
> IMO, the patch should be:
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
>  			pin6 = (struct in6_addr *)__entry->primary_key6;
>   			*pin6 = *(struct in6_addr *)n->primary_key;
> 
> > @@ -147,15 +143,10 @@ DECLARE_EVENT_CLASS(neigh__update,
> >  		else
> >  			*p32 = 0;
> >  
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -		if (n->tbl->family == AF_INET6) {
> > -			pin6 = (struct in6_addr *)__entry->primary_key6;
>
pin6  is already assinged .Assinging pin6 is redudant in if loop
 Below is the original code
 <code-snippet>
		pin6 = (struct in6_addr *)__entry->primary_key6;
		p32 = (__be32 *)__entry->primary_key4;

		if (n->tbl->family == AF_INET)
			*p32 = *(__be32 *)n->primary_key;
		else
			*p32 = 0;

#if IS_ENABLED(CONFIG_IPV6)
		if (n->tbl->family == AF_INET6) {
                       pin6 = (struct in6_addr *)__entry->primary_key6;
		       *pin6 = *(struct in6_addr *)n->primary_key;
		} else
#endif
                {
			ipv6_addr_set_v4mapped(*p32, pin6);
		}
 </code-snippet>


> Same here.
> 
> -- Luc Van Oostenryck
