Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED64C2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Jls1cMO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLFBLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:11:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44485 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFBLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:11:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id bh2so849315plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 17:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=afFgdaPpYNHvy5QgCmSyg24Hm+ltvoWQsuROrBrCOAA=;
        b=Jls1cMO18zwlNXp1RcxuRzsLNqRvDkKqZjbzo6ZngtVlM/X+QlWs13zMLYRwqXBRQo
         kBChDfpJSztwtKn52szanSvW1WWT2SCtmedbAOjZ1g6DwlufiYLEbc4xAjaotwjB4/NN
         N9zV3b+9CBxZXd52VTfe3/pWbW7+CyQeIN5q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=afFgdaPpYNHvy5QgCmSyg24Hm+ltvoWQsuROrBrCOAA=;
        b=GHpSY1wEv7jTrXktwP7AttXWKe2mJ/JDzgvRxwpxvTe4H8ogHCvhiOIsd7KKW2a/4E
         8bY/kAlQULoP11AV0LvrAngV1CqkeLYvM6n7eX9X0z9AvCRyxCexniB+TE9KhfVpm3hs
         sg2lUynwV5uRE3xvVeW8lDdbS9aerNMmBDLr+mCt8GLNqSPQQ27esqTysWJnBt5ckuUc
         UgwZet3K1ZsloHf2zu6jKe0e459ROqT9fUUacgDyiK0xhwAo51aXBlD3RhjD+2R+dNN1
         xw2C1YUMdvnH+xkAx1ys+8TGP0stxpu3OYYHL79AASlY6/TsDQP/dr6axmrJwOWnhjTl
         eD/A==
X-Gm-Message-State: APjAAAWFgbAPMIQidgUd/Nq8wqfVSa3hHbxlcofwNLUH6Cl+5glEbLua
        lUyP6/DSD4QuIS2YDiaB+W9P4g==
X-Google-Smtp-Source: APXvYqwnyB3hgGzxp6a/jdh6wC9AyEDlREjAgJs5KYIUY5ylBbAWt0nWAe28Thxa5y10mEBEjTnvXg==
X-Received: by 2002:a17:90a:c01:: with SMTP id 1mr12729171pjs.37.1575594698986;
        Thu, 05 Dec 2019 17:11:38 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b2sm14031169pff.6.2019.12.05.17.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:11:38 -0800 (PST)
Date:   Thu, 5 Dec 2019 20:11:37 -0500
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
Message-ID: <20191206011137.GB142442@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191203175712.GI2889@paulmck-ThinkPad-P72>
 <20191204100549.GB114697@gmail.com>
 <20191204161239.GL2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204161239.GL2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 08:12:39AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > > >  * This list-traversal primitive may safely run concurrently with
> > > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > > >  * as long as the traversal is guarded by rcu_read_lock().
> > > >  */
> > > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > > 
> > > > is actively harmful. Why is it there?
> > > 
> > > For cases where common code might be invoked both from the reader
> > > (with RCU protection) and from the updater (protected by some
> > > lock).  This common code can then use the optional argument to
> > > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > > called with either form of protection in place.
> > > 
> > > This also combines with the __rcu tag used to mark RCU-protected
> > > pointers, in which case sparse complains when a non-RCU API is applied
> > > to these pointers, to get back to your earlier question about use of
> > > hlist_for_each_entry_rcu() within the update-side lock.
> > > 
> > > But what are you seeing as actively harmful about all of this?
> > > What should we be doing instead?
> > 
> > Yeah, so basically in the write-locked path hlist_for_each_entry() 
> > generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> > correct?
> 
> Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
> depending of course on the compiler and the surrounding code.
> 
> > Also, the principle of passing warning flags around is problematic - but 
> > I can see the point in this specific case.
> 
> Would it help to add an hlist_for_each_entry_protected() that expected
> RCU-protected pointers and write-side protection, analogous to
> rcu_dereference_protected()?  Or would that expansion of the RCU API
> outweigh any benefits?

Personally, I like keeping the same API and using the optional argument like
we did thus preventing too many APIs / new APIs.

thanks,

 - Joel

