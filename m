Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3247C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45B221655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576113603;
	bh=2xneQyJ26LjPKcfQUBVtoZqwvkEND8rpRB+N5P9GBjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=sXK4LuVAFckxXYN1FzmoOWsCwFcltr1b0zJKmbC3bXkhYeo1e9eFrz1QAK2zDh1WM
	 T/2DSblcAFEkPabQ+AUCgzRrpPZsK06UF01r5MqIrQc1lF0mgbah1rJbUuHu7I5MbY
	 dFaWDBlsWQ1oC6UgqPl95gIKvfMhw990Hp18NFuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLLBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfLLBUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:20:02 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06904214D8;
        Thu, 12 Dec 2019 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576113601;
        bh=2xneQyJ26LjPKcfQUBVtoZqwvkEND8rpRB+N5P9GBjM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L5fWSRXdjhHTiYZMsMkQ3arn/RcFsM7zwX9vMQbnajx/dd/SnKF02EfuCqBra5/gW
         Nmkrh9iMg3UG4qEBSdANw0+26B0fUK+zAC5gBL9BbsuhoWGn3kaOjnrPgnSduOQnAr
         vNsmPLX1Vlvkjzn0DKmnMl6msJRaMx/HmxtYvnKc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8DCB535203C6; Wed, 11 Dec 2019 17:20:00 -0800 (PST)
Date:   Wed, 11 Dec 2019 17:20:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, stern@rowland.harvard.edu,
        dvyukov@google.com, mark.rutland@arm.com, parri.andrea@gmail.com,
        edumazet@google.com, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/kcsan 1/2] kcsan: Document static blacklisting
 options
Message-ID: <20191212012000.GP2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191212000709.166889-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212000709.166889-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:07:08AM +0100, Marco Elver wrote:
> Updates the section on "Selective analysis", listing all available
> options to blacklist reporting data races for: specific accesses,
> functions, compilation units, and entire directories.
> 
> These options should provide adequate control for maintainers to opt out
> of KCSAN analysis at varying levels of granularity. It is hoped to
> provide the required control to reflect preferences for handling data
> races across the kernel.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Both queued for testing and review, thank you!

							Thanx, Paul

> ---
>  Documentation/dev-tools/kcsan.rst | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index a6f4f92df2fa..65a0be513b7d 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -101,18 +101,28 @@ instrumentation or e.g. DMA accesses.
>  Selective analysis
>  ~~~~~~~~~~~~~~~~~~
>  
> -To disable KCSAN data race detection for an entire subsystem, add to the
> -respective ``Makefile``::
> +It may be desirable to disable data race detection for specific accesses,
> +functions, compilation units, or entire subsystems.  For static blacklisting,
> +the below options are available:
>  
> -    KCSAN_SANITIZE := n
> +* KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
> +  any data races due to accesses in ``expr`` should be ignored and resulting
> +  behaviour when encountering a data race is deemed safe.
> +
> +* Disabling data race detection for entire functions can be accomplished by
> +  using the function attribute ``__no_kcsan`` (or ``__no_kcsan_or_inline`` for
> +  ``__always_inline`` functions). To dynamically control for which functions
> +  data races are reported, see the `debugfs`_ blacklist/whitelist feature.
>  
> -To disable KCSAN on a per-file basis, add to the ``Makefile``::
> +* To disable data race detection for a particular compilation unit, add to the
> +  ``Makefile``::
>  
>      KCSAN_SANITIZE_file.o := n
>  
> -KCSAN also understands the ``data_race(expr)`` annotation, which tells KCSAN
> -that any data races due to accesses in ``expr`` should be ignored and resulting
> -behaviour when encountering a data race is deemed safe.
> +* To disable data race detection for all compilation units listed in a
> +  ``Makefile``, add to the respective ``Makefile``::
> +
> +    KCSAN_SANITIZE := n
>  
>  debugfs
>  ~~~~~~~
> -- 
> 2.24.0.525.g8f36a354ae-goog
> 
