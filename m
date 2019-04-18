Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A43C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738042087F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555627249;
	bh=YxHaJ+QZW/DEQVe9hRwt+at2rvp/ryoBPlAmgbd1TuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DXA7UFB4xRzaB6WGNGpvbFkXyAFCICTAKgUWGIM6WlG2QWtG08cR89LtAL840vHN4
	 fSOR5HQ8+jcbaqKjwuX08SS6VA1hxybZin0svJRUOS87nXbqEDeyvg14t0xnad7yMr
	 MxHBD3Lp/mMz+UjBJJBmpBnyv32v0X1cGauK0RNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfDRWks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:40:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDRWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:40:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2FC519E1;
        Thu, 18 Apr 2019 22:40:46 +0000 (UTC)
Date:   Thu, 18 Apr 2019 15:40:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
Message-Id: <20190418154045.2ad0bd50e73a6e71c0fac768@linux-foundation.org>
In-Reply-To: <20190417131531.9525-1-mcroce@redhat.com>
References: <20190417131531.9525-1-mcroce@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 15:15:31 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
> 
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
> 
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
> 
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
>     245
> 
> This patch adds three const variables for the most commonly used values,
> and use them instead of creating a local one for every object file.
> 
> ...
>
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -220,15 +220,13 @@ appldata_timer_handler(struct ctl_table *ctl, int write,
>  			   void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int timer_active = appldata_timer_active;
> -	int zero = 0;
> -	int one = 1;
>  	int rc;
>  	struct ctl_table ctl_entry = {
>  		.procname	= ctl->procname,
>  		.data		= &timer_active,
>  		.maxlen		= sizeof(int),
> -		.extra1		= &zero,
> -		.extra2		= &one,
> +		.extra1		= (void *)&sysctl_zero,
> +		.extra2		= (void *)&sysctl_one,
>  	};

Still not liking the casts :(

Did we decide whether making extra1&2 const void*'s was feasible?

I'm wondering if it would be better to do

extern const int sysctl_zero;
/* comment goes here */
#define SYSCTL_ZERO ((void *)&sysctl_zero)

and then use SYSCTL_ZERO everywhere.  That centralizes the ugliness and
makes it easier to switch over if/when extra1&2 are constified.

But it's all a bit sad and lame :( 
