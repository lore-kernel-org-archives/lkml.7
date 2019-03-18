Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B659020863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCRR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:59:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39152 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfCRR7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:59:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E895EBD;
        Mon, 18 Mar 2019 10:59:21 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F0C3F614;
        Mon, 18 Mar 2019 10:59:18 -0700 (PDT)
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro> <86zhqm8i6d.wl-marc.zyngier@arm.com>
 <20190224035356.GD572@tuxbook-pro>
 <33d765b5-1807-fa6c-1ceb-99f09f7c8d5a@free.fr>
 <8eb4f446-6152-ffb6-9529-77fb0bcc307f@arm.com>
 <20190318170041.qu4x2565fmno6sei@shell.armlinux.org.uk>
 <5ba7c4d0-30ec-e38d-41dc-653fd5cb7f05@arm.com>
 <fbacd3df-41c4-f98a-8875-db654aff3a5c@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0c06cb51-fc33-f2ba-e2b8-ad280b89f35c@arm.com>
Date:   Mon, 18 Mar 2019 17:59:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fbacd3df-41c4-f98a-8875-db654aff3a5c@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 17:30, Marc Gonzalez wrote:
> On 18/03/2019 18:19, Robin Murphy wrote:
> 
>> For the context bank reset, yes, I am assuming that no complier will
>> ever be perverse enough to detect that cfg is not written after the
>> NULL check and immediately reallocate it to XZR for no good reason.
>> I'd like to think that assumption is going to hold for the reasonable
>> scope of this particular workaround, though.
> 
> I'm not sure I understand the above paragraph.
> 
> In code such as:
> 
> 	if (val == 0) foo(val);
> 
> gcc's algorithm is likely to figure out that the code is equivalent to
> 
> 	if (val == 0) foo(0)
> 
> and perform constant-propagation, etc.
> 
> Is that what we're talking about?

As may already be apparent, the way I expect compilers to behave, and 
the way compilers actually behave, are two overlapping but distinct sets 
of concepts...

Robin.
