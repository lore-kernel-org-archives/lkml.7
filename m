Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5341C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D062053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8aGvRl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLCIXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:23:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40266 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfLCIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:23:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id 6so2489908oix.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lzt0CorWBSFXLDqsCRfHsqkuwAx1CnMYNM6P0NKIKcg=;
        b=X8aGvRl/4FxkFXiHdu9CRlUaAU3uYajjaW+NP95OAUNSgGL39UHAuxvmuoLrRgIZdC
         VblkUBqHA5VpIze7eZxrD8vI8XsEyYMBwgzRvDTb4RUdASvdeDrbnmbpZsUqtW7VrTRn
         yFWdnWNr1tSJPcCBCB20uKc//wniCL8sqELtxxVPAlOvmPh6wMjvn6lqEjxno7c4FYSW
         6TxeYIjPfcLM80U+n6Ovqve5yEJynlEx3FA4OhvzW6bU+OJhfHZvfZIXILSSt2xNk5Or
         6CIdR+uKaVpCEFD00/IFwjG914LlxaYWV9W0d7/gh1Z1q+Wv9CoVQ5/Y/xyhaRy348FH
         sYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lzt0CorWBSFXLDqsCRfHsqkuwAx1CnMYNM6P0NKIKcg=;
        b=BRrPj4tXt2UqZ60QcWDRSNdaLJvROEdWJdxkvCAyQXKj3n5qqcJKPjlarZWXAHRqb5
         ZBeiNgnxx+ttEhlCivAdiwOqPbSsL1FeEqE8Oh2BzgL9ybNZWm4bsMDZdh7v6dpHyNXf
         jt++NC58m9wVSTF8F+YvX4mQaCQw0wbihOpn0wjjFqlG0JvOZlvbgrZfU2SAYgbarqWh
         kkb0ymL8b9s4n9tiaEm7JR1wV+asYPPbIYRL2cqrAK8KCGb8w8m1F19ONWGpocm4EKE1
         fv1tppLRloYDUrsL4+uUXC43xGooaaV24w7VYRDe2exlp8kMjAWKoxYfIkQ/s4TQEN7t
         AopQ==
X-Gm-Message-State: APjAAAV66WoOcKS9sfhkej0CZrg53jO3uXgqLa7HiIaiWXsoOWqaLe1c
        +7TDhOBKa2U9/6wjEejNVn44Zg==
X-Google-Smtp-Source: APXvYqyE3aD0H99rNZKO8K9i1B0fjDlmhfnLelWJGBsr4nKoE6yuRKq7pJqafIHTqvRyTTfku16z9A==
X-Received: by 2002:aca:dc04:: with SMTP id t4mr2563717oig.51.1575361413760;
        Tue, 03 Dec 2019 00:23:33 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id t61sm843935otb.21.2019.12.03.00.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Dec 2019 00:23:33 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:23:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] tty: serial: msm_serial: Fix deadlock caused by
 recursive output
Message-ID: <20191203082325.GC28241@leoy-ThinkPad-X240s>
References: <20191127141544.4277-1-leo.yan@linaro.org>
 <20191127141544.4277-3-leo.yan@linaro.org>
 <CAOCk7NqZmBYN4tY0_V8xzvBfWShDCP8gTa60Aoc78wK2tXx=6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7NqZmBYN4tY0_V8xzvBfWShDCP8gTa60Aoc78wK2tXx=6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:40:55AM -0700, Jeffrey Hugo wrote:
> On Wed, Nov 27, 2019 at 7:16 AM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The uart driver might run into deadlock caused by recursive output; the
> > basic flow is after uart driver has acquired the port spinlock, then it
> > invokes some functions, e.g. dma engine operations and allocate dma
> > descriptor with kzalloc(), if the system has very less free memory, the
> > kernel will give out warning by printing logs, thus recursive output
> > will happen and at the second time the attempting to acquire lock will
> > cause deadlock.  The detailed flow is shown as below:
> >
> >   msm_uart_irq()
> >     spin_lock_irqsave(&port->lock, flags)  => First time to acquire lock
> >     msm_handle_tx(port)
> >       msm_handle_tx_dma()
> >         dmaengine_prep_slave_single()
> >           bam_prep_slave_sg()
> >             kzalloc()
> >                __kmalloc()
> >                  ___slab_alloc()
> >                    alloc_pages_current()
> >                      __alloc_pages_nodemask()
> >                        warn_alloc()
> >                          printk()
> >                            msm_console_write()
> >                              __msm_console_write()
> >                                spin_lock(&port->lock) => Cause deadlock
> >
> > This patch fixes the deadlock issue for recursive output; it adds a
> > variable 'curr_user' to indicate the uart port is used by which CPU, if
> > the CPU has acquired spinlock and wants to execute recursive output,
> > it will directly bail out.  Here we don't choose to avoid locking and
> > print out log, the reason is in this case we don't want to reset the
> > uart port with function msm_reset_dm_count(); otherwise it can introduce
> > confliction with other flows and results in uart port malfunction and
> > later cannot output anymore.
> 
> Is this not fixable?  Sure, fixing the deadlock is an improvement, but
> dropping logs (particularly a memory warning like in your example)
> seems undesirable.

Thanks a lot for your reviewing, Jeffrey.

Agreed with you for the concern.

To be honest, I am not familiar with the msm uart driver, so have no
confidence which is the best way for uart port operations.  I can
think out one possible fixing is shown in below, if detects the lock
is not acquired then it will force to reset UART port before exit the
function __msm_console_write().

This approach is not tested yet and it looks too arbitrary; I will
give a try for it.  At the meantime, welcome any insight suggestion
with proper register operations.

@@ -1572,6 +1579,7 @@ static inline struct uart_port *msm_get_port_from_line(unsigned int line)
 static void __msm_console_write(struct uart_port *port, const char *s,
                                unsigned int count, bool is_uartdm)
 {
+       struct msm_port *msm_port = UART_TO_MSM(port);
        int i;
        int num_newlines = 0;
        bool replaced = false;
@@ -1593,6 +1601,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
                locked = 0;
        else if (oops_in_progress)
                locked = spin_trylock(&port->lock);
+       else if (cpumask_test_cpu(smp_processor_id(), &msm_port->curr_user))
+               return;
        else
                spin_lock(&port->lock);
 
@@ -1632,6 +1642,9 @@ static void __msm_console_write(struct uart_port *port, const char *s,
                i += num_chars;
        }
 
+       if (!locked && is_uartdm)
+               msm_reset(port);
+
        if (locked)
                spin_unlock(&port->lock);
 }

Thanks,
Leo

> >
> > Fixes: 99693945013a ("tty: serial: msm: Add RX DMA support")
> > Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/tty/serial/msm_serial.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> > index 889538182e83..06076cd2948f 100644
> > --- a/drivers/tty/serial/msm_serial.c
> > +++ b/drivers/tty/serial/msm_serial.c
> > @@ -182,6 +182,7 @@ struct msm_port {
> >         bool                    break_detected;
> >         struct msm_dma          tx_dma;
> >         struct msm_dma          rx_dma;
> > +       struct cpumask          curr_user;
> >  };
> >
> >  #define UART_TO_MSM(uart_port) container_of(uart_port, struct msm_port, uart)
> > @@ -436,6 +437,7 @@ static void msm_complete_tx_dma(void *args)
> >         u32 val;
> >
> >         spin_lock_irqsave(&port->lock, flags);
> > +       cpumask_set_cpu(smp_processor_id(), &msm_port->curr_user);
> >
> >         /* Already stopped */
> >         if (!dma->count)
> > @@ -470,6 +472,7 @@ static void msm_complete_tx_dma(void *args)
> >
> >         msm_handle_tx(port);
> >  done:
> > +       cpumask_clear_cpu(smp_processor_id(), &msm_port->curr_user);
> >         spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >
> > @@ -544,6 +547,7 @@ static void msm_complete_rx_dma(void *args)
> >         u32 val;
> >
> >         spin_lock_irqsave(&port->lock, flags);
> > +       cpumask_set_cpu(smp_processor_id(), &msm_port->curr_user);
> >
> >         /* Already stopped */
> >         if (!dma->count)
> > @@ -590,6 +594,7 @@ static void msm_complete_rx_dma(void *args)
> >
> >         msm_start_rx_dma(msm_port);
> >  done:
> > +       cpumask_clear_cpu(smp_processor_id(), &msm_port->curr_user);
> >         spin_unlock_irqrestore(&port->lock, flags);
> >
> >         if (count)
> > @@ -931,6 +936,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
> >         u32 val;
> >
> >         spin_lock_irqsave(&port->lock, flags);
> > +       cpumask_set_cpu(smp_processor_id(), &msm_port->curr_user);
> >         misr = msm_read(port, UART_MISR);
> >         msm_write(port, 0, UART_IMR); /* disable interrupt */
> >
> > @@ -962,6 +968,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
> >                 msm_handle_delta_cts(port);
> >
> >         msm_write(port, msm_port->imr, UART_IMR); /* restore interrupt */
> > +       cpumask_clear_cpu(smp_processor_id(), &msm_port->curr_user);
> >         spin_unlock_irqrestore(&port->lock, flags);
> >
> >         return IRQ_HANDLED;
> > @@ -1572,6 +1579,7 @@ static inline struct uart_port *msm_get_port_from_line(unsigned int line)
> >  static void __msm_console_write(struct uart_port *port, const char *s,
> >                                 unsigned int count, bool is_uartdm)
> >  {
> > +       struct msm_port *msm_port = UART_TO_MSM(port);
> >         int i;
> >         int num_newlines = 0;
> >         bool replaced = false;
> > @@ -1593,6 +1601,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
> >                 locked = 0;
> >         else if (oops_in_progress)
> >                 locked = spin_trylock(&port->lock);
> > +       else if (cpumask_test_cpu(smp_processor_id(), &msm_port->curr_user))
> > +               return;
> >         else
> >                 spin_lock(&port->lock);
> >
> > --
> > 2.17.1
> >
