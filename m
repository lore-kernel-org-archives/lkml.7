Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478DC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6A222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570304140;
	bh=N2IGytc2o4ufvvnPDZG2PtjqoSMvf+gv69vkoEiVA88=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=D5GcavRlIHfHqGHXhNrQpvA8Bo+2n5yMigbNumTEywmuQGBpuJDlSfNKW5FVVQ6hi
	 UwSc0kCHDavj6Nkz7cxDPEFdtx2dTB4RBNn+YplsPabqD+LnkLDNiexP3LNc9SPzhy
	 IiY/isDYw1ayL9wIB8DFMAizyYOxlzp9oGgw8wto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfJETff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfJETff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 15:35:35 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B48222BE;
        Sat,  5 Oct 2019 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570304134;
        bh=N2IGytc2o4ufvvnPDZG2PtjqoSMvf+gv69vkoEiVA88=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=czj5hSPTOGjg+uzNMcwu5L2tOZvDxeNia0zNVpAuDgsXGXstWhXaPSHBuejTPGVeG
         9aWMov28pcCxLa5YUzAENj2e2f4EFB4V7HHeLDhXbJxuvJXgsT5wEXZx5nqi4VuE++
         1wdsN9yMuuQruMJrvpRVXAk0Wu/pFlkcb8wcgEGI=
Date:   Sat, 5 Oct 2019 12:35:33 -0700
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
Message-ID: <20191005193533.GO2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191004215402.28008-1-j.neuschaefer@gmx.net>
 <20191004222439.GR2689@paulmck-ThinkPad-P72>
 <20191004232328.GC19803@latitude>
 <20191005133330.GX2689@paulmck-ThinkPad-P72>
 <20191005193123.GD19803@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191005193123.GD19803@latitude>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 09:31:23PM +0200, Jonathan Neuschäfer wrote:
> On Sat, Oct 05, 2019 at 06:33:30AM -0700, Paul E. McKenney wrote:
> > On Sat, Oct 05, 2019 at 01:23:28AM +0200, Jonathan Neuschäfer wrote:
> > > On Fri, Oct 04, 2019 at 03:24:39PM -0700, Paul E. McKenney wrote:
> > > > On Fri, Oct 04, 2019 at 11:54:02PM +0200, Jonathan Neuschäfer wrote:
> > > > > Without this patch, Sphinx shows "variable arguments" as the description
> > > > > of the cond argument, rather than the intended description, and prints
> > > > > the following warnings:
> > > > > 
> > > > > ./include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
> > > > > ./include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
> > > 
> > > Hmm, small detail that I didn't realize before: It's actually the
> > > kernel-doc script, not Sphinx, that can't deal with variadic macro
> > > arguments and thus requires this patch.
> > > 
> > > So it may also be possible to fix the script instead. (I have not
> > > looked into how much work that would be.)
> > 
> > OK, thank you for letting me know.  I will keep your patch for the
> > moment, but please let me know if the fix can be elsewhere.
> > 
> > 							Thanx, Paul
> 
> Turns out the actual fix in scripts/kernel-doc is easy enough:
> 
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1449,6 +1449,10 @@ sub push_parameter($$$$) {
>  	      # handles unnamed variable parameters
>  	      $param = "...";
>  	    }
> +	    elsif ($param =~ /\w\.\.\.$/) {
> +	      # for named variable parameters of the form `x...`, remove the dots
> +	      $param =~ s/\.\.\.$//;
> +	    }
>  	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq "") {
>  		$parameterdescs{$param} = "variable arguments";
>  	    }
> 
> ... but there are other macros in the code base that are documented
> using the 'x...' syntax, so I guess it's best to take my initial patch
> (or something similar) now, and I'll fix kernel-doc later, in a longer
> patchset that also cleans up the fallout.

You got it!  ;-)

							Thanx, Paul
