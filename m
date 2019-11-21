Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6494C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75213208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5mfgtqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKUEM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 23:12:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41676 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUEM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 23:12:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id 207so892554pge.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 20:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kP2wggYyMK9//uGeO+OrprwkC14o85isnyjfCuB8bk8=;
        b=L5mfgtqzQKkH1DybloeEYuTP5c6VICzluWnLCN4IaAZfFfme0kZCK724NmmPcAKECy
         XJ5kCClp1FXFbrX1552Bxd/01IjOuuxDOF2CDfgWiMuBrErhzJzd03+xtkavIr9yydkY
         P99hfYv0/f5TshZvfjhoyj97aVtJPpINI7mXE5H7io9DmrlEGH75n3TdY6p2332rvO/1
         H9FsqCnyPJn3tkfdDn2LpflOoFZktQQLkOQW16WGZlFK9HY+DIQlFCqHLLnK2LzwbH5r
         GbmqATrc7dB8axOR/Pu2zCMguH1+ycWNPGckw+dof/kmHyhdB4lD5nWf2ljfUr9Pb8l+
         ePGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kP2wggYyMK9//uGeO+OrprwkC14o85isnyjfCuB8bk8=;
        b=hr8qwrUhVB5d/hK9mMlsRO1jpqjWOVodZv6vWkqR16VRB2c2GB+x3vydGQcPckb0rl
         61tKiFRi9pXrJ2fKPln1Ox92HuTV+3fKYHYutESTJ6j35YOHlgogLslfywLBnrDaAVz/
         7fo37TZ3BeUzT5zPyXF0Ys4uS5VwrtuikxAlzO97yLt+9GF4ppzW1Cbiw8hFxHOvvM4M
         IrioDfZa0bgfEpthHTKMPml2UjPhOY2c5L99kAytUVghLqKdAlupcSt/7AoZN+HL69b1
         KSUApSvmYqSfr7DpWBS4vHAwL11b1Ie/4Lmb91uQo1Z1RaXJrU+/XCpjv1GmnV3Ld4XR
         ajBQ==
X-Gm-Message-State: APjAAAVQz4jZp5az3525MuWcqwZIVaIgM+ik0qakVybPOLSf515oAWNx
        ZxY9N2K2XgHodJ5SQsQ0ZtuyWg==
X-Google-Smtp-Source: APXvYqzgua6bBhAXdpmKoP4zl8CWweoXw5ADuOFp0N76HMNT1wqMLEeFqSqiD3ZBrh8QOIK4+AUHUg==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr7289785pgj.453.1574309545267;
        Wed, 20 Nov 2019 20:12:25 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id y26sm1036291pfo.76.2019.11.20.20.12.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 20:12:24 -0800 (PST)
Date:   Wed, 20 Nov 2019 20:12:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: Don't WARN if page is still mapped in
 remove_stable_node()
In-Reply-To: <20191119131850.5675-1-aryabinin@virtuozzo.com>
Message-ID: <alpine.LSU.2.11.1911202007550.1733@eggly.anvils>
References: <20191119131850.5675-1-aryabinin@virtuozzo.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Andrey Ryabinin wrote:

> It's possible to hit the WARN_ON_ONCE(page_mapped(page)) in
> remove_stable_node() when it races with __mmput() and squeezes
> in between ksm_exit() and exit_mmap().
> 
>  WARNING: CPU: 0 PID: 3295 at mm/ksm.c:888 remove_stable_node+0x10c/0x150
> 
>  Call Trace:
>   remove_all_stable_nodes+0x12b/0x330
>   run_store+0x4ef/0x7b0
>   kernfs_fop_write+0x200/0x420
>   vfs_write+0x154/0x450
>   ksys_write+0xf9/0x1d0
>   do_syscall_64+0x99/0x510
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Remove the warning as there is nothing scary going on.
> 
> Fixes: cbf86cfe04a6 ("ksm: remove old stable nodes more thoroughly")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Thanks -
Acked-by: Hugh Dickins <hughd@google.com>

> Cc: <stable@vger.kernel.org>

For removing a WARN_ON_ONCE? No, I don't think this needs to go to
stable; but I won't resist if Andrew or autobot insist otherwise.

> ---
>  mm/ksm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbee2eb4dd05..7905934cd3ad 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -885,13 +885,13 @@ static int remove_stable_node(struct stable_node *stable_node)
>  		return 0;
>  	}
>  
> -	if (WARN_ON_ONCE(page_mapped(page))) {
> -		/*
> -		 * This should not happen: but if it does, just refuse to let
> -		 * merge_across_nodes be switched - there is no need to panic.
> -		 */
> -		err = -EBUSY;
> -	} else {
> +	/*
> +	 * Page could be still mapped if this races with __mmput() running in
> +	 * between ksm_exit() and exit_mmap(). Just refuse to let
> +	 * merge_across_nodes/max_page_sharing be switched.

Good comment, thank you.

> +	 */
> +	err = -EBUSY;
> +	if (!page_mapped(page)) {
>  		/*
>  		 * The stable node did not yet appear stale to get_ksm_page(),
>  		 * since that allows for an unmapped ksm page to be recognized
> -- 
> 2.23.0
