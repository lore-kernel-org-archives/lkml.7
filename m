Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C220835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GqKBVhIz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GqKBVhIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbfDQQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:08:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDQQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:08:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B874460741; Wed, 17 Apr 2019 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555517294;
        bh=cejLxVwclff3ws4tuXqtx6wPfxFNcTws1Knvj/BR/Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqKBVhIzZXzBS0H+3ZtGNF6xDTluC6/daaRrs/Vzw0hmRjC/8/Ls3tSH4Y6U+EcgE
         IdayWe8bxWSDns/JyghacBqKWe0929LGwwXZN3iSXkz6JWajeXJQ25ZcAiy+CnfqOX
         Rk2wi3WoCbZ9aqkw3eBRboGQuWaoCAKTc0mzjhMk=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D08B5602DD;
        Wed, 17 Apr 2019 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555517294;
        bh=cejLxVwclff3ws4tuXqtx6wPfxFNcTws1Knvj/BR/Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqKBVhIzZXzBS0H+3ZtGNF6xDTluC6/daaRrs/Vzw0hmRjC/8/Ls3tSH4Y6U+EcgE
         IdayWe8bxWSDns/JyghacBqKWe0929LGwwXZN3iSXkz6JWajeXJQ25ZcAiy+CnfqOX
         Rk2wi3WoCbZ9aqkw3eBRboGQuWaoCAKTc0mzjhMk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D08B5602DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 17 Apr 2019 10:08:13 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190417160813.GE16124@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-8-ilina@codeaurora.org>
 <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15 2019 at 10:28 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-03-13 14:18:41)
>> ---
>> Changes in v4:
>>         - Remove irq_set_wake() on summary IRQ interrupt
>> Changes in v3:
>>         - Use of_irq_domain_map() and pass PDC pin to parent irqdomain
>> Changes in v2:
>>         - Call parent mask when masking GPIO interrupt
>> Changes in v1:
>>         - Fix bug when unmasking PDC interrupt
>[...]
>> +}
>> +
>> +/*
>> + * TODO: Get rid of this and push it into gpiochip_to_irq()
>> + */
>
>Any chance this TODO can be resolved?
>

I am thinking of something like this. Would there be any issue in
setting the type to IRQ_TYPE_SENSE_MASK instead of any one particular
type?

---8<-----
static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
{
#ifdef CONFIG_OF_GPIO
        struct irq_fwspec fwspec;

        if (chip->of_node) {
               fwspec.fwnode = of_node_to_fwnode(chip->of_node);
               fwspec.param[0] = offset;
               fwspec.param[1] = IRQ_TYPE_SENSE_MASK;
               fwspec.param_count = 2;
               return irq_create_fwspec_mapping(&fwspec);
        }
#endif

        if (!gpiochip_irqchip_irq_valid(chip, offset))
                return -ENXIO;

        return irq_create_mapping(chip->irq.domain, offset);
}
---8<----


Thanks,
Lina

