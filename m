Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7293C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8997620643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BrQea9kW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BrQea9kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCHWan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:30:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHWam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:30:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C462B604BE; Fri,  8 Mar 2019 22:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552084241;
        bh=7EmFq2bsdSMXunQcC3U97iWThXMttuBUha8q57peoxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrQea9kW/npURT5jXhIgROH9uYaTsmd0hyrrqOHQfA2mUGfb0mjHbitUtjRvLwr1o
         5+uW7rQb27BV9DgC+1K6FZEgbxJbsmn01O9SwOFhfUcque+d4/bzQG6ftPCnO+3W2B
         gFbEq85OU3k27smqILat6KQklIxzrNUQdS5uJWzs=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFC5F60328;
        Fri,  8 Mar 2019 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552084241;
        bh=7EmFq2bsdSMXunQcC3U97iWThXMttuBUha8q57peoxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrQea9kW/npURT5jXhIgROH9uYaTsmd0hyrrqOHQfA2mUGfb0mjHbitUtjRvLwr1o
         5+uW7rQb27BV9DgC+1K6FZEgbxJbsmn01O9SwOFhfUcque+d4/bzQG6ftPCnO+3W2B
         gFbEq85OU3k27smqILat6KQklIxzrNUQdS5uJWzs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFC5F60328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 8 Mar 2019 15:30:40 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v3 6/9] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190308223040.GA31960@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
 <20190222221850.26939-7-ilina@codeaurora.org>
 <155200677430.20095.14337964669558394653@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155200677430.20095.14337964669558394653@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07 2019 at 17:59 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-02-22 14:18:47)
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index ee8119879c4c..83053b45982e 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -890,6 +918,9 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>>
>>         raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>Can we remove the above hunk of code in this function? From what I can
>tell we're trying to set wake on the GIC SPI line and that won't ever
>work because it doesn't support wakeup support. Furthermore, I get a
>lockdep splat when I try to set wake on a GPIO irq with this patchset
>applied. It's probably a false positive though because it's warning
>about an AA deadlock with the irq descriptor lock, which is aliased
>between the two controllers.
>
>>
>> +       if (d->parent_data)
>> +               irq_chip_set_wake_parent(d, on);
>> +
>>         return 0;
>>  }
>>
>
>Here's a patch on top. If you need my signed-off-by please feel free to
>add it:
>
I will fold it in in my patch. It has your Co-developed-by anyways.

Thanks,
Lina

>Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
>-----8<-------
>diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>index cdbc06ec5e96..4e81dad80a4d 100644
>--- a/drivers/pinctrl/qcom/pinctrl-msm.c
>+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>@@ -852,20 +852,10 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>
> static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
> {
>-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>-	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>-	unsigned long flags;
>-
>-	raw_spin_lock_irqsave(&pctrl->lock, flags);
>-
>-	irq_set_irq_wake(pctrl->irq, on);
>-
>-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>-
> 	if (d->parent_data)
>-		irq_chip_set_wake_parent(d, on);
>+		return irq_chip_set_wake_parent(d, on);
>
>-	return 0;
>+	return -ENOSYS;
> }
>
> static int msm_gpio_irq_reqres(struct irq_data *d)
