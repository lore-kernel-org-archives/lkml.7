Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F53BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574CA206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="MKLy/mC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLBZHRLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfG3QYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:24:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35979 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbfG3QYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:24:20 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A327221AD;
        Tue, 30 Jul 2019 12:24:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 12:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=F
        wo6VfvTIXOne5ZNuHPjqzaWc/eTYjBFCPDEzlOfnDI=; b=MKLy/mC0ZAsCZuEu8
        WLNQb6o90vZ/LL81br2hUK565khmq5tK1oHxrWNxTb36ML6So3y5/pE1YePz88K3
        RQGH+SgZURNZzBHg9qDh8WsZUky80O4LYYDRzY+j1RwVAKwpdXH4jsdR2RTHXRV6
        YYg6hF3LT3QEOEsFtaI7bz8Sl7ToMqPXqqeHAk8zWbVc3VADP6HmWyWR54ROHNaX
        kwwiMUAUMVX49Z/lcRySZB4zUv2EnzXzS7zUPZPiujFGycICvmP4IrVUDEEhKdFW
        nnvabQq/G9mMgqyNkfbDLY60afb15h6t3oiLXaSig4GiIbRyXrOIxjZQ5SuivOUG
        jwkYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Fwo6VfvTIXOne5ZNuHPjqzaWc/eTYjBFCPDEzlOfn
        DI=; b=DLBZHRLLeZDt+FItY8fBshC07hLEWOQJ5F9wfNNHggy7KqfVo6x4TAII3
        rahg328cSF8Ie4+/lje9BnvrCDvvaQswa2KWch5v9D0Xlspp+f5+f2YAT4LW+TiE
        e/9VFQ+b5rsLfDzNN29atWfxRypD+my2ytjpNHS1pQB3isbF23/Azg2eTHOt7qj9
        2Lc4+ivteElZCRKd50wL8SOooTCeu1NRBcKUvaEADajnh3I+YMdzYDWbqeDQlBDC
        4NH5PmvbEW05CWPXieMk67nuEHetvwhssoaGyQRk2LYPrKorHWnGOY2Doj9AeGi/
        dUA5fYfygywJF4n37ijYthJ/x96uA==
X-ME-Sender: <xms:Mm9AXSREQwjILnWkzYNZWvSDwpNGEXDHRDntxpdDkATIrYJr6BE4NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflrghnpgfu
    vggsrghsthhirghnpgfinphtthgvuceolhhinhhugiesjhgrshgvghdrnhgvtheqnecuff
    homhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecukfhppeeitddrjedurdeifedr
    jeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhnuhigsehjrghsvghgrdhnvghtne
    cuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Mm9AXSHY5uyzFAQ7OtwO58-stbsMeh_kge901u8juG1kWOJOR0I1jg>
    <xmx:Mm9AXaGWQ942Q42NUfg-PjQMoI2oIu-4cu9pFP-bEWBwLI2hhZbAtQ>
    <xmx:Mm9AXUS9Obw0Py43tRDVgD5p5rBhm9Kj_P_BYev9p7ELoK-8TDA3KQ>
    <xmx:M29AXSV9tgvyGrwBcXUoDU4nkwL3QS1FWKQCpiXgLqO-P-8HxxUXcg>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06BE980059;
        Tue, 30 Jul 2019 12:24:16 -0400 (EDT)
Subject: Re: [RFC PATCH 0/6] tiny: Add driver for gooddisplay epaper panels
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
 <CAKMK7uFBSHbEU3Nk3=dNnyt1pO_B83VCYTvbcfUiwomzXbR3Ew@mail.gmail.com>
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Message-ID: <9630934c-df9b-0d14-9dd9-fd27fa862571@jaseg.net>
Date:   Wed, 31 Jul 2019 01:24:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFBSHbEU3Nk3=dNnyt1pO_B83VCYTvbcfUiwomzXbR3Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

thanks for your comments!

On 7/30/19 11:26 PM, Daniel Vetter wrote:
>> I have a couple of questions regarding this driver, thus the RFC:
>> (1) By default, when loading the module a vt console binds to the fb. I think this is useful, but the cursor blink of the vt leads to an eternal refresh loop. Refresh on these displays is *extremely* slow (1 frame per 15s), so ideally I'd want the cursor to not blink. Is there some nice way to tell the vt/console driver to do this by default?
> 
> Hm maybe there is something, but this is the first epaper driver, so I
> guess even if it's exists already in fbcon, you'd need to wire through
> a flag from drm to drm fbdev emulation to fbdev core to fbcon that
> cursors should better not blink.

Thanks. I'll look into that.

>> (2) Is ioctl the correct interface for the driving waveform/refresh stuff?
> 
> For kms, no. In general kms is supposed to be standardized and
> generic, and uses properties. I think Emil already comment a bit with
> pointers what you should look into instead for each part. For partial
> updates we have the damage rectangle stuff now, but no idea whether
> that's good enough for what you need.

I suspect not. I looked into these properties, but as far as I understood they're tied to a mode, and modes are kind of static? If you want to display an animation on the epaper you might have to change these on a frame-per-frame basis. Can that be done with kms properties?

>> (3) I read that any drm driver has to be committed along with a libdrm implementation. I think the most likely interface for anyone to interact with this driver would be the fb dev. Do I have to make some userspace implementation as well anyway? If so, where would that go: libdrm or some sort of new libepaper?
> 
> Even more strict: we require full open source userspace, per
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> 
> But since kms is standardized you should be able to create a driver
> for it with no new changes in userspace at all.

phew!

>> (4) The driver accepts both XRGB8888 and RGB565 (for compatibility with small LCDs). The driver's current approach to calculate a b/w/r "ternary" image from this data is to just take the MSBs of each color component, then make anything red (R>127, G,B<=127) red, anything black (R,G,B each <=127) black and anything else white. This is since the display's default state is white, and a pixel can turn either red or black from that. Note that it's the actual pixel changing color, i.e. there is no black and red sub-pixels. If you try to drive black and red at the same time, the chip just selects red for that pixel. What are your thoughts on this interface? I was thinking about using some indexed color mode, but that would limit possible future grayscale support[7].
> 
> Hm generally we're trying not to fake stuff in the kernel driver in
> drm. XRGB8888 is an exception because too much stuff blindly assumes
> it exists. I think what we want here is an epaper drm_fourcc.h code,
> at least long-term. But since that's new userspace api it also means
> we need some open source userspace to drive it. I think best approach
> would be to get the basic driver with XRGB8888 emulation merged first,
> and then figure out how to best add the specific epaper formats to
> fully expose the underlying capabilities.

I think I'll rip out the rgb565 part then.

>> The following patches all apply on v5.2. This is my first linux driver, so please be gentle but please do point out all my mistakes :) I'm aware the dt binding doc is still lacking.
> 
> So the great and also somewhat tricky bit is that support code for
> tiny drivers is evolving really quick, so would be good if you can
> rebase onto drm-misc-next from
> https://cgit.freedesktop.org/drm/drm-misc/ There's still tons
> in-flight, but that should at least help. One notable series that
> didn't land yet renames tindydrm to drm/tiny/, so maybe wait for that
> to land (it hopefully should land soon I think).

I'm aware of that and I'll rebase when that's landed.

- Jan
