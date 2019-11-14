Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B842C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2CD206E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKNByC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:54:02 -0500
Received: from regular1.263xmail.com ([211.150.70.201]:56522 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNByC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:54:02 -0500
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 1F1D8405;
        Thu, 14 Nov 2019 09:53:49 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.9] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P47878T139986162661120S1573696426616732_;
        Thu, 14 Nov 2019 09:53:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <438ac3b0e67c996fd5c2911b5379e891>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: npcomplete13@gmail.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Soeren Moch <smoch@web.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Andy Yan <andyshrk@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Nick Xie <nick@khadas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Unune <npcomplete13@gmail.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
 <CAD=FV=UjbPALRU2r0s27F4RxjsbDyQ+horUBezVQejk1pT=vqA@mail.gmail.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <a6d41fc5-4ed5-6ec2-5697-ca2b0abe288c@rock-chips.com>
Date:   Thu, 14 Nov 2019 09:53:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UjbPALRU2r0s27F4RxjsbDyQ+horUBezVQejk1pT=vqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 2019/11/14 上午1:01, Doug Anderson wrote:
> Hi,
>
> On Sun, Nov 10, 2019 at 4:52 PM Kever Yang <kever.yang@rock-chips.com> wrote:
>> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
>> will be 'enable' with the dts node at a default PWM state with high or low
>> output. Both too high or too low for vdd_log is not good for the board,
>> add init voltage for driver to make the regulator get into a know output.
>>
>> Note that this will be used by U-Boot for init voltage output, and this
>> is very important for it may get system hang somewhere during system
>> boot up with regulator enable and without this init value.
> I'm a tad bit confused here.  When U-Boot boots the kernel, how is the
> PWM configured?
>
> I remember folks going through a lot of work to make sure that we
> could actually _read_ the PWM state that the bootloader gave us and
> report it as the initial voltage.  If the kernel ends up needing to
> configure the PWM regulator's period for some reason, I remember it
> would actually pick something close.  Is that not working for you?
>
> For instance, on rk3288-veyron when I boot up mainline (no devfreq on
> rk3288-veyron on mainline) the vdd_logic reports 1.2 volts because it
> read what the bootloader left it as.
>
> ...are you saying that U-Boot doesn't configure the PWM and you're
> trying to fix it up in the kernel?

U-Boot will configure the PWM with dts setting(and now U-Boot would like 
to sync the dts

from kernel directly):

- no dts node for pwm regulator, it will be default as input IO without 
any configure;

- with pwm regulator dts enable, no 'init-microvolt', enable PWM with 
default 0% output;

- with pwm regulator dts with 'init-microvolt', enable PWM with 
corresponding duty output;

We should leave it not configure(around 0.9V for most of board) or 
configure to correct

output(some boards need 0.95V while default is 0.9V for stability issue).

For the rk3399 boards on upstream, some of them do not have a vdd_log in 
dts,

and others have dts node but without 'init-microvolt' for init setting, 
that's what I want

to fix to make sure all the boards can work correctly.


Thanks,

- Kever

>
> -Doug
>
>
> -Doug
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>


