Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C18C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B9B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG9dHGRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfCKIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:24:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCKIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:24:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so3392657wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t19P+Q1pISXUKqRN3zUKG2oapktYiJ8GlidvF+eV11I=;
        b=CG9dHGRF5W3ChTBGo/XGK9Lxq/Me5M+MRLrf4mJQEYD9FAusrJI+OTrmP5jHBoydTk
         p8grgN+RSqVHkyhN+IV/3TTQh/ku4nQJ+NpuSjM84rOtbcYnxOhCxW2YTOq9Mz683LKf
         AZhLwvSSG+SKX0y8eGcbDctWVs5NML6SbgX9/f+3nL3q8NxfffHybanh8Qc/u8U0dcKe
         adUgvkKJzS7Tnr+xwTTthrUH676n6+9XaLkfhOTqquMIfFZPribg+DH/WeT/NEm9Z/zS
         UMwGNURN5S1JcDRdBRqvAr8T8Y4q1UGbZymt9DoFKZyXPGdZ66hedw6xkhwY22L29lGI
         th1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t19P+Q1pISXUKqRN3zUKG2oapktYiJ8GlidvF+eV11I=;
        b=ZgFOXhJI7OFMKmTntz+y5/+6ogpkwNwKPBg6fIe/kmeTLtWIpSPWcUnXN1D+gz7nHr
         vKMSY+aLq/x7x/7WsP6J4yunuIUb4mTowbJ/z+3UJz9x/PAV0N4Zsr2wb4SJgOyMzHZV
         zpBN5bQBLYFX7wXUwbYF35e9EGAsSJRWC7c0F99PhYItmIBBCgVVLNVzvbvO1d+UB7su
         TMWtgGAFA6Ks/935yRvqWVfNbUNK32ZOscpx49fGcMtU987HiEY/Fr1avkuhMs23snWP
         v915uAF5fZY/npgkHHmnjtbdMRpOdppQs8jPJwgv5d6y0Y5eiC+NmEljBif4BQlVm6k7
         8AXw==
X-Gm-Message-State: APjAAAUguL2HXMvOXOQpOhLKDOd3ZucPuaUCeu0LVdZDWOT+BPXKPB6U
        CuQnthZ8w69WazUQg/saozNy2270
X-Google-Smtp-Source: APXvYqz2dBQwHQczKnlZbZJBEL+fiawxynMrY73aQWvsgvK6qqiQ20RHcECtRNeRm4NOZFPMoqyRuQ==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr17662637wmb.140.1552292661594;
        Mon, 11 Mar 2019 01:24:21 -0700 (PDT)
Received: from giga-mm ([62.68.22.49])
        by smtp.gmail.com with ESMTPSA id v2sm24882187wme.29.2019.03.11.01.24.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 01:24:21 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:24:20 +0100
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for
 tty_buffer_worker
Message-Id: <20190311092420.7f57b8e4e3420de225213367@gmail.com>
In-Reply-To: <20190110101232.9398-4-o.rempel@pengutronix.de>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
        <20190110101232.9398-4-o.rempel@pengutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksij,

On Thu, 10 Jan 2019 11:12:32 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> sched_priority = 1 is enough to dramatically reduce latency
> on have system load produced by tasks with default user space prio.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  drivers/tty/tty_buffer.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 18bd7f48a319..7cf42f6570a0 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -13,11 +13,13 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> +#include <linux/sched/rt.h>
>  #include <linux/wait.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/ratelimit.h>
> +#include <uapi/linux/sched/types.h>
>  
>  
>  #define MIN_TTYB_SIZE	256
> @@ -567,7 +569,15 @@ bool tty_buffer_queue_work(struct tty_port *port)
>  
>  void tty_buffer_init_kthread(void)
>  {
> -	kthread_run(kthread_worker_fn, &tty_buffer_worker, "tty");
> +	struct sched_param param = { .sched_priority = 1 };
> +	struct task_struct *kworker_task;
> +
> +	kworker_task = kthread_run(kthread_worker_fn, &tty_buffer_worker, "tty");
> +	if (IS_ERR(kworker_task)) {
> +		pr_err("failed to create message pump task\n");
> +		return;
> +	}
> +	sched_setscheduler(kworker_task, SCHED_FIFO, &param);
>  }
>  
>  /**


-- 
Alexander Sverdlin.
