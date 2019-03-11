Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E012075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtxvR2mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCKIRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:17:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38978 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:17:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id z84so3284594wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7rfsXeTGnmu0wmQA7+37iHI9cfFYSdM46ow32yeWUI=;
        b=BtxvR2mnOgRYtC2htq2dOrk5xdbfQ9BTo/Sh+CwaKDKQbaVhEplQPJ4/MYJsQkhEaV
         rfUMCKXFM+1zV2XWYQ0UMEbmvE7gEQt9QCitxPH0Xm56bHRmKiy6qVUvXSUncimzZiWr
         OlH6rczIiBZOyEHMI8+whoz0lKkACCenb3hjqMVMadXOwlpVYYkfytfKYmvEKvk11Rd8
         AxvCtyhgTXkpzjEz4G81O2M5c62ReCtEa/0GnZXf/uxpTmBxfSifcI8X4a9wPawMvAsq
         kboZuzxzWFlXoDEeAOOmjQ0tls5l1XF8AROSPEQGC0EqNP4mODb5pPDJW+uZZZZV0kY2
         zi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7rfsXeTGnmu0wmQA7+37iHI9cfFYSdM46ow32yeWUI=;
        b=Q6Y5IsilLKaKpwfWIuF58Y7f6TmB5O/BWCmjU6mvBirdbpNdq1cs9O6r6ABT/jgB1h
         6i53f7uWEfjnGUKQwB9b+cTxQ8iwDkQgWuwf8LXRCU0yV6iNzuNDOZXanbxBVmHCBQGZ
         mm5EehMrj77nNwjWNVdsbJNWcxg6F315BkGYWTuR+Pus3/r19E+eBW7i8Ai8X4vyD8yl
         uNWyWSJ4KpnJUrYz2Yf+eeOwV3J2EEikskj+wddGiqCvJIdp7pW5ecdGb3gyo0Sti+1Y
         vJ+kfPXkH9son6KA5Yy0Fv7Hj3fd9hIETYlZiIsJOVW8o9IcDP5SVKe3Dx6eDAKtspUY
         iY4g==
X-Gm-Message-State: APjAAAVjHH1db22yWWUyM+Z5YM0YaZEeJgQ0aaTLhbkyW4Mit7C7jEgm
        Q01Hu4MMZAb8RApQ8q8YBbw=
X-Google-Smtp-Source: APXvYqxhpO7MtOQRuW+rx9QNXGTF8Xorie9Oke2++Yr6fv3BiyTlvs2HFE8sO1ELVMgiKKB0m0cPGQ==
X-Received: by 2002:a1c:64c1:: with SMTP id y184mr16304578wmb.0.1552292221397;
        Mon, 11 Mar 2019 01:17:01 -0700 (PDT)
Received: from giga-mm ([62.68.22.49])
        by smtp.gmail.com with ESMTPSA id h13sm8351294wrt.89.2019.03.11.01.17.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 01:17:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:16:59 +0100
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drivers/tty: refactor functions for
 flushing/queuing work
Message-Id: <20190311091659.c9acd07eab2f5d19c3e00369@gmail.com>
In-Reply-To: <20190110101232.9398-2-o.rempel@pengutronix.de>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
        <20190110101232.9398-2-o.rempel@pengutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksij,

On Thu, 10 Jan 2019 11:12:30 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> From: Steven Walter <stevenrwalter@gmail.com>
> 
> Preparation for converting to kthread_worker
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  drivers/tty/tty_buffer.c | 12 +++++++++---
>  include/linux/tty.h      |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 77070c2d1240..e0090e65d83a 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -72,7 +72,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
>  	atomic_dec(&buf->priority);
>  	mutex_unlock(&buf->lock);
>  	if (restart)
> -		queue_work(system_unbound_wq, &buf->work);
> +		tty_buffer_queue_work(port);
>  }
>  EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
>  
> @@ -410,7 +410,7 @@ void tty_schedule_flip(struct tty_port *port)
>  	 * flush_to_ldisc() sees buffer data.
>  	 */
>  	smp_store_release(&buf->tail->commit, buf->tail->used);
> -	queue_work(system_unbound_wq, &buf->work);
> +	tty_buffer_queue_work(port);
>  }
>  EXPORT_SYMBOL(tty_schedule_flip);
>  
> @@ -557,6 +557,12 @@ void tty_flip_buffer_push(struct tty_port *port)
>  }
>  EXPORT_SYMBOL(tty_flip_buffer_push);
>  
> +bool tty_buffer_queue_work(struct tty_port *port)
> +{
> +	struct tty_bufhead *buf = &port->buf;
> +	return schedule_work(&buf->work);
> +}
> +
>  /**
>   *	tty_buffer_init		-	prepare a tty buffer structure
>   *	@tty: tty to initialise
> @@ -605,7 +611,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
>  
>  bool tty_buffer_restart_work(struct tty_port *port)
>  {
> -	return queue_work(system_unbound_wq, &port->buf.work);
> +	return tty_buffer_queue_work(port);
>  }
>  
>  bool tty_buffer_cancel_work(struct tty_port *port)
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index bfa4e2ee94a9..226a9eff0766 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -507,6 +507,7 @@ extern void session_clear_tty(struct pid *session);
>  extern void no_tty(void);
>  extern void tty_buffer_free_all(struct tty_port *port);
>  extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
> +extern bool tty_buffer_queue_work(struct tty_port *port);
>  extern void tty_buffer_init(struct tty_port *port);
>  extern void tty_buffer_set_lock_subclass(struct tty_port *port);
>  extern bool tty_buffer_restart_work(struct tty_port *port);


-- 
Alexander Sverdlin.
