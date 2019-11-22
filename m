Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1874C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A942520706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKVMsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:48:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfKVMsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:48:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 964A4B1B1;
        Fri, 22 Nov 2019 12:48:41 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
To:     Marc Zyngier <maz@misterjones.org>,
        James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
 <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
 <279fd3a3-17dc-5796-f0b0-e39eb919081f@suse.de>
 <7c94c59649c04442886a98c057c07654@realtek.com>
 <23f44f6f4aec90b412d5d7ff6f4d95f1@www.loen.fr>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <80d0aed8-3b85-1312-1091-0ced3ab1f5d2@suse.de>
Date:   Fri, 22 Nov 2019 13:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <23f44f6f4aec90b412d5d7ff6f4d95f1@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.11.19 um 10:43 schrieb Marc Zyngier:
> On 2019-11-17 15:39, James Tai wrote:
>> Hi Andreas,
>>
>>> > Sorry for my misunderstanding. The RAM region don't require two cells
>>> > for memory nodes, so I'll fix it in v3 patch.
>>>
>>> Should I then also change RTD1395 to use only one cell, or does it
>>> support
>>> more RAM than RTD1619?
>>
>> Yes, you can. The memory capacity of RTD1395 and RTD1619 are the same.
>>
>>> By my calculation 0x98000000 is less than 2.4 GiB! So, does RAM continue
>>> between r-bus and GIC, similar to how it does on RTD1195? Then we
>>> need to
>>> exclude those RAM ranges from the SoC node (adjusting 0x68000000).
>>
>> We need to reserve memory address for r-bus and GIC and exclude those
>> RAM range from the SoC node.
> 
> Memory for the GIC? For what purpose?

MMIO, for GICD and GICR. It's about fixing the ranges of the /soc node:

My proposed
ranges = <0x98000000 0x98000000 0x68000000>;
needs to be split, with a gap between r-bus and GIC for continued RAM.

https://github.com/afaerber/linux/commit/1884ec6a533c9d5c2b6ca40ee138ff7e8312b6c8

This goes back to Rob's review of RTD1295 [1], where we then for lack of
memory space documentation assumed that everything beyond 2 GiB would be
potential register space. Here we're dealing with up to 4 GiB though.


James, are you planning to send a fix-up patch here? If not, you'll need
to tell me what values to use, e.g., is there a NOR flash region on
RTD1619, and does RAM continue also in between and after GIC, or is
there some timer register behind it, like on RTD1195?

ranges = <0x00000000 0x00000000 0x00030000>, // ??? boot ROM size
         <0x98000000 0x98000000 0x00200000>, // r-bus
         // anything here? e.g., NOR flash?
         <0xff100000 0xff100000 0x00010000>, // GICD
         <0xff140000 0xff140000 0x000c0000>; // GICR
         // anything here? e.g., timer enable?

ranges = <0x00000000 0x00000000 0x00030000>,
         <0x98000000 0x98000000 0x00200000>,
         <0xff100000 0xff100000 0x00100000>; // whole GIC?

Regards,
Andreas

[1] https://patchwork.kernel.org/patch/9588611/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
