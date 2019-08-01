Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C4FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95E9214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PibmSTkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vpFmvQLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfHAGKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:10:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56753 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729226AbfHAGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:10:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 41F9E21F3C;
        Thu,  1 Aug 2019 02:10:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 01 Aug 2019 02:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=hOeNybep07VjZ/TbsIdXNPDn5HL
        BnSZU3O6eiq4ILIg=; b=PibmSTkBgEJD7tlRYhHfO0gjT2CXcpJ82NXLBN/XCQz
        BI7aA8g4hA4vmgGroLp5QyDY0WdIqSt9huaBOp3ldz86A4C0QrN9yBMAV9ECQSvZ
        +9/PtQ07cnKpuO6WxvCdYzpU+K3rvtwoVKTniehlPZEO60i/qsJH3Fv8meOy/GjC
        AlGuywiWKAKrfb78M1jlkI/5KcnnAIjIaovBfqo7RcUkaEg/L6Ewt6upk+h/KXgm
        w9oHdwB0RYdbNdcEXhRop9uhuKzkApQbObQMyQEzT+WNnAo/1/7HvDRr3xWxKChM
        XUcHfD4l9uX0XqJ1aVsHu+KvINYPwJW9MmAAz+nynEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hOeNyb
        ep07VjZ/TbsIdXNPDn5HLBnSZU3O6eiq4ILIg=; b=vpFmvQLp+Ex1jnEmZdyR8f
        cG7HKOwoRtQBBSHKOg0tr3Yr4N5uvXwesn144AoXFlxBE0EIMFHj+5dcNJd52ZxY
        P4j6ZKy1t2QSxBWi4/qzmshBaOxrpyRjzz+IFgOIUQx2IaH8IPVPwE4A3QoZgwDc
        2pBeTc569xc1DV2ESOY3sIzyjMEzGEub/cUL+W6MMqkuruLcIXf6RGk8cwIuPTwC
        bRCr68B0fYHLcJDzg23bz0KuF6bB5atj7BpdF1RJ7YgPcBClZz00g5hb7cOo3wXY
        anzg2S3uhkFu25nVf3BdnuuCZM2NI2W2s75Zu8r1wrfUXgb2b4HHoX2bASVV9AiQ
        ==
X-ME-Sender: <xms:ZIJCXbmTv7jrAHjk7ne7tq0abq_j5mF9rMy36fnUflYzAUVGiordbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleeigddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ZIJCXWgyd1dQ6phvgJJ-_-TD4hG-ATNmh-mBms9xKlRQSumlbPj9Kg>
    <xmx:ZIJCXT32l18KgNSy1RftA0UcmTcohG7rly-tUxs8h74gjgRXGKn-nQ>
    <xmx:ZIJCXSQr1OnssSo0UA7oS6mRMlL_G9LYyOZ5__6d7OVaPuxWLsEG5Q>
    <xmx:ZYJCXVx9QWN3j6i2TMFzWsB1y3LKnyTIWS3q6VPeSrcVp8gEfw6oNA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35B4A380076;
        Thu,  1 Aug 2019 02:10:44 -0400 (EDT)
Date:   Thu, 1 Aug 2019 08:10:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190801061042.GA1132@kroah.com>
References: <20190801150537.5878bbac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801150537.5878bbac@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:05:37PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/i2c/i2c-core-acpi.c:347:12: warning: 'i2c_acpi_find_match_adapter' defined but not used [-Wunused-function]
>  static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")

Oops, missed that one.

Suzuki, can you send a follow-on patch to fix this up?

thanks,

greg k-h
