Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B067F206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564405376;
	bh=Nj50RvGIEgpAZ37LNTWS5ynqsMWjn3lmP7Ky+d2eWR0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EyfxGpCpokLgWV8S8WDf/Vix8hB25jMmTNPRXlYgN8axc6cx7M6VHq32fEW1Q23M5
	 AZuo2IN7HW8MtjGwfh45moS1u5IcGsAH912tkypFA3YEYVCzdsCMpfxe4wJuCWFwAl
	 cxTxIxucIEyVYcCVYp/iA0KCcc1yvMRzoupVMA+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfG2NCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:02:55 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:13992
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbfG2NCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:02:54 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 09:02:53 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AWAAAF6z5d/zXSMGcNWRkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgWeDBIEuhB6RZQEBAQEBBoEJCCWDZIV+kRoJAQEBAQE?=
 =?us-ascii?q?BAQEBKwwBAYRAAoMPOBMBAwEBAQQBAQEBBQGFUjmFVgEBAQECASMVQQULCw0?=
 =?us-ascii?q?LAgImAgJXBg0GAgEBgx4BgXYFHqsccYEyGoQZARRAQIMxgUiBDCiBY4oUeIE?=
 =?us-ascii?q?HgTgMgl8+gmEEgTiDMoJYBIxFggSGL5V/CYIchluNMwYbgxuKMgOKPpQpXJI?=
 =?us-ascii?q?bgXkzGggoCDuCOAEBMgmGKoRZhgxgjBmCUgEB?=
X-IPAS-Result: =?us-ascii?q?A2AWAAAF6z5d/zXSMGcNWRkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgWeDBIEuhB6RZQEBAQEBBoEJCCWDZIV+kRoJAQEBAQEBAQEBKwwBAYRAA?=
 =?us-ascii?q?oMPOBMBAwEBAQQBAQEBBQGFUjmFVgEBAQECASMVQQULCw0LAgImAgJXBg0GA?=
 =?us-ascii?q?gEBgx4BgXYFHqsccYEyGoQZARRAQIMxgUiBDCiBY4oUeIEHgTgMgl8+gmEEg?=
 =?us-ascii?q?TiDMoJYBIxFggSGL5V/CYIchluNMwYbgxuKMgOKPpQpXJIbgXkzGggoCDuCO?=
 =?us-ascii?q?AEBMgmGKoRZhgxgjBmCUgEB?=
X-IronPort-AV: E=Sophos;i="5.64,322,1559491200"; 
   d="scan'208";a="200466061"
Received: from unknown (HELO [10.44.0.193]) ([103.48.210.53])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 29 Jul 2019 20:53:32 +0800
Subject: Re: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        arm-soc <arm@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
References: <20190415202501.941196-1-arnd@arndb.de>
 <2424c672-e3fb-4c32-4c24-fafc59d03a96@uclinux.org>
 <CACRpkdaJ+2bub_nDp9=5b4kyKjWDnOGKscWg3KsEVixDpk8rzA@mail.gmail.com>
 <20190503170613.GA1783@roeck-us.net>
 <d8d81aca-722d-8b5f-cd5f-30cc3e4e407b@kernel.org>
 <CAK8P3a0StV==jMq1L9k91qEsvRD1Cw2FB1V25wr1AQqzmjsTVw@mail.gmail.com>
From:   Greg Ungerer <gerg@kernel.org>
Message-ID: <2bc41895-d4f9-896c-0726-0b2862fcbf25@kernel.org>
Date:   Mon, 29 Jul 2019 22:53:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0StV==jMq1L9k91qEsvRD1Cw2FB1V25wr1AQqzmjsTVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 23/7/19 12:44 am, Arnd Bergmann wrote:
> On Sat, May 4, 2019 at 4:27 PM Greg Ungerer <gerg@kernel.org> wrote:
>> On 4/5/19 3:06 am, Guenter Roeck wrote:
>>> On Fri, May 03, 2019 at 08:16:05AM +0100, Linus Walleij wrote:
>>>> On Fri, May 3, 2019 at 8:02 AM Greg Ungerer <gerg@uclinux.org> wrote:
>>>>> Ultimately though I am left wondering if the ks8695 support in the
>>>>> kernel is useful to anyone the way it is at the moment. With a minimal
>>>>> kernel configuration I can boot up to a shell - but the system is
>>>>> really unreliable if you try to interactively use it. I don't think
>>>>> it is the hardware - it seems to run reliably with the old code
>>>>> it has running from flash on it. I am only testing the new kernel,
>>>>> running with the existing user space root filesystem on it (which
>>>>> dates from 2004 :-)
>>>>
>>>> Personally I think it is a bad sign that this subarch and boards do
>>>> not have active OpenWrt support, they are routers after all (right?)
>>>> and any active use of networking equipment should use a recent
>>>> userspace as well, given all the security bugs that popped up over
>>>> the years.
> 
> Looking around on the internet, I found that Micrel at some point
> had their own openwrt fork for ks8695, but I can't find a copy
> any more, as the micrel.com domain is no longer used after the
> acquisition by Microchip.

I build it with uClinux-dist, https://sourceforge.net/projects/uclinux/files/uClinux%20Stable/.
And again I can build for it, it just doesn't currently work
in any sort of reasonable way. So I get the impression it
hasn't worked for a while and nobody has noticed.


> https://wikidevi.com/wiki/Micrel has a list of devices based on
> ks8695, and it seems that most of these are rather memory
> limited, which is a problem for recent openwrt builds.
> 
> Only two of the 17 listed devices have the absolute minimum of 4MB
> flash and 32MB RAM for openwrt, two more have 8/32 and one
> or two have 4/64, but all these configurations are too limited for the
> web U/I now.


>>>> With IXP4xx, Gemini and EP93xx we have found active users and
>>>> companies selling the chips and reference designs and even
>>>> recommending it for new products (!) at times.  If this is not the
>>>> case with KS8695 and no hobbyists are willing to submit it
>>>> to OpenWrt and modernize it to use device tree I think it should be
>>>> deleted from the kernel.
>>>>
>>>
>>> That may be the best approach if indeed no one is using it,
>>> much less maintaining it.
>>
>> Well, I for one don't really use it any more. So I don't have a lot
>> of motivation to maintain it any longer.
> 
> I came across my patches while rebasing my backlog to 5.3-rc1.
> 
> Should I save the (very small) trouble of sending them out again
> and just remove the platform then?

At this time I have no issue with removing it.

Regards
Greg

