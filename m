Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570CCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2939B20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfDCIAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:00:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfDCIAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:00:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBDDAADA3;
        Wed,  3 Apr 2019 08:00:08 +0000 (UTC)
Message-ID: <1554278395.20869.5.camel@suse.com>
Subject: Re: [PATCH V5 1/3] USB: serial: f81232: clear overrun flag
From:   Oliver Neukum <oneukum@suse.com>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Wed, 03 Apr 2019 09:59:55 +0200
In-Reply-To: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2019-04-03 at 14:26 +0800,  Ji-Ze Hong (Peter Hong)  wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when overrun and flush the worker on close() &
> suspend().

Hi,

I am most sorry to complain again. Please forgive me for being less
clear than necessary.

> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> v5:
> 	1: Source code base revert to v3 and remove all v4 changes.
> 	2: Add serial->suspending check in f81232_process_read_urb()
> 	   before schedule_work(&priv->lsr_work) to avoid race condition.
> 
> v4:
> 	1: Add serial->suspending check in f81232_lsr_worker() to avoid
> 	   re-trigger
> 	2: Add port_priv-lsr_work_resched to re-trigger LSR worker
> 
> v3:
> 	1: Add flush_work(&port_priv->lsr_work) in f81232_suspend().
> 
> v2:
> 	1: Add flush_work(&port_priv->lsr_work) in f81232_close().
> 
>  drivers/usb/serial/f81232.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 0dcdcb4b2cde..d8a0bb7a41f0 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -41,12 +41,14 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  #define FIFO_CONTROL_REGISTER		(0x02 + SERIAL_BASE_ADDRESS)
>  #define LINE_CONTROL_REGISTER		(0x03 + SERIAL_BASE_ADDRESS)
>  #define MODEM_CONTROL_REGISTER		(0x04 + SERIAL_BASE_ADDRESS)
> +#define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
>  #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
>  
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
>  	u8 modem_status;

Here you need a flag

bool deferred_lsr_work_needed;
> +	struct work_struct lsr_work;
>  	struct work_struct interrupt_work;
>  	struct usb_serial_port *port;
>  };
> @@ -282,6 +284,8 @@ static void f81232_read_int_callback(struct urb *urb)
>  static void f81232_process_read_urb(struct urb *urb)
>  {
>  	struct usb_serial_port *port = urb->context;
> +	struct usb_serial *serial = port->serial;
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
>  	unsigned char *data = urb->transfer_buffer;
>  	char tty_flag;
>  	unsigned int i;
> @@ -315,6 +319,9 @@ static void f81232_process_read_urb(struct urb *urb)
>  
>  			if (lsr & UART_LSR_OE) {
>  				port->icount.overrun++;
> +
> +				if (!serial->suspending)
> +					schedule_work(&priv->lsr_work);
Yes, but you cannot just drop it. You also need

else
	priv->deferred_lsr_work_needed = true;
>  				tty_insert_flip_char(&port->port, 0,
>  						TTY_OVERRUN);
>  			}
> @@ -556,9 +563,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
>  
>  static void f81232_close(struct usb_serial_port *port)
>  {
> +	struct f81232_private *port_priv = usb_get_serial_port_data(port);
> +
>  	f81232_port_disable(port);
>  	usb_serial_generic_close(port);
>  	usb_kill_urb(port->interrupt_in_urb);
> +	flush_work(&port_priv->lsr_work);
>  }
>  
>  static void f81232_dtr_rts(struct usb_serial_port *port, int on)
> @@ -603,6 +613,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
>  	f81232_read_msr(priv->port);
>  }
>  
> +static void f81232_lsr_worker(struct work_struct *work)
> +{
> +	struct f81232_private *priv;
> +	struct usb_serial_port *port;
> +	int status;
> +	u8 tmp;
> +
> +	priv = container_of(work, struct f81232_private, lsr_work);
> +	port = priv->port;
> +
> +	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
> +	if (status)
> +		dev_warn(&port->dev, "read LSR failed: %d\n", status);
> +}
> +
>  static int f81232_port_probe(struct usb_serial_port *port)
>  {
>  	struct f81232_private *priv;
> @@ -613,6 +638,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
>  
>  	mutex_init(&priv->lock);
>  	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
> +	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
>  
>  	usb_set_serial_port_data(port, priv);
>  
> @@ -632,6 +658,16 @@ static int f81232_port_remove(struct usb_serial_port *port)
>  	return 0;
>  }
>  
> +static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
> +{
> +	struct f81232_private *port_priv;
> +
> +	port_priv = usb_get_serial_port_data(serial->port[0]);
> +	flush_work(&port_priv->lsr_work);
> +
> +	return 0;
> +}

And you do need a resume, which you had in version v4 to check
the  deferred_lsr_work_needed flag and schedule the work if it is
set.

	Most sorry
		Oliver

