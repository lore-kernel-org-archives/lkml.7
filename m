Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B1CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF6218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563887710;
	bh=mz9mTp7Gd95uhLBemlJRlCK00PVAZY0jiN6ov4dQQBg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=z25jhKlM+jepRvxQRwYqewa9PD8jM2wdIHICfG5J7aqmhGLWT0ivxKZFsIUZNUN0n
	 UIHjgZKJ1nYT13bsjYL0nmeTItiWu6LWPaeulIVdkjr/w4LLIy+mpfxY8EVJLiEQMD
	 zEPIiPk4Spj0lX/iTXqXszoG0rVWn07b+yegc8ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfGWNPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:15:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbfGWNPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4D728;
        Tue, 23 Jul 2019 06:15:07 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BECF93F71F;
        Tue, 23 Jul 2019 06:15:06 -0700 (PDT)
Subject: Re: [PATCH 3/9] dt-bindings: interrupt-controller: arm, gic-v3:
 Describe ESPI range support
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190723104437.154403-1-maz@kernel.org>
 <20190723104437.154403-4-maz@kernel.org>
 <04e80def-c8e3-a403-036e-2a64db935ed4@ti.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e67ff715-9625-6aec-5e1f-28f7c9df66f6@kernel.org>
Date:   Tue, 23 Jul 2019 14:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <04e80def-c8e3-a403-036e-2a64db935ed4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 13:59, Lokesh Vutla wrote:
> 
> 
> On 23/07/19 4:14 PM, Marc Zyngier wrote:
>> GICv3.1 introduces support for new interrupt ranges, one of them being
>> the Extended SPI range (ESPI). The DT binding is extended to deal with
>> it as a new interrupt class.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>> index c34df35a25fc..98a3ecda8e07 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>> @@ -44,11 +44,12 @@ properties:
>>        be at least 4.
>>  
>>        The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>> -      interrupts. Other values are reserved for future use.
>> +      interrupts, 2 for interrupts in the Extended SPI range. Other values
>> +      are reserved for future use.
> 
> Any reason why hardware did not consider extending SPIs from 1020:2043? This way
> only EPPI would have been introduced. Just a thought.

First, 1020-1023 is the special INTID range. You can't have anything
else there.

Then, making the range contiguous could imply that the range is also
contiguous in the register space, which isn't possible (note that the
EPPI range does it the other way around -- it is discontinuous in the
INTID space, and yet continuous in the register space).

Finally, the decision to push the numbering out towards the LPI range
allows the ESPI space to be grown easily up to 4k.

But frankly, none of that really matters. They are just numbers.

> Either ways, just to be consistent with hardware numbering can ESPI range be 3
> and EPPI range be 2?

Well, the way I see it is that it is more logical for the binding
itself. We already have 0 for SPIs and 1 for PPIs, despite PPIs being
before SPIs in the INTID space.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
