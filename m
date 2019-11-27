Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8383BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53128206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCxbHt3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfK0OQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:16:48 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45722 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfK0OQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:16:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id i3so9004547ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7g3g9npAzkK8xZ5a4hvEUAgGO4Fs0nsH32bKzdrbRA=;
        b=KCxbHt3EBBOVhGaQx6fFPLHK6Biu+/hbggYWU0ZelReZ4qFl2zY+9n1pry0+68I4H6
         n3IwhRL0QgpF+HAaM+l+ucUa8Al8amR9u2kThc/MNsVDkI+nlrrvEL9kFS4403k4JZ23
         ko5vh+cBkxhe3KsZi/8kPK9lNXHBwH/0ln7iuScWn5s5PcoIErYtk6xhDNlbsp4Hln23
         x4zJ+0Kgc1YMuaeZNWXk1MITps1xs2DAg/CRdNzpWGxGhe2TiDeJs68hMCAnR6golVCo
         gaEi9C5qRKkf4V5s9fA7itbYyLrZEn+R2pAQcSJRWKcsWj4XaADUNaDly+IPhPOK7yqm
         NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7g3g9npAzkK8xZ5a4hvEUAgGO4Fs0nsH32bKzdrbRA=;
        b=TCxvmtTg0bjjN6Culf3cP6hw7odUJ6PhAW21NOkgkmwp47ezPr8BNba8UC0CuvuIui
         PAQaOksMOKHauUXdCI4Jw1bwZ70QzanakgIvbKJ8dziVjn4CKbuerDFHE7aVYo/D60n5
         A8Se46A5VOb9XNRihVfzPuYS8ux4JwRzzHvEqbCWgtG71OI1vMn3nboK4+LLSIfaxOt6
         w7vd8sZB4HrtgQvqQjcavr3ScSnb3SiTHi0dYnVd0p/WxOODRU4qNEp2ZBH2VYV74spG
         NyTD3ZskAhdXhYp50EsjKZ7cL0dsX/WyqnpuWGK3YjHGXEJxfyg5GLdPwfuy+G2qjIF6
         +9aw==
X-Gm-Message-State: APjAAAX8e6pbz2z7V4kmTWkL3/rDLS90QBODT7pmyzppnG2XDuuX96Op
        81r5HnWtLd4FGPJ+WbU1gyih/w==
X-Google-Smtp-Source: APXvYqyp+DI+3dLoV9OTv6LSfs6SDahLwSNCVjYK8HVguVy1LLv4GQjdpvE3/Fx3MG4Ca6qpUDbizw==
X-Received: by 2002:a25:3848:: with SMTP id f69mr32588371yba.498.1574864205023;
        Wed, 27 Nov 2019 06:16:45 -0800 (PST)
Received: from localhost.localdomain (li2093-158.members.linode.com. [172.105.159.158])
        by smtp.gmail.com with ESMTPSA id u123sm6911115ywd.105.2019.11.27.06.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 06:16:44 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/2] tty: serial: msm_serial: Fix deadlock caused by recursive output
Date:   Wed, 27 Nov 2019 22:15:44 +0800
Message-Id: <20191127141544.4277-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127141544.4277-1-leo.yan@linaro.org>
References: <20191127141544.4277-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uart driver might run into deadlock caused by recursive output; the
basic flow is after uart driver has acquired the port spinlock, then it
invokes some functions, e.g. dma engine operations and allocate dma
descriptor with kzalloc(), if the system has very less free memory, the
kernel will give out warning by printing logs, thus recursive output
will happen and at the second time the attempting to acquire lock will
cause deadlock.  The detailed flow is shown as below:

  msm_uart_irq()
    spin_lock_irqsave(&port->lock, flags)  => First time to acquire lock
    msm_handle_tx(port)
      msm_handle_tx_dma()
        dmaengine_prep_slave_single()
          bam_prep_slave_sg()
            kzalloc()
               __kmalloc()
                 ___slab_alloc()
                   alloc_pages_current()
                     __alloc_pages_nodemask()
                       warn_alloc()
                         printk()
                           msm_console_write()
                             __msm_console_write()
                               spin_lock(&port->lock) => Cause deadlock

This patch fixes the deadlock issue for recursive output; it adds a
variable 'curr_user' to indicate the uart port is used by which CPU, if
the CPU has acquired spinlock and wants to execute recursive output,
it will directly bail out.  Here we don't choose to avoid locking and
print out log, the reason is in this case we don't want to reset the
uart port with function msm_reset_dm_count(); otherwise it can introduce
confliction with other flows and results in uart port malfunction and
later cannot output anymore.

Fixes: 99693945013a ("tty: serial: msm: Add RX DMA support")
Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 889538182e83..06076cd2948f 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -182,6 +182,7 @@ struct msm_port {
 	bool			break_detected;
 	struct msm_dma		tx_dma;
 	struct msm_dma		rx_dma;
+	struct cpumask		curr_user;
 };
 
 #define UART_TO_MSM(uart_port)	container_of(uart_port, struct msm_port, uart)
@@ -436,6 +437,7 @@ static void msm_complete_tx_dma(void *args)
 	u32 val;
 
 	spin_lock_irqsave(&port->lock, flags);
+	cpumask_set_cpu(smp_processor_id(), &msm_port->curr_user);
 
 	/* Already stopped */
 	if (!dma->count)
@@ -470,6 +472,7 @@ static void msm_complete_tx_dma(void *args)
 
 	msm_handle_tx(port);
 done:
+	cpumask_clear_cpu(smp_processor_id(), &msm_port->curr_user);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -544,6 +547,7 @@ static void msm_complete_rx_dma(void *args)
 	u32 val;
 
 	spin_lock_irqsave(&port->lock, flags);
+	cpumask_set_cpu(smp_processor_id(), &msm_port->curr_user);
 
 	/* Already stopped */
 	if (!dma->count)
@@ -590,6 +594,7 @@ static void msm_complete_rx_dma(void *args)
 
 	msm_start_rx_dma(msm_port);
 done:
+	cpumask_clear_cpu(smp_processor_id(), &msm_port->curr_user);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (count)
@@ -931,6 +936,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	u32 val;
 
 	spin_lock_irqsave(&port->lock, flags);
+	cpumask_set_cpu(smp_processor_id(), &msm_port->curr_user);
 	misr = msm_read(port, UART_MISR);
 	msm_write(port, 0, UART_IMR); /* disable interrupt */
 
@@ -962,6 +968,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 		msm_handle_delta_cts(port);
 
 	msm_write(port, msm_port->imr, UART_IMR); /* restore interrupt */
+	cpumask_clear_cpu(smp_processor_id(), &msm_port->curr_user);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_HANDLED;
@@ -1572,6 +1579,7 @@ static inline struct uart_port *msm_get_port_from_line(unsigned int line)
 static void __msm_console_write(struct uart_port *port, const char *s,
 				unsigned int count, bool is_uartdm)
 {
+	struct msm_port *msm_port = UART_TO_MSM(port);
 	int i;
 	int num_newlines = 0;
 	bool replaced = false;
@@ -1593,6 +1601,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 		locked = 0;
 	else if (oops_in_progress)
 		locked = spin_trylock(&port->lock);
+	else if (cpumask_test_cpu(smp_processor_id(), &msm_port->curr_user))
+		return;
 	else
 		spin_lock(&port->lock);
 
-- 
2.17.1

