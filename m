Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50742C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F1620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfDQIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:40:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:40:25 -0400
Received: from [192.168.1.110] ([95.117.89.119]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2NqA-1hHEKA0bIU-003slx; Wed, 17 Apr 2019 10:39:08 +0200
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20190416155618.1369-1-TheSven73@gmail.com>
 <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net>
 <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
 <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net>
 <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3103f45a-facf-89a3-8a36-84507c570909@metux.net>
Date:   Wed, 17 Apr 2019 10:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:J1VGXw/sIMk06lVpe/qj508MUrpovhkBenvF/IWqgpKrFMDJCCi
 JAuod9W+gm9PMJtnIzQ+jOb/NxQm964O909uNBm5QwN8OpPaiEPrmEMTTHp/lL2L5kHRPIe
 l0mkTSRW7r2CTkKF03oY8os+hmsZcWby8FcvUDOakABsGroH4+NRDNn65UaOaz9COzfGGVK
 2HGAlryCah2Ga0R3L+GIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ucpNO5lO9Gk=:o2KacvIlBEHT6L27wjw/6p
 wHeHWCjS/7KCalOgi11nYrN2oMNQacveFCn02kp5AXE3G3wFpANUe/dvAhy/RLUESh01Pkwf6
 ZEB+DkDX3+e/2bPAccz1fNRsAAqEGbFl4VYw4Xf8/VJ21IwpySgCklX66HXpBnjBFlUr4IBM7
 2rxPuxq+pysrcU5IJjGHEAn1lb5CIjYoTHb3VOGYTvoS2EiOvalGZeKbWYr0mL+x1W2GsHAkx
 VcOmF3Q2u/fdqFl02kMiYUp7aiw9pSf1UxIokzq6NKUbIqNA9rHZ7srXNXCwNTlpS74ASkpVd
 UANpAxf/XAtf0z1f6RcjVQxT3SS0fGNpKEszDaBQp2OYFVdDTv4EXl/VAxazvy6M34UHVXU4J
 w3OFTJnYeu7Tn867EQYRrIvXyUdrNm1lRzqFWBKXfp8Lxlz/NayWI9dd4hDdLv+o6YISG+Bcu
 I0Cc1/E+R4bbpZ7KreHw8e4mEB0ErAslEDMq6HgKLD88pRijcC5Z4cngxiXdSNaQJsfi5HxOz
 GHgXMCOkvwSE0s13QanNpujNrCCVJYxOEYockr/wkzfr5k5M68+3Wvx7mUZyLuKCAr9aIGlhv
 PwwQzxgFQiXl9XL5w7k1aw76Hr2eCDRFOxSgPssg3SWdxeG4LzevjnQ1Zx2eYc+FWNl/tHJEs
 uzLsF+Mk5gIsco0NY3FQPfXVCYUUJ3+ELQsk73ZrJsYt634VuH3TDb0H1Ivu/F4NYbzZPWP2f
 jCWWY3QvL5Lb1FEIHWlHmG0dTpT7mXTwKFlt8lup51egOaOGP4beVvX/BhU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 23:23, Sven Van Asbroeck wrote:

Hi,

> Well yes, we could treat it as an mfd device, with a common register accessor,> which registers anybus-s host and adc drivers, all selectable via>
Kconfig / defconfig... But that's a lot of extra code just to handle one
single> bit in a register, which is a boolean input.> > Can be done but
is it worth it?
hmm, I think the main question here is clean separation between
subsystems - devices that span multiple subsystems, IMHO, fall
into the category "mfd".

separate drivers probably don't make much sense here, but maybe
a CONFIG_ flag for disabling this functionality ?

>> Does this power read-out involve some CAN traffic, or is it just
>> fetching from some card that just happens to be some CAN interface ?
>> (IOW: is cansocket needed for that ?)
> 
> It is purely a boolean input. The boolean output of a voltage monitor chip.
> When our hardware is assembled, the voltage monitor input is connected
> to a signal which indicates the CAN status. In theory, it could be connected
> to the factory's light switch. It would then read out the status of the factory
> floor lights. It has no CAN functionality whatsoever.

hmm, wouldn't the input subsystem be more appropriate for that ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
