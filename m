Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFBBC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D332075E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="laG2+Nxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfHQEan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:30:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34625 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfHQEam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:30:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3912481pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gam5/JgpEz7478TT1VCHez++Gfwsns89IHEVFVLSr8Q=;
        b=laG2+Nxv0B64t6/nv+EeOygMx1pbhmZiu87TaPe0iUfVYmJjX+30WfYa0Hnw2rpRiy
         SrYKT3046yJwFQ7Ca5Z1Ng7wzo4hw7S8EBCFW/F+1z9kcxXIST5+4nI3PHF9iUacgyBk
         rTxRLbb5vrMkVdbYrumIqRhwBbLYI76ygVqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gam5/JgpEz7478TT1VCHez++Gfwsns89IHEVFVLSr8Q=;
        b=qxISflFMoHcEh/HH07cMUWV+vIpFfwcS+fNWKjQuYBXhPXfm40MOwHvviQvsibycxq
         in81q3HCqTqzXcsFqow/y/XLT9oYQJ5m97q3yKBgQoHq7FiFp4MgdHPrg05wNRFj11+o
         FbbACEuGtmDCDFADTDJA8WgroUZy5zBfFBrk9WOUPTML8G0ciE2mhc+BwnLzuccP70Oa
         28ng4iTIA+Z7zPSJZUqUcXFHZ0U9DaAk+TGXsuUJ2d8XMHec33Ic2Y28VTzedNNZvaWd
         Ev02URCuoQQYpbz1Sqch0BF+Z2bHuukwO1HOCcxq4yNzWFWJ1QdVjZ9C5WhGLTA8ASYQ
         h/Gw==
X-Gm-Message-State: APjAAAVDm39/cPE7+vplUSlRH65k0kfy+ny7OPJ/dV2PGolzTxlgNrog
        VCQLRqYtuzt7p6R+v7vLjzQzsQ==
X-Google-Smtp-Source: APXvYqx4KO0UhYlQRcR4hUAYds+M7jp9fZWDNHA2rEMOc2ajaLyZvZ81gWdaScSAK1Iex3hdMMmteQ==
X-Received: by 2002:a17:90a:9604:: with SMTP id v4mr10217906pjo.66.1566016242080;
        Fri, 16 Aug 2019 21:30:42 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id t70sm6115416pjb.2.2019.08.16.21.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:30:41 -0700 (PDT)
Date:   Sat, 17 Aug 2019 00:30:24 -0400
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
Message-ID: <20190817043024.GA137383@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190816164330.GA8320@linux.ibm.com>
 <20190816174429.GE10481@google.com>
 <20190816191629.GW28441@linux.ibm.com>
 <CAEXW_YTSJaKzWGC5nTbOuoQ6dxO4_uYW6=ttTJY6FWGb5rcB6Q@mail.gmail.com>
 <20190817035637.GY28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817035637.GY28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 08:56:37PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 16, 2019 at 09:32:23PM -0400, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Fri, Aug 16, 2019 at 3:16 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > > Hello, Joel,
> > > > >
> > > > > I reworked the commit log as follows, but was then unsuccessful in
> > > > > working out which -rcu commit to apply it to.  Could you please
> > > > > tell me what commit to apply this to?  (Once applied, git cherry-pick
> > > > > is usually pretty good about handling minor conflicts.)
> > > >
> > > > It was originally based on v5.3-rc2
> > > >
> > > > I was able to apply it just now to the rcu -dev branch and I pushed it here:
> > > > https://github.com/joelagnel/linux-kernel.git (branch paul-dev)
> > > >
> > > > Let me know if any other issues, thanks for the change log rework!
> > >
> > > Pulled and cherry-picked, thank you!
> > >
> > > Just for grins, I also  pushed out a from-joel.2019.08.16a showing the
> > > results of the pull.  If you pull that branch, then run something like
> > > "gitk v5.3-rc2..", and then do the same with branch "dev", comparing the
> > > two might illustrate some of the reasons for the current restrictions
> > > on pull requests and trees subject to rebase.
> > 
> > Right, I did the compare and see what you mean. I guess sending any
> > future pull requests against Linux -next would be the best option?
> 
> Hmmm...  You really want to send some pull requests, don't you?  ;-)

I would be lying if I said I don't have the itch to ;-)

> Suppose you had sent that pull request against Linux -next or v5.2
> or wherever.  What would happen next, given the high probability of a
> conflict with someone else's patch?  What would the result look like?

One hopes that the tools are able to automatically resolve the resolution,
however adequate re-inspection of the resulting code and testing it would be
needed in either case, to ensure the conflict resolution (whether manual or
automatic) happened correctly.

IIUC, this usually depends on the maintainer's preference on which branch to
send patches against.

Are you saying -rcu's dev branch is still the best option to send patches
against, even though it is rebased often?

thanks,

 - Joel

