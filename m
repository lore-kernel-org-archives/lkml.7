Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ECB2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UthxIiQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tGXCdIHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfECBY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:24:58 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43249 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbfECBY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:24:58 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 21:24:57 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C7A598E7;
        Thu,  2 May 2019 21:19:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 May 2019 21:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sPDbUJmHaVq97y4GuG/FIKWkWKV
        tpZfVshd5q6sAmvk=; b=UthxIiQ1ntdc1HsURjtS8Up+4edtQxHwwGMSlVTIxQa
        M5z7BuNJLIvNcVu2H8/duSREUvclFw+gPg52jQBrHqGPUXThnlwTQC0oJyu1K4G6
        ptgXgOtQQCyYYut8UDJxiZrAuewJtbcdKlaApyQwyfr8h4hoaVcBD6DVSanDDK7z
        UvdumQqpZ8CqmOEpaIQp+KsDBhTQzbuk7UOZ96EAYs38rbFQRFOXPQ+hWL7sq4w6
        LpYRtsf+8ByUrsvHZ3M/qCJ41EflLCQIHm9stKYLDXxbVat7RvGyLDJRbmsF0K7w
        njny6nxiuIxHYRpPzRr3SYKhJMhKGhpHjkBR7wt2oLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sPDbUJ
        mHaVq97y4GuG/FIKWkWKVtpZfVshd5q6sAmvk=; b=tGXCdIHVNAUwKbdpPkj2ku
        YWF62ogALsBS+qCRu1CIURbjuRI6v2nLMrDmlv1IB3GCrwnGb9vnIn2NukUqf9qG
        PSJ8UJV6IaUguc3IBpBAM3T63kgYivBtFqmfAN3+8qMnIPVT4RA/9873mikB0ISn
        fpFvq9Jl3+8Bp1X4quiCMAORAyUE9lIIzMmITOnCbiZnRUn2e05jFJLx3INR9DIg
        THAbJ8wm0Zl2DNopXkzOBBHwAFDNoSisSZdG633IU89ODXG/nOCDyOfv7UAn90gQ
        qDl+Rjeojp8X3AmQU+4gJMS1frbuexXcQF1tlI5BzwqAN1SY4vxoz+YuXfLFLUSw
        ==
X-ME-Sender: <xms:BpfLXLkipxRY1xOmyt1Ojd3sIAZCFDpyodGmEOPJz0L-jvSMqK7LqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjedtgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrlhhsrgdqphhrohhjvggtthdr
    ohhrghenucfkphepudegrdefrdejhedrudekudenucfrrghrrghmpehmrghilhhfrhhomh
    epohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:BpfLXF7LeeYKYX79kzKoESKET-5AUUhoGQz-O4eqt5j_Zu7bzATvGg>
    <xmx:BpfLXJpTb9xeYoQMrRpiHjCOrZu6z5edpKz-zn_QZNLqiXh9mtSSYg>
    <xmx:BpfLXFQB2_6OgcLBYD3gkfqi-Kl7s3V4ARTRCtVOfiPUniBsVDhe6w>
    <xmx:B5fLXCaQufuO0eLQRkQfJCsZUW1UeY3_HcR3cxKRZGkLqmoTEi44SA>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB2001037C;
        Thu,  2 May 2019 21:18:59 -0400 (EDT)
Date:   Fri, 3 May 2019 10:18:56 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update git tree for sound entries
Message-ID: <20190503011855.GA30162@workstation>
Mail-Followup-To: Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>,
        Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20190502172700.215737-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502172700.215737-1-zwisler@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 02, 2019 at 11:27:00AM -0600, Ross Zwisler wrote:
> Several sound related entries in MAINTAINERS refer to the old git tree
> at "git://git.alsa-project.org/alsa-kernel.git".  This is no longer used
> for development, and Takashi Iwai's kernel.org tree is used instead.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  MAINTAINERS | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

This is a good catch.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b5480..d373d976a9317 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3351,7 +3351,7 @@ F:	include/uapi/linux/bsg.h
>  BT87X AUDIO DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	Documentation/sound/cards/bt87x.rst
>  F:	sound/pci/bt87x.c
> @@ -3404,7 +3404,7 @@ F:	drivers/scsi/FlashPoint.*
>  C-MEDIA CMI8788 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/pci/oxygen/
>  
> @@ -5696,7 +5696,7 @@ F:	drivers/edac/qcom_edac.c
>  EDIROL UA-101/UA-1000 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/usb/misc/ua101.c
>  
> @@ -6036,7 +6036,7 @@ F:	include/linux/f75375s.h
>  FIREWIRE AUDIO DRIVERS
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/firewire/
>  
> @@ -11593,7 +11593,7 @@ F:	Documentation/devicetree/bindings/opp/
>  OPL4 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/drivers/opl4/
>  
> @@ -14490,7 +14490,6 @@ M:	Takashi Iwai <tiwai@suse.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  W:	http://www.alsa-project.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> -T:	git git://git.alsa-project.org/alsa-kernel.git
>  Q:	http://patchwork.kernel.org/project/alsa-devel/list/
>  S:	Maintained
>  F:	Documentation/sound/
> @@ -16100,7 +16099,7 @@ F:	drivers/usb/storage/
>  USB MIDI DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/usb/midi.*
>  
> -- 
> 2.21.0.593.g511ec345e18-goog

Regards

Takashi Sakamoto
