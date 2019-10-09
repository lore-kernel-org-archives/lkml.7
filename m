Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03774C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF861206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hNhbcpxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNBGiYbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfJINIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:08:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38827 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731224AbfJINIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:08:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D2C992214A;
        Wed,  9 Oct 2019 09:08:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 09 Oct 2019 09:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mLKOTL/8x5gDgJFUJhb3gNI98kn
        LsTJTiu2myd2FUm8=; b=hNhbcpxLBrllawZD05Fou1XENFBUs9M6EKGJmP4Lia4
        2hV2LzodIvo7MnT4LRFkfJQ8g5gs7Ss0xDmYBBWeFVQ6tgjYZpUz/a00tB0ECRj9
        HkGgu2TAgCjblJ/ug9PHHWL0wdd4KJpKIHhuaC7ixOR6y0dMNIWeK8qyecwFpb1n
        oeebZ4/6ziYTpYERWG6XsTu3foxkZHH1IQBvewgNvSZZm71T0EI0pTMBEp1oYfSt
        9VkuAyrQ5oqw9x91KFSWOW+rdo9gbRncM2IgB9YC5l6Kf73+WfugJFhKni6PN59j
        GfIHXlGhzKMg0HrV7+7QlaLVFI1w1URjL6VD3McV8cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mLKOTL
        /8x5gDgJFUJhb3gNI98knLsTJTiu2myd2FUm8=; b=jNBGiYbuvNrXUM4MjX81uU
        GqFuP/jUuo+oP39GYep1haEv3KEBTJUppsZy+ldyhL9ievsDhTVMctzaiK8312wE
        wVae1trfvEv7z/dhmOsZaQx61FD/UG4cR+re8BhTJy2axrc0ylJZUtS6S+nsj8pB
        h32gG2eBsmbJCkJTdgo7yDL5w9w3Vnj6/GV7wiqs1FdcnIANr3gCRRV7Qn3Yvv6C
        6sUI4Yxxu+VfM3F8LUg78jkkTlKHN4oKxQ9yALbVQhgfhG0OMkriQ1k6gL7q3PY5
        fWn0aH3awOhySosC65uD9Ma/9w62AGIsq9bWT2PyOYXcbBneS7w0ilB3/g31lXBQ
        ==
X-ME-Sender: <xms:xNudXXcK6dMPpKj0_oxaG-bTWJHiqmRyhVsvG5kvUGntUJTAD3AOhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedugdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xNudXRcrfEORuG5dl9z9rmsHxSj7qQS_5iwoIpoRpJp4H1tGnwVjKA>
    <xmx:xNudXde6sP8rTqO2F8bQ7AC5iZXUI4sdMa9qL6dXp5o6MyHHm0-RsQ>
    <xmx:xNudXXo44Dl4h4BbC7pwG61Q1B-UfEyrgZkvuaxbR_M5PRCwyA53uA>
    <xmx:xNudXQFZNblyOfLkPG8IKhwn39aidh-ucqUngk2RVygeY0Ii-6868Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4253ED6005D;
        Wed,  9 Oct 2019 09:08:20 -0400 (EDT)
Date:   Wed, 9 Oct 2019 15:08:18 +0200
From:   Greg KH <greg@kroah.com>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] dmaengine: avalon: Intel Avalon-MM DMA
 Interface for PCIe test
Message-ID: <20191009130818.GB4148375@kroah.com>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <6b540aeae71112154836003f2356703df2b36333.1570558807.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b540aeae71112154836003f2356703df2b36333.1570558807.git.a.gordeev.box@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:12:31PM +0200, Alexander Gordeev wrote:
> +config AVALON_TEST_TARGET_BASE
> +	hex "Target device base address"
> +	default "0x70000000"
> +
> +config AVALON_TEST_TARGET_SIZE
> +	hex "Target device memory size"
> +	default "0x10000000"

Don't put stuff like this as a configuration option, requiring the
kernel to be rebuilt.  Make it dynamic, or from device tree, but not
like this.

thanks,

greg k-h
