Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B3C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C790C20C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8rQiUnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEHAtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:49:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35363 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:49:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so9019400plp.2;
        Tue, 07 May 2019 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4DaXEI4RXMI2Ha+KEPle/O32l3yeez/gfD+bCb4ZQ4=;
        b=F8rQiUnmcH2ZQ6T6EsdGNIYwJaFrYnhANeh2O3g9QAtOyXM951IYNgzhCNRT8I7Dxo
         I1sI2H4OI51rJvym7+GjIqXnlKt0+/w7bSjayfEop/ZNb9pBXwQwcafhE2DRYSZk5Iq9
         jRL+SRAYOyz/+UL6VlymYt/W6+skYtN4rm5LinKbLi09DCzFoJCe5xSSBVeq5iJuF7UR
         FK1Q0pCeb/C0uAGTOKzA9qQ2TaXN4DZgEe0i1A8c3kj06SwUOCXaHvuzChRzXvBYZTOr
         NybUy3MD0fhlWaebK+uftz87dUIyy58dJwL2H0c3D4zJ1bc+tgMSGT9P+ASV+humz7aD
         Z6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4DaXEI4RXMI2Ha+KEPle/O32l3yeez/gfD+bCb4ZQ4=;
        b=eYSB4Yuhr5I/oD/lsLiows3651w9q+DoIzdWp4HOgirIR7EtvqgVZ7S93mlOPoG6f6
         B2V+8W00pRY7/0eG/BBLUexfKcJ0NKqXrlVHNcwX8ZRzJAy9f6ZtwJcZcl5pFLOVYAPQ
         rNb4aGl0m7eGw+5IAmYX7DfGCtuqeiqtWSRW7kKduNRBlrrADZqQitHzvJRudhaRh1pF
         4FF0GzYlS8A2Of91UUFYIeTVkKzQ6qOMKVl/bNSwzEU7avj0n6SW2SqNBATSit6rGYKI
         FTjIU9R+rkWlsQh9JWMo049siUGpFRMnNDXxBDFh6foZLxDfxLThhSbdUGvwplH/OuPi
         6Ztg==
X-Gm-Message-State: APjAAAWSSXQn3waHduxEWBkf6gbyWzOtXdvxhPWG7kL3hL/yUYOmXYP4
        LKZa0179wGOc4bocDxl4jv0XzDer
X-Google-Smtp-Source: APXvYqw/aIXMWSlLjL40RmduVaHWQFjjTA4VY4w9rLLBTv02WyjtlPhVUAfRy1dooDCIHTvF6/9j7w==
X-Received: by 2002:a17:902:a3:: with SMTP id a32mr43580938pla.111.1557276556732;
        Tue, 07 May 2019 17:49:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j22sm18332187pfn.129.2019.05.07.17.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 17:49:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>, angus.ainslie@puri.sm
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190508002749.14816-1-angus@akkea.ca>
 <20190508002749.14816-2-angus@akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5f0bec69-9579-f153-c3fd-d7b8deea75c4@roeck-us.net>
Date:   Tue, 7 May 2019 17:49:14 -0700
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

That is not how Fixes: tags are supposed to work. This should probably be

Fixes: 74e656d6b0551 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")

Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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

