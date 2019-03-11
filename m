Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46908C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0918920643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAas790h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfCKIXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:23:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41556 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCKIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:23:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2so3975211wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pc1heY3mOjPU3BPmKt4DA0+vAstFl0OjDWuaP+LoJzA=;
        b=qAas790hOFrPmLhtq74TL5kD0HbOST6wxWwvh8Z/PfJTqC7uCt5p9MF7zyt7A8qiL+
         Ra2F5NdzEAgsgUJ32+y/r7d8oEx6aMpVH1DNLApRpbR8W3cQbp4BAxfuiW6eWggKr0HZ
         e92eK1V/ZsPO+kRIikDIcWB36YmFdEKdAxnS3x0vnu3VOpwK1dlyEf1rbQ7/LYy9tRQ1
         ve0uu4iPIMYl/CHroNdv1RhzRZ5o/JRANwwitLTtfUzIPEkTuECRGTKUrskBvpGT2Vxv
         z4I83I5QgMACnBg3+GrhxTF7py/oPGnqa4I4yPzeuaMdJDhLGwIVV1DhT4TdQxev5tnF
         gjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pc1heY3mOjPU3BPmKt4DA0+vAstFl0OjDWuaP+LoJzA=;
        b=Cc+JQs6XECIxo4NGiauuY8uLI0LeMr7Bfy/F2IVy+Zg3/8XvgCVeM/PJU7H88REqCW
         1ilbMr0KjwxQh7OKryu4yDeoJZ955WbYDU8TMg75Mp5HsqEuJji8vfW8yzAw+T4xspav
         /weF57x5IJJLlaqaJMBOaKRFPctBhP4BQDWp9Abk1zcaIWwlQRAChzHR2lchFS/jA/7+
         ehnTrpp/F2plFZ0MU76DrBpMhKgAKg+ilqb7N7DZtIGRD42KEIEWmY5CMF0yBJTmK15A
         9/31Ymk/mp1/TOrdhJfKRy2gn7GDnEkjy14XGbEbrCathucoxtjondfWNAmL1v/GF7fr
         NNWg==
X-Gm-Message-State: APjAAAUzovakmvh3YT0iALU2IiOZq86jxkMy5GmoWiEkAWSsytDKLs16
        sQ5Yb2Ftv2xa9Ux2jP8ZRF8=
X-Google-Smtp-Source: APXvYqwfp/H9US2hx5DfZEzhExmsH+E2aJSQW6skPaIcr0K3uh3mKpxfuYRoa6K0eHf7cq7Nr+6zJg==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr18572931wrr.329.1552292594960;
        Mon, 11 Mar 2019 01:23:14 -0700 (PDT)
Received: from giga-mm ([62.68.22.49])
        by smtp.gmail.com with ESMTPSA id c15sm5370986wrv.69.2019.03.11.01.23.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 01:23:14 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:23:13 +0100
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers/tty: convert tty_port to use
 kthread_worker
Message-Id: <20190311092313.ebf38daafe4e5b0a6fcb838f@gmail.com>
In-Reply-To: <20190110101232.9398-3-o.rempel@pengutronix.de>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
        <20190110101232.9398-3-o.rempel@pengutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksij,

On Thu, 10 Jan 2019 11:12:31 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> From: Steven Walter <stevenrwalter@gmail.com>
> 
> Use kthread_worker instead of workqueues.  For now there is only a
> single workqueue, but the intention is to bring back the "low_latency"
> tty option, along with a second high-priority kthread worker.
> 
> Even without a second worker this patch allows to give a higher priority
> to tty processing by modifying the priority of the corresponding
> kthread.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

In general I agree with Linus, that a thread with some random
priority is suboptimal, and we actually should move this
work into the context of the receiving thread, to properly
inherit its priority. But this would be quite amount of rework.

In the meanwhile this patch series restores the "low_latency"
tty option. Thanks for your efforts!

> ---
>  drivers/tty/tty_buffer.c | 21 ++++++++++++++-------
>  drivers/tty/tty_io.c     |  1 +
>  include/linux/tty.h      |  7 ++++---
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index e0090e65d83a..18bd7f48a319 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/types.h>
> +#include <linux/kthread.h>
>  #include <linux/errno.h>
>  #include <linux/tty.h>
>  #include <linux/tty_driver.h>
> @@ -497,7 +498,7 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
>   *		 'consumer'
>   */
>  
> -static void flush_to_ldisc(struct work_struct *work)
> +static void flush_to_ldisc(struct kthread_work *work)
>  {
>  	struct tty_port *port = container_of(work, struct tty_port, buf.work);
>  	struct tty_bufhead *buf = &port->buf;
> @@ -557,10 +558,16 @@ void tty_flip_buffer_push(struct tty_port *port)
>  }
>  EXPORT_SYMBOL(tty_flip_buffer_push);
>  
> +static DEFINE_KTHREAD_WORKER(tty_buffer_worker);
> +
>  bool tty_buffer_queue_work(struct tty_port *port)
>  {
> -	struct tty_bufhead *buf = &port->buf;
> -	return schedule_work(&buf->work);
> +	return kthread_queue_work(&tty_buffer_worker, &port->buf.work);
> +}
> +
> +void tty_buffer_init_kthread(void)
> +{
> +	kthread_run(kthread_worker_fn, &tty_buffer_worker, "tty");
>  }
>  
>  /**
> @@ -582,7 +589,7 @@ void tty_buffer_init(struct tty_port *port)
>  	init_llist_head(&buf->free);
>  	atomic_set(&buf->mem_used, 0);
>  	atomic_set(&buf->priority, 0);
> -	INIT_WORK(&buf->work, flush_to_ldisc);
> +	kthread_init_work(&buf->work, flush_to_ldisc);
>  	buf->mem_limit = TTYB_DEFAULT_MEM_LIMIT;
>  }
>  
> @@ -614,12 +621,12 @@ bool tty_buffer_restart_work(struct tty_port *port)
>  	return tty_buffer_queue_work(port);
>  }
>  
> -bool tty_buffer_cancel_work(struct tty_port *port)
> +void tty_buffer_cancel_work(struct tty_port *port)
>  {
> -	return cancel_work_sync(&port->buf.work);
> +	tty_buffer_flush_work(port);
>  }
>  
>  void tty_buffer_flush_work(struct tty_port *port)
>  {
> -	flush_work(&port->buf.work);
> +	kthread_flush_work(&port->buf.work);
>  }
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index bfe9ad85b362..5fd7cecbe4e7 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3476,6 +3476,7 @@ void console_sysfs_notify(void)
>   */
>  int __init tty_init(void)
>  {
> +	tty_buffer_init_kthread();
>  	cdev_init(&tty_cdev, &tty_fops);
>  	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
>  	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 226a9eff0766..924c1093967e 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -3,9 +3,9 @@
>  #define _LINUX_TTY_H
>  
>  #include <linux/fs.h>
> +#include <linux/kthread.h>
>  #include <linux/major.h>
>  #include <linux/termios.h>
> -#include <linux/workqueue.h>
>  #include <linux/tty_driver.h>
>  #include <linux/tty_ldisc.h>
>  #include <linux/mutex.h>
> @@ -84,7 +84,7 @@ static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
>  
>  struct tty_bufhead {
>  	struct tty_buffer *head;	/* Queue head */
> -	struct work_struct work;
> +	struct kthread_work work;
>  	struct mutex	   lock;
>  	atomic_t	   priority;
>  	struct tty_buffer sentinel;
> @@ -510,8 +510,9 @@ extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
>  extern bool tty_buffer_queue_work(struct tty_port *port);
>  extern void tty_buffer_init(struct tty_port *port);
>  extern void tty_buffer_set_lock_subclass(struct tty_port *port);
> +extern void tty_buffer_init_kthread(void);
>  extern bool tty_buffer_restart_work(struct tty_port *port);
> -extern bool tty_buffer_cancel_work(struct tty_port *port);
> +extern void tty_buffer_cancel_work(struct tty_port *port);
>  extern void tty_buffer_flush_work(struct tty_port *port);
>  extern speed_t tty_termios_baud_rate(struct ktermios *termios);
>  extern speed_t tty_termios_input_baud_rate(struct ktermios *termios);


-- 
Alexander Sverdlin.
