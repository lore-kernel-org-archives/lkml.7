Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88455C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6788A206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKSIet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:34:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:51374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfKSIet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:34:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71713AD2B;
        Tue, 19 Nov 2019 08:34:47 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] ARM: dts: rtd1195: Add reset nodes
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-7-afaerber@suse.de>
 <20b3d0956bed4338a540216df07f16e5@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <ed7c483d-b518-c74f-f66d-a812d0858f4c@suse.de>
Date:   Tue, 19 Nov 2019 09:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20b3d0956bed4338a540216df07f16e5@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Adding Philipp.

Am 18.11.19 um 10:22 schrieb James Tai:
>> +			reset1: reset-controller@0 {
>> +				compatible = "snps,dw-low-reset";
>> +				reg = <0x0 0x4>;
>> +				#reset-cells = <1>;
>> +			};
>> +
>> +			reset2: reset-controller@4 {
>> +				compatible = "snps,dw-low-reset";
>> +				reg = <0x4 0x4>;
>> +				#reset-cells = <1>;
>> +			};
>> +
>> +			reset3: reset-controller@8 {
>> +				compatible = "snps,dw-low-reset";
>> +				reg = <0x8 0x4>;
>> +				#reset-cells = <1>;
>> +			};
>> +
>> +			iso_reset: reset-controller@7088 {
>> +				compatible = "snps,dw-low-reset";
>> +				reg = <0x7088 0x4>;
>> +				#reset-cells = <1>;
>> +			};
>> +
> 
> We don't use the DesignWare IP for the reset controller.

Thanks for reviewing.

We already merged the equivalent nodes for RTD129x into arm-soc.git.
No Realtek review was received back when it was posted [1], sadly.

How does your reset controller differ from DesignWare, and how would you
prefer to handle it?

a) Do you want to send patches for a new Realtek-specific dt-binding [2]
and extend reset-simple driver to cover it as a copy&paste of the
DesignWare of_device_id?

b) Do you believe you need to submit a completely new reset driver?

An issue I had raised twice [4, 1] was that reset-simple only allows for
contiguous registers and thus couldn't handle the gap between reset3 and
reset4 on RTD1295, forcing me to use per-register nodes for consistency.
I am against modeling RTD1195 differently from RTD1295+, assuming
they're the equivalent IP, so we need a solution that works for both.
Philipp did indicate in [4] we could extend reset-simple for this gap
"if the implementation could be kept reasonably simple".

With v5.4-rc8 already tagged, please hurry if you want a different
binding in v5.5.

Regards,
Andreas

[1] https://patchwork.kernel.org/cover/11206255/
[2] https://patchwork.kernel.org/patch/9902665/
[3] https://patchwork.kernel.org/patch/9902673/
[4] https://patchwork.kernel.org/patch/9902675/
[5] https://patchwork.kernel.org/patch/9902671/
[6] https://patchwork.kernel.org/patch/9902663/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
