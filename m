Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF6C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9548B2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pEx6jeAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOp3IzG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfFRLvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:51:37 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50621 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729712AbfFRLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:51:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 84220754;
        Tue, 18 Jun 2019 07:51:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 18 Jun 2019 07:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=DC9V7nZigwULy1vXQzkKAfN8Y81
        PyCPnn1G5PFEEkWs=; b=pEx6jeAUlu1KEq3LJcLdHwKFkgEzcJsQzyYkZEL++np
        wCmnL29+7hit1h1cim3TQxlLNTRd93PqUF+odnsv1RGghB1V/BXS73SMRHYDv5Fb
        SVTIqNy6L650QF3saKqN0E7Wsk6wN+iLhVk0RVNNlLXCPY5jL7yCc+1c8JD6fDVK
        mXL00vaQH58aTy95YodXO9k+W3NQ3+hQMYItnnmoHABEAfBUALR8QMWNSJ66ACZ1
        PXCxw9tONOFKVFhy7jmXs8bCyOJerqy7qWFrBkuVGbU/mSa0RdPTeH3iX4e+tAAh
        lDquW+sEaPVNe3cindpijtw8e1LA2AvDXCH7llsKLhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DC9V7n
        ZigwULy1vXQzkKAfN8Y81PyCPnn1G5PFEEkWs=; b=UOp3IzG99VID2tkE3N9AAG
        G+66LMK6ep2PTHdsqzNNSYg3zpsU1fzjN6ctjH0HW/xs/1oBNU2xjXTHw1FvduwO
        nFoddJBZSY+NxShvPQGZHF09uuqvpkxWON1Z+5ar03J2S6eleJ86a4dW7eGlm+79
        vVgFcBu0zRdJjjEr6H1l/9Jr6AVr8lKEWT8woWlmUvrjxmZhLQQ0XRWN1j8F8jJl
        7fqF0OOr+GZZGR0+9Yo0nAn6Colp5X5lpM/s9oHqF4dS9f7bL9tQhLu1Ul+8EhrN
        VKGapQs38PMns4SdaLD/beILDWmVLhVFH7fpxtrRq1bwmfG/O8q3OH4Pdy/tT17g
        ==
X-ME-Sender: <xms:RtAIXQDSdVfjb8-bjMHZlvCN1MemiEsf6z9I04UvqPlglDkGGwanXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:RtAIXdun1X8KGtREfWcXtAdrdDhL_M0EmpqThnLlpUuQaNGKSHvATA>
    <xmx:RtAIXXa440YQGHt3UsMG2Z4GEkGEUodjZ2JAf4K9aRcBRqWA8gd1lg>
    <xmx:RtAIXRGUJAYYHv2hvrbC9UYU75ekSW2VHEeznKPVs4EV_aXqCjkLbA>
    <xmx:R9AIXfPmfvhfHD9fN2kQWAckSn79O9eO8p8azkp84D3ryyphHBU2jA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE5FD38008B;
        Tue, 18 Jun 2019 07:51:33 -0400 (EDT)
Date:   Tue, 18 Jun 2019 13:51:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the staging.current tree
Message-ID: <20190618115131.GB21419@kroah.com>
References: <20190618073618.0682627e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618073618.0682627e@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:36:18AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   0c75376fa395 ("counter/ftm-quaddec: Add missing dependencies in Kconfig")
> 
> Fixes tag
> 
>   Fixes: a3b9a99 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 
> In commit
> 
>   bce0d57db388 ("iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c controller")
> 
> Fixes tag
> 
>   Fixes: c91c1c844ebd ("imu: st_lsm6dsx: add i2c embedded controller support")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'

Ugh.

I blame Jonathan for all of these as they came in through his tree :)

thanks,

greg k-h
