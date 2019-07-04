Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5882CC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222B821882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cVoieuWt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vleNwZS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGDIch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:32:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52713 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbfGDIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:32:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C68021AD0;
        Thu,  4 Jul 2019 04:32:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jul 2019 04:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=WgA6uD4WsSiU3o6j/qJ6WguzOjn
        IR8KH4WV+iv3GLbw=; b=cVoieuWttcTdF3rBTlPx8fmgktR/lMovd7ep9JnTEeB
        VKImQqv8Uj4VMQE8yGcPde5CtDrTMyIS7XgZuLRoAjuUXnN+ewGS1Lu9OSeWyl6i
        OHSa6wBsHhcUpquTIpAoMxn8Z55Imgaf++jwapaQeJDxzMyNf8Dc+mHBuq5N2l7K
        CZcBCU0qfU3XOAfKe96n96JQnJP7Roe4ojlVPTv2mRrNWS92j1TbkKSbgvscAvUd
        X7hgVrZT+me1xtGbkRcs4XeRzVFnLEIdk4nHSUEVlz7jXOWlErypPKvvWoBC3oK+
        F325dOPUVva08hfbUNB/gllYxausup8Tam9hK6W59pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WgA6uD
        4WsSiU3o6j/qJ6WguzOjnIR8KH4WV+iv3GLbw=; b=vleNwZS/EzprXkQpOAwb+9
        UhbFPt/XpiszjNQyMP8D1GFC1iX9sYU3ZAm4SjnMlZDX5/YwwADGT4u+7OAgrp9J
        M6gT+YJ6aNzi+RjaoHut/8zt1YUk8gP6GzJ6g4pgt5BD4pM98uB8L9X6TSh+VJQm
        ObyIzSmt1BPguqNklYS3ibmEd4N8mMN5rx5Nk9Rrcy6mMbKfuf+w6SEBf3qhi/6j
        YT36EXi+XFEMsJ1CRL9uPZ9k0GFldRMgiqP4pm3HsJbifOK4+k1Z8adY8v4lgkPl
        O3LKDe0+VVQ8KMrC4GY9M/RqpyY+ANTv8HC34qgFIR1hskRs0Wf/roXx09ezU2lA
        ==
X-ME-Sender: <xms:o7kdXdyvfSOGJq2gfQ5RMNdFcUCTH00b58gu6qMYmLlN2t6Ddys69w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:o7kdXdg99bmKz2DQYtU3d61PPmhrCdZKFpjGd1gErMjYVqOhZ3MJ_w>
    <xmx:o7kdXQMYSlCLdz3YIqOD4FDJuPmvK9d5HFERtFy01i2hswYh_AyfPA>
    <xmx:o7kdXTbQULBbK2pEdL-95PMZdAp71D26XAaCFTlXiBVk21SlQUJ-Ag>
    <xmx:pLkdXXqCD0zC9PIa9PkAk97uC0OGOsjVR1s4P4lEsD-egXyKjFuzxA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6C56380084;
        Thu,  4 Jul 2019 04:32:34 -0400 (EDT)
Date:   Thu, 4 Jul 2019 10:32:33 +0200
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
Message-ID: <20190704083233.GH6438@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imsiyzo3.fsf@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:25:16AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Pawel Laszczak <pawell@cadence.com> writes:
> 
> >>
> >>Hi,
> >>
> >>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
> >>>
> >>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
> >>> > Hi all,
> >>> >
> >>> > After merging the usb tree, today's linux-next build (arm
> >>> > multi_v7_defconfig) failed like this:
> >>> >
> >>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
> >>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
> >>> >
> >>> > Caused by commit
> >>> >
> >>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
> >>> >
> >>> > I have used the usb tree from next-20190703 for today.
> >>> >
> >>> > This also occurs in the usb-gadget tree so I have used the version of
> >>> > that from next-20190703 as well.
> >>>
> >>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
> >>> take a look at this to see if I messed something up?
> >>
> >>This looks like it was caused by Pawel's patches.
> >>
> >>I'll try to reproduce here and see what's causing it.
> >
> > Problem is in my Patch. I reproduced it, but I don't understand why compiler 
> > complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
> > declaration is in drivers/usb/gadget.h. 
> 
> That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
> is a module:
> 
> CONFIG_USB_DWC3=y
> CONFIG_USB_LIBCOMPOSITE=m
> 
> 
> I remember that when you were doing this work, I asked you to move
> functions to usb/common. Why did you deviate from that suggestion? It's
> clear that decoding a ctrl request can be used by peripheral and host
> and we wouldn't have to deal with this problem if you had just followed
> the suggestion.
> 
> Now we have to come up with a way to fix this that doesn't involve
> reverting my part2 tag in its entirety because there are other important
> things there.
> 
> This is what I get for trusting people to do their part. I couldn't even
> compile test this since I don't have ARM compilers anymore (actually,
> just installed to test). Your customer, however, uses ARM cores so I
> would expect you to have at least compile tested this on ARM. How come
> this wasn't verified by anybody at TI?
> 
> TI used to have automated testing for many of the important defconfigs,
> is that completely gone? Are you guys relying entirely on linux-next?
> 
> Greg, if you prefer, please revert my part2 tag. If you do so, please
> let me know so I can drop the tag and commits from my tree as well.

How do I revert a tag?  How about I just revert individual commits,
which ones should I revert?

thanks,

greg k-h
