Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C31C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5072196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NgiYz666"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405241AbfIIOLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:11:34 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:28642 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405170AbfIIOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568038293; x=1599574293;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gi28FrqFGKtAvBvYFxkZYst96FU+E+hOzXKbUu21vJY=;
  b=NgiYz6661i710lrns0RQQhBY7WORviGbrfTKjHpt5W1lMAUqyujP1QvJ
   TMsUQXD8a/Qk4inMT8mx1gmKEG6LwVjyzq4Ywt0U6JhswsFkIwMOis+NP
   lIZpExSCBUZlLIlF38B8/NNxQ9Zg35i3cDBVWd896pTS6piUNu0DixtC/
   c=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="829310330"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Sep 2019 14:11:29 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 3BF3DA1CC0;
        Mon,  9 Sep 2019 14:11:22 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 14:11:22 +0000
Received: from [10.125.238.52] (10.43.161.152) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 9 Sep
 2019 14:11:11 +0000
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
 <98f0028e-5653-3116-fdaa-1385ecdf0289@amazon.com>
 <CAK8P3a1NVGwYa1bw_vjBatd1xe-i875X1Vq1M+2G_Zxd2Oqusg@mail.gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <8f7840c3-a682-04a5-18bf-ac7a723725b0@amazon.com>
Date:   Mon, 9 Sep 2019 17:11:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1NVGwYa1bw_vjBatd1xe-i875X1Vq1M+2G_Zxd2Oqusg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.152]
X-ClientProxiedBy: EX13D15UWB002.ant.amazon.com (10.43.161.9) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2019 4:41 PM, Arnd Bergmann wrote:
> On Mon, Sep 9, 2019 at 1:13 PM Shenhar, Talel <talel@amazon.com> wrote:
>> On 9/9/2019 12:44 PM, Arnd Bergmann wrote:
>>> On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:
>>>> +       writel_relaxed(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
>>> Why do you require _relaxed() accessors here? Please add a comment
>>> explaining that, or use the regular readl()/writel().
>> I don't think commenting is needed here as there is nothing special in
>> this type of access.
>>
>> I don't see this is common to comment the use of the _relaxed accessors.
> I usually mention it in driver reviews, but most authors revert back
> to the normal accessors when there is no difference.
>
>> This driver is for SoC using arm64 cpu.
>>
>> If one uses the non-relaxed version of readl while running on arm64, he
>> shall cause read barrier, which is then doing dsm(ld).. This barrier is
>> not needed here, so we spare the use of the more heavy readl in favor of
>> the less "harmful" one.
>>
>> Let me know what you think.
> If the barrier causes no harm, just leave it in to keep the code more
> readable. Most developers don't need to know the difference between
> the two, so using the less common interface just makes the reader
> curious about why it was picked.
>
> Avoiding the barrier can make a huge performance difference in a
> hot code path, but the downside is that it can behave in unexpected
> ways if the same code is run on a different CPU architecture that
> does not have the exact same rules about what _relaxed() means.
>
> In fact, replacing a 'readl()' with 'readl_relaxed() + rmb()' can lead
> to slower rather than faster code when the explicit barrier is heavier
> than the implied one (e.g. on x86), or readl_relaxed() does not skip
> the barrier.
>
> The general rule with kernel interfaces when you have two versions
> that both do what you want is to pick the one with the shorter name.
> See spin_lock()/spin_lock_irqsave(),  ioremap()/ioremap_nocache(),
> or ktime_get()/ktime_get_clocktai_ts64(). (yes, there are also
> exceptions)
>
>      Arnd


Thanks for the detailed response.


In current implementation of v1, I am not doing any read barrier, Hence, 
using the non-relaxed will add unneeded memory barrier.

I have no strong objection moving to the non-relaxed version and have an 
unneeded memory barrier, as this path is not "hot" one.


Beside of avoiding the unneeded memory barrier, I would be happy to keep 
common behavior for our drivers:

e.g.

https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-al-fic.c#L49


So what do you think we should go with? relaxed or non-relaxed?


