Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DFC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA286207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfLIOwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:52:09 -0500
Received: from mail.manjaro.org ([176.9.38.148]:55212 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfLIOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:52:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id ED77136E3C6B;
        Mon,  9 Dec 2019 15:52:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ROUn39D3oXYX; Mon,  9 Dec 2019 15:52:04 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
To:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
 <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com>
 <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
Message-ID: <5baf8423-8aa6-21a4-b066-71e3d12330cd@manjaro.org>
Date:   Mon, 9 Dec 2019 15:51:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Mon, Dec 9, 2019 at 8:29 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 06/12/2019 6:45 pm, Anand Moon wrote:
>>> Most of the RK3399 SBC boards do not perform clean
>>> shutdown and clean reboot.
>> FWIW reboot problems on RK3399 have been tracked down to issues in
>> upstream ATF, and are unrelated to the PMIC.
>>
>>> These patches try to help resolve the issue with proper
>>> shutdown by turning off the PMIC.
>> As mentioned elsewhere[1], although this is what the BSP kernel seems to
>> do, and in practice it's unlikely to matter for the majority of devboard
>> users like you and me, I still feel a bit uncomfortable with this
>> solution for systems using ATF as in principle the secure world might
>> want to know about orderly shutdowns, and this effectively makes every
>> shutdown an unexpected power loss from secure software's point of view.
>>
>> Robin.
> Since ATF is operating completely in volatile memory, and shouldn't be
> touching hardware once it passes off control to the kernel anyways,
> what is the harm of pulling the rug out from under it?
> If this idea is to prevent issues in the future, such as if ATF does
> gain the ability to preempt hardware control, then at that time ATF
> will need to be able to handle actually powering off devices using the
> same functionality.

As far as I know ATF implements PSCI, doesn't it? Thus I would assume 
that it should most definitely handle power off for all platforms as 
indicated by the presence of platform handlers in [1].

> But as we discussed previously, ATF doesn't have this capability, so
> in this case any board without a dedicated power-off gpio will be
> unable to power off at all.
> Also it seems that giving ATF this functionality, with the current
> state of ATF, would be cost prohibitive.
>
> I personally feel that allowing the kernel to do this is a solution to
> the problem we have now.

Maybe I'm missing something here but I'd suggest that implementing an 
i2c driver in the rockchip platform part of ATF using libfdt to find the 
PMIC from the devicetree would be the way to go.

[1] 
https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/psci/psci_system_off.c#L31

