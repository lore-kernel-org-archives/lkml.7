Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE7C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADDD205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVD+eEv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEFQUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:20:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38824 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfEFQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:20:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id a59so6615751pla.5;
        Mon, 06 May 2019 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwhJD74xfD/UXtBBnubuC2BkNBqZahNTcck6QOIWCQQ=;
        b=BVD+eEv22cofmtuysgxgU27eatoy7VtaMG+XH5ppIZitrkrJRlzq1NW69R/bvgR5d8
         1OkWrkcydsBTKzaFRWVDS9csU+wXdyrpW3FpqIassCS5CzDVneJpJT4eXO0V3/VhmSqF
         qNRIVDpd8jy0YeekzYsi9SWKSyO0yvSiaNDRAGCUs/RAsFIxZJwi/cO8Sd01f/Mm7Tin
         4IMIscJsesC1isZUqDSoHOr7wRsyW/Sl4+8NsCTWgOIoMqN1hUtoqd86STFRAZa6X4/K
         kQR/M4mcECQw2kJVD/oJaD6eh5wch/DMrKmJHQ74UUirnrZIPpLNv57+lPmfBUH+ZPT8
         Ugmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwhJD74xfD/UXtBBnubuC2BkNBqZahNTcck6QOIWCQQ=;
        b=P18rwo++PtxomF5d9349M/LcREWPJ6g8CNCmbFJrYM7SfOdb6F/R+92Eo4wYtyHPiX
         gy+77jMrxgUoR+1RmC6+bMNHnbT/efItsLkx164gZWXXmapC1+tSBfJ8mViFwyjJM/rV
         UT1RY1hGX/HUJznRm3bUVbr6hcU/NgrGbcJjXBC1NIJj+kTMtCdkNlymkHo3sSMZwsRw
         N7Iy+GjE0dch9/+UBfTRJSUcRhfFvDLuz/x8a8HC3xP0d4vLAXZhsq73jO0Hv43h2oh/
         78ugENAUa0oh/81vFQGfE45Ldpd4RXZ5/mZicGlHXAPtI5SIFUeZqhbFfecb8+PXxTob
         4Jhg==
X-Gm-Message-State: APjAAAXLsFsQXwzfPTolsr+aZgl2Tu5tZ/+s52jTosrljCoCMJFsYqT9
        nvZKEOFOoKNq2jSYrrFza4lCFsBg
X-Google-Smtp-Source: APXvYqx1AaDT6JXFCF2yVVs31A0dxBBaQlvZMLooiC+UlO61cPKdoXveF88gss+9vqbA1/fQTRKwPw==
X-Received: by 2002:a17:902:d88b:: with SMTP id b11mr12930180plz.186.1557159651393;
        Mon, 06 May 2019 09:20:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n18sm24028204pfi.48.2019.05.06.09.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:20:50 -0700 (PDT)
Date:   Mon, 6 May 2019 09:20:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: tcpm: Add functions to read the VBUS
 voltage
Message-ID: <20190506162049.GA26804@roeck-us.net>
References: <20190506140830.25376-1-angus@akkea.ca>
 <20190506140830.25376-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506140830.25376-3-angus@akkea.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 08:08:29AM -0600, Angus Ainslie (Purism) wrote:
> Put some diagnostics in the tcpm log when there's an over
> or under voltage situation.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Subject is missing 'tcpci'.

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index c1f7073a56de..c6e0e48b9a2a 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -261,6 +261,39 @@ static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
>  	return 0;
>  }
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
> +	switch ((ret >> 10) & 3) {

Did you test this code ?

> +	case 0:
> +		scale = 1;
> +		break;
> +	case 1:
> +		scale = 2;
> +		break;
> +	case 2:
> +		scale = 4;
> +		break;
> +	case 3:
> +		tcpm_log(tcpci->port, "invalid VBUS scale");
> +		return -1;

Any special reason for not using standard error codes ?
The code above does, meaning this is a hardcodesd -EPERM, which doesn't
really make any sense.

> +	}
> +
> +	if (scale != 1)
> +		vbus_voltage *= scale;

I don't immediately see why this is better than, say,

	scale = (vbus_reg >> 10) & 3;
	if (scale == 3)
		return -Esomething;	// -EPROTO, maybe
	return vbus_voltage << scale;

> +
> +	return vbus_voltage;
> +}
> +
>  static int tcpci_get_vbus(struct tcpc_dev *tcpc)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -463,6 +496,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  	else if (status & TCPC_ALERT_TX_FAILED)
>  		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
>  
> +	if (status & (TCPC_ALERT_V_ALARM_LO | TCPC_ALERT_V_ALARM_HI)) {
> +		int ret;
> +
> +		ret = tcpci_get_vbus_voltage(&tcpci->tcpc);
> +
Unnecessary empty line.

> +		if (IS_ERR(ret))
> +			tcpm_log(tcpci->port, "Can't read VBUS voltage");

VBUS_VOLTAGE is an optional register. This is not an error. Besides, the
message doesn't match the event and is useless.

> +		else
> +			tcpm_log(tcpci->port, "Invalid VBUS voltage %d", ret);

Displaying a raw number without context is not very useful.
'ret' is the voltage in multiples of 25mV. Besides, the error is that a low
or high voltage was detected. That doesn't mean the voltage is still invalid.
The error message should reflect that situation. Something like

		"VBUS {low, high} detected, VBUS=x.yy V"

would be much more useful (with VBUS=x.yy being optional).

Also, please no tcpm log. The tcpci driver needs to implement
its own logging if that is desired.

> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  EXPORT_SYMBOL_GPL(tcpci_irq);
> -- 
> 2.17.1
> 
