Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E332C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5741220851
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NX/KmtDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEYOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:19:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46301 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfEYOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:19:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id r18so5298407pls.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oA6FcJ72zNid4SwAO5Y6rnUXHdUQj0L4tCh0ZCLJSFI=;
        b=NX/KmtDCs4EGb9mO5SMMkYszAarGd0UZP0S8vAwwQjy5ElvPnArSQCM79p6zDDG599
         0Nrwt8GmeJlUpxdahkhFUQgjljvJWEl8W0oRgaWVvzii8pMGxtDBNNez3szb6V5hR7Sl
         /oVTbrXCcQaK/wd3nTy2BIpckmRhnlhqmFMt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oA6FcJ72zNid4SwAO5Y6rnUXHdUQj0L4tCh0ZCLJSFI=;
        b=actoabjk+HMBYQEKL3Xzxs4PTcjCSS0ZaxCP0ERJSHjtFGlYIogWff54fYc3KojSLw
         IK47cA8jS8cHMeOLBVyPxXo+9TMJEYEqEnRiG3uSFWTGm0aWhcELfb7BgDYIScs6/Zos
         Hck014OGg1TzrCSRmgi25YilM/FUrfeq9JDLardU2lMuM61isCLJyU1Y5NcqxUCvpRRd
         8Wg8JSszRzN7WfAdWuqC7ww8UtSTzmUngmevzgVw97u617bmBJbQUj3EBu0fpkJ4GcPx
         nwm8z69GF3ikXr4IJLkpl8Ugh7jKlLT1vB0CoO8eezdVOltJKJnXi2vXiMY6mh1ip/ci
         4juw==
X-Gm-Message-State: APjAAAX/p1CIF4KwVK7ZEwMfViUJRJ53TnMXHbbgIvLs82T09X2WAs38
        HvlbUjKKCCE6CYPGff13viwmjQ==
X-Google-Smtp-Source: APXvYqz1DtDvRXpDvMqOaGFx8+a+/FEFbXY2Ry7LB+HHkerKQ+Avr2mpCrR118QII1Whv7IzQ6nqfw==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr42398103plt.318.1558793996314;
        Sat, 25 May 2019 07:19:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p63sm6795234pfb.70.2019.05.25.07.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 07:19:55 -0700 (PDT)
Date:   Sat, 25 May 2019 10:19:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] Remove some notrace RCU APIs
Message-ID: <20190525141954.GA176647@google.com>
References: <20190524234933.5133-1-joel@joelfernandes.org>
 <20190524232458.4bcf4eb4@gandalf.local.home>
 <20190525081444.GC197789@google.com>
 <20190525070826.16f76ee7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525070826.16f76ee7@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 07:08:26AM -0400, Steven Rostedt wrote:
> On Sat, 25 May 2019 04:14:44 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > I guess the difference between the _raw_notrace and just _raw variants
> > > is that _notrace ones do a rcu_check_sparse(). Don't we want to keep
> > > that check?  
> > 
> > This is true.
> > 
> > Since the users of _raw_notrace are very few, is it worth keeping this API
> > just for sparse checking? The API naming is also confusing. I was expecting
> > _raw_notrace to do fewer checks than _raw, instead of more. Honestly, I just
> > want to nuke _raw_notrace as done in this series and later we can introduce a
> > sparse checking version of _raw if need-be. The other option could be to
> > always do sparse checking for _raw however that used to be the case and got
> > changed in http://lists.infradead.org/pipermail/linux-afs/2016-July/001016.html
> 
> What if we just rename _raw to _raw_nocheck, and _raw_notrace to _raw ?

That would also mean changing 160 usages of _raw to _raw_nocheck in the
kernel :-/.

The tracing usage of _raw_notrace is only like 2 or 3 users. Can we just call
rcu_check_sparse directly in the calling code for those and eliminate the APIs?

I wonder what Paul thinks about the matter as well.

thanks, Steven!
