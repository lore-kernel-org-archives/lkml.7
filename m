Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ABB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfC1Sr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:47:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfC1Sr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:47:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8DA15AB;
        Thu, 28 Mar 2019 11:47:25 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AAB73F614;
        Thu, 28 Mar 2019 11:47:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
To:     Rob Herring <robh@kernel.org>, Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, mchehab@kernel.org,
        devicetree@vger.kernel.org
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
 <20190328131657.GA9056@bogus>
From:   James Morse <james.morse@arm.com>
Message-ID: <be7246a0-2426-995d-0a24-f104c173d752@arm.com>
Date:   Thu, 28 Mar 2019 18:47:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328131657.GA9056@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Yash,

On 28/03/2019 13:16, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 02:51:00PM +0530, Yash Shah wrote:
>> DT documentation for L2 cache controller added.

>> diff --git a/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
>> new file mode 100644
>> index 0000000..abce09f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
>> @@ -0,0 +1,31 @@
>> +SiFive L2 Cache EDAC driver device tree bindings
>> +-------------------------------------------------
>> +This driver uses the EDAC framework to report L2 cache controller ECC errors.
> 
> Bindings are for h/w blocks, not drivers. (And Boris may want a single 
> driver, but bindings should reflect the h/w, not what Linux (currently) 
> wants.

For h/w block compatibles and edac, I think all we need now is to ensure the DT contains
the three compatible strings: platform (if there is one), soc and ip-name (if its a
re-usable thing).
This is so that linux can pick the biggest of the three (usually platform) to probe the
driver from, as this lets us capture platform properties we only find out about later.

The single-driver idea is because ras/edac gets done late, (its not necessary to boot
linux on the board), and the edac core has difficulty with multiple components feeding
into it.

I don't think we need platform-specific-drivers until someone has a platform that needs
one for this multiple-component issue. To let us do that later (and possibly your
customer's customer to do it), we'd like to avoid probing based on the smallest
compatible, and use the biggest instead.
This lets us remove the platform-compatible from the L2-cache-controller driver's list,
and let some platform driver use it as a library instead. This is to avoid 'but not this
one' checks in the driver.

Yes it results in more one-line patches to enable support in the kernel, but these are
also statements that this platform/soc supports ras/edac. Its possible to build a soc out
of components that all support ras, but not have it working end-to-end.
(oh its optional, was it turned on? Does firmware need to enable something? Is there a
side-band signal, was it wired up everywhere).


> Are the only controls for ECC? Are all the cache attributes discoverable 
> (size, ways, line size, level, etc.)? 

>> +Example:
>> +
>> +cache-controller@2010000 {
>> +	compatible = "sifive,fu540-c000-ccache", "sifive,ccache0";

/me googles
fu540-c000 is the soc, but it doesn't have dram, so it must get used in other platforms.

If there is anything the platform/firmware can influence with this thing please ensure
they have properties in here. (firmware-privilege enables, or pins that have to be tied
high/lwo)

As an example of the problem we're tring to avoid: someone could re-use the design of
"sifive,ccache0" in another soc, where the DRAM controller also supports edac. From just
"sifive,ccache0", they can't tell their system (which needs a multi-component driver) from
yours, which just needs this one.

There may be a clever way of getting DT to do this...


>> +	interrupt-parent = <&plic>;
>> +	interrupts = <1 2 3>;
>> +	reg = <0x0 0x2010000 0x0 0x1000 0x0 0x8000000 0x0 0x2000000>;
>> +	reg-names = "control", "sideband";
>> +};
>> -- 
>> 1.9.1
>>


Thanks,

James
