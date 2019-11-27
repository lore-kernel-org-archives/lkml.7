Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D5C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D46C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="JyfZhtH6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkWluTh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfK0Wdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:33:54 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41781 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbfK0Wdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:33:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 32353226DF;
        Wed, 27 Nov 2019 17:33:52 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 27 Nov 2019 17:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=IzkBKtsIWNt/0KHfahdEn8h/zDvhTn2
        y2qgOjDS+X54=; b=JyfZhtH6I0ZKd2o2M57TsCUen61dfpyhBJHt1MIXtLQoq+m
        +2SV44eMSwO3/Sg3qCJSQzC9ivUtSYXsGmQPjJx1x92rJGsl7jg4F3Q5kkIqS/3Q
        TeMYsnZJix15P8V/a/Q704xp6FdQdOwNkTmacY8XgVnOU0z0YplSIS1yS/31rJLU
        FD2hdDpUnu37PYM9byWslm84bFryGXoRbHA3XgHg0pnQn4YiXchz+H9KCI4BhHKX
        S1MSNRCgJuzAyk/rq0SKAb7PHdCh2TaV8QgqOc/izm/fljxM23UEQYh6VAAYFCou
        cXe2zHFlCv63fYqIRSutrZI9lcymfM820VwNejQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IzkBKt
        sIWNt/0KHfahdEn8h/zDvhTn2y2qgOjDS+X54=; b=CkWluTh8Tm5dT5epjP51lz
        jx5K+LxQqnCvdtEo+rOmMggbUljcIaeSvt4GZrpi/CBMMN2fQpfnar53Sl4FC8ab
        62BiZNuRSczkqqqKfOTf+pQfwmnlrf0eF7isYQijN+JU1G/PTE2IUIBhpzKeme0K
        a4SYsLk2pofV41p9vwvlbfz9taVYkkHsQhb4+F27+NBG1QKivNfw+B2fXW5a67RF
        0q4ZB1acSoXDf2Xbas7pyFvq1KGNPmBlJV8CRY6y2aLvNhAVW4TaQk+/rhSKwOdM
        W9njISK6GvSGBakXljoJHbW55s7/ISiNUc2ohS8LlolIEkGfbxCCW3sfesUeimWg
        ==
X-ME-Sender: <xms:z_neXWo_Igav66JgJT3RYTIr2u4xyUZNi1yFgbw3Wy14hBTB9E0AIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeihedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:z_neXepZLzgoxCq1TKoy6h_wUuwIOut7c0gQ21N767Ijq-tGRS5EsQ>
    <xmx:z_neXR0T6G5V7ONdwjjHPXe5jUtOs4CAzG5U_3A8MjBUl8VAoCL-IQ>
    <xmx:z_neXUEvcF8WiaBzxrpdy6Ggbfx9A5ZUuz1dSqQ_MNVaMbPtgNVzog>
    <xmx:0PneXRjJxm8EcHfJjrEapQVWzrxWaqNwBpczZCUwNS8kJhVFDJohyA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3D649E00A3; Wed, 27 Nov 2019 17:33:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <ba027dc2-613c-40c6-bb5e-1d320e51b191@www.fastmail.com>
In-Reply-To: <20191127132340.GA22672@cnn>
References: <20191127132340.GA22672@cnn>
Date:   Thu, 28 Nov 2019 09:05:21 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>
Cc:     "Joel Stanley" <joel@jms.id.au>, "Sai Dasari" <sdasari@fb.com>,
        "Vijay Khemka" <vijaykhemka@fb.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Nov 2019, at 23:53, manikandan-e wrote:
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>

If people have reviewed previous versions of your patches and sent
Reviewed-by/Acked-by/Tested-by tags, please make sure to include
them on future versions of the patches _unless_ there has been
significant change that might invalidate the tag. In that case, also
provide a short description as to why you dropped the tags. You can
add free-form information below the `---` and it will not be included
in the commit for the patch.

Cheers,

Andrew
