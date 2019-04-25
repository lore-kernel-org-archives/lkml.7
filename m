Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D4C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6213206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Y4pXbgNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfDYViy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:38:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46583 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDYViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:38:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id w73so679601qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Z2ymsil4t+f8haW3B+fgWDElnPaasnLnhmiu+EuIRsQ=;
        b=Y4pXbgNb4B1XSftJ95HSjtKYIEl/0O/3vzIBqhFqB8ulzCLApDmLM8NlKYfbNhNwYj
         A4++wCITfFcAvuRHFZI3gN1PvIWIdxGKsy56Cxnr6ZCbMokTCZc+ukRetf4g/qnTa3M2
         gOL9jGXPL39JOECWljgbxEKwJWkl6u4F8QFjRhwRRVz+dxm46UZLNhERSU5NbS1aUN7Z
         9eIqFQTWlg5kwaedDjGPrjH6LbktqaG551cDbwT2WFBA9MEwSMH1ZXX6tDCUHVsxNOw1
         3DGqJd1YMij4nnrxvfBpCIBvlBL6kCOj+SuiQN5v17STyZYj/2E0pl6Qh6hRFugzDV3T
         Nmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Z2ymsil4t+f8haW3B+fgWDElnPaasnLnhmiu+EuIRsQ=;
        b=lhEHro5v1Kux/Bqq4YMnXJNA9FHwlpDnm55ntuMVTW0p6iU/mc782YSAHLH/MOkfs1
         JdsZ9nOFIVkUW0KXuwWx+s5jrd27ikta0/WN9nZZ8X4wlkSprghj1a1TyyZ7VxOjt/n6
         LhkTvIewTrZPzwgrrgq34+8K4dWLf4evKHpbD1MZQ0LIBfctrOqpSfO6ki6bPoK3QFpc
         J9YYzc7KTYigt1nwdKQJP6wZ4CYT6WZeDI18m3JWSp2axbN+Q1epTtFU5aLTNp37l4Bc
         2MH4hm5FFILNB0ucY7+HIOUi3lILUWq0KjbQkFDQiLjfDFu4KRkNAbH6qymCtHQeWk2Y
         9qbA==
X-Gm-Message-State: APjAAAUEuXSjcUB+Jw5pGJi9V9JzCSzGSSl0z80oBHJ9ChiyFy966b8V
        f3kycEFeOQ+WyN336Wqu2uXvhA==
X-Google-Smtp-Source: APXvYqzcGdLtE2wPFLZmNlvdD/7x8ZOjZi2v9sEjFzACAIDaVPxBAYCV1YsIYuYPMOr7zrt4ss6DLQ==
X-Received: by 2002:a37:5a46:: with SMTP id o67mr31107616qkb.31.1556228333105;
        Thu, 25 Apr 2019 14:38:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t188sm12430161qkf.81.2019.04.25.14.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:38:52 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:38:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Message-ID: <20190425143847.417033ab@cakuba.netronome.com>
In-Reply-To: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 13:57:03 +0300, Moshe Shemesh wrote:
> Different reporters have different rules in the driver and are being
> created/destroyed during different stages of driver load/unload/running.
> So during execution of a reporter recover the flow can go through
> another reporter's destroy and create. Such flow leads to deadlock
> trying to lock a mutex already held if the flow was triggered by devlink
> recover command.
> To avoid such deadlock, we execute the recover flow from a workqueue.
> Once the recover work is done successfully the reporter health state and
> recover counter are being updated.

Naive question, why not just run the doit unlocked?  Why the async?

> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>

One day we really gotta start documenting the context from which 
things are called and locks called when ops are invoked.. :)

> diff --git a/net/core/devlink.c b/net/core/devlink.c
> index 7b91605..8ee380e 100644
> --- a/net/core/devlink.c
> +++ b/net/core/devlink.c
> @@ -4443,6 +4444,40 @@ struct devlink_health_reporter {
>  	return NULL;
>  }
>  
> +static int
> +devlink_health_reporter_recover(struct devlink_health_reporter *reporter,
> +				void *priv_ctx)
> +{
> +	int err;
> +
> +	if (!reporter->ops->recover)
> +		return -EOPNOTSUPP;
> +
> +	err = reporter->ops->recover(reporter, priv_ctx);
> +	if (err)
> +		return err;
> +
> +	reporter->recovery_count++;
> +	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_HEALTHY;
> +	reporter->last_recovery_ts = jiffies;

Well, the dump looks at these without taking any locks..

> +	trace_devlink_health_reporter_state_update(reporter->devlink,
> +						   reporter->ops->name,
> +						   reporter->health_state);
> +	return 0;
> +}
> +
> +static void
> +devlink_health_reporter_recover_work(struct work_struct *work)
> +{
> +	struct devlink_health_reporter *reporter;
> +
> +	reporter = container_of(work, struct devlink_health_reporter,
> +				recover_work);
> +
> +	devlink_health_reporter_recover(reporter, NULL);
> +}
> +
>  /**
>   *	devlink_health_reporter_create - create devlink health reporter
>   *

> @@ -4483,6 +4518,8 @@ struct devlink_health_reporter *
>  	reporter->devlink = devlink;
>  	reporter->graceful_period = graceful_period;
>  	reporter->auto_recover = auto_recover;
> +	INIT_WORK(&reporter->recover_work,
> +		  devlink_health_reporter_recover_work);
>  	mutex_init(&reporter->dump_lock);
>  	list_add_tail(&reporter->list, &devlink->reporter_list);
>  unlock:
> @@ -4505,6 +4542,7 @@ struct devlink_health_reporter *
>  	mutex_unlock(&reporter->devlink->lock);
>  	if (reporter->dump_fmsg)
>  		devlink_fmsg_free(reporter->dump_fmsg);
> +	cancel_work_sync(&reporter->recover_work);
>  	kfree(reporter);
>  }
>  EXPORT_SYMBOL_GPL(devlink_health_reporter_destroy);
> @@ -4526,26 +4564,6 @@ struct devlink_health_reporter *
>  }
>  EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
>  
> -static int
> -devlink_health_reporter_recover(struct devlink_health_reporter *reporter,
> -				void *priv_ctx)
> -{
> -	int err;
> -
> -	if (!reporter->ops->recover)
> -		return -EOPNOTSUPP;
> -
> -	err = reporter->ops->recover(reporter, priv_ctx);
> -	if (err)
> -		return err;
> -
> -	reporter->recovery_count++;
> -	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_HEALTHY;
> -	reporter->last_recovery_ts = jiffies;
> -
> -	return 0;
> -}
> -
>  static void
>  devlink_health_dump_clear(struct devlink_health_reporter *reporter)
>  {
> @@ -4813,7 +4831,11 @@ static int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
>  	if (!reporter)
>  		return -EINVAL;
>  
> -	return devlink_health_reporter_recover(reporter, NULL);
> +	if (!reporter->ops->recover)
> +		return -EOPNOTSUPP;
> +
> +	queue_work(devlink->reporters_wq, &reporter->recover_work);
> +	return 0;
>  }

So the recover user space request will no longer return the status, and
it will not actually wait for the recover to happen.  Leaving user
pondering - did the recover run and fail, or did it nor get run yet...

>  static int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
> @@ -5234,6 +5256,11 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
>  	INIT_LIST_HEAD(&devlink->param_list);
>  	INIT_LIST_HEAD(&devlink->region_list);
>  	INIT_LIST_HEAD(&devlink->reporter_list);
> +	devlink->reporters_wq = create_singlethread_workqueue("devlink_reporters");

Why is it single threaded?

> +	if (!devlink->reporters_wq) {
> +		kfree(devlink);
> +		return NULL;
> +	}
>  	mutex_init(&devlink->lock);
>  	return devlink;
>  }
> @@ -5278,6 +5305,7 @@ void devlink_unregister(struct devlink *devlink)
>  void devlink_free(struct devlink *devlink)
>  {
>  	mutex_destroy(&devlink->lock);
> +	destroy_workqueue(devlink->reporters_wq);
>  	WARN_ON(!list_empty(&devlink->reporter_list));
>  	WARN_ON(!list_empty(&devlink->region_list));
>  	WARN_ON(!list_empty(&devlink->param_list));

