Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90511C06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AB82189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562229917;
	bh=HrlKZKP5l8Vhyw+yoPKEguar342FbH5jYvnfFzBqyio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=l2usQyN51qJ3RFIX+HDyY/mCUtaHv1oWCMvoJuP59kn1XHuDfmaoS61OQUqNoUeP/
	 0CpqgmZ1Cc6bfTKVrtpkUglHO/eq2Gz3gHVm4ENMqZjqhefU/tD6xSspRtT5U3Dos5
	 T3GmIvYuWZSTZEOmfuPE/fRpaae8fUGaSvU1ykfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGDIpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:45:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:27819 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfGDIpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:45:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 01:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="164585008"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2019 01:45:13 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget trees
In-Reply-To: <20190704083233.GH6438@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au> <20190704065949.GA32707@kroah.com> <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com> <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com> <87imsiyzo3.fsf@linux.intel.com> <20190704083233.GH6438@kroah.com>
Date:   Thu, 04 Jul 2019 11:45:11 +0300
Message-ID: <87ftnmyyqw.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greg KH <greg@kroah.com> writes:

> On Thu, Jul 04, 2019 at 11:25:16AM +0300, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Pawel Laszczak <pawell@cadence.com> writes:
>> 
>> >>
>> >>Hi,
>> >>
>> >>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>> >>>
>> >>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
>> >>> > Hi all,
>> >>> >
>> >>> > After merging the usb tree, today's linux-next build (arm
>> >>> > multi_v7_defconfig) failed like this:
>> >>> >
>> >>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
>> >>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
>> >>> >
>> >>> > Caused by commit
>> >>> >
>> >>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
>> >>> >
>> >>> > I have used the usb tree from next-20190703 for today.
>> >>> >
>> >>> > This also occurs in the usb-gadget tree so I have used the version of
>> >>> > that from next-20190703 as well.
>> >>>
>> >>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
>> >>> take a look at this to see if I messed something up?
>> >>
>> >>This looks like it was caused by Pawel's patches.
>> >>
>> >>I'll try to reproduce here and see what's causing it.
>> >
>> > Problem is in my Patch. I reproduced it, but I don't understand why compiler 
>> > complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
>> > declaration is in drivers/usb/gadget.h. 
>> 
>> That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
>> is a module:
>> 
>> CONFIG_USB_DWC3=y
>> CONFIG_USB_LIBCOMPOSITE=m
>> 
>> 
>> I remember that when you were doing this work, I asked you to move
>> functions to usb/common. Why did you deviate from that suggestion? It's
>> clear that decoding a ctrl request can be used by peripheral and host
>> and we wouldn't have to deal with this problem if you had just followed
>> the suggestion.
>> 
>> Now we have to come up with a way to fix this that doesn't involve
>> reverting my part2 tag in its entirety because there are other important
>> things there.
>> 
>> This is what I get for trusting people to do their part. I couldn't even
>> compile test this since I don't have ARM compilers anymore (actually,
>> just installed to test). Your customer, however, uses ARM cores so I
>> would expect you to have at least compile tested this on ARM. How come
>> this wasn't verified by anybody at TI?
>> 
>> TI used to have automated testing for many of the important defconfigs,
>> is that completely gone? Are you guys relying entirely on linux-next?
>> 
>> Greg, if you prefer, please revert my part2 tag. If you do so, please
>> let me know so I can drop the tag and commits from my tree as well.
>
> How do I revert a tag?  How about I just revert individual commits,
> which ones should I revert?

Anything from Pawel. Here's the full list:

573aff747ee3 usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
8bc1901ca7b0 usb:cdns3 Add Cadence USB3 DRD Driver
c2af6b07803e usb:gadget Simplify usb_decode_get_set_descriptor function.
ca888ce7495e usb:gadget Patch simplify usb_decode_set_clear_feature function.
3db1b636c07e usb:gadget Separated decoding functions from dwc3 driver.
e8a8b40cc892 dt-bindings: add binding for USBSS-DRD controller.

I just tested a branch without these patches and it builds fine:

$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- multi_v7_defconfig
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j32 -s
$

-- 
balbi
