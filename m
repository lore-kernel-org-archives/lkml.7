Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122712089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bQvc3MUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393401AbfIJGS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:18:26 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29660 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfIJGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568096304; x=1599632304;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NUby1e5z8ZmZZG/r8xjMa7/ADWenJfdiJrb9sSaJJJI=;
  b=bQvc3MUJ5s/JTaKRQOCHqdJgS4wK5znTY/wujDnOWfMBwqfAuUaUnHTA
   MPa3I7cBCEoeYlhsz+SCpkX6g3K/Noib0oP1sK8eH7NJ9eqbZsLm6i/9e
   3he7IEKymrEaf5B8nSCiKYOmbPUa+fmX7xHUNxKAbuDojZ/W/CZQnP4ge
   U=;
X-IronPort-AV: E=Sophos;i="5.64,487,1559520000"; 
   d="scan'208";a="701737185"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Sep 2019 06:17:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 374E0A226A;
        Tue, 10 Sep 2019 06:17:28 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 06:17:28 +0000
Received: from [10.125.238.52] (10.43.161.82) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 10 Sep
 2019 06:17:17 +0000
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
 <0d36f94d-596f-0ec7-6951-b097b5ee0d2d@amazon.com>
 <CAK8P3a0RUHxcpyUJU5bpd8nqpm0Sqhy4aJaoh7K9jVn8zJC6aQ@mail.gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <a616c903-6d3e-cf84-8afb-ade48d5ca68f@amazon.com>
Date:   Tue, 10 Sep 2019 09:17:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0RUHxcpyUJU5bpd8nqpm0Sqhy4aJaoh7K9jVn8zJC6aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2019 6:08 PM, Arnd Bergmann wrote:
> On Mon, Sep 9, 2019 at 3:59 PM Shenhar, Talel <talel@amazon.com> wrote:
>> On 9/9/2019 4:45 PM, Arnd Bergmann wrote:
>>
>> Its not that something will get broken. its error event detector for POS
>> events which allows seeing bad accesses to registers.
>>
>> What is the general rule of which configs to put under select and which
>> under defconfig?
>>
>> I was thinking that "general" SoC support is good under select - those
>> things that we always want.
> I generally want as little as possible to be selected, basically only
> things that are required for linking the kernel and booting it without
> potentially destroying the hardware.
>
> In particular, I want most drivers to be enabled as loadable modules
> if possible. When you have general-purpose distributions support
> your platform, there is no need to have this module built-in while
> running on a different chip, even if you always want to load the
> module when it's running on yours.
>
>> And specific features, e.g. RAID support or features that supported only
>> on specific HW shall go under defconfig.
>>
>> Similar, I see ARCH_LAYERSCAPE selecting EDAC_SUPPORT.
> I think this was done to avoid a link failure. It's also possible that this
> is a mistake and just did not get caught in review.
>
>         Arnd


I see.

Will remove this from v2.

