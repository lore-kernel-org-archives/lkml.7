Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD56C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225220883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfDBMiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:38:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDBMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:38:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC509AE80;
        Tue,  2 Apr 2019 12:38:07 +0000 (UTC)
Message-ID: <1554208674.6310.33.camel@suse.com>
Subject: Re: [PATCH V4 1/3] USB: serial: f81232: clear overrun flag
From:   Oliver Neukum <oneukum@suse.com>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 02 Apr 2019 14:37:54 +0200
In-Reply-To: <1554182797-12815-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554182797-12815-1-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2019-04-02 at 13:26 +0800,  Ji-Ze Hong (Peter Hong)  wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when overrun and flush the worker on close() &
> suspend().

Hi,

I really hate doing this to you, but you are exchanging one race
condition for another race. Exact explanation below.

> @@ -315,6 +319,7 @@ static void f81232_process_read_urb(struct urb *urb)
>  
>  			if (lsr & UART_LSR_OE) {
>  				port->icount.overrun++;
> +				schedule_work(&priv->lsr_work);

Again you schedule the work. It may run anytime.
The check you put into the work item needs to go here.
 
> +static void f81232_lsr_worker(struct work_struct *work)
> +{
> +	struct f81232_private *priv;
> +	struct usb_serial_port *port;
> +	struct usb_serial *serial;
> +	int status;
> +	u8 tmp;
> +
> +	priv = container_of(work, struct f81232_private, lsr_work);
> +	port = priv->port;
> +	serial = port->serial;
> +
> +	if (serial->suspending) {

There is no locking. f81232_resume() can run here.
This test
if (port_priv->lsr_work_resched) {
will evaluate to false

> +		priv->lsr_work_resched = true;
> +		return;
> +	}
> +
> +	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
> +	if (status)
> +		dev_warn(&port->dev, "read LSR failed: %d\n", status);
> +}
> +
>  static int f81232_port_probe(struct usb_serial_port *port)
>  {
>  	struct f81232_private *priv;
> @@ -613,6 +643,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
>  
>  	mutex_init(&priv->lock);
>  	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
> +	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
>  
>  	usb_set_serial_port_data(port, priv);
>  
> @@ -632,6 +663,30 @@ static int f81232_port_remove(struct usb_serial_port *port)
>  	return 0;
>  }
>  
> +static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
> +{
> +	struct f81232_private *port_priv;
> +
> +	port_priv = usb_get_serial_port_data(serial->port[0]);
> +	flush_work(&port_priv->lsr_work);

Strictly speaking useless.

> +
> +	return 0;
> +}
> +
> +static int f81232_resume(struct usb_serial *serial)
> +{
> +	struct f81232_private *port_priv;
> +
> +	port_priv = usb_get_serial_port_data(serial->port[0]);
> +
> +	if (port_priv->lsr_work_resched) {
> +		port_priv->lsr_work_resched = false;

Strictly speaking even that is a race, as you have no guarantee that
your work queue is run before the system is suspended again. You
are in a task context. There is no reason to defer action.

> +		schedule_work(&port_priv->lsr_work);
> +	}
> +
> +	return usb_serial_generic_resume(serial);
> +}

	Regards
		Oliver

