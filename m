Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AE120896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="laLhDnUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406349AbfFLQ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:58:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44782 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFLQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:58:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so4254315plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=doqps207aklzkNibx2UK5NKzROKOwbdrRNXX9K06a2Q=;
        b=laLhDnUqvPldP4l7pwnBihK5mFKAUspRzjC9g/q0HGyrpWWoAn8QwJQmxqt4MCk/oh
         sciRwmt5rECIWaT3Y3Lbo7Mk6e+jRArhPlCGew580dHewuTBPaVhyq+jKVyM8fXpjgCo
         VJ6iuclaEUHNEN4eOt+fvT6v748IQUGQBoR1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=doqps207aklzkNibx2UK5NKzROKOwbdrRNXX9K06a2Q=;
        b=VWd5MSrro3rsv5AUz3vhIhXkxPAnWdkWOnd7lZ4c9wesAO8LGc64bq63kylX81oWCd
         lczRjmc8d/L/VJKGR1Qe4iY43FLaeBGtyTM37RZSrTuIFl/Fn61nOn/bQeV9FiN0iYx/
         RZdCB8V70l1cmvmdwgn6hGfwdGINLtTnt5RF6BztOPKZN+bWK0jvM/DlUDUmOHf0xn0I
         LXKIOLV0Um8YdyiEXXyBqXRQlUnWXH7YeOEMj1N0Z9+m9fzx0Y8OnHjXjqKEwH2mA01H
         4jF2QiVnVHWWb+gZ8oigwfDx6kJBEl3jTfCX7qRCbjR3JfYRwBpECHxg0vK9omeU7grw
         wGug==
X-Gm-Message-State: APjAAAUkARV7QiU31nALYjs5Nl6C0svYWGGxBmO/xU4oHVn8YthkFrs1
        Qdodn/UksErHsuWhGRwj398sJg==
X-Google-Smtp-Source: APXvYqyDoEmjcNQETcV3AVat+B3LhPFOuxNrMM0JKQ26W5X9oBkBDGaODzn6125KV+rx1xI53Ou8jQ==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr30746039plb.158.1560358702023;
        Wed, 12 Jun 2019 09:58:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k3sm23156pju.27.2019.06.12.09.58.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 09:58:21 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:58:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Zhong Jiang <zhongjiang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: debugobjects: no need to check return value of
 debugfs_create functions
Message-ID: <20190612165819.GA123863@google.com>
References: <20190612153513.GA21082@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612153513.GA21082@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:35:13PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Qian Cai <cai@gmx.us>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Cc: Zhong Jiang <zhongjiang@huawei.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  lib/debugobjects.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 55437fd5128b..2ac42286cd08 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -850,26 +850,16 @@ static const struct file_operations debug_stats_fops = {
>  
>  static int __init debug_objects_init_debugfs(void)
>  {
> -	struct dentry *dbgdir, *dbgstats;
> +	struct dentry *dbgdir;
>  
>  	if (!debug_objects_enabled)
>  		return 0;
>  
>  	dbgdir = debugfs_create_dir("debug_objects", NULL);
> -	if (!dbgdir)
> -		return -ENOMEM;
>  
> -	dbgstats = debugfs_create_file("stats", 0444, dbgdir, NULL,
> -				       &debug_stats_fops);
> -	if (!dbgstats)
> -		goto err;
> +	debugfs_create_file("stats", 0444, dbgdir, NULL, &debug_stats_fops);


One weirdness is, if dbgdir is ever NULL, then debugfs_create_file() may end
up creating the stats file in the root.

In debugfs_create_file():
        /* If the parent is not specified, we create it in the root.
         * We need the root dentry to do this, which is in the super
         * block. A pointer to that is in the struct vfsmount that we
         * have around.
         */
        if (!parent)
                parent = debugfs_mount->mnt_root;

But I guess that's not a major issue since its debugfs :-) So LGTM,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

>  
>  	return 0;
> -
> -err:
> -	debugfs_remove(dbgdir);
> -
> -	return -ENOMEM;
>  }
>  __initcall(debug_objects_init_debugfs);
>  
> -- 
> 2.22.0
> 
