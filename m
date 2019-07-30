Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB66C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF2208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="W/9MgqPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmN20DN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfG3Nqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:46:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50733 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730282AbfG3Nqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:46:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF1C32129D;
        Tue, 30 Jul 2019 09:46:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:to:subject:cc:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=iXH+1Em/W1KL7rQXqy2WX7mi+H
        4sQNF8v7vl1I4FYtM=; b=W/9MgqPA1DW5OOEPCyXyfuEBcfvzIWoSHlTZrqBE2z
        K/ZB3/b6NppEhoxRCi2kc+DJsE1vm52Pdt7p/G+o0kqRpPzeEjhTN0KQJhnDwaom
        ICY2z7EO+Ak763SJCFPpiFM0tNbURoUNk/uvpkRrUYj5Tpw8XHzoLkTXEpRH9AFH
        1Ek68jlzaF+UgR8FEaqDSyHet9aPv7itfss+YwfxCDUQb10s1ZTZelmAbIrVT98f
        UI5VZgc3xJEEutFLcNQEHjsM0PxXSrAIEZ2CxSw8FIuMOKwswIHw9zc/vR/yadw5
        7qUEBERjraufwhew01pqzKAKO9UIbz0AxRch83zggSHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iXH+1E
        m/W1KL7rQXqy2WX7mi+H4sQNF8v7vl1I4FYtM=; b=UmN20DN+L6EhazEkvJmNmi
        AsJ2YImIkrTMKApneFZq77epcA57/knms84khSy/J4BW02jlxGi2nAmLdW8SJkwM
        4rc5y50npBHUAnx9f91Ak8uTuo0AcRXBl75ruRZEybreOtQ5+jsXqXsQSl3cyR80
        TDk23l7tdcxMIwDw9kf8E6jygxJB2zIn/y+fgqVpOtV5zsChTGBSbmOSq7GrsdO5
        NszpH1x6g8wMVDgWXfETpyHygEmTyoL75CZ8BFl4r93sS77Zfr4ZT0XWepseiuLL
        m6Nx6Cn/if5kvfNo1NJxcLAHg5J0Xdjh8PJN7Hlv2kw1WKJOI25lPdo0Ui5A7wpg
        ==
X-ME-Sender: <xms:MkpAXfPnAJnfeE5wBvgl-ytd7SStatbdXGr8KyIkKP2q0og4c-eoig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffukffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpeflrghnpgfuvggs
    rghsthhirghnpgfinphtthgvuceolhhinhhugiesjhgrshgvghdrnhgvtheqnecuffhomh
    grihhnpehjrghsvghgrdhnvghtpdifrghvvghshhgrrhgvrdgtohhmpdhgihhthhhusgdr
    tghomhdpghhoohguqdguihhsphhlrgihrdgtohhmpdihohhuthhusggvrdgtohhmnecukf
    hppeeitddrjedurdeifedrjeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhnuhig
    sehjrghsvghgrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:MkpAXeMJ8CT09u2pnnx45I-ea0ScC2eg_371iu4KzxAAOzMUM89HNw>
    <xmx:MkpAXZQUBRyKq0Q90b5yfSL7p8DVS1mh7EcIdhTumYbR26hrReuyLA>
    <xmx:MkpAXYDEFd6bjWMN0S3RGeC7DK-QOYubd81Hv11-U0xFgby7AU7-xA>
    <xmx:M0pAXX_O1ml59H9CvDhpVo6ONgo3h2lbB5AZRpf33Zf6z1HS28k_-g>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id E871D80061;
        Tue, 30 Jul 2019 09:46:24 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Openpgp: preference=signencrypt
To:     dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 0/6] tiny: Add driver for gooddisplay epaper panels
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Message-ID: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Date:   Tue, 30 Jul 2019 22:46:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a tinydrm-based driver for black/white/red, b/w/yellow and b/w epaper displays made by good display[sic!][0]. These panels are fairly popular since waveshare[1] sells raspberry pi and arduino-compatible breakout boards with them.

The current state of the art in open source software as well as the vendors examples on how to drive these seems to be "pour some fairy dust into /dev/mem". This cannot stand, so here is a (tested, working) tinydrm driver. I've got working color output on two black/white/red panels (2.7" and 4.2") from python[2], and I have a kernel console showing up[3,4] and I can print colorful cows using cowsay and some ANSI escape sequences[5].

In this rfc patch I've added a couple ioctls to allow userspace to control refresh behavior. IMO this is necessary for a fully working driver: These displays support partial refresh, and you can use that to do proper animations[6]. But for this to work, you need to fine-tune the display's driving waveforms depending on the content displayed.

I have a couple of questions regarding this driver, thus the RFC:
(1) By default, when loading the module a vt console binds to the fb. I think this is useful, but the cursor blink of the vt leads to an eternal refresh loop. Refresh on these displays is *extremely* slow (1 frame per 15s), so ideally I'd want the cursor to not blink. Is there some nice way to tell the vt/console driver to do this by default?
(2) Is ioctl the correct interface for the driving waveform/refresh stuff?
(3) I read that any drm driver has to be committed along with a libdrm implementation. I think the most likely interface for anyone to interact with this driver would be the fb dev. Do I have to make some userspace implementation as well anyway? If so, where would that go: libdrm or some sort of new libepaper?
(4) The driver accepts both XRGB8888 and RGB565 (for compatibility with small LCDs). The driver's current approach to calculate a b/w/r "ternary" image from this data is to just take the MSBs of each color component, then make anything red (R>127, G,B<=127) red, anything black (R,G,B each <=127) black and anything else white. This is since the display's default state is white, and a pixel can turn either red or black from that. Note that it's the actual pixel changing color, i.e. there is no black and red sub-pixels. If you try to drive black and red at the same time, the chip just selects red for that pixel. What are your thoughts on this interface? I was thinking about using some indexed color mode, but that would limit possible future grayscale support[7].

The following patches all apply on v5.2. This is my first linux driver, so please be gentle but please do point out all my mistakes :) I'm aware the dt binding doc is still lacking.

Best regards,
Jan Sebastian Götte

[0] https://www.good-display.com/
[1] https://www.waveshare.com/product/modules/oleds-lcds/e-paper.htm
[2] https://blog.jaseg.net/images/epaper3.jpg
[3] https://blog.jaseg.net/images/epaper1.jpg
[4] https://blog.jaseg.net/images/epaper2.jpg
[5] https://blog.jaseg.net/images/epaper4.jpg
[6] https://www.youtube.com/watch?v=MsbiO8EAsGw
[7] https://github.com/zkarcher/FancyEPD
