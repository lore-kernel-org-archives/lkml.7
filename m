Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD0BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B96B20836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfKYOLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:11:25 -0500
Received: from ns.iliad.fr ([212.27.33.1]:43692 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKYOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:11:25 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E46E320C1C;
        Mon, 25 Nov 2019 15:11:22 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id CDF0620BCE;
        Mon, 25 Nov 2019 15:11:22 +0100 (CET)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125530.GP25745@shell.armlinux.org.uk>
 <c7414301-da0d-cd4d-237d-34277f5ee1d2@free.fr>
 <20191125133752.GS25745@shell.armlinux.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <21c242a9-3599-3288-79bf-a8889fad2a73@free.fr>
Date:   Mon, 25 Nov 2019 15:11:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125133752.GS25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Nov 25 15:11:22 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 14:37, Russell King - ARM Linux admin wrote:

> On Mon, Nov 25, 2019 at 02:10:21PM +0100, Marc Gonzalez wrote:
>
>> On 25/11/2019 13:55, Russell King - ARM Linux admin wrote:
>>
>>> It's also worth reading https://lore.kernel.org/patchwork/patch/755667/
>>> and considering whether you really are using the clk_prepare() and
>>> clk_enable() APIs correctly.  Wanting these devm functions suggests
>>> you aren't...
>>
>> In that older thread, you wrote:
>>
>>> If you take the view that trying to keep clocks disabled is a good way
>>> to save power, then you'd have the clk_prepare() or maybe
>>> clk_prepare_enable() in your run-time PM resume handler, or maybe even
>>> deeper in the driver... the original design goal of the clk API was to
>>> allow power saving and clock control.
>>>
>>> With that in mind, getting and enabling the clock together in the
>>> probe function didn't make sense.
>>>
>>> I feel that aspect has been somewhat lost, and people now regard much
>>> of the clk API as a bit of a probe-time nuisance.
>>
>> In the few drivers I've written, I call clk_prepare_enable() at probe.
> 
> Right, so the clocks are enabled as soon as the device is probed,
> in other words at boot time. It remains enabled for as long as the
> device is bound to its driver, whether or not the device is actually
> being used. Every switching edge causes heat to be generated. Every
> switching edge causes energy to be wasted.
> 
> That's fine if you have an infinite energy supply. That hasn't been
> discovered yet.
> 
> Given the prevalence of technology, don't you think we should be
> doing as much as we possibly can to reduce the energy consumption
> of the devices we use? It may be peanuts per device, but at scale
> it all adds up.

OK, I'm starting to see the bigger picture.

(To provide some rationale for the patch, I think devm is a huge
improvement for probe error-handling, and I did not understand
why every driver must do manual error-handling when dealing with
clocks in probe.)

I did envision kernel modules being loaded on an as-needed basis,
somewhat side-stepping the energy-waste issue you point out.
But I realize that such a use-case may be uncommon. (Especially
due to module auto-loading.)

A few months ago, I was discussing a similar issue with GKH:
Consider a device with a "START" register. Basically, if we write 0,
the device turns itself off; if we write 1, it runs as configured.

I was trying to start the device only when at least one user had
it "open". So I used reference counting, and started the device
on 0->1 open transitions, and stopped the device on 1->0 close
transitions. GKH told me that was the wrong way to do it, and IIRC
suggested to start the device in probe.

I probably misunderstood Greg's suggestion. Where is the right place
to start/stop a device (or gate its clocks)?

Regards.
