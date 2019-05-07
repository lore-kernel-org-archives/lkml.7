Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB088C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D257205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="HBxCcCtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEGMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:20:33 -0400
Received: from node.akkea.ca ([192.155.83.177]:50710 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfEGMUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:20:33 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 749404E204B; Tue,  7 May 2019 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557231632; bh=uNQSdULdLhLXke+sVh9CJSn8ILWLrlBcNdJ0iCE+fHg=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=HBxCcCtHYigQMIa+28XmuqqpJnFns+o8aJFMkt0DsO17Oafu8ciamepG/5uLSR3s0
         FZV9VUzZ2IG2AQTGwM2DUsUVaw4vkvvQfoK46fXFsDlvfT4dh/d29x6AEmStyzqvgr
         LgI5nfUvntOUGyWtYTcxCdwHnVozqZWNva6mO0VI=
To:     Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] usb: typec: tcpm: Add functions to read the VBUS  voltage
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 May 2019 06:20:32 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
In-Reply-To: <20190506162049.GA26804@roeck-us.net>
References: <20190506140830.25376-1-angus@akkea.ca>
 <20190506140830.25376-3-angus@akkea.ca>
 <20190506162049.GA26804@roeck-us.net>
Message-ID: <0c8b8a38c50f0d80276bd6d2a443fc82@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-06 10:20, Guenter Roeck wrote:
> On Mon, May 06, 2019 at 08:08:29AM -0600, Angus Ainslie (Purism) wrote:
>> Put some diagnostics in the tcpm log when there's an over
>> or under voltage situation.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> 
> Subject is missing 'tcpci'.
> 
>> ---
>>  drivers/usb/typec/tcpm/tcpci.c | 44 
>> ++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>> 
>> diff --git a/drivers/usb/typec/tcpm/tcpci.c 
>> b/drivers/usb/typec/tcpm/tcpci.c
>> index c1f7073a56de..c6e0e48b9a2a 100644
>> --- a/drivers/usb/typec/tcpm/tcpci.c
>> +++ b/drivers/usb/typec/tcpm/tcpci.c
>> @@ -261,6 +261,39 @@ static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, 
>> bool enable)
>>  	return 0;
>>  }
>> 
>> +static int tcpci_get_vbus_voltage(struct tcpc_dev *tcpc)
>> +{
>> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>> +	u16 vbus_reg;
>> +	unsigned int vbus_voltage;
>> +	int ret, scale;
>> +
>> +	ret = tcpci_read16(tcpci, TCPC_VBUS_VOLTAGE, &vbus_reg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	vbus_voltage = vbus_reg & 0x3f;
>> +	switch ((ret >> 10) & 3) {
> 
> Did you test this code ?
> 

It turned out this wasn't how the device was failing so the code path 
never got executed. I'll figure out how to get it to run before v2.

>> +	case 0:
>> +		scale = 1;
>> +		break;
>> +	case 1:
>> +		scale = 2;
>> +		break;
>> +	case 2:
>> +		scale = 4;
>> +		break;
>> +	case 3:
>> +		tcpm_log(tcpci->port, "invalid VBUS scale");
>> +		return -1;
> 
> Any special reason for not using standard error codes ?
> The code above does, meaning this is a hardcodesd -EPERM, which doesn't
> really make any sense.
> 

Ok I'll find a better return value.

>> +	}
>> +
>> +	if (scale != 1)
>> +		vbus_voltage *= scale;
> 
> I don't immediately see why this is better than, say,
> 
> 	scale = (vbus_reg >> 10) & 3;
> 	if (scale == 3)
> 		return -Esomething;	// -EPROTO, maybe
> 	return vbus_voltage << scale;
> 

That looks more concise than what I can up with.

>> +
>> +	return vbus_voltage;
>> +}
>> +
>>  static int tcpci_get_vbus(struct tcpc_dev *tcpc)
>>  {
>>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>> @@ -463,6 +496,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>>  	else if (status & TCPC_ALERT_TX_FAILED)
>>  		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
>> 
>> +	if (status & (TCPC_ALERT_V_ALARM_LO | TCPC_ALERT_V_ALARM_HI)) {
>> +		int ret;
>> +
>> +		ret = tcpci_get_vbus_voltage(&tcpci->tcpc);
>> +
> Unnecessary empty line.
> 
>> +		if (IS_ERR(ret))
>> +			tcpm_log(tcpci->port, "Can't read VBUS voltage");
> 
> VBUS_VOLTAGE is an optional register. This is not an error. Besides, 
> the
> message doesn't match the event and is useless.
> 
>> +		else
>> +			tcpm_log(tcpci->port, "Invalid VBUS voltage %d", ret);
> 
> Displaying a raw number without context is not very useful.
> 'ret' is the voltage in multiples of 25mV. Besides, the error is that a 
> low
> or high voltage was detected. That doesn't mean the voltage is still 
> invalid.
> The error message should reflect that situation. Something like
> 
> 		"VBUS {low, high} detected, VBUS=x.yy V"
> 
> would be much more useful (with VBUS=x.yy being optional).
> 
> Also, please no tcpm log. The tcpci driver needs to implement
> its own logging if that is desired.
> 

Ok I'll clear up the logging.

>> +	}
>> +
>>  	return IRQ_HANDLED;
>>  }
>>  EXPORT_SYMBOL_GPL(tcpci_irq);
>> --
>> 2.17.1
>> 

