Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C6AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A686217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfJNNCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:02:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbfJNNCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC1ACBAC1;
        Mon, 14 Oct 2019 13:02:48 +0000 (UTC)
Date:   Mon, 14 Oct 2019 15:02:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] printf: add support for printing symbolic error
 names
Message-ID: <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011133617.9963-2-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-10-11 15:36:17, Rasmus Villemoes wrote:
> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This
> implements that as a %p extension: With %pe, one can do

Reviewed-by: Petr Mladek <pmladek@suse.com>

I like the patch. There are only two rather cosmetic things.

> diff --git a/lib/errname.c b/lib/errname.c
> new file mode 100644
> index 000000000000..30d3bab99477
> --- /dev/null
> +++ b/lib/errname.c
> +const char *errname(int err)
> +{
> +	bool pos = err > 0;
> +	const char *name = __errname(err > 0 ? err : -err);
> +
> +	return name ? name + pos : NULL;

This made me to check C standard. It seems that "true" really has
to be "1".

But I think that I am not the only one who is not sure.
I would prefer to make it less tricky and use, for example:

	const char *name = __errname(err > 0 ? err : -err);
	if (!name)
		return NULL;

	return err > 0 ? name + 1 : name;

> +}
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 5d94cbff2120..4fa0ccf58420 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -593,6 +593,29 @@ flags(void)
>  	kfree(cmp_buffer);
>  }
>  
> +static void __init
> +errptr(void)
> +{
> +	char buf[PLAIN_BUF_SIZE];
> +
> +	test("-1234", "%pe", ERR_PTR(-1234));
> +
> +	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
> +	BUILD_BUG_ON(IS_ERR(PTR));
> +	snprintf(buf, sizeof(buf), "(%p)", PTR);
> +	test(buf, "(%pe)", PTR);

There is a small race. "(____ptrval____)" is used for %p before
random numbers are initialized. The switch is done via workqueue
work, see enable_ptr_key_workfn(). It means that it can be done
in parallel.

I doubt that anyone would ever hit the race. But it could be very confusing
and hard to debug. I would replace it with:

	test_hashed("%pe", PTR);


If would like to have the two things fixed. I am not sure if you want
to send one more revision. Or I could also change it by follow
up patch when pushing. What is your preference, please?

Best Regards,
Petr
