Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC634C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70B21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bFctbMb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrsAUZh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGCHea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:34:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43509 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfGCHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:34:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 37CC720D87;
        Wed,  3 Jul 2019 03:34:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Jul 2019 03:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8KFL/xorIZQ802Jhn4t9oQ3fFKw
        r20EIBGVmO3p9U9A=; b=bFctbMb6yriaYJ6ZSoYxHpiDsOmhFGsP+9wmjvzlNZ4
        Io30wo+8pmknuZk6z8Lm90DhdckImoiSFE2I4P/6eiDAL8GKUlai+o8jVFmPspnW
        AdrgIbpS1HtnhQgHK5px12FD1joF2APuRbRqX0Z+z+v4oF7Ys3ek9x2tfEu3HIY+
        GNUNXAH3/mfFgeUCySd0l6FpgMZhGvORaC1u3UT00Z+d8wCDEkxZ7sqRDQdVmOIy
        5QcEDx6mW5Qr5vhkXpBooYh8N7RgNAhDAoe+MkhgsreRbIBd7HXqCENK5J+c/fh1
        e4EFTUPkBvctOYQTb9wtyiL8qShZu5K/bgZglYlPDPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8KFL/x
        orIZQ802Jhn4t9oQ3fFKwr20EIBGVmO3p9U9A=; b=IrsAUZh3mlFOF3h0k7DPUb
        AowVwZhuZooj/3YH2tx8k3bjKnjBMmtJ/kCdA/b9g/Wl8WFSBq0BTcPCLRpHlMKK
        C1ggT89MmYukk1kDVYsKQnJ3Aw3F74mCSYmLpPCssn+QQc7CsM8sR1sqfgR+Sx+o
        dYO8XR1Sy38wFJXwuEgnUbmCGaqgMZykP+RTtT9Xn9G64W4obVQOvDnPmuTkdqmG
        EsU2uMVNWf46WIT6czATmTt5+FUCZFBsu1vGdMA8tX8u2FQPaPL9oAUxDptqz6JR
        Rqy8EPsUlSIVngS/VBx/6Z49qV4KpGSyQN5JtFCW4maED7BYNRoQCmzdhfXU0X0A
        ==
X-ME-Sender: <xms:hFocXc9DLUp4BXOuSxL3CTLk128keej7rEyXnR0uKqutKHPds1J0sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrvdelgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:hFocXZ4ghnXN8OlhxeDeNRFzz44whTGMQDTW-WdWuaHHKDaowpaYyw>
    <xmx:hFocXVZffMD2G7ja593cRn3e2x_TmMrwmVChDID0JhkeWzJqy--XGA>
    <xmx:hFocXb8aAshYjoKOn7D2okfKWq_pi64Rh06QQYxL4xa_b2DKTEkO2w>
    <xmx:hVocXZxKOhPszUYB67NBFNhYMSL8Tz6b9RoJVHcWHlwR3RE08QZYeA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D23AF80060;
        Wed,  3 Jul 2019 03:34:27 -0400 (EDT)
Date:   Wed, 3 Jul 2019 09:34:25 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: linux-next: Fixes tag needs some work in the staging tree
Message-ID: <20190703073425.GG3033@kroah.com>
References: <20190703075221.4ef65011@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703075221.4ef65011@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:52:21AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   597382cbd3c1 ("dt-bindings: iio: adc: stm32: add missing vdda supply")
> 
> Fixes tag
> 
>   Fixes: 841fcea454fe ("Documentation: dt-bindings: Document STM32 ADC DT
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.

Jonathan, I thought the iio tree was included in linux-next already, and
stuff like this should have been shaken out before it hit my tree?

thanks,

greg k-h
