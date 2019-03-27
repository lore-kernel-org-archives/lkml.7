Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B695206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbfC0TDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:03:01 -0400
Received: from foss.arm.com ([217.140.101.70]:59472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389416AbfC0SNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E425A78;
        Wed, 27 Mar 2019 11:13:30 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091A73F557;
        Wed, 27 Mar 2019 11:13:23 -0700 (PDT)
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Mircea Pop <mircea.pop@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jun Li <jun.li@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Zening Wang <zening.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Leo Zhang <leo.zhang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Viorel Suman <viorel.suman@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <0ac4b527-2f79-4d21-7408-18c87cadb512@arm.com>
Date:   Wed, 27 Mar 2019 18:13:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 17:00, Leonard Crestez wrote:
> On Wed, 2019-03-27 at 17:06 +0100, Lucas Stach wrote:
>> Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
>>> On 27/03/2019 15:44, Lucas Stach wrote:
>>>> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
>>>>> This work is a workaround I'm looking into (more as a background task)
>>>>> in order to add support for cpuidle on i.MX8MQ based platforms.
>>>>>
>>>>> The main idea here is getting around the missing GIC wake_request signal
>>>>> (due to integration design issue) by waking up a each individual core through
>>>>> some dedicated SW power-up bits inside the power controller (GPC) right before
>>>>> every IPI is requested for that each individual core.
>>>>
>>>> Just a general comment, without going into the details of this series:
>>>> this issue is not only affecting IPIs, but also MSIs terminated at the
>>>> GIC. Currently MSIs are terminated at the PCIe core, but terminating
>>>> them at the GIC is clearly preferable, as this allows assigning CPU
>>>> affinity to individual MSIs and lowers IRQ service overhead.
>>>>
>>>> I'm not sure what the consequences are for upstream Linux support yet,
>>>> but we should keep in mind that having a workaround for IPIs is only
>>>> solving part of the issue.
>>>
>>> If this erratum is affecting more than just IPIs, then indeed I don't
>>> see how this patch series solves anything.
>>>
>>> But the erratum documentation seems to imply that only SGIs are
>>> affected, and goes as far as suggesting to use an external interrupt
>>> would solve it. How comes this is not the case? Or is it that anything
>>> directly routed to a redistributor is also affected? This would break
>>> LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
>>>
>>> What is the *exact* status of this thing? I have the ugly feeling that
>>> the true workaround is just to disable cpuidle.
>>
>> As far as I understand the erratum, the basic issue is that the GIC
>> wake_request signals are not connected to the GPC (the CPU/peripheral
>> power sequencer). The SPIs are routed through the GPC and thus are
>> visible as wakeup sources, which is why the workaround of using an
>> external SPI as wakeup trigger for the IPI works.
> 
> We had a kernel workaround for IPIs in our internal tree for a long
> time and I don't think we do anything special for PCI. Does PCI MSI
> really bypass the GPC on 8mq?

If you have an ITS, certainly. If you don't, it depends. MSIs can hit
the distributor's MBI registers and generate non-wired SPIs, which I
assume will bypass the GPC altogether.

> Adding Richard/Jacky, they might know about this.
> 
> This seems like something of a corner case to me, don't many imx boards
> ship without PCI; especially for low-power scenarios? If required it
> might be reasonable to add an additional workaround to disable all
> cpuidle if pci msis are used.

Establishing a link between cpuidle and PCI in the kernel would be
pretty invasive, and that would come on top of what this series also
mandates.

At that level of apparent brokenness, it is far safer to get cpuidle out
of the picture altogether, and I'd rather see these patches in a vendor
tree (for once).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
