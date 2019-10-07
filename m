Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D968BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABA22070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRzjKtXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGKku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:40:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfJGKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:40:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so11740949wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hlqn0Qia24Xv7B5txaeOBUpq8YG1iSw7nB1lyh2UV8E=;
        b=HRzjKtXaBi5os6pzxPm2NShM16nO0rw+HM7y5Lr8co/MeeiYnY2hXh+W298mSPHHN2
         m4GbY0sI94ScQKub7pGOjqCmr3nQ+tijk3Zu/3QUtPLZSGC6M0IZ/IqlxZ12ND5ljlGH
         N63aPHpuO5ewSyFuen1nEEfGQfNjinFJNx4TylA7LDbLZGTfggIG8RK8ayVnU5xXp5Lp
         MVMrRgbTjghitzYOTXUvL1khVP0m1Lf7k0ItL6FLoaotbTiJX233hclt/UouVyfOnjf+
         jjqVzZ2qK37prV2i5KgPVA9NdlL++8RKgzuDHf3G2UgWUAdOoztpRgtuFCzG0BNTYd5I
         lAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hlqn0Qia24Xv7B5txaeOBUpq8YG1iSw7nB1lyh2UV8E=;
        b=fnvamQq8Ks+BDaTH8t3gCWsZffCjSSW35tUOmUrnAUVfy+DPaOQw8SG2QYmsSMnKTx
         CZ+RrXgFqBi+1MER2M+V8bPmwkMGcXocHaby6T572xQ+E0y5LXa/fhjHILOSrhe0gOLd
         GWQTmLdeBswVnpQCu+uhbNtcjIKA2RAMOXBpIeQbcRdeMgNBgdeooyyLJJXPof834CKz
         y3WnzNbr7dIN6FwffzoKsmWt/rb8bQq94w7AxjRAYbcpJJxgWgELZSpRlG2usWsDzMuT
         qU0wu9VFgJWv/1wowd+Ln1WwjexNliP2FdUPuY53NppFTwoTgog11gAN6fm90rKRLmGb
         uXxA==
X-Gm-Message-State: APjAAAVI6A3Uskr4/C85L4Lf+I2jIC8D6VissD4vnD2s/pCWRhRxW0CM
        Wd+irvOyNAApemONxBoLTnk=
X-Google-Smtp-Source: APXvYqxNoSFnMD+ayHxZlRnNTOAQN2hrZ+nABipStiiTnwsibrbploCGkIGz1wT+rWa2XgDK02v/fw==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr19618654wmj.57.1570444847085;
        Mon, 07 Oct 2019 03:40:47 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1012:69a4:816:a2c:e717])
        by smtp.gmail.com with ESMTPSA id z142sm40291608wmc.24.2019.10.07.03.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 03:40:46 -0700 (PDT)
Date:   Mon, 7 Oct 2019 12:40:39 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     bsingharora@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] taskstats: fix data-race
Message-ID: <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
References: <20191005112806.13960-1-christian.brauner@ubuntu.com>
 <20191006235216.7483-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006235216.7483-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Mon, Oct 07, 2019 at 01:52:16AM +0200, Christian Brauner wrote:
> When assiging and testing taskstats in taskstats_exit() there's a race
> when writing and reading sig->stats when a thread-group with more than
> one thread exits:
> 
> cpu0:
> thread catches fatal signal and whole thread-group gets taken down
>  do_exit()
>  do_group_exit()
>  taskstats_exit()
>  taskstats_tgid_alloc()
> The tasks reads sig->stats holding sighand lock seeing garbage.
> 
> cpu1:
> task calls exit_group()
>  do_exit()
>  do_group_exit()
>  taskstats_exit()
>  taskstats_tgid_alloc()
> The task takes sighand lock and assigns new stats to sig->stats.
> 
> Fix this by using READ_ONCE() and smp_store_release().
> 
> Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

FYI, checkpatch.pl says:

WARNING: memory barrier without comment
#62: FILE: kernel/taskstats.c:568:
+		smp_store_release(&sig->stats, stats_new);

Maybe you can make checkpatch.pl happy  ;-) and add a comment to stress
the 'pairing' between this barrier and the added READ_ONCE() (as Dmitry
was alluding to in a previous post)?

Thanks,
  Andrea


> ---
> /* v1 */
> Link: https://lore.kernel.org/r/20191005112806.13960-1-christian.brauner@ubuntu.com
> 
> /* v2 */
> - Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>:
>   - fix the original double-checked locking using memory barriers
> ---
>  kernel/taskstats.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 13a0f2e6ebc2..8ee046e8a792 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -554,24 +554,25 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
>  {
>  	struct signal_struct *sig = tsk->signal;
> -	struct taskstats *stats;
> +	struct taskstats *stats_new, *stats;
>  
> -	if (sig->stats || thread_group_empty(tsk))
> -		goto ret;
> +	stats = READ_ONCE(sig->stats);
> +	if (stats || thread_group_empty(tsk))
> +		return stats;
>  
>  	/* No problem if kmem_cache_zalloc() fails */
> -	stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> +	stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
>  
>  	spin_lock_irq(&tsk->sighand->siglock);
>  	if (!sig->stats) {
> -		sig->stats = stats;
> -		stats = NULL;
> +		smp_store_release(&sig->stats, stats_new);




> +		stats_new = NULL;
>  	}
>  	spin_unlock_irq(&tsk->sighand->siglock);
>  
> -	if (stats)
> -		kmem_cache_free(taskstats_cache, stats);
> -ret:
> +	if (stats_new)
> +		kmem_cache_free(taskstats_cache, stats_new);
> +
>  	return sig->stats;
>  }
>  
> -- 
> 2.23.0
> 
