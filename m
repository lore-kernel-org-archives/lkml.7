Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C27FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05052213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfDAIfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:35:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:53302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfDAIfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:35:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7894AF1E;
        Mon,  1 Apr 2019 08:34:59 +0000 (UTC)
Message-ID: <1554107689.6310.17.camel@suse.com>
Subject: Re: [RESEND PATCH V3 1/3] USB: serial: f81232: clear overrun flag
From:   Oliver Neukum <oneukum@suse.com>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 01 Apr 2019 10:34:49 +0200
In-Reply-To: <1554098453-31278-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554098453-31278-1-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-04-01 at 14:00 +0800,  Ji-Ze Hong (Peter Hong)  wrote:

Hi,
I am afraid there is a race condiion in this code.


> @@ -315,6 +318,7 @@ static void f81232_process_read_urb(struct urb *urb)
>  
>  			if (lsr & UART_LSR_OE) {
>  				port->icount.overrun++;
> +				schedule_work(&priv->lsr_work);

Unconditionally scheduled

>  				tty_insert_flip_char(&port->port, 0,
>  						TTY_OVERRUN);
>  			}

[..] 
> +static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
> +{
> +	struct f81232_private *port_priv;
> +
> +	port_priv = usb_get_serial_port_data(serial->port[0]);
> +	flush_work(&port_priv->lsr_work);
> +
> +	return 0;
> +}
> +
>  static struct usb_serial_driver f81232_device = {
>  	.driver = {
>  		.owner =	THIS_MODULE,
> @@ -655,6 +688,7 @@ static struct usb_serial_driver f81232_device = {
>  	.read_int_callback =	f81232_read_int_callback,
>  	.port_probe =		f81232_port_probe,
>  	.port_remove =		f81232_port_remove,
> +	.suspend =		f81232_suspend,

Please have a look at:
int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
{
        struct usb_serial *serial = usb_get_intfdata(intf);
        int i, r = 0;


        serial->suspending = 1;


        /*
         * serial->type->suspend() MUST return 0 in system sleep context,
         * otherwise, the resume callback has to recover device from
         * previous suspend failure.
         */
        if (serial->type->suspend) {
                r = serial->type->suspend(serial, message);
                if (r < 0) {
                        serial->suspending = 0;
                        goto err_out;
                }
        }


        for (i = 0; i < serial->num_ports; ++i)
                usb_serial_port_poison_urbs(serial->port[i]);
err_out:
        return r;
}
EXPORT_SYMBOL(usb_serial_suspend);

As you can see, the suspend method is called first and then the URBs
are poisoned. That means that after you have flushed the work, it may
be submitted again. The fix would be to test the 'suspending' flag
before you schedule work (and recheck the need to schedule it
during resume)

	Regards
		Oliver

