Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A28C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9372420815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="CpsQQPIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LGOno1P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKYAC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:02:56 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58723 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbfKYACz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:02:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7CFB15C3D;
        Sun, 24 Nov 2019 19:02:54 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 24 Nov 2019 19:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm1; bh=yAnKxPZbRoo2OEW2NIbW2/4bJIIdzho
        1/YK4gE1VRSI=; b=CpsQQPIhPJ/jYdZjfnThBWlUg781MVJEU4QU+iJ6hrboGoH
        BQsmQIfd8fPnBwmdp36oTQWfl4ne2rOqyYGXRZaxw6DBTW+RxHrpQ4TeqnR7Da04
        lYHKG8nETc29H3Sqbg2tcjWiKXGA6jDKGSEXWYjV+YmwxjXox7FMo0d0K8XFy6/c
        +Tfot/aRG3tRp6M+luzjlzvTyxDTNot77hdK0Idw1dT5yHkLatejQxgeFx44waTX
        2KD2uGu1bpHNyt/0F/BproROs/moImh4jCuyJkC6s2ZqHa+N9VA54Hlv1bOQNcBv
        k5Qzt2H9cRVrCdapq4hTAWkyFOzpjhGSJZXmcpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yAnKxP
        ZbRoo2OEW2NIbW2/4bJIIdzho1/YK4gE1VRSI=; b=LGOno1P+W3b/rePYylNzoK
        bBxLTrKmyFUTwlm86ughlr1HMuV62A2DQuSVMLFgLMY2SYdzXBepH/jbrB6d+azZ
        9/F7fBp1ZzRQ9uIt1FYUViwoSYRy2ZSsckdengfnTNJWOIDwqesJGXjRgZIRqioU
        +jhN5tHyiFhurj2b2HhHQOiUrR1TNF6Uf3CVXadfrDsMSzz2lVSnA2W/rWiipQmh
        LyLJPjIu9e3sdGFJuMZjIvkJMQnZHooYsJmvt6pG2gCRGZNzi62iD+08Q2m6YOSd
        I/N8c4nSwHGDeJFvbVPeWNJ0/O2nbW+5mM0uWiHys3Alxv8yMyVV0hSlrWVsiEVw
        ==
X-ME-Sender: <xms:LRrbXWUvwxkLfpXcaYQh4THV3cG8v3qN88Yz_EoLsJIK87BcFDVPOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:LRrbXRRKtLxr4ZWaqqIOYvR1Day3I9pQjOgnBMXSL21zCHwcghRwOA>
    <xmx:LRrbXdtkdba12QZVYsGYAO-y3uHHrs5UV3A-z1MfsQoQd34ej5nMRA>
    <xmx:LRrbXaMaSzHburtqGZ2qO0hvR3WyKvrgLNBX-y1tssUWxrmtQ9mJIg>
    <xmx:LhrbXaxeNjVY1OcNxmMWetzIFofI1MOqPtBc_xvODKv-MQJ2oZGIUA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 59B21E00A3; Sun, 24 Nov 2019 19:02:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <ef65b741-baec-484d-a5f4-984452e9d4e5@www.fastmail.com>
In-Reply-To: <20191031014040.12898-1-rentao.bupt@gmail.com>
References: <20191031014040.12898-1-rentao.bupt@gmail.com>
Date:   Mon, 25 Nov 2019 10:34:22 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Tao Ren" <rentao.bupt@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Paul Burton" <paulburton@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Doug Anderson" <armlinux@m.disordat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        "Tao Ren" <taoren@fb.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v2]_ARM:_ASPEED:_update_default_ARCH=5FNR=5FGPIO_fo?=
 =?UTF-8?Q?r_ARCH=5FASPEED?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2019, at 12:10, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Increase the max number of GPIOs from default 512 to 1024 for ASPEED
> platforms, because Facebook Yamp (AST2500) BMC platform has total 594
> GPIO pins (232 provided by ASPEED SoC, and 362 by I/O Expanders).
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Hopefully userspace is not making assumptions about sysfs gpiochip numbers.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
