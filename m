Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A44C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10322087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="m7AfO5Vu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QtQ9mdBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfG1NOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:14:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57379 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbfG1NOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:14:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 307A621C28;
        Sun, 28 Jul 2019 09:13:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 28 Jul 2019 09:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=hVzKI8p0w2xwoUa9N8XqZjSz+WD
        RhfjRDgqEvd3Dgy8=; b=m7AfO5Vuvv3+YGZtrBOCkbCocobGFPQ+kizk/ZjFw4z
        17dCQkOXQpmJHd2KANFixX1uEYs2O8mm761pAK9Nkf9CbLuqQbxztq//z/fRutkr
        kISJPv5erURLEMB9sXDSI57VR4Var4iXozZ6/ZbW6ZrYbWqjei35pY2n2lnDE2/z
        W59Y4NZ61XHuEKbmbupey+P8uQ1TONIKPHVshmdABi0zMGg+bEsxowF6naYjF6Xg
        ofQWPK1zgo7KmMq4O+vWFg/+xaOrD9WYQl0npFfAJvg5vaYCDnBqhUhd4hXXNsad
        +AQJEwobrHwXIR8oWz7yXIAKJt9USLl5W35wlkhkQLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hVzKI8
        p0w2xwoUa9N8XqZjSz+WDRhfjRDgqEvd3Dgy8=; b=QtQ9mdBioZbkMeAkk0gvLV
        10nqDTuIK5FAo+senYC2BB/2aEXIlM24aN15mWYGFLK0O+BHdNvUs2/SHy00j0ik
        Tqid8kR+NarZpqEYpgFPM1JZeyb/M9KgK6YXbhXJN6gCFw099blqoDJD+VuaT5TT
        nrasenQEaXsK6wHL2XgjcI364YVYsfhqcg8VoCe7y5sxqFqohxC2mk8OW7BdmZ8B
        bkVp1w2K6070CBsBzvnFAYs10dDmqXI8QwL5X2+w8gsn0UA0SiXzidtoNWFIstGs
        5RNoR8wZ3SRHlr41N4HoSsS/fF7vBkAxc4qC3ZYwaIUNIpDzyG7EO8mOkRvGOvHQ
        ==
X-ME-Sender: <xms:lZ89XYV0ik0qEiTVmF-IkqbAPh13HYUvKa1pKiZ2mfZLw8u8vXeYDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:lZ89XY4H6ur_ycTVEUG_DCHLz3chCvPwnNYdB-hRE7EF6TuzIuqXFg>
    <xmx:lZ89XfLUVXLZyeOEL8Bd6DK8jFCIvdg0dS2L2JAj36KLsVAd9tsIiQ>
    <xmx:lZ89XZK2iM9Kb67FAHOK6_qLamw6lfnspB2Y5mXLRllLZLijUvia8g>
    <xmx:l589XYORfpZGOZfwr-Xx86FWInxTXh9L4bLuArahqGG6kxJLPjJl0g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59F5C80059;
        Sun, 28 Jul 2019 09:13:57 -0400 (EDT)
Date:   Sun, 28 Jul 2019 15:13:55 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: linux-next: Fixes tag needs some work in the staging.current tree
Message-ID: <20190728131355.GA5007@kroah.com>
References: <20190728230147.1925870f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728230147.1925870f@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 11:01:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   5a304e1a4ea0 ("IIO: Ingenic JZ47xx: Set clock divider on probe")
> 
> Fixes tag
> 
>   Fixes: 1a78daea107d ("iio: adc: probe should set clock divider")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> Did you mean
> 
> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")

Jonathan, I'm guessing this was your fault...

greg k-h
