Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B0AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0122083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561355901;
	bh=AvXQB0CV4vJHJQNcor1z9L7HYmP2PloOeDMNIxwYSTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=aELCwLjjxriOEd6MGUtibmBV5nQwWWI/Xjv9R1GS44/EebupmilfQ+55yRNKbqBt+
	 BuLLd5AzDtklLqo3w3jJ1FfXCwzvJpqFhmSTUnsvF7XZX+cg3VgkeLq3TWfyXepWHb
	 NrLvXzmTALxFcqErt0p4XHZz92RxDVOp6szvadhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFXF6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:58:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:34567 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFXF6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:58:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 22:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="161523545"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2019 22:58:17 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
In-Reply-To: <VE1PR04MB66557834D3588FC8B558950AF1E00@VE1PR04MB6655.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com> <87ineb9b5v.fsf@linux.intel.com> <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com> <87shdfet90.fsf@linux.intel.com> <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com> <87k1eaanjw.fsf@linux.intel.com> <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com> <AM5PR0402MB2865D0F0E2B4F65C86D051F8F1140@AM5PR0402MB2865.eurprd04.prod.outlook.com> <87o92wgyqj.fsf@linux.intel.com> <VE1PR04MB66557834D3588FC8B558950AF1E00@VE1PR04MB6655.eurprd04.prod.outlook.com>
Date:   Mon, 24 Jun 2019 08:58:16 +0300
Message-ID: <87v9wvsex3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Ran Wang <ran.wang_1@nxp.com> writes:
>> >> > >> >> >  /* Global Debug Queue/FIFO Space Available Register */
>> >> > >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
>> >> > >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
>> >> > >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
>> >> > >> >> >   * 	3	- Reserved
>> >> > >> >> >   * @imod_interval: set the interrupt moderation interval in 250ns
>> >> > >> >> >   *                 increments or 0 to disable.
>> >> > >> >> > + * @dma_coherent: set if enable dma-coherent.
>> >> > >> >>
>> >> > >> >> you're not enabling dma coherency, you're enabling cache snooping.
>> >> > >> >> And this property should describe that. Also, keep in mind
>> >> > >> >> that different devices may want different cache types for
>> >> > >> >> each of those fields, so your property would have to be a lot
>> >> > >> >> more complex. Something
>> >> > like:
>> >> > >> >>
>> >> > >> >> 	snps,cache-type = <foobar "cacheable">, <baz "cacheable">, ...
>> >> > >> >>
>> >> > >> >> Then driver would have to parse this properly to setup GSBUSCFG0.
>> >> > >
>> >> > > According to the DesignWare Cores SuperSpeed USB 3.0 Controller
>> >> > > Databook (v2.60a), it has described Type Bit Assignments for all
>> >> > > supported
>> >> > master bus type:
>> >> > > AHB, AXI3, AXI4 and Native. I found the bit definition are
>> >> > > different among
>> >> > them.
>> >> > > So, for the example you gave above, feel a little bit confused.
>> >> > > Did you mean:
>> >> > >     snps,cache-type = <DATA_RD  "write allocate">, <DESC_RD
>> >> > > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">
>> >> >
>> >> > yeah, something like that.
>> >>
>> >> I think DATA_RD  should be a macro, right? So, where I can put its define?
>> >> Create a dwc3.h in include/dt-bindings/usb/ ?
>> >
>> > Could you please give me some advice here? I'd like to prepare next
>> > version patch after getting this settled.
>> >
>> >> Another question about this remain open is: DWC3 data book's Table
>> >> 6-5 Cache Type Bit Assignments show that bits definition will differ
>> >> per MBUS_TYPEs as
>> >> below:
>> >> ----------------------------------------------------------------
>> >>  MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
>> >>  ----------------------------------------------------------------
>> >>  AHB      |Cacheable     |Bufferable   |Privilegge |Data
>> >>  AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
>> >>  AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
>> >>  AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
>> >>  Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
>> >>  ----------------------------------------------------------------
>> >>  Note: The AHB, AXI3, AXI4, and PCIe busses use different names for
>> >> certain  signals, which have the same meaning:
>> >>    Bufferable = Posted
>> >>    Cacheable = Modifiable = Snoop (negation of No Snoop)
>> >>
>> >> For Layerscape SoCs, MBUS_TYPE is AXI3. So I am not sure how to use
>> >> snps,cache-type = <DATA_RD  "write allocate">, to cover all MBUS_TYPE?
>> >> (you can notice that AHB and AXI3's cacheable are on different bit)
>> >> Or I just need to handle AXI3 case?
>> >
>> > Also on this open. Thank you in advance.
>> 
>> You could pass two strings and let the driver process them. Something
>> like:
>> 
>> 	snps,cache_type = <"data_wr" "write allocate">, <"desc_rd"
>> "cacheable">...
>> 
>> And so on. The only thing missing is for the mbus_type to be known by the driver.
>> Is that something we can figure out on any of the HWPARAMS registers or does
>> it have to be told explicitly?
>
> I have checked Layerscape Reference manual, HWPARAMS0~8 doesn't contain mbus_type
> Info, and I didn't know where have declared it explicitly.
>
>> Another option would be to pass a string followed by one hex digit for the bits:
>> 
>> 	snps,cache_type = <"data_wr" 0x8>, <"desc_rd" 0x2>...;
>> 
>> Then we don't need to describe mbus_type since the bits are what matters.
>
> Yes, it's also what we prefer to use, it will be more flexible, I can add above Table
> 6-5 Cache Type Bit Assignments in binding to help user decide which value they
> would use.
>
> I would submit another version of patch for further review, thank you very much.

cool, thanks

-- 
balbi
