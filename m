Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA330CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A0620873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UNEfoqJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfJUMTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:19:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46946 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbfJUMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:19:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so9885202lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JNOM4Pg0n8Q4UqLt3Kh0p/niTCV+End7za47n4/6Ktg=;
        b=UNEfoqJSjHmG0+iNd+CHQt8KffLkhlNrReI8ER0SN3uGr4sAv282oSQFllCK1GufFa
         zhyeCzPVuEfYjLiYUz65wwf4KY0lcSxLiBZfhClN0nM4F+d1yXzwkBXnW56H1nx2orKR
         9lHhBafiS+qfKOKzY/Sz5Y0Vu8kmm9SZea1bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JNOM4Pg0n8Q4UqLt3Kh0p/niTCV+End7za47n4/6Ktg=;
        b=UZgxaZBEwZSrAjLRldUsMuO7SeENfr7hQaBKpFIlO+MMdEHXdSXX9Lgo86AUfW8Fkr
         DT4VtBlmKmEJVantqj6pLwS5MnE37wwpl+Axsh/uyOKML6ILycPh8SFRPal4DsKHYbQS
         gV0QexcMJag5LDdjoFXQ3ANyPBjjpcw8wPDVxXms/0qseQEdOtWhDUWDhZz4K89WsyBt
         suBOIvENxiAQpRru7AGswMteqsQLF17FbIfEEV8PYTM4whAaReAwJ+qTwOdICTGI4SSk
         8YawV++SqB63WOGItgUmXvQi2Lw7+7al4qO5Ds6Zp2nCCsIvs+zbU6h2RqDsO2CgF1sX
         shxQ==
X-Gm-Message-State: APjAAAVbK5gYZfQnX4VNPq6Xw2OtdqeMkZh+n0knh+RzTnTgMmihzADZ
        U8L3IFYofeJUlqCmcRPjrO0N1Q==
X-Google-Smtp-Source: APXvYqwt2eM1kZ85F15jYxbBeCLzCU2TXQeJLonX186jbNS9UUkduoKUyAQHXJVB71RH+jbnqv8GOQ==
X-Received: by 2002:ac2:484e:: with SMTP id 14mr8022102lfy.184.1571660343384;
        Mon, 21 Oct 2019 05:19:03 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r19sm6810718ljd.95.2019.10.21.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 05:19:02 -0700 (PDT)
Subject: Re: [PATCH v6] taskstats: fix data-race
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     bsingharora@gmail.com, dvyukov@google.com, elver@google.com,
        parri.andrea@gmail.com, stable@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <efaecf5d-b528-24ba-1955-e1b190ece98c@rasmusvillemoes.dk>
Date:   Mon, 21 Oct 2019 14:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021113327.22365-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2019 13.33, Christian Brauner wrote:
> The first approach used smp_load_acquire() and smp_store_release().
> However, after having discussed this it seems that the data dependency
> for kmem_cache_alloc() would be fixed by WRITE_ONCE().
> Furthermore, the smp_load_acquire() would only manage to order the stats
> check before the thread_group_empty() check. So it seems just using
> READ_ONCE() and WRITE_ONCE() will do the job and I wanted to bring this
> up for discussion at least.
> 
> /* v6 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - bring up READ_ONCE()/WRITE_ONCE() approach for discussion
> ---
>  kernel/taskstats.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 13a0f2e6ebc2..111bb4139aa2 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -554,25 +554,29 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
>  {
>  	struct signal_struct *sig = tsk->signal;
> -	struct taskstats *stats;
> +	struct taskstats *stats_new, *stats;
>  
> -	if (sig->stats || thread_group_empty(tsk))
> -		goto ret;
> +	/* Pairs with WRITE_ONCE() below. */
> +	stats = READ_ONCE(sig->stats);
> +	if (stats || thread_group_empty(tsk))
> +		return stats;
>  
>  	/* No problem if kmem_cache_zalloc() fails */
> -	stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> +	stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
>  
>  	spin_lock_irq(&tsk->sighand->siglock);
> -	if (!sig->stats) {
> -		sig->stats = stats;
> -		stats = NULL;
> +	if (!stats) {
> +		stats = stats_new;
> +		/* Pairs with READ_ONCE() above. */
> +		WRITE_ONCE(sig->stats, stats_new);
> +		stats_new = NULL;

No idea about the memory ordering issues, but don't you need to
load/check sig->stats again? Otherwise it seems that two threads might
both see !sig->stats, both allocate a stats_new, and both
unconditionally in turn assign their stats_new to sig->stats. Then the
first assignment ends up becoming a memory leak (and any writes through
that pointer done by the caller end up in /dev/null...)

Rasmus
