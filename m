Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E18EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF232187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573136874;
	bh=x0tD8QPg5+9rNj9eiZasj+95TTki8u7csrKsOWaOvR8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AQtCPxu5IR5up5ri1ZKhNPsiCt0+yttFlNJRfQfKyD2jBhGkYEtuMREXHevFpEYyt
	 y4UoVorEmWHADIzjGp12Y6G/qyWCUYBtCK1ArPbFznwjgRGXJZtCX/6vIZUDewk8mB
	 xWWrTGQAGGCMAMr0IiEmBTbNBDJbpVHtk38gBLCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbfKGO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:27:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGO1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:27:53 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.209.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78EB1207FA;
        Thu,  7 Nov 2019 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573136871;
        bh=x0tD8QPg5+9rNj9eiZasj+95TTki8u7csrKsOWaOvR8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ePEqbXEg0stzokyxq8cdFAe7G5ANj+pk90tvrO3MiRQ6pi6YJoabhrAApy3bfwRdy
         LCClauPRA9NqrjDuJcR4+sdaJkQNkVa4ifgntq9EHm8bl6u4+W/xkc1Nfz7XotP2w1
         frfy4yE0ZB07wgiiUlVIrKUgX2m4eLGkKJqpfy/4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DE07D35227FC; Thu,  7 Nov 2019 06:27:48 -0800 (PST)
Date:   Thu, 7 Nov 2019 06:27:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: Add support for named variable macro
 arguments
Message-ID: <20191107142748.GN20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191107134133.14690-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107134133.14690-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:41:33PM +0100, Jonathan Neuschäfer wrote:
> Currently, when kernel-doc encounters a macro with a named variable
> argument[1], such as this:
> 
>    #define hlist_for_each_entry_rcu(pos, head, member, cond...)
> 
> ... it expects the variable argument to be documented as `cond...`,
> rather than `cond`. This is semantically wrong, because the name (as
> used in the macro body) is actually `cond`.
> 
> With this patch, kernel-doc will accept the name without dots (`cond`
> in the example above) in doc comments, and warn if the name with dots
> (`cond...`) is used and verbose mode[2] is enabled.
> 
> The support for the `cond...` syntax can be removed later, when the
> documentation of all such macros has been switched to the new syntax.
> 
> Testing this patch on top of v5.4-rc6, `make htmldocs` shows a few
> changes in log output and HTML output:
> 
>  1) The following warnings[3] are eliminated:
> 
>    ./include/linux/rculist.h:374: warning:
>         Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
>    ./include/linux/rculist.h:651: warning:
>         Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
> 
>  2) For list_for_each_entry_rcu and hlist_for_each_entry_rcu, the
>     correct description is shown
> 
>  3) Named variable arguments are shown without dots
> 
> 
> [1]: https://gcc.gnu.org/onlinedocs/cpp/Variadic-Macros.html
> [2]: scripts/kernel-doc -v
> [3]: See also https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=5bc4bc0d6153617eabde275285b7b5a8137fdf3c
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Cc: Paul E. McKenney <paulmck@kernel.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  scripts/kernel-doc | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 81dc91760b23..48696391eccb 100755
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
> @@ -1936,6 +1940,18 @@ sub process_name($$) {
>  sub process_body($$) {
>      my $file = shift;
> 
> +    # Until all named variable macro parameters are
> +    # documented using the bare name (`x`) rather than with
> +    # dots (`x...`), strip the dots:
> +    if ($section =~ /\w\.\.\.$/) {
> +	$section =~ s/\.\.\.$//;
> +
> +	if ($verbose) {
> +	    print STDERR "${file}:$.: warning: Variable macro arguments should be documented without dots\n";
> +	    ++$warnings;
> +	}
> +    }
> +
>      if (/$doc_sect/i) { # case insensitive for supported section names
>  	$newsection = $1;
>  	$newcontents = $2;
> --
> 2.20.1
> 
