Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC95C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 05:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7642133F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 05:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cB47Bb4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfHQFxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 01:53:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33974 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 01:53:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so1451293plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iF1d/XucEfTZBKbZNeVNe2rlZZm7hfnL8VoxPV7mfrs=;
        b=cB47Bb4rnd6z0pZ3KLPUCVyuTUj5PHum8fUBgfOrDHW6sjSZs109jNX4k6geJstPP3
         eGuJYxyQE4qkZG4yTgwEElWDP6XSjxJxVAPWruAQALOp39weBVoAaTHIiCfi/6aW36jd
         pL0WfuhSCh8uf5nLPuAT68K6wSOhxHsN4Ymm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iF1d/XucEfTZBKbZNeVNe2rlZZm7hfnL8VoxPV7mfrs=;
        b=FOt5RD6hINQhtuYd+WO+udZ+s0ShPhRse+6RYYEPwezYEwaMptNvLxPgPMoWmpNIKg
         pz2mDQBMFA16RDJGg5m67AfD7WdTtnhHduapFa/JdZ5A0R9ahopGrR49HFOZKF4iSMLl
         6emmR0qzX2JNR1TjTqWAuCB+OdqiMntkLQh7TSSbMttweDq9msCLkVCLsWxAKI07g4+Z
         UnR9geRi9UzLa+vRBqtlefDYytfkSOjwumD0HZvFNlzhgYPMBZ0OScvA/fUmPTWLgvHM
         DL8pM9cxuE9mxNVYYeoEv/1MQtZECE7E0EusGxhoxZh6hTbC0RifGhHwUA0RpFlEw1HC
         J5+w==
X-Gm-Message-State: APjAAAW/9nL0SJ6ytnjfUrf+VWXKa6TN1kF4kfv8Vz85RqZDDwQMHFG6
        X6aCqm/ngzJiffoEsVVDXg3sLg==
X-Google-Smtp-Source: APXvYqz2lfmYpZuJnBqQg+aZNL/ns18BABfPrDtNxRGURxTiWR9Ghm48SUA3n3gfjEdkAO7cKoEepA==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr12236863plj.116.1566021227286;
        Fri, 16 Aug 2019 22:53:47 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id y11sm7841397pfb.119.2019.08.16.22.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 22:53:46 -0700 (PDT)
Date:   Sat, 17 Aug 2019 01:53:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        kernel-team <kernel-team@lge.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20190817055329.GA151631@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190816164330.GA8320@linux.ibm.com>
 <20190816174429.GE10481@google.com>
 <20190816191629.GW28441@linux.ibm.com>
 <CAEXW_YTSJaKzWGC5nTbOuoQ6dxO4_uYW6=ttTJY6FWGb5rcB6Q@mail.gmail.com>
 <20190817035637.GY28441@linux.ibm.com>
 <20190817043024.GA137383@google.com>
 <20190817052023.GA28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817052023.GA28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:20:23PM -0700, Paul E. McKenney wrote:
> On Sat, Aug 17, 2019 at 12:30:24AM -0400, Joel Fernandes wrote:
> > On Fri, Aug 16, 2019 at 08:56:37PM -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 16, 2019 at 09:32:23PM -0400, Joel Fernandes wrote:
> > > > Hi Paul,
> > > > 
> > > > On Fri, Aug 16, 2019 at 3:16 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > > > > Hello, Joel,
> > > > > > >
> > > > > > > I reworked the commit log as follows, but was then unsuccessful in
> > > > > > > working out which -rcu commit to apply it to.  Could you please
> > > > > > > tell me what commit to apply this to?  (Once applied, git cherry-pick
> > > > > > > is usually pretty good about handling minor conflicts.)
> > > > > >
> > > > > > It was originally based on v5.3-rc2
> > > > > >
> > > > > > I was able to apply it just now to the rcu -dev branch and I pushed it here:
> > > > > > https://github.com/joelagnel/linux-kernel.git (branch paul-dev)
> > > > > >
> > > > > > Let me know if any other issues, thanks for the change log rework!
> > > > >
> > > > > Pulled and cherry-picked, thank you!
> > > > >
> > > > > Just for grins, I also  pushed out a from-joel.2019.08.16a showing the
> > > > > results of the pull.  If you pull that branch, then run something like
> > > > > "gitk v5.3-rc2..", and then do the same with branch "dev", comparing the
> > > > > two might illustrate some of the reasons for the current restrictions
> > > > > on pull requests and trees subject to rebase.
> > > > 
> > > > Right, I did the compare and see what you mean. I guess sending any
> > > > future pull requests against Linux -next would be the best option?
> > > 
> > > Hmmm...  You really want to send some pull requests, don't you?  ;-)
> > 
> > I would be lying if I said I don't have the itch to ;-)
> > 
> > > Suppose you had sent that pull request against Linux -next or v5.2
> > > or wherever.  What would happen next, given the high probability of a
> > > conflict with someone else's patch?  What would the result look like?
> > 
> > One hopes that the tools are able to automatically resolve the resolution,
> > however adequate re-inspection of the resulting code and testing it would be
> > needed in either case, to ensure the conflict resolution (whether manual or
> > automatic) happened correctly.
> 
> I didn't ask you to hope.  I instead asked you what tell me what would
> actually happen.  ;-)
> 
> You could actually try this by randomly grouping the patches in -rcu
> (say, placing every third patch into one of three groups), generating
> separate pull requests, and then merging the pull requests together.
> Then you wouldn't have to hope.  You could instead look at it in (say)
> gitk after the pieces were put together.

So you take whatever is worked on in 'dev' and create separate branches out
of them, then merge them together later?

I have seen you doing these tricks and would love to get ideas from your
experiences on these.

> > IIUC, this usually depends on the maintainer's preference on which branch to
> > send patches against.
> > 
> > Are you saying -rcu's dev branch is still the best option to send patches
> > against, even though it is rebased often?
> 
> Sounds like we might need to discuss this face to face.

Yes, let us talk for sure at plumbers, thank you so much!

(Also I sent a patch just now to fix that xchg() issue).

 - Joel

