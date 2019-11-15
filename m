Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8175CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A08206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKOAQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:16:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:58860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbfKOAQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:16:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26C1DAD78;
        Fri, 15 Nov 2019 00:16:49 +0000 (UTC)
Subject: Re: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-6-afaerber@suse.de>
 <a43d184d74c34e269714858b2635c35e@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <960a80b9-b1bf-3709-bbb7-fc2a3c3ae1da@suse.de>
Date:   Fri, 15 Nov 2019 01:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a43d184d74c34e269714858b2635c35e@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 13.11.19 um 03:53 schrieb James Tai:
>> +		rbus: r-bus@18000000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x18000000 0x100000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0x0 0x18000000 0x100000>;
>> +
> 
> The r-bus size of RTD1195 is 0x70000‬.

Fixed, also further above for the soc node. This now leaves a gap until
0x18100000 - is that gap RAM or non-r-bus registers then?

		ranges = <0x18000000 0x18000000 0x00070000>,
		         <0x18100000 0x18100000 0x01000000>,
		         <0x40000000 0x40000000 0xc0000000>;

Did you also review the other two ranges? The middle one was labeled NOR
flash somewhere - are start and size correct? The final one depends on
the maximum RAM size - does RTD1195 allow more than 1 GiB RAM? All
non-RAM regions should be covered here.

So another question, applicable to all SoCs: This reserved Boot ROM area
at the start of the address space, here of size 0xa800, is that copied
into RAM, or is that the actual ROM overlapping RAM? If the latter, we
should exclude it from /memory@0's reg (making it /memory@a800), and add
it to soc's ranges here for correctness.

With the follow-up question: Is it correct that, given the size 0xa800,
I have a gap between /memreserve/s from 0xa800 to 0xc000, or should we
reserve that gap by extending the next /memreserve/ or inserting one?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
