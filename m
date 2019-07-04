Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867FC06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E06205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jMgP5S4n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DK4CgGdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGDLDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:03:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42993 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfGDLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:03:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9F8A820355;
        Thu,  4 Jul 2019 07:03:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Jul 2019 07:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=0iZYXzwFrmQtPuuQr4Pn9G8zFL3
        fT36VF37zsMwW3/8=; b=jMgP5S4n2qiSYCBrubBqAYQ561dsYlw5KG0qqbi8BMm
        sybJfP01GrtXM7a+Rhbj+YMGmh5AGX7IcC2oWGtxsPhiXrJyRYVu7+D1d4Q14ggO
        0dFLLze53UE98nbp5AYEQodXIWrRKOjQ9SyJHL0Bk/CFbTuxl1W8xmjNQa0r4cDB
        pDcJUsvbqNbJAoT7t7PJt5MhtOv35WBJVBMu/czLbJK+o39dEZF+9/Ja9oU0bVNC
        YD189ZWcHh6hdZbo4NC1/uwCexnGmNnadgThDYVA8BElq79LgXT4cPbxO38nWUyZ
        zoxvvEkttCij19zB0+HJYAcYrkg8UX7biiVEwEex9hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0iZYXz
        wFrmQtPuuQr4Pn9G8zFL3fT36VF37zsMwW3/8=; b=DK4CgGdj8vj4uZ1MjmJDrp
        MK3B4NcOPeTefwjrWoawexOfPtmXl1oZslogd9uXP405U2uL7/kCj35Z4HAADPfG
        +n7N9189+05I6us8DhVUsOxUjCYik6onHtqDmxkiEZxyHSmbZutTjPOszfQCez9b
        OOWKuVtIMqRkn7+7op/K9mqebvY1GSjhCEK44SFcC3Qeuil8HOBXxWaY1H7v6S7z
        Vt3NRzJBqvRxjDDeWDdKOAPRgUxSkqx/jy+9oOIIAoHUDlL7aICy22J39a4/Sxv/
        sS0+MoJFyaesrauSMrBtMg8fTXr6u8OIiIo0lxug12bPWkSEG3yNwq8VkdtB/d/A
        ==
X-ME-Sender: <xms:Ad0dXSE2HN3-3YYk4eHrEjEGGuu3zQkH3c8SBL6V8EeFxhGNMEMeRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedvgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Ad0dXVU5fQFI8JG-QCTsx4oOgT4I5oZ4xIf9j-cE223PGYVRmBFqag>
    <xmx:Ad0dXQd8amZvY2cVH3EyMgwzt0zcAk-b0qCh6oaxsQPjoV7FsbFccg>
    <xmx:Ad0dXUQ1HdGrOBustYrld8CtLgECfZB5VVvgNdR7Wu372iIkGdYEuw>
    <xmx:At0dXbTkiXXkHBm9WAmtrg6fRYcXMF9bfB60RY646XIXdddcqEreeg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 027E88005B;
        Thu,  4 Jul 2019 07:03:28 -0400 (EDT)
Date:   Thu, 4 Jul 2019 13:03:06 +0200
From:   Greg KH <greg@kroah.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget
 trees
Message-ID: <20190704110306.GA1404@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
 <20190704083233.GH6438@kroah.com>
 <87ftnmyyqw.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftnmyyqw.fsf@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:45:11AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Greg KH <greg@kroah.com> writes:
> 
> > On Thu, Jul 04, 2019 at 11:25:16AM +0300, Felipe Balbi wrote:
> >> 
> >> Hi,
> >> 
> >> Pawel Laszczak <pawell@cadence.com> writes:
> >> 
> >> >>
> >> >>Hi,
> >> >>
> >> >>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
> >> >>>
> >> >>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
> >> >>> > Hi all,
> >> >>> >
> >> >>> > After merging the usb tree, today's linux-next build (arm
> >> >>> > multi_v7_defconfig) failed like this:
> >> >>> >
> >> >>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
> >> >>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
> >> >>> >
> >> >>> > Caused by commit
> >> >>> >
> >> >>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
> >> >>> >
> >> >>> > I have used the usb tree from next-20190703 for today.
> >> >>> >
> >> >>> > This also occurs in the usb-gadget tree so I have used the version of
> >> >>> > that from next-20190703 as well.
> >> >>>
> >> >>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
> >> >>> take a look at this to see if I messed something up?
> >> >>
> >> >>This looks like it was caused by Pawel's patches.
> >> >>
> >> >>I'll try to reproduce here and see what's causing it.
> >> >
> >> > Problem is in my Patch. I reproduced it, but I don't understand why compiler 
> >> > complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
> >> > declaration is in drivers/usb/gadget.h. 
> >> 
> >> That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
> >> is a module:
> >> 
> >> CONFIG_USB_DWC3=y
> >> CONFIG_USB_LIBCOMPOSITE=m
> >> 
> >> 
> >> I remember that when you were doing this work, I asked you to move
> >> functions to usb/common. Why did you deviate from that suggestion? It's
> >> clear that decoding a ctrl request can be used by peripheral and host
> >> and we wouldn't have to deal with this problem if you had just followed
> >> the suggestion.
> >> 
> >> Now we have to come up with a way to fix this that doesn't involve
> >> reverting my part2 tag in its entirety because there are other important
> >> things there.
> >> 
> >> This is what I get for trusting people to do their part. I couldn't even
> >> compile test this since I don't have ARM compilers anymore (actually,
> >> just installed to test). Your customer, however, uses ARM cores so I
> >> would expect you to have at least compile tested this on ARM. How come
> >> this wasn't verified by anybody at TI?
> >> 
> >> TI used to have automated testing for many of the important defconfigs,
> >> is that completely gone? Are you guys relying entirely on linux-next?
> >> 
> >> Greg, if you prefer, please revert my part2 tag. If you do so, please
> >> let me know so I can drop the tag and commits from my tree as well.
> >
> > How do I revert a tag?  How about I just revert individual commits,
> > which ones should I revert?
> 
> Anything from Pawel. Here's the full list:
> 
> 573aff747ee3 usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
> 8bc1901ca7b0 usb:cdns3 Add Cadence USB3 DRD Driver
> c2af6b07803e usb:gadget Simplify usb_decode_get_set_descriptor function.
> ca888ce7495e usb:gadget Patch simplify usb_decode_set_clear_feature function.
> 3db1b636c07e usb:gadget Separated decoding functions from dwc3 driver.
> e8a8b40cc892 dt-bindings: add binding for USBSS-DRD controller.
> 
> I just tested a branch without these patches and it builds fine:
> 
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- multi_v7_defconfig
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j32 -s
> $

All now reverted.

When these are resent, I want to review them as well as I thought the
cdns3 driver still needed work before it could be merged...

thanks,

greg k-h
