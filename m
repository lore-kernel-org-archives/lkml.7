Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680ABC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ADE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EsXmEMrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfG3E0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:26:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38323 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfG3E0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:26:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so20523832pgu.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+uAEwHCS/q5YqbTZfM9UhcffVFTLKHWKlvMKu9AlaN4=;
        b=EsXmEMrAKLXYhP9zY31O+/h2ZdkuRU0uxUsvt12z/dYH/onDFgVEw8/psz+asNdBYU
         nFXBcaiag1L68Tv6zpHm7dfIu0NIX/b28PPUvE9EqMHFn//8WEUWABDEeEqYk5Fghedc
         pEQppssDC1/AlpgweEINkqIDwRAPLQbsEmQA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+uAEwHCS/q5YqbTZfM9UhcffVFTLKHWKlvMKu9AlaN4=;
        b=SMn4Ns2StDV6UVNneNmLfoyNTGcVL75TUKaZxS+fiYzOk0RjPmdzoteoAjnnR1OGQl
         HHuSDU6bcdPgki+Fq0ZHGJl5leSl2tzGSw4LAolRkWalwBtAra7JxijOzMJVsMYv9bWL
         KNYQcA4tUDduC49hrsIZMOG+UTlOO6So3UrChhYxXLsPrDtJ9QBbAcWRezWYOUb4BPgr
         xzHmIdsGBkbNDNorYwBBu8W0kaAO+9dMvnmwbA/es2L6yTzumyYVexJJJmbklVSYIZ7N
         DSf8LZUkKDeQpz5uzbq5/DERyXRg2xinJZ6/iYHxkQp4yWYpoqCXK8sq9YK6cCEpZiic
         m4IQ==
X-Gm-Message-State: APjAAAWGW8tj1fxtdQbLQVeKTRQhrvdMsrMq3EfS0o9qPfzrOrR8apar
        MyBuSauqKEKmuhTzpzA2OtnzbQ==
X-Google-Smtp-Source: APXvYqw2DLcYsS+Y/kRsFOifnzk248iODzBuup35eBpVU/fNRfatgN+BuHFV6EhGR/gtK8Sdcr0WOg==
X-Received: by 2002:a62:174a:: with SMTP id 71mr41180815pfx.140.1564460781249;
        Mon, 29 Jul 2019 21:26:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w22sm67693578pfi.175.2019.07.29.21.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:26:20 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:26:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
Message-ID: <201907292117.DA40CA7D@keescook>
References: <20190729151346.9280-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729151346.9280-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.

Wait, stop. :) After Laura called my attention to your conversion series,
mpe pointed out that str_has_prefix() is almost redundant to strstarts()
(from 2009), and the latter has many more users. Let's fix strstarts()
match str_has_prefix()'s return behavior (all the existing callers are
doing boolean tests, so the change in return value won't matter), and
then we can continue with this replacement. (And add some documentation
to Documenation/process/deprecated.rst along with a checkpatch.pl test
maybe too?)

Actually I'd focus first on the actually broken cases first (sizeof()
without the "-1", etc):

$ git grep strncmp.*sizeof | grep -v -- '-' | wc -l
17

I expect the "copy/paste" changes could just be a Coccinelle script that
Linus could run to fix all the cases (and should be added to the kernel
source's list of Coccinelle scripts). Especially since the bulk of the
usage pattern are doing literals like this:

arch/alpha/kernel/setup.c:   if (strncmp(p, "mem=", 4) == 0) {

$ git grep -E 'strncmp.*(sizeof|, *[0-9]*)' | wc -l
2565

And some cases are weirdly backwards:

tools/perf/util/callchain.c:  if (!strncmp(tok, "none", strlen(tok))) {

-Kees

> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  kernel/cgroup/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
> index ae042c347c64..fd12a227f8e4 100644
> --- a/kernel/cgroup/rdma.c
> +++ b/kernel/cgroup/rdma.c
> @@ -379,7 +379,7 @@ static int parse_resource(char *c, int *intval)
>  			return -EINVAL;
>  		return i;
>  	}
> -	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
> +	if (str_has_prefix(value, RDMACG_MAX_STR)) {
>  		*intval = S32_MAX;
>  		return i;
>  	}
> -- 
> 2.20.1
> 

-- 
Kees Cook
