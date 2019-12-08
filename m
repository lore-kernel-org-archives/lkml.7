Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1812AC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 00:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF80214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 00:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FRa+gNKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLHAIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:08:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35613 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLHAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 19:08:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so4298871pjd.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dXZlRb8cq1PmzSVNnBv1JsUvKa+HUrbvgeQMELIpBDY=;
        b=FRa+gNKNyGY+isoLzWTjdOUoV7Coi1XYDUCljTDMSvLtrd91MQWHH0kKBB/jA9GIab
         mCxNQdgbE72U4Pal6H6QutInxUi3w4ZziVwWc4lNTtg7d1JDFsFuV/ciNr0b9/xs6zQE
         n7KBAL8lxmzEGIDpbxIK2Iqpa7bNPi+7mzVzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dXZlRb8cq1PmzSVNnBv1JsUvKa+HUrbvgeQMELIpBDY=;
        b=EFJdWIGDCTEerpIReQDb8d26quMG15OmY1NS2Ifck4kURqc5DP4wWgnX7W7xy+nS/q
         om+MCZVAoSE4yVyRSzSA8d0pU/h+BW+epTY3dK8Wfrcbrl7uywoLabGfVSO/or2FQp9M
         IsiKU5usaOnGOGzTRbtZTHFDEVhH6l3EFDT4K4txhuxvwDGCSr+qS9px1BnnJiZNyFtA
         00e2ROkSDmLa2nyUCcIaRF4pybHz31/WdHwpHRBn8ghL5WZgto01Ae6mZ8W0OxLgmY3u
         qpB8WGodU5QWAbm7W9fS4SuC/lFzsucdlf0tkzwoTq/rwWo7z6PPEdRHXJBt8mT2KQ/6
         CSsw==
X-Gm-Message-State: APjAAAVjYgGXXTY/3QqpK5iLL+fAjyI88IIkFk4gPubOQDovxByZigRb
        GaRSFcAg7sWgu1g3x7K0ZVbN5Q==
X-Google-Smtp-Source: APXvYqxt6pXSjNAdOsypElD3oLaCojPyxuXzDU1l+0WiqQFa4oNYi73z1sh8qTAJoWfpZEnX8gSoPA==
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr22192805plp.91.1575763724541;
        Sat, 07 Dec 2019 16:08:44 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z130sm20445219pgz.6.2019.12.07.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 16:08:43 -0800 (PST)
Date:   Sat, 7 Dec 2019 19:08:42 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191208000842.GA62607@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191203175712.GI2889@paulmck-ThinkPad-P72>
 <20191204100549.GB114697@gmail.com>
 <20191204161239.GL2889@paulmck-ThinkPad-P72>
 <20191206011137.GB142442@google.com>
 <20191206031151.GY2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206031151.GY2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 07:11:51PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 05, 2019 at 08:11:37PM -0500, Joel Fernandes wrote:
> > On Wed, Dec 04, 2019 at 08:12:39AM -0800, Paul E. McKenney wrote:
> > > On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> > > > 
> > > > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > > >  * This list-traversal primitive may safely run concurrently with
> > > > > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > > > > >  * as long as the traversal is guarded by rcu_read_lock().
> > > > > >  */
> > > > > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > > > > 
> > > > > > is actively harmful. Why is it there?
> > > > > 
> > > > > For cases where common code might be invoked both from the reader
> > > > > (with RCU protection) and from the updater (protected by some
> > > > > lock).  This common code can then use the optional argument to
> > > > > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > > > > called with either form of protection in place.
> > > > > 
> > > > > This also combines with the __rcu tag used to mark RCU-protected
> > > > > pointers, in which case sparse complains when a non-RCU API is applied
> > > > > to these pointers, to get back to your earlier question about use of
> > > > > hlist_for_each_entry_rcu() within the update-side lock.
> > > > > 
> > > > > But what are you seeing as actively harmful about all of this?
> > > > > What should we be doing instead?
> > > > 
> > > > Yeah, so basically in the write-locked path hlist_for_each_entry() 
> > > > generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> > > > correct?
> > > 
> > > Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
> > > depending of course on the compiler and the surrounding code.
> > > 
> > > > Also, the principle of passing warning flags around is problematic - but 
> > > > I can see the point in this specific case.
> > > 
> > > Would it help to add an hlist_for_each_entry_protected() that expected
> > > RCU-protected pointers and write-side protection, analogous to
> > > rcu_dereference_protected()?  Or would that expansion of the RCU API
> > > outweigh any benefits?
> > 
> > Personally, I like keeping the same API and using the optional argument like
> > we did thus preventing too many APIs / new APIs.
> 
> Would you be willing to put together a prototype patch so that people
> can see exactly how it would look?

Hi Paul,

I was referring to the same API we have at the moment (that is
hlist_for_each_entry_rcu() with the additional cond parameter). I was saying
let us keep that and not add a hlist_for_each_entry_protected() instead, so
as to not proliferate the number of APIs.

Or did I miss the point?

thanks,

 - Joel

