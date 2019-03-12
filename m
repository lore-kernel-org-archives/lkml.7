Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95E214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfCLT2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:28:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:13657 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCLT2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:28:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 12:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="151078177"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2019 12:28:09 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2 2/5] Documentation: dt: edac: Add Stratix10 Peripheral
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     bp@alien8.de, dinguyen@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-3-git-send-email-thor.thayer@linux.intel.com>
 <20190312160445.GA8802@bogus>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <8b671f75-8488-1e06-a020-5f7d95166918@linux.intel.com>
Date:   Tue, 12 Mar 2019 14:30:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312160445.GA8802@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/12/19 11:04 AM, Rob Herring wrote:
> On Wed, Feb 27, 2019 at 11:27:22AM -0600, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add peripheral bindings for Stratix10 EDAC to capture
>> the differences between the ARM64 and ARM32 architecture.
> 
> What's the difference? Sounds like 2 different chips, so Stratix10 or
> s10 is not specific enough perhaps.
> 

Yes, our ARM32 chips are the Cyclone5 and Arria10. The Stratix10 is 
ARM64 and I'm using S10 as shorthand for the Stratix10.

The ECC blocks are very similar between Arria10 and Stratix10 but there 
are differences as a result of the ARM32 vs ARM64 architecture 
differences. The major difference is how Double Bit Errors are handled. 
In the ARM32, the DBE is mapped to an IRQ. On ARM64, the DBE is mapped 
to a SError.

I had started out re-using the Arria10 bindings for Stratix10 since they 
were very similar. Dinh pointed out that having separate bindings for 
ARM64 would allow separation between the architectures and make future 
changes easier.

I'm unclear on the comment about being specific enough. Are you 
suggesting that I use arm64 in the binding name instead of s10? Or is 
there a better naming convention I should follow?

Thanks for your comments and for reviewing!

Thor
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2 No change
>> ---
>>   .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 106 +++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
>> index a0ac50e15912..a0fa80c53d2a 100644
>> --- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
>> +++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
>> @@ -258,6 +258,49 @@ Required Properties:
>>   - compatible : Should be "altr,sdram-edac-s10"
>>   - interrupts : Should be single bit error interrupt.
>>   
>> +On-Chip RAM ECC
>> +Required Properties:
>> +- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
>> +- reg             : Address and size for ECC block registers.
>> +- altr,ecc-parent : phandle to parent OCRAM node.
>> +- interrupts      : Should be single bit error interrupt.
>> +
>> +Ethernet FIFO ECC
>> +Required Properties:
>> +- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
>> +- reg             : Address and size for ECC block registers.
>> +- altr,ecc-parent : phandle to parent Ethernet node.
>> +- interrupts      : Should be single bit error interrupt.
>> +
>> +NAND FIFO ECC
>> +Required Properties:
>> +- compatible      : Should be "altr,socfpga-s10-nand-ecc"
>> +- reg             : Address and size for ECC block registers.
>> +- altr,ecc-parent : phandle to parent NAND node.
>> +- interrupts      : Should be single bit error interrupt.
>> +
>> +DMA FIFO ECC
>> +Required Properties:
>> +- compatible      : Should be "altr,socfpga-s10-dma-ecc"
>> +- reg             : Address and size for ECC block registers.
>> +- altr,ecc-parent : phandle to parent DMA node.
>> +- interrupts      : Should be single bit error interrupt.
>> +
>> +USB FIFO ECC
>> +Required Properties:
>> +- compatible      : Should be "altr,socfpga-s10-usb-ecc"
>> +- reg             : Address and size for ECC block registers.
>> +- altr,ecc-parent : phandle to parent USB node.
>> +- interrupts      : Should be single bit error interrupt.
>> +
>> +SDMMC FIFO ECC
>> +Required Properties:
>> +- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
>> +- reg             : Address and size for ECC block registers.
>> +- altr,ecc-parent : phandle to parent SD/MMC node.
>> +- interrupts      : Should be single bit error interrupt for port A
>> +		    and then single bit error interrupt for port B.
>> +
>>   Example:
>>   
>>   	eccmgr {
>> @@ -274,4 +317,67 @@ Example:
>>   			compatible = "altr,sdram-edac-s10";
>>   			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>> +
>> +		ocram-ecc@ff8cc000 {
>> +			compatible = "altr,socfpga-s10-ocram-ecc";
>> +			reg = <ff8cc000 0x100>;
>> +			altr,ecc-parent = <&ocram>;
>> +			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		emac0-rx-ecc@ff8c0000 {
>> +			compatible = "altr,socfpga-s10-eth-mac-ecc";
>> +			reg = <0xff8c0000 0x100>;
>> +			altr,ecc-parent = <&gmac0>;
>> +			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		emac0-tx-ecc@ff8c0400 {
>> +			compatible = "altr,socfpga-s10-eth-mac-ecc";
>> +			reg = <0xff8c0400 0x100>;
>> +			altr,ecc-parent = <&gmac0>;
>> +			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
>> +		};
>> +
>> +		nand-buf-ecc@ff8c8000 {
>> +			compatible = "altr,socfpga-s10-nand-ecc";
>> +			reg = <0xff8c8000 0x100>;
>> +			altr,ecc-parent = <&nand>;
>> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		nand-rd-ecc@ff8c8400 {
>> +			compatible = "altr,socfpga-s10-nand-ecc";
>> +			reg = <0xff8c8400 0x100>;
>> +			altr,ecc-parent = <&nand>;
>> +			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		nand-wr-ecc@ff8c8800 {
>> +			compatible = "altr,socfpga-s10-nand-ecc";
>> +			reg = <0xff8c8800 0x100>;
>> +			altr,ecc-parent = <&nand>;
>> +			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		dma-ecc@ff8c9000 {
>> +			compatible = "altr,socfpga-s10-dma-ecc";
>> +			reg = <0xff8c9000 0x100>;
>> +			altr,ecc-parent = <&pdma>;
>> +			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		usb0-ecc@ff8c4000 {
>> +			compatible = "altr,socfpga-s10-usb-ecc";
>> +			reg = <0xff8c4000 0x100>;
>> +			altr,ecc-parent = <&usb0>;
>> +			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		sdmmc-ecc@ff8c8c00 {
>> +			compatible = "altr,socfpga-s10-sdmmc-ecc";
>> +			reg = <0xff8c8c00 0x100>;
>> +			altr,ecc-parent = <&mmc>;
>> +			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <15 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>>   	};
>> -- 
>> 2.7.4
>>
> 

