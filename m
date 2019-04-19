Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A328C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFCE2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="QCLn0Ghb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfDSTC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:02:57 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.87]:46406 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728823AbfDSTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:02:52 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 15:02:51 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 38E63D847CC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:12:52 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id HY0KhQw8qYTGMHY0KhXu2I; Fri, 19 Apr 2019 13:12:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=POBm3POgnF9dNWYaSNQl7zAnLu6dfC4n/mraAAfr//s=; b=QCLn0Ghbw9fi2w6SWZfZQ9XlPS
        WgwLi8mx4pW+OIGiLRfSgOZIEuzSDo0U9ftMZDF1EOtKNEwewAYKBPbf8/ZEjmky+chxdvkQ/bFIC
        V+2kYxjLm/ToQLiOveRPW7QVXnqfcfsKIdauPP0uGxprvlIdO+Pt+L1g1RBatls+Lk2EDAETxZ/vc
        WcKwb2yf1KsdD/G1HXhrWoGPo5ggLIBh4C/Y3wmuv4+CHZDcDrXPqWip03ak1upAklY1CnlxCc2TH
        /rTobVg01krjGzNnfdj8L3aJ1kuILu2iSqrfa04o+Qok56ixYMeGu0L3siaBCox90fvExUP2z2vJB
        nFsw810g==;
Received: from [177.35.229.111] (port=52782 helo=[192.168.0.50])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hHY0J-003wyR-DH; Fri, 19 Apr 2019 15:12:51 -0300
Subject: Re: [PATCH v2 1/4] power: supply: max17040: Add IRQ handler for low
 SOC alert
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
 <20190415012635.6369-2-matheus@castello.eng.br>
 <CAJKOXPfXS_L992rPdHqitFyRmw93En9GRLVOjRRnwGgiEwV28Q@mail.gmail.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <c4bffa4d-36bb-1f6c-cf56-69a990d9b832@castello.eng.br>
Date:   Fri, 19 Apr 2019 15:12:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfXS_L992rPdHqitFyRmw93En9GRLVOjRRnwGgiEwV28Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.35.229.111
X-Source-L: No
X-Exim-ID: 1hHY0J-003wyR-DH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.50]) [177.35.229.111]:52782
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 10
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Em 4/15/19 4:10 AM, Krzysztof Kozlowski escreveu:
> On Mon, 15 Apr 2019 at 03:49, Matheus Castello <matheus@castello.eng.br> wrote:
>>
>> According datasheet max17040 has a pin for alert host for low SOC.
>> This pin can be used as external interrupt, so we need to check for
>> interrupts assigned for device and handle it.
>>
>> In hadler we are checking and storing fuel gauge registers values
>> and send an uevent to notificate user space, so user space can decide
>> save work or turn off since the alert demonstrate that the battery may
>> no have the power to keep the system turned on for much longer.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   drivers/power/supply/max17040_battery.c | 69 +++++++++++++++++++++++--
>>   1 file changed, 64 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>> index 91cafc7bed30..8d2f8ed3f44c 100644
>> --- a/drivers/power/supply/max17040_battery.c
>> +++ b/drivers/power/supply/max17040_battery.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/err.h>
>>   #include <linux/i2c.h>
>>   #include <linux/delay.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/power_supply.h>
>>   #include <linux/max17040_battery.h>
>>   #include <linux/slab.h>
>> @@ -160,21 +161,40 @@ static void max17040_get_status(struct i2c_client *client)
>>                  chip->status = POWER_SUPPLY_STATUS_FULL;
>>   }
>>
>> +static void max17040_check_changes(struct i2c_client *client)
>> +{
>> +       max17040_get_vcell(client);
>> +       max17040_get_soc(client);
>> +       max17040_get_online(client);
>> +       max17040_get_status(client);
>> +}
>> +
>>   static void max17040_work(struct work_struct *work)
>>   {
>>          struct max17040_chip *chip;
>>
>>          chip = container_of(work, struct max17040_chip, work.work);
>> -
>> -       max17040_get_vcell(chip->client);
>> -       max17040_get_soc(chip->client);
>> -       max17040_get_online(chip->client);
>> -       max17040_get_status(chip->client);
>> +       max17040_check_changes(chip->client);
>>
>>          queue_delayed_work(system_power_efficient_wq, &chip->work,
>>                             MAX17040_DELAY);
>>   }
>>
>> +static irqreturn_t max17040_thread_handler(int id, void *dev)
>> +{
>> +       struct max17040_chip *chip = dev;
>> +       struct i2c_client *client = chip->client;
>> +
>> +       dev_warn(&client->dev, "IRQ: Alert battery low level");
>> +       /* read registers */
>> +       max17040_check_changes(chip->client);
>> +
>> +       /* send uevent */
>> +       power_supply_changed(chip->battery);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>   static enum power_supply_property max17040_battery_props[] = {
>>          POWER_SUPPLY_PROP_STATUS,
>>          POWER_SUPPLY_PROP_ONLINE,
>> @@ -217,6 +237,27 @@ static int max17040_probe(struct i2c_client *client,
>>                  return PTR_ERR(chip->battery);
>>          }
>>
>> +       /* check interrupt */
>> +       if (client->irq) {
>> +               int ret;
>> +               unsigned int flags;
>> +
>> +               dev_info(&client->dev, "IRQ: enabled\n");
>> +               flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
>> +
>> +               ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +                                               max17040_thread_handler, flags,
>> +                                               chip->battery->desc->name,
>> +                                               chip);
>> +
>> +               if (ret) {
>> +                       client->irq = 0;
>> +                       if (ret != -EBUSY)
> 
> Why not on EBUSY?
> 
>> +                               dev_warn(&client->dev,
>> +                                       "Failed to get IRQ err %d\n", ret);
>> +               }
>> +       }
>> +
>>          max17040_reset(client);
>>          max17040_get_version(client);
>>
>> @@ -224,6 +265,8 @@ static int max17040_probe(struct i2c_client *client,
>>          queue_delayed_work(system_power_efficient_wq, &chip->work,
>>                             MAX17040_DELAY);
>>
>> +       device_init_wakeup(&client->dev, 1);
> 
> Either you parse DT for wakeup-source property and use it... or you
> unconditionally enable wakeup. In the second case - there is no point
> to check later for device_may_wakeup(). Instead check the return value
> of device_init_wakeup().
> 
>> +
>>          return 0;
>>   }
>>
>> @@ -244,6 +287,14 @@ static int max17040_suspend(struct device *dev)
>>          struct max17040_chip *chip = i2c_get_clientdata(client);
>>
>>          cancel_delayed_work(&chip->work);
>> +
>> +       if (client->irq) {
>> +               if (device_may_wakeup(dev))
>> +                       enable_irq_wake(client->irq);
>> +               else
>> +                       disable_irq_wake(client->irq);
> 
> Did you try the wakeup from suspend? You do not have a disable_irq()
> here which usually was needed for interrupts to work properly on
> suspend. Maybe this was fixed?
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

I test it using mem state and suspend, resuming seems to have worked 
correctly ...

Thanks for the review, I'm working in your suggestions and I expect to 
send v3 this weekend.

Best Regards,
Matheus Castello

