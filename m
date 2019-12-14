Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8CC2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CBF2465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576305652;
	bh=ywRbms/3SILxNnbJWJRfGsJaom/QIpHbbWAIN9MG/Xc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lBfmQ6f0EWoYxBhHb28PHspA/3XbynUDtBCNuKI0ma2UlDwXDSebjjohLzWgfsz9l
	 p3nV86y4GOCSkMrsmH426JJ9KVKWCBdbBgFDLuLI+wglh8fEA60k2u3iviscKKXj//
	 zsGE5of88WOGjd6SRVCt/FaELABSaiab2dhCDAw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfLNGkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 01:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfLNGku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 01:40:50 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87B6214AF;
        Sat, 14 Dec 2019 06:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576305650;
        bh=ywRbms/3SILxNnbJWJRfGsJaom/QIpHbbWAIN9MG/Xc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TArLbUEdqOTQ8RP5TNPmRuqZQ8TG3JA6KzrdenMoMMjnXeYmQPORLO7UEPY7POfac
         Yeal7xjT9zoRYp+MZrHMkz1JLowXAyh4OtbA8haXK56LY70Coi6IUa3UD+Q9bUj3qK
         gwSEDUpqQXmwgQTElBrSc7uMW7mjJ+Q2rzvw7n78=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 13534352276B; Fri, 13 Dec 2019 22:40:48 -0800 (PST)
Date:   Fri, 13 Dec 2019 22:40:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Message-ID: <20191214064048.GI2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191213224646.GH2889@paulmck-ThinkPad-P72>
 <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 06:11:16PM -0500, Qian Cai wrote:
> 
> 
> > On Dec 13, 2019, at 5:46 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > I am running this on a number of x86 systems, but will try it on a
> 
> The config to reproduce includes several debugging options that might
> required to recreate.

If you run without those debugging options, do you still see the hangs?
If not, please let me know which debugging are involved.

> > wider variety.  If I cannot reproduce it, would you be willing to
> > run diagnostics?
> 
> Yes.

Very good!  Let me see what I can put together.  (No luck reproducing
at my end thus far.)

> > Just to double-check...  Are you running rcutorture built into the kernel?
> > (My guess is "no", but figured that I should ask.)
> 
> No as you can see from the config I linked in the original email.

Fair point, and please accept my apologies for the pointless question.

							Thanx, Paul
