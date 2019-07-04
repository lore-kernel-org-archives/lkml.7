Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C62C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF402218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="dlveryba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tDJYmswe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGDLDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:03:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41293 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfGDLDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:03:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EBA5207FD;
        Thu,  4 Jul 2019 07:03:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Jul 2019 07:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9InZWB2AFjlJ00RfC8Iw6HdvhBy
        Ol8+yBDgBpsze3T4=; b=dlverybaqwK95UoPAD7kpY2wpY15lkJFT+K8pE1k/S2
        Zl3yNTQ98iKZivqMEYJCbuW+5Of1kNUUBId82oWRkI5r1hxuXI1mwIVyrgrcoMs3
        vWgh+6bKX+6IrqNOctWs4tVgCvqnDp1FP8J+rnPUHLnXxS153tXtteQPGXRSKx+B
        caVwuz71VILuUbEdbTOoP3nGWgzG+Oxx22lwdjmA7L1XKoxUIM5MzbIUC8z+nEQz
        Q4YF/4/L4U9h49pCdg+oZSJx+eQziYwsIwVMuKOrr31AEtJ8gkOet1FtPhUi9CMh
        U8Vnzw7ciHavx5+9ETh5+veVxIzjxMrRU7Fal8yn0/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9InZWB
        2AFjlJ00RfC8Iw6HdvhByOl8+yBDgBpsze3T4=; b=tDJYmswesMr6sT9RWwAiax
        Esn0G8SzoP+sFxFkpVEWRDyWUxY95efbtO4ynfsZHUwK0evbaOcK9wyo98DNobI1
        zTIk/aFXLw/sVs7Q7NvjZ7u3petJewBhW6pTv6aKmW6A99iS158iVhudXVehfxuA
        sfUzfI3gjNY7AM9lYD4N/fQN5z0Fuz+WUxjw/ZPk1Yg7Roq1YgQoZvvLRI/e4pGy
        H5Awh55bBsUR85xrt4kfa11MXeENkfAp6gx2yjmqzrprFBTrNO+UKZcYjqVmVWF6
        zXSBCNaEj4Zu0phZbNeLQvN4v7D6lJ/TJg8fU790n9Jw6tnMhLClQDacjHd0dOKA
        ==
X-ME-Sender: <xms:Bt0dXbKXc8lorFXkQkfxyKNVQX_qXsdF5msMm7kbEZU5QE884FlHxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedvgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:Bt0dXVRmJNLpZzq_UFXQE2GNZYGiS090-UUW8OtfFvSsGPneTaN-DQ>
    <xmx:Bt0dXaO7ECXMVnXuyEWn73Clpd8D7loEKZaIgVpU_4_ZXVbaAWyrHg>
    <xmx:Bt0dXebrkPU_M8_sKu8FaBdsI4C9Y64vb9JaRYIPjqeP80B1JqskUw>
    <xmx:B90dXRkc1e50Ke2GCBN9djK71FdWHv-76zMxFvVumypdID_PvzbH9g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E1818005A;
        Thu,  4 Jul 2019 07:03:34 -0400 (EDT)
Date:   Thu, 4 Jul 2019 13:03:33 +0200
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
Message-ID: <20190704110333.GB1404@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
 <BYAPR07MB4709076903F55352193FC78FDDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <877e8y6snr.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e8y6snr.fsf@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:44:08PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Pawel Laszczak <pawell@cadence.com> writes:
> 
> >>
> >>
> >>Hi,
> >>
> >>Pawel Laszczak <pawell@cadence.com> writes:
> >>
> >>>>
> >>>>Hi,
> >>>>
> >>>>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
> >>>>>
> >>>>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
> >>>>> > Hi all,
> >>>>> >
> >>>>> > After merging the usb tree, today's linux-next build (arm
> >>>>> > multi_v7_defconfig) failed like this:
> >>>>> >
> >>>>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
> >>>>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
> >>>>> >
> >>>>> > Caused by commit
> >>>>> >
> >>>>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
> >>>>> >
> >>>>> > I have used the usb tree from next-20190703 for today.
> >>>>> >
> >>>>> > This also occurs in the usb-gadget tree so I have used the version of
> >>>>> > that from next-20190703 as well.
> >>>>>
> >>>>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
> >>>>> take a look at this to see if I messed something up?
> >>>>
> >>>>This looks like it was caused by Pawel's patches.
> >>>>
> >>>>I'll try to reproduce here and see what's causing it.
> >>>
> >>> Problem is in my Patch. I reproduced it, but I don't understand why compiler
> >>> complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
> >>> declaration is in drivers/usb/gadget.h.
> >>
> >>That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
> >>is a module:
> >>
> >>CONFIG_USB_DWC3=y
> >>CONFIG_USB_LIBCOMPOSITE=m
> >>
> >>
> >>I remember that when you were doing this work, I asked you to move
> >>functions to usb/common. Why did you deviate from that suggestion? It's
> >>clear that decoding a ctrl request can be used by peripheral and host
> >>and we wouldn't have to deal with this problem if you had just followed
> >>the suggestion.
> >
> > Some time ago Greg wrote: 
> > " It's nice to have these in a common place, but you just bloated all of
> > the USB-enabled systems in the world for the use of 2 odd-ball system
> > controllers that almost no one has :) "
> >
> > So I moved these functions to gadget directory. 
> >
> > It was mistake that I added debug.c file to libcomposite.ko.
> 
> The plan is to use this decoding function for xHCI as well. Other host
> controllers can use it as well.
> 
> The biggest mistake was to put this under gadget. What you should have
> done was create a file under usb/common that only gets compile in if
> tracing is enabled.
> 
> Then there's no bloating unless you have a kernel purposefuly built for
> debugging and tracing.
> 
> Greg, does that work for you?

I guess, but I'd like to see patches before answering that :)

thanks,

greg k-h
