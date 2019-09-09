Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5093C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94BE21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iThLrsB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfIIN7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:59:43 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63751 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405137AbfIIN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568037581; x=1599573581;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=K42g/AFNMDx/RgjzKJBTKWAce5pXZj/ROym93HlBV/I=;
  b=iThLrsB7pkHCwAmSPl2JFKAjReiQpTcVs4GslPOukjdC1ZlQolkkH/xN
   GC5nBTT2WFDl/oMVgNEcDhqOLtkewFS4ru5q5xCq4LTK4Fyve4Yb2MLO0
   4YACa25Pz9wgmhI+zccrkrJxl6/YN1ljnX4cf8BLQr4hc876TWhkmrhuO
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="829304744"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Sep 2019 13:59:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 0CCB1A1E19;
        Mon,  9 Sep 2019 13:59:12 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 13:59:12 +0000
Received: from [10.125.238.52] (10.43.160.27) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 9 Sep
 2019 13:59:01 +0000
Subject: Re: [PATCH 3/3] arm64: alpine: select AL_POS
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
 <1568020220-7758-4-git-send-email-talel@amazon.com>
 <CAK8P3a0DEMeFWK+RuAdSLyDYduWWwj9DxP_Beipays-d_6ixnA@mail.gmail.com>
 <ab512ced-d989-5c10-a550-2a4723d38e7e@amazon.com>
 <CAK8P3a34eKFXoAPOfkFN5+H4kxOhRjXgws_0wy+d-186LFxcTw@mail.gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <0d36f94d-596f-0ec7-6951-b097b5ee0d2d@amazon.com>
Date:   Mon, 9 Sep 2019 16:58:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a34eKFXoAPOfkFN5+H4kxOhRjXgws_0wy+d-186LFxcTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.27]
X-ClientProxiedBy: EX13D23UWA002.ant.amazon.com (10.43.160.40) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2019 4:45 PM, Arnd Bergmann wrote:
> On Mon, Sep 9, 2019 at 12:17 PM Shenhar, Talel <talel@amazon.com> wrote:
>> On 9/9/2019 12:40 PM, Arnd Bergmann wrote:
>>> On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:
>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>> index 4778c77..bd86b15 100644
>>>> --- a/arch/arm64/Kconfig.platforms
>>>> +++ b/arch/arm64/Kconfig.platforms
>>>> @@ -25,6 +25,7 @@ config ARCH_SUNXI
>>>>    config ARCH_ALPINE
>>>>           bool "Annapurna Labs Alpine platform"
>>>>           select ALPINE_MSI if PCI
>>>> +       select AL_POS
>>>>           help
>>>>             This enables support for the Annapurna Labs Alpine
>>>>             Soc family.
>>> Generally I think this kind of thing should go into the defconfig
>>> rather than being hard-selected. There might be users that
>>> want to not enable the driver.
>> The reason for selecting it is because this is a driver that we will
>> always want for ARCH_ALPINE.
> Can you put the exact requirement (other than "we want this")
> in the changelog text then? It's still not clear to me what breaks
> without this driver.
>
>          Arnd

Its not that something will get broken. its error event detector for POS 
events which allows seeing bad accesses to registers.

What is the general rule of which configs to put under select and which 
under defconfig?

I was thinking that "general" SoC support is good under select - those 
things that we always want.

And specific features, e.g. RAID support or features that supported only 
on specific HW shall go under defconfig.


Similar, I see ARCH_LAYERSCAPE selecting EDAC_SUPPORT.


Will love to hear the general rule for select vs defconfig.

