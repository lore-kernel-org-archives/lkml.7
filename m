Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B26C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7012077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bssJTdkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OmKz87wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfLLMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:24:42 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50819 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729093AbfLLMYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:24:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0858B226DA;
        Thu, 12 Dec 2019 07:24:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 12 Dec 2019 07:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2scdUPQH6/S737X9bHyYedRxXFA
        +cGGK7uaXn+cxR+4=; b=bssJTdkTRgSmIe3wKmne6OBDU2GO0mfk6A1uHln3c3i
        HtNDCklTVoX7NJ62q7TwoLViFTsMomNCru86QkHHj332x5gXQZKNL3/XK8oyQQsl
        Yer8jWGngrSc7kmGZ9kM6GmTf96ARhcRLcHCX3Xjp2UQeRgwR/VgB/0XJH2eTc1n
        nXxi3LzZXTB6BA5gSqZGq9mu/5OQ1t8LDBEl2pMjIpjSuRjwuo+GaKw7XJhwEPXn
        eIgHDyQHoXBke4TzdZ1kV47Bmg9I1aTOCtj0ubvC61gwaubmpd/fzPb+PC8dru+0
        0u1zFOTPcvQnMsD+dZsKJCyK8u7dB/jr7r1Sqhq36NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2scdUP
        QH6/S737X9bHyYedRxXFA+cGGK7uaXn+cxR+4=; b=OmKz87wUNQgdgCH5WvFKSk
        H2/SxdW7+AIJpvCjbMZldFW5Q0ID/mnhEHlaQMGEXeM6YVWED381FbrWHcrdqZVU
        LX9MGrlBD1bpwof1V5mwR/FbaFDwOlbMVVIRSzua4HK1oEtVeBsOqDIf5DmcMmVZ
        aywwnuh43WqJabPFginNLHF9T8l/XsB41uQuGwo+oOqMIfTR2Ody4OgqsdIu5PXu
        xgNlh0+CM7YhV2UMHV8VCSJnIidFw0Ak8vlRF/Bs+lPtY4AwOC14ogtN486Wb7o7
        RwofC1TOAiFW0NWGKyP2UGF72zKoMB7Gu7ZE8x7GFk+TwuTdOdPgvO2nOV6/Dx5w
        ==
X-ME-Sender: <xms:iDHyXcLPrTdhTlFqv6IXHo9BPM06m_9npGWD8deQZB94lKJ96jvrlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeljedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:iDHyXTuRE_fxWf0NgawgyjAQYf3n4X58vH7cpgkBKrxto7qUiQ7h3g>
    <xmx:iDHyXcXi3u4IdmKtPWOaP-mBj8sU_tHRwha42oPMziD1ANugwEIklA>
    <xmx:iDHyXWLr8os-CNAIGOVHZVoMefFf8Uh1MqTKlEs5BvLLguELjL9hGA>
    <xmx:iTHyXUXMqI0zLC85pkp8IKhjH3GSL_8074Qn_g-SbiZRbtBoa9KIww>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF6CA80059;
        Thu, 12 Dec 2019 07:24:39 -0500 (EST)
Date:   Thu, 12 Dec 2019 13:24:37 +0100
From:   Greg KH <greg@kroah.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 148/350] media: ad5820: Define entity function
Message-ID: <20191212122437.GA1541615@kroah.com>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-109-sashal@kernel.org>
 <20191212121938.GB17876@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212121938.GB17876@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:19:38PM +0100, Pavel Machek wrote:
> On Tue 2019-12-10 16:04:13, Sasha Levin wrote:
> > From: Ricardo Ribalda Delgado <ribalda@kernel.org>
> > 
> > [ Upstream commit 801ef7c4919efba6b96b5aed1e72844ca69e26d3 ]
> > 
> > Without this patch, media_device_register_entity throws a warning:
> > 
> > dev_warn(mdev->dev,
> > 	 "Entity type for entity %s was not initialized!\n",
> > 	 entity->name);
> 
> This fixes warning, not a serious bug. Thus it is against stable
> rules.

That's a good enough fix for a real issue.  We take patches in stable
for this all the time.

thanks,

greg k-h
