Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC18C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DD920815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfEPQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:00:09 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45226 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfEPQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:00:00 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 07E472064E;
        Thu, 16 May 2019 17:59:59 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id ECB6920581;
        Thu, 16 May 2019 17:59:58 +0200 (CEST)
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        arm-soc <arm@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190516064304.24057-1-olof@lixom.net>
 <20190516064304.24057-2-olof@lixom.net>
 <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <aad06de6-b85c-b549-5653-45f9c4ebb384@free.fr>
Date:   Thu, 16 May 2019 17:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu May 16 17:59:59 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 17:33, Linus Torvalds wrote:

> On Wed, May 15, 2019 at 11:43 PM Olof Johansson wrote:
>>
>> SoC updates, mostly refactorings and cleanups of old legacy platforms.
>> Major themes this release:
> 
> Hmm. This brings in a new warning:
> 
>   drivers/clocksource/timer-ixp4xx.c:78:20: warning:
> ‘ixp4xx_read_sched_clock’ defined but not used [-Wunused-function]
> 
> because that drivers is enabled for build testing, but that function
> is only used under
> 
>   #ifdef CONFIG_ARM
>         sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
>   #endif
> 
> It's not clear why that #ifdef is there. This driver only builds
> non-ARM when COMPILE_TEST is enabled, and that #ifdef actually breaks
> that build test.
> 
> I'm going to remove that #ifdef in my merge, because I do *not* want
> to see new warnings, and it doesn't seem to make any sense.
> 
> Maybe that's the wrong resolution, please holler and let me know if
> you want something else.

Hello BDFL,

Your email client did something strange by changing

	linux-arm-kernel@lists.infradead.org
to
	"linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>

which is odd  ;-)


As for your actual remark, I note that Olof has an arm/late branch
(which I assume he plans to submit in a few days?) which contains
the change you mention:

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=arm/late
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=arm/late&id=5cb9de627e25421e2e2edaff6360c84d32cd3c02

Regards.
