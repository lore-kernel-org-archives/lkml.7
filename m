Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75164C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D25120656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO3R80TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEHB7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:59:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34225 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEHB7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:59:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so1074225pfa.1;
        Tue, 07 May 2019 18:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKDYwa6gUv5wCTyZ99PrxN7F5ZX+WfRDRB+TBVrMR/M=;
        b=bO3R80TSFgE++pk0ozdsgJgulasRz6lSf+dyLKEVUTZnfrzKlw4n41cPixoi/YaXAm
         qDKvTGfvQ+qMhD+bh7vb7BD5GTw+DMtuB25imranm80XSc2CleG5G0YkZ8T1DDB59CeE
         bILBcf4cuYFCFWQFJnz02u5w12qvjgsFJeB3LpSXWcQbS63aSCBVz8sNJA2+XT3F8uyf
         /WPfZpv53QTIJLeOG97HFQkXLaKUlzppqEogTcYfC9a4r/0Ane+aLN/ScxQNT3mWRuly
         5dI+eBPVKfxjv5p/hCZu610r2FW/KiwoGYi2/rPiTcRBXNP8uBHaE/KH93zXb8w9CEWK
         dmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKDYwa6gUv5wCTyZ99PrxN7F5ZX+WfRDRB+TBVrMR/M=;
        b=C+kcWKfM4RtoXnyXtmHvVArc6muUqb8qSsp/VdcXLTxqAzzd/jfRaYHzNwRmBQnA0Z
         v6ekA3c99cjNQVANjTaPBolMa+d+RVAQlLtT8Yl5O8Iw3D8ILuHUpWWnt5Qied3dOBUc
         FCNOR1XMKKlmOzenRMTCFqz/MeYKcXrgq1oek5r9Oc9BJIZVllyuq/qQOWVKz+IKY3FJ
         CGpUb+UI1SDfSy4tR3gC6Wfm35/djreg1wteCrNIXrs1h7ZKjiFyr0zpB19MDMaQi2Mm
         maT5KwfRvHXFN4zOoiKvGBzKl5DDw7LQo+M3RyhTkZiLKW34SnRk5vpkyoe9H4sePHS+
         dwpA==
X-Gm-Message-State: APjAAAWRRo/GFDVTm/wKOfoMC+fs2L6/HHoYnAzD3SovpflVbXG+hOXe
        BiiPRCD0ugYPHAC3NPbVZLPpR2zX
X-Google-Smtp-Source: APXvYqxDuhJVVTLedW1BLuHfADxWqaSKHmzJSrRoR+NS1/eEc5b2m3SHitJ4rvGEcpem027CijC6qA==
X-Received: by 2002:a63:fb01:: with SMTP id o1mr43420797pgh.135.1557280778532;
        Tue, 07 May 2019 18:59:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm14455836pfr.22.2019.05.07.18.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 18:59:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] usb: typec: tcpci: add functions to read the VBUS
 voltage
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190508004027.16558-1-angus@akkea.ca>
 <20190508004027.16558-2-angus@akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f70df755-9462-54af-cd7d-83d35c1dd3f8@roeck-us.net>
Date:   Tue, 7 May 2019 18:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508004027.16558-2-angus@akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 5:40 PM, Angus Ainslie (Purism) wrote:
> Show an error when the VBUS voltage is out of range.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>   drivers/usb/typec/tcpm/tcpci.c | 35 ++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index a5746657b190..223941e11ef3 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -261,6 +261,26 @@ static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
>   	return 0;
>   }
>   
> +static int tcpci_get_vbus_voltage(struct tcpc_dev *tcpc)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +	u16 vbus_reg;
> +	unsigned int vbus_voltage;
> +	int ret, scale;
> +
> +	ret = tcpci_read16(tcpci, TCPC_VBUS_VOLTAGE, &vbus_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	vbus_voltage = vbus_reg & 0x3f;
> +
> +	scale = (vbus_reg >> 10) & 3;
> +	if (scale == 3)
> +		return -EIO;
> +
> +	return (vbus_voltage << scale) * 25;
> +}
> +
>   static int tcpci_get_vbus(struct tcpc_dev *tcpc)
>   {
>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -401,6 +421,7 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>   irqreturn_t tcpci_irq(struct tcpci *tcpci)
>   {
>   	u16 status;
> +	int ret;
>   
>   	tcpci_read16(tcpci, TCPC_ALERT, &status);
>   
> @@ -474,6 +495,20 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>   		tcpci_write16(tcpci, TCPC_FAULT_STATUS, fault_status);
>   	}
>   
> +	if (status & (TCPC_ALERT_V_ALARM_LO | TCPC_ALERT_V_ALARM_HI)) {
> +		ret = tcpci_get_vbus_voltage(&tcpci->tcpc);
> +
Extra empty line.

> +		if (ret >= 0) {
> +			if (status & TCPC_ALERT_V_ALARM_LO)
> +				dev_err(tcpci->dev, "Low VBUS voltage %d mV\n",
> +						ret);
> +
> +			if (status & TCPC_ALERT_V_ALARM_HI)
> +				dev_err(tcpci->dev, "High VBUS voltage %d mV\n",
> +						ret);
> +		}

This doesn't report anything if reading the VBUS voltage
returns an error.

Also, per TCPCI specification, you probably want to check
POWER_CONTROL.VBUS_VOLTAGE Monitor to see if it is enabled
in the first place.

On a higher level, the driver doesn't currently set limits for low
and high voltage alarms, and it doesn't enable those alarms. As such,
I wonder if/how you can get those alerts. Can you clarify ?

Thanks,
Guenter

> +	}
> +
>   	return IRQ_HANDLED;
>   }
>   EXPORT_SYMBOL_GPL(tcpci_irq);
> 

