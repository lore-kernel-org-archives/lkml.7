Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6243C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826F20835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 14:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RDWHphDd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOXsY4aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJFOn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 10:43:28 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43885 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfJFOn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 10:43:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5F9A42B7;
        Sun,  6 Oct 2019 10:43:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 06 Oct 2019 10:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=k/vLThNCgaYuNTAWlGdIAwooUFW
        4oooG8+RtbEaxCQw=; b=RDWHphDdTCQ7NthgqDQ18MHip0dtAbJ4qA4lJDCAVp0
        t9QimCOsy3HDlIk3u3ch6gLDy0XNWAZ6dQ+zK2LFmPFMbkje29W185mkw+JawzoY
        kmCa4Qjf0/wg7el9Qj6pohd5rYu0KI96+D+IZKHi4tm2dl3xClsimq3/6P+LMZRx
        1EH5s2yjj4MubcEjzwCw6d6ItxPKyDrM2cgL6Bhc2XAGvG/wBIrKBpV+F+1j7iUe
        dUVAh2mYBAWgb4sUs8zDGeKnb3nKvFQzfBabkozStpHR3jHCCKhGJPx23PzZqc62
        ka7ai6r1PVs1zasuqrMWgwxrQr9jDpnyxTjLo8MTxaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k/vLTh
        NCgaYuNTAWlGdIAwooUFW4oooG8+RtbEaxCQw=; b=nOXsY4aFF2B367w8NqtAyO
        OlC2mT3bxbezPHyZI0REsc5SrW0gY7Iu9QFHG8lD10Na6yXMNwr6K+O/EauzE3j8
        DxnT8mgGPXt6dKF2fOVHThlBC1brMzv5q3oNycx5/NI2HX5Q+4l5x2jdB2Dw5Tda
        Qct4zD6sZHrBXxORrFlkyh0NcxldBlaTHWivuvla3cBny2stSCc3Zv83GNeBoh8y
        2Bqsq4UfgAjrqzjY+zX9S8FYrqoU+JWQNv0cVO1XOqPjJKKuqQjybKLVU0FoupqJ
        OMnrPAv8VBQN96EpUfXvH3da8PdHZGcR+kCyDCKq9QJZPBDITO8jtnzWOwdXnf6A
        ==
X-ME-Sender: <xms:jf2ZXdJp7TtOkL-bfPQClj2LVlID-13OcR-gj3tPH_SuVHQiWxqWaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheehgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesthdtre
    dttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:jf2ZXZU_akMnsDMLeb63bfaKHH5GU90PxPe2VwAtLLtKY5o71TLYRw>
    <xmx:jf2ZXfNZWCmacri3_-sRljxetLfkcYvKBpRPV3AP01BZFlMod29HGg>
    <xmx:jf2ZXddTStfdAEQ9bg4VxlWSZLvIBemIsTEoGOa9K6ol2ClGTv4Htg>
    <xmx:jv2ZXVQp_3ztQNwuvEPnq9g5pkW3h1TUpdTBLgdExfoi17fNleGN8w>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C172D6005D;
        Sun,  6 Oct 2019 10:43:25 -0400 (EDT)
Date:   Sun, 6 Oct 2019 16:43:23 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "soundwire: fix regmap dependencies and align with other
 serial links" has been added to the 5.2-stable tree
Message-ID: <20191006144323.GA4050853@kroah.com>
References: <20191006134448.9CBEE2084B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006134448.9CBEE2084B@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 09:44:47AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     soundwire: fix regmap dependencies and align with other serial links
> 
> to the 5.2-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      soundwire-fix-regmap-dependencies-and-align-with-oth.patch
> and it can be found in the queue-5.2 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 3287dff699a585506096287541cc4414600899c7
> Author: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Date:   Thu Jul 18 18:02:15 2019 -0500
> 
>     soundwire: fix regmap dependencies and align with other serial links
>     
>     [ Upstream commit 8676b3ca4673517650fd509d7fa586aff87b3c28 ]
>     
>     The existing code has a mixed select/depend usage which makes no sense.
>     
>     config SOUNDWIRE_BUS
>            tristate
>            select REGMAP_SOUNDWIRE
>     
>     config REGMAP_SOUNDWIRE
>             tristate
>             depends on SOUNDWIRE_BUS
>     
>     Let's remove one layer of Kconfig definitions and align with the
>     solutions used by all other serial links.
>     
>     Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>     Link: https://lore.kernel.org/r/20190718230215.18675-1-pierre-louis.bossart@linux.intel.com
>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 6ad5ef48b61ee..8cd2ac650b505 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -44,7 +44,7 @@ config REGMAP_IRQ
>  
>  config REGMAP_SOUNDWIRE
>  	tristate
> -	depends on SOUNDWIRE_BUS
> +	depends on SOUNDWIRE
>  
>  config REGMAP_SCCB
>  	tristate
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 3a01cfd70fdcd..f518273cfbe3c 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  
>  menuconfig SOUNDWIRE
> -	bool "SoundWire support"
> +	tristate "SoundWire support"
>  	help
>  	  SoundWire is a 2-Pin interface with data and clock line ratified
>  	  by the MIPI Alliance. SoundWire is used for transporting data
> @@ -17,17 +17,12 @@ if SOUNDWIRE
>  
>  comment "SoundWire Devices"
>  
> -config SOUNDWIRE_BUS
> -	tristate
> -	select REGMAP_SOUNDWIRE
> -
>  config SOUNDWIRE_CADENCE
>  	tristate
>  
>  config SOUNDWIRE_INTEL
>  	tristate "Intel SoundWire Master driver"
>  	select SOUNDWIRE_CADENCE
> -	select SOUNDWIRE_BUS
>  	depends on X86 && ACPI && SND_SOC
>  	help
>  	  SoundWire Intel Master driver.
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index fd99a831b92a0..45b7e50016539 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -5,7 +5,7 @@
>  
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> -obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
> +obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>  
>  #Cadence Objs
>  soundwire-cadence-objs := cadence_master.o

Do any of these Kconfig changes actually fix any real issue?  It looks
like they are all just "cleanups" to me.  What problem are they solving?

thanks,

greg k-h
