Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B72AC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66BE24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576774564;
	bh=PMSrHvqg0gemRV++ytAtKoOkAvugTmkmbonktzFyE18=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=d4MZf2qS4RSxR9V+vgGtcKjdtyVezbaGPZu0FBNTUyczZgmupTt+3+adKTMKEJvsB
	 UtzXVL2Yje9xQuvjIhqOyaiqG7lBrQNbALQ7TWNp3JGkyoZ0i+yuBh5+nZLh0vOB+F
	 DDDlbven7CgdBr2XUlJ75A8Jg9QK390xVD15zVEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLSQ4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQ4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:56:02 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48DE2146E;
        Thu, 19 Dec 2019 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576774561;
        bh=PMSrHvqg0gemRV++ytAtKoOkAvugTmkmbonktzFyE18=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kOWy03CFpwgpXw2oFdpVHUn7E+twuJwx204ffHmEP3rX5xAhmL0yn3pJryLeHzsM/
         9mHGJBz4Lz4LHdvx1jUkbqzyiNnllYhG2ubYHjX6ory+oEl2IBwYYEKMx28ZlHvUDQ
         +gMlaF8T9cykSqBWbLdfxDfbcLvFvApGmIPpgPC0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8483E352274B; Thu, 19 Dec 2019 08:56:01 -0800 (PST)
Date:   Thu, 19 Dec 2019 08:56:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Amol Grover <frextrite@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH v2] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191219165601.GA2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191203063941.6981-1-frextrite@gmail.com>
 <20191206080750.21745-1-frextrite@gmail.com>
 <20191219092913.76ca933e@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219092913.76ca933e@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:29:13AM -0700, Jonathan Corbet wrote:
> On Fri,  6 Dec 2019 13:37:51 +0530
> Amol Grover <frextrite@gmail.com> wrote:
> 
> > - Add more information about listRCU patterns taking examples
> > from audit subsystem in the linux kernel.
> > 
> > - The initially written audit examples are kept, even though they are
> > slightly different in the kernel.
> > 
> > - Modify inline text for better passage quality.
> > 
> > - Fix typo in code-blocks and improve code comments.
> > 
> > - Add text formatting (italics, bold and code) for better emphasis.
> > 
> > Patch originally submitted at
> > https://lore.kernel.org/patchwork/patch/1082804/
> > 
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> 
> Paul, what's your wish regarding this one?  Do you want to pick it up, or
> should I ... ?

I was waiting for replies agreeing that Amol's changes addressed the
feedback to v1 of this patch.  I take this to mean that you are OK
with his v2, so will queue Amol's patch.  ;-)

							Thanx, Paul
