Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C6C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6211F222CA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570282415;
	bh=N38XZT/ZGKyamYsz24sQHqqiC9R554U2eV45zXldpaE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=z5WWpo2BmIhamByno/xt/h/wIjNKU5QUa7BHr3dUHRmkgLV7++PQTcIYSIUr3p1CO
	 YndIPT+snkXGivgpJBxKdQqYHbqUQ/Msf0JUKygQLou1Sml6lFAk5chUZjLIGvKlht
	 UoL1SOupHp6jsJNUqVyad41c6Sf0UvsTvvqh5IIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfJENdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 09:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJENdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:33:32 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A651B222C5;
        Sat,  5 Oct 2019 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570282411;
        bh=N38XZT/ZGKyamYsz24sQHqqiC9R554U2eV45zXldpaE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lMMExsEd7DQiL1ZbMg5X7yqLGWIGBP/fB9vg8wJDNN0kuZlRr9CEIwwWT9xEuE5Y1
         zwqVSkUPC54FHj8ngILUAvSSS6cdfUS55hVV7F8d+U8Q2DCwCMyh/YTpphNgTDdeGR
         Xo1KMof0Sxc4riE84nZFv6b5efvZ/tdFBzyIO0F4=
Date:   Sat, 5 Oct 2019 06:33:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Describe variadic macro argument in a
 Sphinx-compatible way
Message-ID: <20191005133330.GX2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191004215402.28008-1-j.neuschaefer@gmx.net>
 <20191004222439.GR2689@paulmck-ThinkPad-P72>
 <20191004232328.GC19803@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004232328.GC19803@latitude>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 01:23:28AM +0200, Jonathan Neuschäfer wrote:
> On Fri, Oct 04, 2019 at 03:24:39PM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 04, 2019 at 11:54:02PM +0200, Jonathan Neuschäfer wrote:
> > > Without this patch, Sphinx shows "variable arguments" as the description
> > > of the cond argument, rather than the intended description, and prints
> > > the following warnings:
> > > 
> > > ./include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
> > > ./include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
> 
> Hmm, small detail that I didn't realize before: It's actually the
> kernel-doc script, not Sphinx, that can't deal with variadic macro
> arguments and thus requires this patch.
> 
> So it may also be possible to fix the script instead. (I have not
> looked into how much work that would be.)

OK, thank you for letting me know.  I will keep your patch for the
moment, but please let me know if the fix can be elsewhere.

							Thanx, Paul
