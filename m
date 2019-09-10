Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D43C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2916921928
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uR30FecK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406445AbfIJGVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:21:32 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:24318 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIJGV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568096488; x=1599632488;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P2cS529XUmulKfRe/UANSM/dlb33mBmMJiHTNnM+zWE=;
  b=uR30FecKBi3b6JpiTLonlq8ol9c47cxJNNnPKm+81uJwY139oSzKn6Bq
   4qJFZww/tIRjUD4vT/Pi+BNV2MUO+MHB3vy+V7XQzY/wPoOmNdOswjuFu
   pdV/x54NMVMDofKkvBLeshixKlzk/5eTmnXjIP9rZipz9oyycG4oEFp7l
   k=;
X-IronPort-AV: E=Sophos;i="5.64,487,1559520000"; 
   d="scan'208";a="749910613"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Sep 2019 06:21:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 95BD1A0742;
        Tue, 10 Sep 2019 06:21:19 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 06:21:18 +0000
Received: from [10.125.238.52] (10.43.161.176) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 10 Sep
 2019 06:21:07 +0000
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
 <8f7840c3-a682-04a5-18bf-ac7a723725b0@amazon.com>
 <CAK8P3a1fbK-qoK+K1ZsWsU3rkxxZgZGaK8ywFAcM4va1GRn_FQ@mail.gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <b50ba032-51f7-3cd1-a302-30146560f636@amazon.com>
Date:   Tue, 10 Sep 2019 09:21:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1fbK-qoK+K1ZsWsU3rkxxZgZGaK8ywFAcM4va1GRn_FQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D31UWC002.ant.amazon.com (10.43.162.220) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2019 6:16 PM, Arnd Bergmann wrote:
> On Mon, Sep 9, 2019 at 4:11 PM Shenhar, Talel <talel@amazon.com> wrote:
>> On 9/9/2019 4:41 PM, Arnd Bergmann wrote:
>>
>> In current implementation of v1, I am not doing any read barrier, Hence,
>> using the non-relaxed will add unneeded memory barrier.
>>
>> I have no strong objection moving to the non-relaxed version and have an
>> unneeded memory barrier, as this path is not "hot" one.
> Ok, then please add it.
ok, shall be part of v2
>
>> Beside of avoiding the unneeded memory barrier, I would be happy to keep
>> common behavior for our drivers:
>>
>> e.g.
>>
>> https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-al-fic.c#L49
>>
>>
>> So what do you think we should go with? relaxed or non-relaxed?
> The al_fic_set_trigger() function is clearly a slow-path and should use the
> non-relaxed functions. In case of al_fic_irq_handler(), the extra barrier
> might introduce a measurable overhead, but at the same time I'm
> not sure if that one is correct without the barrier:
>
> If you have an MSI-type interrupt for notifying a device driver of
> a DMA completion, there might not be any other barrier between
> the arrival of the MSI message and the CPU accessing the data.
> Depending on how strict the hardware implements MSI and how
> the IRQ is chained, this could lead to data corruption.
>
> If the interrupt is only used for level or edge triggered interrupts,
> this is ok since you already need another register read in
> the driver before it can safely access a DMA buffer.
>
> In either case, if you can prove that it's safe to use the relaxed
> version here and you think that it may help, it would be good to
> add a comment explaining the reasoning.
Decided to go with the non-relaxed version as this is not hot path and 
likely be more clear to the common reader to have non relaxed version.
>
>         Arnd
