Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9114EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7A206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfJNKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:16:38 -0400
Received: from foss.arm.com ([217.140.110.172]:39604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbfJNKQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:16:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47578337;
        Mon, 14 Oct 2019 03:16:37 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43F333F718;
        Mon, 14 Oct 2019 03:16:36 -0700 (PDT)
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
 <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
 <20191011100521.GA5122@bogus> <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
 <2bf88cd2-9c4f-11dc-4b70-f717de891cff@samsung.com>
 <20191011131058.GA26061@bogus>
 <0b02b15f-38be-7a63-14cc-eabd288782eb@samsung.com>
 <20191011134354.GA31516@bogus> <20191011144233.GA2438@bogus>
 <7ef07169-4335-0a73-8bce-229433ef96f5@samsung.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <957bdc52-8eb1-8704-0a39-cad11e86c3d0@arm.com>
Date:   Mon, 14 Oct 2019 11:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7ef07169-4335-0a73-8bce-229433ef96f5@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 14/10/2019 10:02, Marek Szyprowski wrote:
> On 11.10.2019 16:42, Sudeep Holla wrote:
>> On Fri, Oct 11, 2019 at 02:43:54PM +0100, Sudeep Holla wrote:
>>> On Fri, Oct 11, 2019 at 03:15:32PM +0200, Marek Szyprowski wrote:
>>>> On 11.10.2019 15:10, Sudeep Holla wrote:
>>>>> On Fri, Oct 11, 2019 at 03:02:42PM +0200, Marek Szyprowski wrote:
>>>>>> On 11.10.2019 12:38, James Morse wrote:
>>>>>>> On 11/10/2019 11:05, Sudeep Holla wrote:
>>>>>>>> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
>>>>>>>>> Recently I've got access to ARM Juno R1 board and did some tests with
>>>>>>>>> current mainline kernel on it. I'm a bit surprised that enabling
>>>>>>>>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
>>>>>>>>> this Kconfig option, I get no single message from the kernel, although I
>>>>>>>>> have earlycon enabled.

>>>> my bootcmd is:
>>>>
>>>> tftp ${fdt_addr} juno/Image.gz; unzip ${fdt_addr} ${kernel_addr}; tftp
>>>> ${fdt_addr} juno/juno-r1.dtb; booti ${kernel_addr} - ${fdt_addr};
>>>>
>> If your ${kernel_addr}=0x80000000 or within first 32MB, then it will override
>> DTB with the image size I had(35MB). Even if kernel fits 32MB, there is a
>> chance that .bss lies beyond 32MB and it will be cleared during boot resulting
>> in DTB corruption(Andre P reminded me this)
>>
>> Can you try setting $${fdt_addr} to 0x84000000 to begin with ?
> 
> Right, my fault. Changing fdt_addr to something higher than the default 
> 0x82000000 fixed the boot issue. I wonder how I missed that, as I was 
> convinced that there is enough space for the kernel image. Sorry for the 
> noise...

Is it possible for uboot's booti command to print a warning in this case?
The size of the BSS is in the header as the 'effective size' of the kernel'.

(it must have taken a while to bisect this, and it just happened to pick a believable
commit that modified start_kernel()...)


Thanks,

James
