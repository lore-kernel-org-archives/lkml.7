Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C9EC06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB71205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562238377;
	bh=uVQltvsAQAfu7iba97jWCMUf7baHCPIvRaNEenuUtRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=gxUprQN3+4hDZB/BwoEULSa1O283C7YVpDIOdyrplObGdu8/Opf1DGqdLZeVpvSzU
	 HxUmUp0G8GYrh/f18ZUYQB+xD2jgCaRyb3wcPZudPM4PmLu2x9Jp8WmCdfclAfAlhp
	 5dXFAsDnwSPAkEHZIhUQoCrYz4rIDG5rTYqiu2B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfGDLGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:06:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:48415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:06:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 04:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="339576906"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2019 04:06:12 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget trees
In-Reply-To: <20190704110333.GB1404@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au> <20190704065949.GA32707@kroah.com> <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com> <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com> <87imsiyzo3.fsf@linux.intel.com> <BYAPR07MB4709076903F55352193FC78FDDFA0@BYAPR07MB4709.namprd07.prod.outlook.com> <877e8y6snr.fsf@linux.intel.com> <20190704110333.GB1404@kroah.com>
Date:   Thu, 04 Jul 2019 14:06:11 +0300
Message-ID: <87sgrm9hzw.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greg KH <greg@kroah.com> writes:

> On Thu, Jul 04, 2019 at 12:44:08PM +0300, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Pawel Laszczak <pawell@cadence.com> writes:
>> 
>> >>
>> >>
>> >>Hi,
>> >>
>> >>Pawel Laszczak <pawell@cadence.com> writes:
>> >>
>> >>>>
>> >>>>Hi,
>> >>>>
>> >>>>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>> >>>>>
>> >>>>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
>> >>>>> > Hi all,
>> >>>>> >
>> >>>>> > After merging the usb tree, today's linux-next build (arm
>> >>>>> > multi_v7_defconfig) failed like this:
>> >>>>> >
>> >>>>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
>> >>>>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
>> >>>>> >
>> >>>>> > Caused by commit
>> >>>>> >
>> >>>>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
>> >>>>> >
>> >>>>> > I have used the usb tree from next-20190703 for today.
>> >>>>> >
>> >>>>> > This also occurs in the usb-gadget tree so I have used the version of
>> >>>>> > that from next-20190703 as well.
>> >>>>>
>> >>>>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
>> >>>>> take a look at this to see if I messed something up?
>> >>>>
>> >>>>This looks like it was caused by Pawel's patches.
>> >>>>
>> >>>>I'll try to reproduce here and see what's causing it.
>> >>>
>> >>> Problem is in my Patch. I reproduced it, but I don't understand why compiler
>> >>> complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
>> >>> declaration is in drivers/usb/gadget.h.
>> >>
>> >>That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
>> >>is a module:
>> >>
>> >>CONFIG_USB_DWC3=y
>> >>CONFIG_USB_LIBCOMPOSITE=m
>> >>
>> >>
>> >>I remember that when you were doing this work, I asked you to move
>> >>functions to usb/common. Why did you deviate from that suggestion? It's
>> >>clear that decoding a ctrl request can be used by peripheral and host
>> >>and we wouldn't have to deal with this problem if you had just followed
>> >>the suggestion.
>> >
>> > Some time ago Greg wrote: 
>> > " It's nice to have these in a common place, but you just bloated all of
>> > the USB-enabled systems in the world for the use of 2 odd-ball system
>> > controllers that almost no one has :) "
>> >
>> > So I moved these functions to gadget directory. 
>> >
>> > It was mistake that I added debug.c file to libcomposite.ko.
>> 
>> The plan is to use this decoding function for xHCI as well. Other host
>> controllers can use it as well.
>> 
>> The biggest mistake was to put this under gadget. What you should have
>> done was create a file under usb/common that only gets compile in if
>> tracing is enabled.
>> 
>> Then there's no bloating unless you have a kernel purposefuly built for
>> debugging and tracing.
>> 
>> Greg, does that work for you?
>
> I guess, but I'd like to see patches before answering that :)

Sure, understandable. I should've done a better job at filtering that
out. Sorry about htat

-- 
balbi
