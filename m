Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E676C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2B8206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bvXYo3UN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bvXYo3UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCLQfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:35:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfCLQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:35:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95B0960DAA; Tue, 12 Mar 2019 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552408511;
        bh=dmqklfg/xizBMlZpxYUcrrQE78iPUO4iXvtJABdIiIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvXYo3UNi23T1XeEqah0F68yEF/DReVz9H3C8k1HrlSAShWpX9sDQ/pl8e/vrT4/N
         AFCLfanswmK1Ar70BA5Nz+TRq0Mt6h/OPeFGotIcG8fRZcS8b+nMmq8aZG8R+gL2s/
         3beEnSgCmIRJ0OvgcQ461JcWZ+74+9K69xPaQ3mg=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8994608CE;
        Tue, 12 Mar 2019 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552408511;
        bh=dmqklfg/xizBMlZpxYUcrrQE78iPUO4iXvtJABdIiIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvXYo3UNi23T1XeEqah0F68yEF/DReVz9H3C8k1HrlSAShWpX9sDQ/pl8e/vrT4/N
         AFCLfanswmK1Ar70BA5Nz+TRq0Mt6h/OPeFGotIcG8fRZcS8b+nMmq8aZG8R+gL2s/
         3beEnSgCmIRJ0OvgcQ461JcWZ+74+9K69xPaQ3mg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8994608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 12 Mar 2019 10:35:09 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v3 6/9] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190312163509.GB8553@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
 <20190222221850.26939-7-ilina@codeaurora.org>
 <6452d538-5714-7e3a-1537-2dd1c4976653@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6452d538-5714-7e3a-1537-2dd1c4976653@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11 2019 at 04:55 -0600, Marc Zyngier wrote:
>On 22/02/2019 22:18, Lina Iyer wrote:
>> To allow GPIOs to wakeup the system from suspend or deep idle, the
>> wakeup capable GPIOs are setup in hierarchy with interrupts from the
>> wakeup-parent irqchip.
>>
>> In older SoC's, the TLMM will handover detection to the parent irqchip
>> and in newer SoC's, the parent irqchip may also be active as well as the
>> TLMM and therefore the GPIOs need to be masked at TLMM to avoid
>> duplicate interrupts. To enable both these configurations to exist,
>> allow the parent irqchip to dictate the TLMM irqchip's behavior when
>> masking/unmasking the interrupt.
>>
>> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

[...]

>> @@ -986,6 +1093,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>  	chip->need_valid_mask = msm_gpio_needs_valid_mask(pctrl);
>>
>>  	pctrl->irq_chip.name = "msmgpio";
>> +	pctrl->irq_chip.irq_eoi	= irq_chip_eoi_parent;
>>  	pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
>>  	pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
>>  	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
>> @@ -994,6 +1102,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>  	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>>  	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>>
>> +	chip->irq.chip = &pctrl->irq_chip;
>> +	chip->irq.domain_ops = &msm_gpio_domain_ops;
>> +	chip->irq.handler = handle_edge_irq;
>> +	chip->irq.default_type = IRQ_TYPE_NONE;
>
>I know you're only moving this around, but can you explain why you're
>setting IRQ_TYPE_NONE in combination with handle_edge_irq? The two
>really should go together. If this doesn't work for some reason, please
>document it.
>
Yes, it was a carry-over from the existing code. I am not sure why that
seems to be a common practice among GPIO drivers.
IRQ_TYPE_EDGE_RISING would be a better option ?

>> +
>> +	dn = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
>> +	if (dn) {
>> +		chip->irq.parent_domain = irq_find_matching_host(dn,
>> +						 DOMAIN_BUS_WAKEUP);
>> +		of_node_put(dn);
>> +		if (!chip->irq.parent_domain)
>> +			return -EPROBE_DEFER;
>> +
>> +		chip->to_irq = msm_gpio_to_irq;
>> +	}
>> +
>>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>>  	if (ret) {
>>  		dev_err(pctrl->dev, "Failed register gpiochip\n");
>> @@ -1015,26 +1139,17 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>  			dev_name(pctrl->dev), 0, 0, chip->ngpio);
>>  		if (ret) {
>>  			dev_err(pctrl->dev, "Failed to add pin range\n");
>> -			gpiochip_remove(&pctrl->chip);
>> -			return ret;
>> +			goto fail;
>>  		}
>>  	}
>>
>> -	ret = gpiochip_irqchip_add(chip,
>> -				   &pctrl->irq_chip,
>> -				   0,
>> -				   handle_edge_irq,
>> -				   IRQ_TYPE_NONE);
>> -	if (ret) {
>> -		dev_err(pctrl->dev, "Failed to add irqchip to gpiochip\n");
>> -		gpiochip_remove(&pctrl->chip);
>> -		return -ENOSYS;
>> -	}
>> -
>>  	gpiochip_set_chained_irqchip(chip, &pctrl->irq_chip, pctrl->irq,
>>  				     msm_gpio_irq_handler);
>>
>>  	return 0;
>> +fail:
>> +	gpiochip_remove(&pctrl->chip);
>> +	return ret;
>>  }
>>

Thanks,
Lina


