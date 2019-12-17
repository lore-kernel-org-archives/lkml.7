Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F94C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE91320733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pg2N6dlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfLQSHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:07:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42482 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfLQSHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:07:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so2214242plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nzMjjA8ddAzos3IXD0xyOi0qISaNV08D/uEl7K44qo8=;
        b=pg2N6dlxoknRXGaOsp8F2Dj48VcEVRGNkfLixlqOgqP2psKShK3//IFaqmUk0WIpF4
         4oLCupLf8D0sYJyE7s7rlX/A8dbMPLmbwxCkKmTFkjh0jK/eXOzDlYK5tG2iZ7uOTU+9
         X3XYB2EzzW/rDER0D/LTH+ZCpYjx9aFXDMPWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nzMjjA8ddAzos3IXD0xyOi0qISaNV08D/uEl7K44qo8=;
        b=HxJLMrERhYHFphdnzRjfyd+qDYdtF5qYDD8Qi/uNoKNymbeZZ7oKW6g4JjRP8123Id
         hKBwxrLdunCpRpjoWLvcNR0Ap5myOllE/tUdHWwNYLZmCdFoogNV6FVobZPF2zuEqcd+
         NTKhzBhGI7FTHGy+5dlQJuHOchxZEsXFnOcqd7HGg7CUt6RJKmtIEbn9PHvXjaZQ9kR2
         1twg6omQObsBECYO48J8V6N9tlQa6irCS9Sae8drM8aLVUaDQ7YZCUWAWQ77W/oM9W2R
         J3KIbsDlOnNysHc2aym2U6KocahgEa0mc3jPgurfAAcf+n+tg43AeQLWK/yJGcVcKMk4
         waag==
X-Gm-Message-State: APjAAAVzC2UX4mDvBU2eC2LIl4uRFv2OEPB2Qo4d2nnf51JcmQ0/DBJw
        Za5fCV51YpbZdQZqXZFtowEXXA==
X-Google-Smtp-Source: APXvYqxAJI81AH6HmfIx5wJrZqZ9VuYSMAAkgG8V4eWOlkYdG/EbGTbT57IKo+0HZ1dJL483/n6Mww==
X-Received: by 2002:a17:90a:ff12:: with SMTP id ce18mr7703214pjb.117.1576606067270;
        Tue, 17 Dec 2019 10:07:47 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l9sm27115023pgh.34.2019.12.17.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 10:07:46 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:07:45 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     paulmck@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191217180745.GA253850@google.com>
References: <20191202210854.GD17234@google.com>
 <20191203071329.GC115767@gmail.com>
 <20191203175712.GI2889@paulmck-ThinkPad-P72>
 <20191204100549.GB114697@gmail.com>
 <20191204161239.GL2889@paulmck-ThinkPad-P72>
 <20191206011137.GB142442@google.com>
 <20191206031151.GY2889@paulmck-ThinkPad-P72>
 <20191208000842.GA62607@google.com>
 <20191209033910.GD2889@paulmck-ThinkPad-P72>
 <20191217235921.01cecb379e5e58493a0815af@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217235921.01cecb379e5e58493a0815af@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:59:21PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> On Sun, 8 Dec 2019 19:39:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Sat, Dec 07, 2019 at 07:08:42PM -0500, Joel Fernandes wrote:
> > > On Thu, Dec 05, 2019 at 07:11:51PM -0800, Paul E. McKenney wrote:
> > > > On Thu, Dec 05, 2019 at 08:11:37PM -0500, Joel Fernandes wrote:
> > > > > On Wed, Dec 04, 2019 at 08:12:39AM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> > > > > > > 
> > > > > > > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > 
> > > > > > > > >  * This list-traversal primitive may safely run concurrently with
> > > > > > > > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > > > > > > > >  * as long as the traversal is guarded by rcu_read_lock().
> > > > > > > > >  */
> > > > > > > > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > > > > > > > 
> > > > > > > > > is actively harmful. Why is it there?
> > > > > > > > 
> > > > > > > > For cases where common code might be invoked both from the reader
> > > > > > > > (with RCU protection) and from the updater (protected by some
> > > > > > > > lock).  This common code can then use the optional argument to
> > > > > > > > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > > > > > > > called with either form of protection in place.
> > > > > > > > 
> > > > > > > > This also combines with the __rcu tag used to mark RCU-protected
> > > > > > > > pointers, in which case sparse complains when a non-RCU API is applied
> > > > > > > > to these pointers, to get back to your earlier question about use of
> > > > > > > > hlist_for_each_entry_rcu() within the update-side lock.
> > > > > > > > 
> > > > > > > > But what are you seeing as actively harmful about all of this?
> > > > > > > > What should we be doing instead?
> > > > > > > 
> > > > > > > Yeah, so basically in the write-locked path hlist_for_each_entry() 
> > > > > > > generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> > > > > > > correct?
> > > > > > 
> > > > > > Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
> > > > > > depending of course on the compiler and the surrounding code.
> > > > > > 
> > > > > > > Also, the principle of passing warning flags around is problematic - but 
> > > > > > > I can see the point in this specific case.
> > > > > > 
> > > > > > Would it help to add an hlist_for_each_entry_protected() that expected
> > > > > > RCU-protected pointers and write-side protection, analogous to
> > > > > > rcu_dereference_protected()?  Or would that expansion of the RCU API
> > > > > > outweigh any benefits?
> > > > > 
> > > > > Personally, I like keeping the same API and using the optional argument like
> > > > > we did thus preventing too many APIs / new APIs.
> > > > 
> > > > Would you be willing to put together a prototype patch so that people
> > > > can see exactly how it would look?
> > > 
> > > Hi Paul,
> > > 
> > > I was referring to the same API we have at the moment (that is
> > > hlist_for_each_entry_rcu() with the additional cond parameter). I was saying
> > > let us keep that and not add a hlist_for_each_entry_protected() instead, so
> > > as to not proliferate the number of APIs.
> > > 
> > > Or did I miss the point?
> > 
> > This would work for me.  The only concern would be inefficiency, but we
> > have heard from people saying that the unnecessary inefficiency is only
> > on code paths that they do not care about, so we should be good.
> 
> So, what will be the conclusion here, Ingo?
> 
> I faced other warnings in tracing subsystem, so I need to add more
> lockdep_is_held()s there to suppress warnings.

Please don't add a new:
hlist_for_each_entry_rcu_protected(..., lockdep_is_held(...))

Instead use the existing one in mainline:
 hlist_for_each_entry_rcu(..., lockdep_is_held(...)).

How many warnings are you facing? I think it is a good idea to add
lockdep_is_held() wherever needed so as to prevent false-positive warnings as
it would harden your code and prevent fireworks.

thanks,

 - Joel

> 
> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
