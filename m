Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFFEC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9901F20815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kkcebdla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfEYSSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:18:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44358 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEYSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:18:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so6798717pgp.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwUwT3IH5HpGo/L8sP6//cCZtClp5/ip6vUnZdkkz+4=;
        b=kkcebdlaAxI4tg4ycJmEqrzHnyewgh+jjzD8JuWykQMD1lxIZbs14DxRaS3JzJWrkx
         D3zUk40qEzDf9b4/+3m3e4ZQvAeZltgNBFxxlJjzMPDywJcvPdcoFqhPgZYDwqU6gPKo
         ZKBP/5ISTo1G00dTfWL1Nmxp2HkYKifVw8IVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwUwT3IH5HpGo/L8sP6//cCZtClp5/ip6vUnZdkkz+4=;
        b=KB/Mk9CNfDMlfvP9/LmKecjw7L5+riGzqbfhLbZ3HMsXu7UI7WXtnLz5HyJXq23Se1
         laj5EfRzxUnadSObUaF+xnxVG9KGer59RPAw691A1NcgqRhNh0oSVmX113UgHnC/WkaG
         5hkUEZO5Ryr/TrNPrGZwljO5KI3H47auptGwTtNxUI9Il6UJY4pWl7Co9v8MOuIVfLV9
         stp+IiCm5P4yHhmhhnc5c1v60SvAMnB6KN43IYrl/1I3bxGyNbTfHvze1VMwT2FI06fC
         WPuiHBuozmkuc4KfP3ULi9rvI0wFyUnLYXzcCl9NeV0a3FK1fAzOrOxMo1jaBOPsAZ24
         TMZA==
X-Gm-Message-State: APjAAAVsm1LZurcTuWfDmggOeE3+4aNQFu4FCnoh+q7vxEs/tdcCBnTB
        Ak/deBgXYAHUmV7Lnox2p54Ttg==
X-Google-Smtp-Source: APXvYqx/tYCXEdllU2F4/1JetbgrhH8TFsHxXRye9Amlmvbkp4RD4ve2+88VYqD+upEJsBYYCIqDXw==
X-Received: by 2002:aa7:8554:: with SMTP id y20mr121952964pfn.258.1558808300867;
        Sat, 25 May 2019 11:18:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s24sm6537148pfe.57.2019.05.25.11.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 11:18:20 -0700 (PDT)
Date:   Sat, 25 May 2019 14:18:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] Remove some notrace RCU APIs
Message-ID: <20190525181818.GA225569@google.com>
References: <20190524234933.5133-1-joel@joelfernandes.org>
 <20190524232458.4bcf4eb4@gandalf.local.home>
 <20190525081444.GC197789@google.com>
 <20190525070826.16f76ee7@gandalf.local.home>
 <20190525141954.GA176647@google.com>
 <20190525155035.GE28207@linux.ibm.com>
 <20190525181407.GA220326@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525181407.GA220326@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 02:14:07PM -0400, Joel Fernandes wrote:
[snip]
> > That aside, if we are going to change the name of an API that is
> > used 160 places throughout the tree, we would need to have a pretty
> > good justification.  Without such a justification, it will just look
> > like pointless churn to the various developers and maintainers on the
> > receiving end of the patches.
> 
> Actually, the API name change is not something I want to do, it is Steven
> suggestion. My suggestion is let us just delete _raw_notrace and just use the
> _raw API for tracing, since _raw doesn't do any tracing anyway. Steve pointed
> that _raw_notrace does sparse checking unlike _raw, but I think that isn't an
> issue since _raw doesn't do such checking at the moment anyway.. (if possible
> check my cover letter again for details/motivation of this series).

Come to think of it, if we/I succeed in adding lockdep checking in _raw, then
we can just keep the current APIs and not delete anything. And we can have
_raw_notrace skip the lockdep checks. The sparse check question would still
be an open one though, since _raw doesn't do sparse checks at the moment
unlike _raw_notrace as Steve pointed.

Thanks,

 - Joel

