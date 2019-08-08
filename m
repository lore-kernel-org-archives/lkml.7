Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C73C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CB12186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfHHGBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:01:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:31453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfHHGBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:01:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 23:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="182498032"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2019 23:01:45 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Yang\, Fei" <fei.yang@intel.com>,
        "john.stultz\@linaro.org" <john.stultz@linaro.org>,
        "andrzej.p\@collabora.com" <andrzej.p@collabora.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH V2] usb: dwc3: gadget: trb_dequeue is not updated properly
In-Reply-To: <02E7334B1630744CBDC55DA8586225837F8DE348@ORSMSX102.amr.corp.intel.com>
References: <1563396788-126034-1-git-send-email-fei.yang@intel.com> <87o91riux9.fsf@linux.intel.com> <02E7334B1630744CBDC55DA8586225837F8DD883@ORSMSX102.amr.corp.intel.com> <87muhascua.fsf@linux.intel.com> <02E7334B1630744CBDC55DA8586225837F8DE348@ORSMSX102.amr.corp.intel.com>
Date:   Thu, 08 Aug 2019 09:01:44 +0300
Message-ID: <8736icnqk7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

"Yang, Fei" <fei.yang@intel.com> writes:
>> I need tracepoints to see what's going on, please collect tracepoints.
>
> See attached. Search for "length 16384/16384" to the USB request using
> sg list. And the transfer stalls at a request with "length 512/512".

which gadget driver is this btw? Let's look at what happened leading up
to this problem:

>        <...>-3107  [001] d..1   164.184431: dwc3_alloc_request: ep1out: req 0000000066963d3c length 0/0 zsI ==> 0

Allocated a new request

>        <...>-3107  [001] d..2   164.184432: dwc3_ep_queue: ep1out: req 0000000066963d3c length 0/16384 zsI ==> -115

queued it for a 16kiB transfer (split into 3 sglist entries)

>        <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 0000000011fb30b4 buf 0000000077caf000 size 4096 ctrl 0000001d (HlCS:sc:normal)

first one, 4kiB. Note the capital 'C', this one is chained.

>        <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 00000000bc197bc2 buf 0000000077cb0000 size 8192 ctrl 0000001d (HlCS:sc:normal)

second one, 8kiB. Also chained.

>        <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 00000000ae5c00ad buf 0000000077cb2000 size 4096 ctrl 00000819 (HlcS:sC:normal)

last one, 4kiB. NOT CHAINED!

>        <...>-3107  [001] d..2   164.184438: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful

issue update transfer

>        <...>-3107  [001] d..1   164.184444: dwc3_alloc_request: ep1out: req 00000000fe2c6e9d length 0/0 zsI ==> 0

now gadget driver allocates a NEW request

>        <...>-3107  [001] d..2   164.184444: dwc3_ep_queue: ep1out: req 00000000fe2c6e9d length 0/512 zsI ==> -115

... and queues it for zero bytes. Why? Why didn't gadget driver set the
ZERO flag in the original request?

>        <...>-3107  [001] d..2   164.184445: dwc3_prepare_trb: ep1out: trb 0000000055827a46 buf 0000000077cb3000 size 512 ctrl 00000819 (HlcS:sC:normal)

a single TRB is prepared correctly.

>        <...>-3107  [001] d..2   164.184449: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful

Update transfer is issued.

>        <...>-3165  [001] d..1   164.192315: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
>        <...>-3165  [001] d..1   164.192316: dwc3_complete_trb: ep1out: trb 0000000017050f80 buf 0000000077c63000 size 0 ctrl 0000001c (hlCS:sc:normal)
>        <...>-3165  [001] d..1   164.192325: dwc3_gadget_giveback: ep1out: req 00000000af8aa80e length 16384/16384 zsI ==> 0
> kworker/u8:5-1165  [001] ....   164.192353: dwc3_free_request: ep1out: req 00000000af8aa80e length 16384/16384 zsI ==> 0
>        <...>-3165  [001] d..1   164.192849: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
>        <...>-3165  [001] d..1   164.192851: dwc3_complete_trb: ep1out: trb 00000000c1f0fd23 buf 0000000077c64000 size 0 ctrl 0000001c (hlCS:sc:normal)
>        <...>-3165  [001] d..1   164.192860: dwc3_gadget_giveback: ep1out: req 0000000066963d3c length 16384/16384 zsI ==> 0

here we giveback the request to the gadget driver. Note that the TRB
addresses that were completed do NOT match the TRB addresses of the
prepared TRBs. Again, which gadget driver is this? Where is the source
code for this gadget driver? Also note that we requested for event upon
completion of the final TRB only but we get events for each and every
TRB.

> kworker/u8:5-1165  [002] ....   164.192981: dwc3_free_request: ep1out: req 0000000066963d3c length 16384/16384 zsI ==> 0
>        <...>-3165  [001] d..1   164.193055: dwc3_event: event (00006084): ep1out: Transfer In Progress [0] (SIm)
>        <...>-3165  [001] d..1   164.193056: dwc3_complete_trb: ep1out: trb 00000000b8513800 buf 0000000077c66000 size 0 ctrl 00000818 (hlcS:sC:normal)
>        <...>-3165  [001] d..1   164.193058: dwc3_gadget_giveback: ep1out: req 00000000fe2c6e9d length 512/512 zsI ==> 0
> kworker/u8:5-1165  [002] ....   164.193116: dwc3_free_request: ep1out: req 00000000fe2c6e9d length 512/512 zsI ==> 0

None of this makes sense to me. Even worse, we have here a large block
of the trace where none of prepared TRBs match the completed TRBs:

       <...>-3107  [001] d..1   164.183201: dwc3_alloc_request: ep1out: req 00000000fdd0cc66 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.183204: dwc3_ep_queue: ep1out: req 00000000fdd0cc66 length 0/24 zsI ==> -115
       <...>-3107  [001] d..2   164.183208: dwc3_prepare_trb: ep1out: trb 00000000e2f3f8ed buf 0000000077c72000 size 24 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.183210: dwc3_prepare_trb: ep1out: trb 000000004dd57f90 buf 0000000076880000 size 488 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.183216: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3165  [001] d..1   164.184096: dwc3_event: event (00006084): ep1out: Transfer In Progress [0] (SIm)
       <...>-3165  [001] d..1   164.184096: dwc3_complete_trb: ep1out: trb 00000000ef1174b7 buf 0000000077c53000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.184097: dwc3_complete_trb: ep1out: trb 00000000c96715eb buf 0000000077c54000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.184099: dwc3_gadget_giveback: ep1out: req 00000000fdd0cc66 length 24/24 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.184116: dwc3_free_request: ep1out: req 00000000fdd0cc66 length 24/24 zsI ==> 0
       <...>-3107  [001] d..1   164.184174: dwc3_alloc_request: ep1out: req 00000000fdd0cc66 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184176: dwc3_ep_queue: ep1out: req 00000000fdd0cc66 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184179: dwc3_prepare_trb: ep1out: trb 00000000c1ccce3e buf 0000000077c73000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184180: dwc3_prepare_trb: ep1out: trb 000000002fb64078 buf 0000000077c74000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184180: dwc3_prepare_trb: ep1out: trb 0000000000e38592 buf 0000000077c75000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184180: dwc3_prepare_trb: ep1out: trb 00000000230e784f buf 0000000077c76000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184186: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184197: dwc3_alloc_request: ep1out: req 00000000a994df2b length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184198: dwc3_ep_queue: ep1out: req 00000000a994df2b length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184199: dwc3_prepare_trb: ep1out: trb 00000000d57e9e38 buf 0000000077c77000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184200: dwc3_prepare_trb: ep1out: trb 00000000b4e76a95 buf 0000000077c78000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184200: dwc3_prepare_trb: ep1out: trb 00000000a8070993 buf 0000000077c79000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184200: dwc3_prepare_trb: ep1out: trb 00000000b0e98604 buf 0000000077c7a000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184204: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184215: dwc3_alloc_request: ep1out: req 000000006e6b4b83 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184216: dwc3_ep_queue: ep1out: req 000000006e6b4b83 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184217: dwc3_prepare_trb: ep1out: trb 00000000cbd10328 buf 0000000077c7b000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184217: dwc3_prepare_trb: ep1out: trb 000000003b2e28ac buf 0000000077c7c000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184218: dwc3_prepare_trb: ep1out: trb 000000004cc5bbec buf 0000000077c7d000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184218: dwc3_prepare_trb: ep1out: trb 00000000934eb5c7 buf 0000000077c7e000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184223: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184233: dwc3_alloc_request: ep1out: req 00000000d8604f28 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184234: dwc3_ep_queue: ep1out: req 00000000d8604f28 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184235: dwc3_prepare_trb: ep1out: trb 00000000018d25dd buf 0000000077c7f000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184235: dwc3_prepare_trb: ep1out: trb 0000000051938443 buf 0000000077c80000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184235: dwc3_prepare_trb: ep1out: trb 000000003c9f70a0 buf 0000000077c81000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184236: dwc3_prepare_trb: ep1out: trb 000000003a0255ff buf 0000000077c82000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184240: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184250: dwc3_alloc_request: ep1out: req 00000000534dc264 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184251: dwc3_ep_queue: ep1out: req 00000000534dc264 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184252: dwc3_prepare_trb: ep1out: trb 000000003491fc14 buf 0000000077c83000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184252: dwc3_prepare_trb: ep1out: trb 00000000fe1f51c8 buf 0000000077c84000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184253: dwc3_prepare_trb: ep1out: trb 000000007de9a685 buf 0000000077c85000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184253: dwc3_prepare_trb: ep1out: trb 000000006c5cd81d buf 0000000077c86000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184257: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184268: dwc3_alloc_request: ep1out: req 00000000d39a76e8 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184268: dwc3_ep_queue: ep1out: req 00000000d39a76e8 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184269: dwc3_prepare_trb: ep1out: trb 00000000db2748fa buf 0000000077c87000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184269: dwc3_prepare_trb: ep1out: trb 0000000029872b1b buf 0000000077c88000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184270: dwc3_prepare_trb: ep1out: trb 000000004324b0bc buf 0000000077c89000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184270: dwc3_prepare_trb: ep1out: trb 00000000a1b0b40f buf 0000000077c8a000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184274: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184284: dwc3_alloc_request: ep1out: req 00000000bf1346c1 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184284: dwc3_ep_queue: ep1out: req 00000000bf1346c1 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184285: dwc3_prepare_trb: ep1out: trb 00000000e461023a buf 0000000077c8b000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184286: dwc3_prepare_trb: ep1out: trb 00000000e4c10f9f buf 0000000077c8c000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184286: dwc3_prepare_trb: ep1out: trb 00000000ddd05bd2 buf 0000000077c8d000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184286: dwc3_prepare_trb: ep1out: trb 0000000083b4245c buf 0000000077c8e000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184290: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184300: dwc3_alloc_request: ep1out: req 000000006b19580b length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184300: dwc3_ep_queue: ep1out: req 000000006b19580b length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184302: dwc3_prepare_trb: ep1out: trb 0000000099b34088 buf 0000000077c8f000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184302: dwc3_prepare_trb: ep1out: trb 00000000e960383e buf 0000000077c90000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184302: dwc3_prepare_trb: ep1out: trb 0000000013d9c89b buf 0000000077c91000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184302: dwc3_prepare_trb: ep1out: trb 00000000b56cf1bc buf 0000000077c92000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184307: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184316: dwc3_alloc_request: ep1out: req 0000000074f81789 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184317: dwc3_ep_queue: ep1out: req 0000000074f81789 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184318: dwc3_prepare_trb: ep1out: trb 00000000124da40e buf 0000000077c93000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184318: dwc3_prepare_trb: ep1out: trb 0000000090a4fb4f buf 0000000077c94000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184318: dwc3_prepare_trb: ep1out: trb 0000000043d9f482 buf 0000000077c95000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184319: dwc3_prepare_trb: ep1out: trb 0000000027522919 buf 0000000077c96000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184323: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184331: dwc3_alloc_request: ep1out: req 00000000097221ac length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184332: dwc3_ep_queue: ep1out: req 00000000097221ac length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184333: dwc3_prepare_trb: ep1out: trb 000000006ce5464c buf 0000000077c97000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184333: dwc3_prepare_trb: ep1out: trb 00000000629d6fa7 buf 0000000077c98000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184334: dwc3_prepare_trb: ep1out: trb 00000000524fbb15 buf 0000000077c99000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184334: dwc3_prepare_trb: ep1out: trb 000000002dd0ed08 buf 0000000077c9a000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184338: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184348: dwc3_alloc_request: ep1out: req 00000000d7867ad0 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184348: dwc3_ep_queue: ep1out: req 00000000d7867ad0 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184350: dwc3_prepare_trb: ep1out: trb 000000005d282d99 buf 0000000077c9b000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184350: dwc3_prepare_trb: ep1out: trb 000000007a0d5141 buf 0000000077c9c000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184350: dwc3_prepare_trb: ep1out: trb 000000009107e212 buf 0000000077c9d000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184351: dwc3_prepare_trb: ep1out: trb 0000000010f9f0c2 buf 0000000077c9e000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184355: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184365: dwc3_alloc_request: ep1out: req 00000000132d87a9 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184366: dwc3_ep_queue: ep1out: req 00000000132d87a9 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184367: dwc3_prepare_trb: ep1out: trb 000000005e662e1a buf 0000000077c9f000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184367: dwc3_prepare_trb: ep1out: trb 00000000cd6aa31c buf 0000000077ca0000 size 8192 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184368: dwc3_prepare_trb: ep1out: trb 00000000aa98978b buf 0000000077ca2000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184372: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184380: dwc3_alloc_request: ep1out: req 000000007005ef18 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184381: dwc3_ep_queue: ep1out: req 000000007005ef18 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184382: dwc3_prepare_trb: ep1out: trb 000000007a229a28 buf 0000000077ca3000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184382: dwc3_prepare_trb: ep1out: trb 0000000089f86dfd buf 0000000077ca4000 size 8192 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184382: dwc3_prepare_trb: ep1out: trb 000000002b6aa38b buf 0000000077ca6000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184387: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184394: dwc3_alloc_request: ep1out: req 00000000ca060a32 length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184395: dwc3_ep_queue: ep1out: req 00000000ca060a32 length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184396: dwc3_prepare_trb: ep1out: trb 000000004f90436e buf 0000000077ca7000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184396: dwc3_prepare_trb: ep1out: trb 00000000d80d03a2 buf 0000000077ca8000 size 8192 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184397: dwc3_prepare_trb: ep1out: trb 0000000054248fb8 buf 0000000077caa000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184401: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184409: dwc3_alloc_request: ep1out: req 00000000af8aa80e length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184410: dwc3_ep_queue: ep1out: req 00000000af8aa80e length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184412: dwc3_prepare_trb: ep1out: trb 00000000fabb0bc2 buf 0000000077cab000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184412: dwc3_prepare_trb: ep1out: trb 000000007038915e buf 0000000077cac000 size 8192 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184412: dwc3_prepare_trb: ep1out: trb 00000000f569a631 buf 0000000077cae000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184417: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184431: dwc3_alloc_request: ep1out: req 0000000066963d3c length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184432: dwc3_ep_queue: ep1out: req 0000000066963d3c length 0/16384 zsI ==> -115
       <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 0000000011fb30b4 buf 0000000077caf000 size 4096 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 00000000bc197bc2 buf 0000000077cb0000 size 8192 ctrl 0000001d (HlCS:sc:normal)
       <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 00000000ae5c00ad buf 0000000077cb2000 size 4096 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184438: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3107  [001] d..1   164.184444: dwc3_alloc_request: ep1out: req 00000000fe2c6e9d length 0/0 zsI ==> 0
       <...>-3107  [001] d..2   164.184444: dwc3_ep_queue: ep1out: req 00000000fe2c6e9d length 0/512 zsI ==> -115
       <...>-3107  [001] d..2   164.184445: dwc3_prepare_trb: ep1out: trb 0000000055827a46 buf 0000000077cb3000 size 512 ctrl 00000819 (HlcS:sC:normal)
       <...>-3107  [001] d..2   164.184449: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
       <...>-3165  [001] d..1   164.184816: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.184817: dwc3_complete_trb: ep1out: trb 00000000c1bdf3cb buf 0000000077c55000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.184826: dwc3_gadget_giveback: ep1out: req 00000000fdd0cc66 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.184873: dwc3_free_request: ep1out: req 00000000fdd0cc66 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.185349: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.185350: dwc3_complete_trb: ep1out: trb 000000009aea2c17 buf 0000000077c56000 size 0 ctrl 00000818 (hlcS:sC:normal)
       <...>-3165  [001] d..1   164.185359: dwc3_gadget_giveback: ep1out: req 00000000a994df2b length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.185390: dwc3_free_request: ep1out: req 00000000a994df2b length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.185891: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.185893: dwc3_complete_trb: ep1out: trb 000000002a07f840 buf 0000000077c57000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.185903: dwc3_gadget_giveback: ep1out: req 000000006e6b4b83 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.185971: dwc3_free_request: ep1out: req 000000006e6b4b83 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.186424: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.186425: dwc3_complete_trb: ep1out: trb 0000000084220a79 buf 0000000077c58000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.186433: dwc3_gadget_giveback: ep1out: req 00000000d8604f28 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.186462: dwc3_free_request: ep1out: req 00000000d8604f28 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.186973: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.186973: dwc3_complete_trb: ep1out: trb 000000005c131a32 buf 0000000077c59000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.186983: dwc3_gadget_giveback: ep1out: req 00000000534dc264 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.187015: dwc3_free_request: ep1out: req 00000000534dc264 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.187500: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.187501: dwc3_complete_trb: ep1out: trb 000000009d8444e6 buf 0000000077c5a000 size 0 ctrl 00000818 (hlcS:sC:normal)
       <...>-3165  [001] d..1   164.187510: dwc3_gadget_giveback: ep1out: req 00000000d39a76e8 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.187538: dwc3_free_request: ep1out: req 00000000d39a76e8 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.188030: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.188031: dwc3_complete_trb: ep1out: trb 000000005b8844a7 buf 0000000077c5b000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.188041: dwc3_gadget_giveback: ep1out: req 00000000bf1346c1 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.188070: dwc3_free_request: ep1out: req 00000000bf1346c1 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.188567: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.188568: dwc3_complete_trb: ep1out: trb 0000000033d113ec buf 0000000077c5c000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.188577: dwc3_gadget_giveback: ep1out: req 000000006b19580b length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.188604: dwc3_free_request: ep1out: req 000000006b19580b length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.189101: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.189102: dwc3_complete_trb: ep1out: trb 000000008ccf7690 buf 0000000077c5d000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.189111: dwc3_gadget_giveback: ep1out: req 0000000074f81789 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.189144: dwc3_free_request: ep1out: req 0000000074f81789 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.189627: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.189628: dwc3_complete_trb: ep1out: trb 0000000034583b98 buf 0000000077c5e000 size 0 ctrl 00000818 (hlcS:sC:normal)
       <...>-3165  [001] d..1   164.189636: dwc3_gadget_giveback: ep1out: req 00000000097221ac length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.189663: dwc3_free_request: ep1out: req 00000000097221ac length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.190175: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.190175: dwc3_complete_trb: ep1out: trb 00000000061f2c2b buf 0000000077c5f000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.190185: dwc3_gadget_giveback: ep1out: req 00000000d7867ad0 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.190212: dwc3_free_request: ep1out: req 00000000d7867ad0 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.190706: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.190708: dwc3_complete_trb: ep1out: trb 0000000060764a23 buf 0000000077c60000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.190717: dwc3_gadget_giveback: ep1out: req 00000000132d87a9 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.190745: dwc3_free_request: ep1out: req 00000000132d87a9 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.191252: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.191253: dwc3_complete_trb: ep1out: trb 00000000019ac139 buf 0000000077c61000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.191262: dwc3_gadget_giveback: ep1out: req 000000007005ef18 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.191294: dwc3_free_request: ep1out: req 000000007005ef18 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.191778: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.191779: dwc3_complete_trb: ep1out: trb 0000000073eb9c36 buf 0000000077c62000 size 0 ctrl 00000818 (hlcS:sC:normal)
       <...>-3165  [001] d..1   164.191788: dwc3_gadget_giveback: ep1out: req 00000000ca060a32 length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.191815: dwc3_free_request: ep1out: req 00000000ca060a32 length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.192315: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.192316: dwc3_complete_trb: ep1out: trb 0000000017050f80 buf 0000000077c63000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.192325: dwc3_gadget_giveback: ep1out: req 00000000af8aa80e length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [001] ....   164.192353: dwc3_free_request: ep1out: req 00000000af8aa80e length 16384/16384 zsI ==> 0
       <...>-3165  [001] d..1   164.192849: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
       <...>-3165  [001] d..1   164.192851: dwc3_complete_trb: ep1out: trb 00000000c1f0fd23 buf 0000000077c64000 size 0 ctrl 0000001c (hlCS:sc:normal)
       <...>-3165  [001] d..1   164.192860: dwc3_gadget_giveback: ep1out: req 0000000066963d3c length 16384/16384 zsI ==> 0
kworker/u8:5-1165  [002] ....   164.192981: dwc3_free_request: ep1out: req 0000000066963d3c length 16384/16384 zsI ==> 0

Please give further of how you're reproducing this. Which kernel, which
gadget driver, do you have out-of-tree patches? Why do we see these
non-sequential TRB addresses. Are you using IOMMU, perhaps? Something
made dwc3 super confused, at least judging by the logs.

cheers

-- 
balbi
