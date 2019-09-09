Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF74C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F292089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YM4sNYFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403945AbfIILNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:13:15 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:63327 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbfIILNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568027593; x=1599563593;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=F9WoBKV+oWdvDBwrEieyAZ8tIJPF4Cx6CuXAUeqFsQk=;
  b=YM4sNYFOJvl1c6aVtpZ5jJV9DG55cDh+WJmP1lArz9A7Khhu1N+msu/d
   xOZyLhcBlT/BRpp4XnYOvKpXPxBDDNDBdQoh/6nsGG38H/pcK46Tj6bkE
   8x9pMojCzjnRZIfzFe6T8hiXDIYRS6X+VcaajL5xR0C0Bwn+HUXTS+bnY
   U=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="414286943"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 09 Sep 2019 11:13:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 57341C0934;
        Mon,  9 Sep 2019 11:13:06 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 11:13:05 +0000
Received: from [10.125.238.52] (10.43.161.152) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 9 Sep
 2019 11:12:54 +0000
Subject: Re: [PATCH 2/3] soc: amazon: al-pos: Introduce Amazon's Annapurna
 Labs POS driver
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Patrick Venture" <venture@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Olof Johansson" <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        <paul.kocialkowski@bootlin.com>, <mjourdan@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
 <1568020220-7758-3-git-send-email-talel@amazon.com>
 <CAK8P3a3UF7xPV1U3eW6Jdu754P1bzG208UxD9KUxEm1JjZudww@mail.gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <98f0028e-5653-3116-fdaa-1385ecdf0289@amazon.com>
Date:   Mon, 9 Sep 2019 14:12:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3UF7xPV1U3eW6Jdu754P1bzG208UxD9KUxEm1JjZudww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.152]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2019 12:44 PM, Arnd Bergmann wrote:
> On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:
>> The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
>> logging unit that reports an error in case write error (e.g. attempt to
>> write to a read only register).
>> This patch introduces the support for this unit.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Looks ok overall, juts a few minor comments:
Thanks.
>
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Talel Shenhar");
>> +MODULE_DESCRIPTION("Amazon's Annapurna Labs POS driver");
> These usually go to the end of the file.
Ack, Will move them as part of v2.
>
>> +       log1 = readl_relaxed(pos->mmio_base + AL_POS_ERROR_LOG_1);
>> +       if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
>> +               return IRQ_NONE;
>> +
>> +       log0 = readl_relaxed(pos->mmio_base + AL_POS_ERROR_LOG_0);
>> +       writel_relaxed(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
> Why do you require _relaxed() accessors here? Please add a comment
> explaining that, or use the regular readl()/writel().

I don't think commenting is needed here as there is nothing special in 
this type of access.

I don't see this is common to comment the use of the _relaxed accessors.

This driver is for SoC using arm64 cpu.

If one uses the non-relaxed version of readl while running on arm64, he 
shall cause read barrier, which is then doing dsm(ld).. This barrier is 
not needed here, so we spare the use of the more heavy readl in favor of 
the less "harmful" one.

Let me know what you think.

>
>> +       resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       pos->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
> This can be simplified to devm_platform_ioremap_resource().
Ack, Will simplify them in v2.
>
>> +       pos->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> And this is usually written as platform_get_irq()
Ack, Will replace them with platform_get_irq() in v2.
>
>         Arnd
