Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C6C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BA120656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No8w8axx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEHCDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:03:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39130 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHCDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:03:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so1680802plm.6;
        Tue, 07 May 2019 19:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3kIazKZf6YmvWTo0nRkCfEyQWIpfS50NodxpYJkF6U0=;
        b=No8w8axxDVVJ74jzVtwx3mn6iWP5zI0oIoSt6MwdLrQomPaG6OQ3OHoynPnUVmuNK3
         yQOek8CmgeSkNx9AIMsRL4/nYsHnqNz7Np2Icw+bku7F7jae5Ge7Mz8/0NFMw7fLf5Zm
         xt92LcIQfRCKSgc7t524eVU15iCk25sJ0GTrfpb0/sC92d59MY0QQfJ/W2wh4iYge/3Z
         tbOs1BEZr2VUPFQ39DgR/teUNZZxYEU365X6D8bteS6bwj5BP5R2rnUh3ay/tQjHqGt1
         V2mrl7fx20Ut8DJ5iqC98Ys/oM/ALnAx+RHavDUtEExWCG4K1SyRCk1XqObndYk2kRJo
         njCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3kIazKZf6YmvWTo0nRkCfEyQWIpfS50NodxpYJkF6U0=;
        b=m1dKIkcaOdF0pL/pIverFDmQVD4PEpngCmJcWIpwd5neGCsP4z4jJaL4MbYIfEliIP
         xegPuChj4Wm2b6X5JVk3bKhKLoAexwqMlFzK86fKr1thwoB3PuYbyVM9F/F2XG7HTMMn
         khWVUY7gNl8svWss/uV/U9A9ieToI0xvidZyVop6xzyH/iRfEgorvbyvUBkdRFhiDrMz
         uvYUH+MHK9oCn7ZKQ7fNsmeNOZMwMGUuzgMfJApMX3/LbURsEafnGUmkswFM+wW1g9Rv
         uUraVH/PASpFxCF+pKZ52Vy5Erljp5Xpsbu+xc7J2sO+EeXMowVK0W8qeXGrMHqpAGzS
         T+sg==
X-Gm-Message-State: APjAAAWyXsdbVm9dppYLjQVIXWlNgdzOgCC0QwZjb4qdhqDrwbBCkdDb
        ZJShYmMfP7+gbrZc/A87/GMQG1kE
X-Google-Smtp-Source: APXvYqyqnfA6xKp2YkxiecUmGzzVut2GDkUlrNGLCJbIy8SUOxVIue6FzmhsSExQWZR8OgeAmDQ2Mw==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr44003839plv.20.1557281015703;
        Tue, 07 May 2019 19:03:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z187sm11670431pfb.132.2019.05.07.19.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:03:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>, angus.ainslie@puri.sm
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190508002749.14816-1-angus@akkea.ca>
 <20190508002749.14816-2-angus@akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <aed487a4-3f7c-55e8-9c84-feaa1c7f583d@roeck-us.net>
Date:   Tue, 7 May 2019 19:03:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508002749.14816-2-angus@akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 5:27 PM, Angus Ainslie (Purism) wrote:
> If the fault status register doesn't get cleared then
> the ptn5110 interrupt gets stuck on. As the fault register gets
> set everytime the ptn5110 powers on the interrupt is always stuck.
> 
> Fixes: fault status register stuck
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>   drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index c1f7073a56de..a5746657b190 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -463,6 +463,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>   	else if (status & TCPC_ALERT_TX_FAILED)
>   		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
>   
> +	if (status & TCPC_ALERT_FAULT) {

Wait - the driver doesn't set TCPC_ALERT_FAULT in the alert mask
register. How can the chip report it if fault alerts are not enabled ?
What am I missing here ?

Thanks,
Guenter

> +		u16 fault_status;
> +
> +		tcpci_read16(tcpci, TCPC_FAULT_STATUS, &fault_status);
> +
> +		dev_warn(tcpci->dev, "FAULT ALERT status 0x%x\n", fault_status);
> +
> +		/* clear the fault status */
> +		tcpci_write16(tcpci, TCPC_FAULT_STATUS, fault_status);
> +	}
> +
>   	return IRQ_HANDLED;
>   }
>   EXPORT_SYMBOL_GPL(tcpci_irq);
> 

