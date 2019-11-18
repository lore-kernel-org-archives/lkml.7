Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAB1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD020715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKRWsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:48:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:46356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfKRWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:48:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2028EAE55;
        Mon, 18 Nov 2019 22:48:33 +0000 (UTC)
Subject: Re: [PATCH v3 8/8] ARM: realtek: Enable RTD1195 arch timer
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        James Tai <james.tai@realtek.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-9-afaerber@suse.de> <20191117110214.6b160b2e@why>
 <7015e4c4-f999-d2e8-fd1f-e15e74a0d092@suse.de>
 <e99e40d8c95147861ab600c5d5287f8f@www.loen.fr>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <4dc05879-f6d9-f754-908e-ad2431d8ff5a@suse.de>
Date:   Mon, 18 Nov 2019 23:48:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <e99e40d8c95147861ab600c5d5287f8f@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Am 18.11.19 um 10:27 schrieb Marc Zyngier:
> On 2019-11-17 17:08, Andreas Färber wrote:
>> Am 17.11.19 um 12:02 schrieb Marc Zyngier:
>>> On Sun, 17 Nov 2019 08:21:09 +0100
>>> Andreas Färber <afaerber@suse.de> wrote:
>>>
>>>> Without this magic write the timer doesn't work and boot gets stuck.
>>>>
>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>> ---
>>>>  What is the name of the register 0xff018000?
>>>>  Is 0x1 a BIT(0) write, or how are the register bits defined?
>>>>  Is this a reset or a clock gate? How should we model it in DT?
>>
>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Sorry? Do you expect me to come up with answer to these questions?

No, I was pointing out that I myself had already asked pretty much the
same questions you just asked me. How did you expect me to have answers
to your "Shouldn't this be a read/modify/write sequence?" then? It
seemed like you missed my questions up there:

Without knowing how the register is structured, I can't implement a
read/modify/write sequence - for that we'd need to know whether it's a
single bit we can just set or a field that we would need to mask first
before writing into it.

And ideally we would be getting its address from DT, so we would need to
know whether it's just this one register or some contiguous IP block
such as "arm,armv7-timer-mem". Same issue whether we implement it in the
kernel or in U-Boot btw. If it's no standard Arm register, we'll need to
have a binding with a sensible compatible string, some REG_ constant to
replace the magic offset number and some meaningful constant for 0x1.

>>>> diff --git a/arch/arm/mach-realtek/rtd1195.c
>>>> b/arch/arm/mach-realtek/rtd1195.c
>>>> index b31a4066be87..0532379c74f5 100644
>>>> --- a/arch/arm/mach-realtek/rtd1195.c
>>>> +++ b/arch/arm/mach-realtek/rtd1195.c
[...]
>>>> @@ -24,6 +27,18 @@ static void __init rtd1195_reserve(void)
>>>>      rtd1195_memblock_remove(0x18100000, 0x01000000);
>>>>  }
>>>>
>>>> +static void __init rtd1195_init_time(void)
>>>> +{
>>>> +    void __iomem *base;
>>>> +
>>>> +    base = ioremap(0xff018000, 4);
>>>> +    writel(0x1, base);
>>>> +    iounmap(base);
>>>> +
>>>> +    of_clk_init(NULL);
>>>> +    timer_probe();
>>>> +}
>>>
>>> Gawd... Why isn't this set from the bootloader? By the time the kernel
>>> starts, everything should be up and running. What is it going to do
>>> when you kexec? Shouldn't this be a read/modify/write sequence?
>>
>> Again, I can't comment on why their BSP bootloaders don't do things the
>> expected way. The list of issues is long, and the newest U-Boot I've
>> seen for RTD1395 was v2015.07 based, still downstream and pre-EBBR.
>> And before we get a .dts merged into the kernel with all needed nodes
>> (network, eMMC, etc.), there is zero chance of a mainline U-Boot anyway.
> 
> [...]
> 
> I certainly dispute that. 

Dispute that with U-Boot maintainers then, please, and let me know the
outcome. I just had an argument with Neil that it's not okay to import
from linux-next.git and that it must be an -rc1 or other stable tag. (My
VIM3 patch submission before Plumbers was not accepted for that reason,
and I haven't found time for U-Boot since.)

> If you're able to support all of this in the
> kernel,

No, I'm not, that was my point! :( We do _not_ have all those drivers
needed for a useful U-Boot implemented for the mainline kernel yet. Like
I said, I'm using a Busybox initrd for testing RTD1195 (also RTD1293,
RTD1296 and RTD1395). And I've already amassed 140+ patches on top of
-next without those core drivers - I really need to get that queue down
for sensible collaboration with Realtek and others.

I need people to be able to help contribute those drivers to the kernel,
therefore I need to get the basics merged, so that Realtek and community
members can base patches on top, so that we get there over time.
If you're asking that someone do a new U-Boot before we can even get a
timer or GIC DT node merged, then we're doomed and I'm wasting my time
here. Rob did give a Reviewed-by for the DT, so I would've thought it
can't be that terrible!

As I pointed out above, we need to get the .dts[i] into some -rc1 kernel
release for U-Boot to pull them. If you're blocking to merge RTD1195
into v5.6-rc1 here, we're not gonna get even a driver-less mainline
U-Boot for it in about 8 weeks. Chicken-and-egg problem.

And my experience with U-Boot has been that if U-Boot patches don't get
merged immediately, other people will duplicate that work later without
crediting me, so that my time spent on U-Boot would be wasted. And the
same is happening with the kernel if we don't get my patches merged in
some form - you already witnessed Aleix doing his own irqchip driver
instead of collaborating on the one that went through three rounds of
review already (and now he's disappeared again without input for me, so
I'm preparing to send you a v4 tonight or tomorrow). STM32 was another
bad experience (and I still have two further v7-M ports to clean up).

With the GeekBox, that I'm the official U-Boot maintainer of, I managed
to shoot myself in the foot, unable to recover from a U-Boot I flashed.
So I am very hesitant to repeat that, especially with RTD1195 hardware
that's no longer sold (X1000).

> you're most probably able to do it in u-boot, and that's the right
> place to do it (and that can be a pretty simple u-boot if you use the
> original one as a first-stage loader).
> 
> I'm not trying to undermine your effort in supporting these platforms
> in mainline. This is certainly commendable. But you're unfortunately
> pushing in a direction that we've tried hard to move away from for
> a good 8 years.
> 
> Look at what we did on the Allwinner front: we got a terrible piece of
> crap, and turned it into one of the best supported platform, because
> we've put the effort where it mattered. I personally wrote PSCI support
> and HYP enablement in u-boot, addressing in one go most of the issues you
> mention here. It didn't take that much time, and it is now there for you
> to make use of.

And the work of the sunXi community - including Bootlin and Arm people -
is commendable and inspiring (e.g., meson-tools).

My time as single person is limited for this night-time project though,
so it's unrealistic to ask me to reverse-engineer a new BL31 without
sources, write a U-Boot implementation and port the kernel, all at once.
Especially when I don't know how to even test those other components.
Maybe that's clear to you - for me it isn't. The RTD1395, where I do
have U-Boot sources for BPi-M4 [2] and get it loaded as file from SD by
a previous bootloader, is not affected by this RTD1195 timer problem;
yet I don't see how from any given U-Boot (or LK) I would be able to
load a new BL31 on RTD1295/RTD1395, nor how to load a HYP capable U-Boot
on RTD1195. I thought it's impossible to escape to higher ELs? And for
ARMv7 I thought U-Boot was neither relocatable not reentrant?

Now, I can continue carrying this commit in my GitHub tree for myself,
like I do for spin-table, if Olof and Arnd agree with you that this 8/8
should not be merged, even if we clarify this register. But I just don't
see the time right now for doing alone what the sunxi community have
achieved together over the course of many years, with Realtek in my neck
for new kernel patches.

The context here is that most of the drivers seen on RTD1295 and later
originated in RTD1195, so for sane compatible strings (cf. watchdog [3],
rtc [4] discussions!) we need to be able to test RTD1195 and to base
patches, such as upcoming irqchip mux v4, on all four+ SoC families.
Realtek appears to be focused on the new RTD1619/RTD1319, and I would
really like to avoid merging drivers for those new chips only and caring
about bindings and compatibility with the three earlier SoC families as
afterthought, repeating the mistakes I made with RTD1295 vs. RTD1195 for
lack of hardware at the time.

I don't think that I'm pushing into a wrong direction; we just disagree
about the steps to get there. I would like people to be able to take a
mainline kernel and boot on RTD1195 without getting stuck; if they have
to use a GitHub tree to successfully boot, then it's not really mainline
yet. Booting with only one CPU up is much less severe by comparison, as
it allows to probe all drivers and to explore sysfs and debugfs.

Keep in mind that I started RTD1295 mainlining without having any BSP
sources at all, which is less than the sunxi folks had to go on.

The key on sunxi, I thought, was that you had the FEL tools to just load
bootloader binaries dynamically over USB. For Amlogic we at least had
binary blobs and binary tools integrated into U-Boot build process and
an idea where to place them on SD to boot them - here I have only what
is on eMMC/SPI, no docs. Also, I do recall a long time where sunxi had
GitHub repos with downstream BSP forks - I'd rather not get into that
business and immediately skip to making mainline more and more usable.

If of course Realtek or one of their OEMs or some other community member
wanted to work on providing a rebased U-Boot in a Git repo, that would
be great. Once we have it working, we could drop workarounds like these.

A quick git-grep finds 277 occurrences of .init_time in arch/arm/mach-*,
so hardly a callback about to get dropped.

Regards,
Andreas

[1] https://github.com/BPI-SINOVOIP/BPI-W2-bsp/tree/master/u-boot-rtk
[2] https://github.com/BPI-SINOVOIP/BPI-M4-bsp/tree/master/u-boot-rtk
[3] https://patchwork.kernel.org/patch/11200563/
[4] https://patchwork.kernel.org/patch/11200561/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
