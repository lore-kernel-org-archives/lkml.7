Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5798C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59C42084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhqpuxI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfDAJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:01:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42948 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfDAJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:01:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so4414715pgh.9;
        Mon, 01 Apr 2019 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zRrI2gVcSPBOrRDl3Z3EFWOVjgSWQsnIxpjQ7VgJeec=;
        b=jhqpuxI2W57TdZ98GoyXXh67S0yptz5ctASjZ/w9uNesNn1PUIscT5i4wClAi0MMrx
         W2qrtWF8K7u0miclnNJjYFns4YAHSaeyv+dKP2t3CMcLykRZMyD7uB86FKV7dD5iQwJF
         IZvmDdND7Pwgj2kKgi6jPxY8N4FCI9irQnvG8s3++DviXBdxHPP3NrOBRw+HaewJZHvH
         DILcUwMEN8BbL8oHcYHEhFfDCygacbzR+9NDNVSUhNuwn89AkEWZNb1mzyRPWrxMgb1z
         mJh+oAjDLn3MlUolxL1FEurQ6z/kQn0kyMpOzF6sMV3eiAcLjyyffx4S9dglxXylJmOe
         2hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zRrI2gVcSPBOrRDl3Z3EFWOVjgSWQsnIxpjQ7VgJeec=;
        b=gWe+r9TqddKuPAvpdcTuoM9VUesuv6qN3hR5f7xpchJKmq82R3dt9fK0OfwJwogi46
         u7DhtPi5Ph9G7eLZOPG1bq/DRdqsYP63iIqG8D/clcCgdOISTSN4WrVl7QL4UeOWwfP1
         +VJ9sqBoqfShXKN1JhJQrJFzOPN9+ONr+LVa+OD33AHFBD7Z0m5bjoL5uisKWGs5bUzZ
         6mrnLo9zBEVdcKxLzYHAgtkEPU8IrD81o2RwzlIJGrFDc9zaPSH/Taz9XEL8a2wGIjyJ
         yg9/z0XM12iPgQmRSvK3dnAx8GRmEmXMfzBq0Um6AmpTClgShZoJWFGXegQQ5ZLspH6F
         L0yg==
X-Gm-Message-State: APjAAAWkWhQ0nbISq7b+xyWZ6s4vQkAqRTEPMBuFS783quBoK9DOG6W/
        F9E0YjMLYmWpkX6a8pJqatfydGJK
X-Google-Smtp-Source: APXvYqyItjWSMA88QzJlCTMvXrMJGWzJ8KSBdndHWLMzEpDJ4oIsQt3vEdcDbmu3YPn3hDngceBOvg==
X-Received: by 2002:aa7:8615:: with SMTP id p21mr37410708pfn.98.1554109291698;
        Mon, 01 Apr 2019 02:01:31 -0700 (PDT)
Received: from [192.168.1.58] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id i3sm12825414pfa.90.2019.04.01.02.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 02:01:30 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 1/3] USB: serial: f81232: clear overrun flag
To:     Oliver Neukum <oneukum@suse.com>, peter_hong@fintek.com.tw,
        johan@kernel.org, gregkh@linuxfoundation.org
Cc:     "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1554098453-31278-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1554107689.6310.17.camel@suse.com>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <fa56bb5b-8945-29f1-8516-58ce0c8ebd39@gmail.com>
Date:   Mon, 1 Apr 2019 17:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554107689.6310.17.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum 於 2019/4/1 下午 04:34 寫道:
> On Mo, 2019-04-01 at 14:00 +0800,  Ji-Ze Hong (Peter Hong)  wrote:
> 
> Hi,
> I am afraid there is a race condiion in this code.
> 
> 
>> @@ -315,6 +318,7 @@ static void f81232_process_read_urb(struct urb *urb)
>>   
>>   			if (lsr & UART_LSR_OE) {
>>   				port->icount.overrun++;
>> +				schedule_work(&priv->lsr_work);
> 
> Unconditionally scheduled
> 
>>   				tty_insert_flip_char(&port->port, 0,
>>   						TTY_OVERRUN);
>>   			}
> 
> [..]
>> +static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
>> +{
>> +	struct f81232_private *port_priv;
>> +
>> +	port_priv = usb_get_serial_port_data(serial->port[0]);
>> +	flush_work(&port_priv->lsr_work);
>> +
>> +	return 0;
>> +}
>> +
>>   static struct usb_serial_driver f81232_device = {
>>   	.driver = {
>>   		.owner =	THIS_MODULE,
>> @@ -655,6 +688,7 @@ static struct usb_serial_driver f81232_device = {
>>   	.read_int_callback =	f81232_read_int_callback,
>>   	.port_probe =		f81232_port_probe,
>>   	.port_remove =		f81232_port_remove,
>> +	.suspend =		f81232_suspend,
> 
> Please have a look at:
> int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
> {
>          struct usb_serial *serial = usb_get_intfdata(intf);
>          int i, r = 0;
> 
> 
>          serial->suspending = 1;
> 
> 
>          /*
>           * serial->type->suspend() MUST return 0 in system sleep context,
>           * otherwise, the resume callback has to recover device from
>           * previous suspend failure.
>           */
>          if (serial->type->suspend) {
>                  r = serial->type->suspend(serial, message);
>                  if (r < 0) {
>                          serial->suspending = 0;
>                          goto err_out;
>                  }
>          }
> 
> 
>          for (i = 0; i < serial->num_ports; ++i)
>                  usb_serial_port_poison_urbs(serial->port[i]);
> err_out:
>          return r;
> }
> EXPORT_SYMBOL(usb_serial_suspend);
> 
> As you can see, the suspend method is called first and then the URBs
> are poisoned. That means that after you have flushed the work, it may
> be submitted again. The fix would be to test the 'suspending' flag
> before you schedule work (and recheck the need to schedule it
> during resume)

Thanks for report the race condition issue. It's seems the same bug
in f81534.c. I'll try to fix it on f81232.c then fix f81534.c too.

-- 
With Best Regards,
Peter Hong
