Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D2C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EC020721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="rLpUWQAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWULgXyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgAIGCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:02:20 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37905 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgAIGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:02:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E326721B2C;
        Thu,  9 Jan 2020 01:02:18 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 01:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=UdhEr+iyYXu1wWyUc29O8TnTBKmF7NO
        gM7/OFTNWI8g=; b=rLpUWQAMg9zjllbFbX0l6+mEXKvU22ZzreE0ZBYGm18gMes
        XwZ1n6ZNqHZAKpOFj282xyfOdS3hMuuNsQn6lfFFojiw+JAjPiMr9z628Osvcf5V
        GCqSYHPlB5Sl5y08Dy7AEL4F1EiuYa+s0rW6x0GqHi3scCYXRFVjUPbT0qn2U4Uz
        G+JzFKLP8j1CuU/OskDKD8Vz1jNc2r4rfMQ/myPWjfhNctVzknczuUgLsqeuW0m0
        2gTlYgPoj2TL6ZM/t6ETl8Eh1adVJJsyhCyqjzih/DFEw79Ug3pMx+q4Q+sez7iF
        XVGaQan8V66IiZutbGJZfkhMTiyLXMd2K+bP6qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UdhEr+
        iyYXu1wWyUc29O8TnTBKmF7NOgM7/OFTNWI8g=; b=ZWULgXyte3UDblGEVjFP83
        H7pmqVzxZ5Bjj3BYaiwHr+Ocp93CnJnhV+f3Hnno44amS28k+ofMS1Cx+B5kPIGZ
        xp05MgyJ+I7XUFTizStJjwgRmgky8rKDQWWtVDWIDbtD53VPwBDiv6NOBytTbbUH
        vQvFbT07gWvV9LA+dEPoPjK04IRiwtzzC6UhcTzf4eQjCATi2mnrLwe/bTw8KxB3
        7Bp6Rc3PF8c2ZyrocnFNa89zxa8M9rlkybrad9MWdCdJsmiKK1SG+Bh9mzDPrkeA
        RVnufIFWZyVtwcUUlT2OukIc7wU5HW2rRm+4/w84YsdZAZll83/Zk+CIEf5QXVtQ
        ==
X-ME-Sender: <xms:6sEWXkYnFMnb33JNiq_p5QOLzvKXqGsJ3YMmVBWtJaw_gc02k4hLPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:6sEWXvQbSMIOyc6STMnCnNkXJm3drNIFz8yrduvuk5OPMfSzjNTyxQ>
    <xmx:6sEWXsQlmTVlq5-4Dt9JKUfhhOUHQNq2pBSmMQwfYsrX3Hg3z1LR4A>
    <xmx:6sEWXq3jgxqim-eSCFAWa2Lx75yxsolvOE-mSYxW66IEy7hipbQ7kA>
    <xmx:6sEWXjoD3DzI_1heMWWewmrPWDwOnZ2kcWH6PXqXWb3xt4uwDrJpGQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E69FEE00A1; Thu,  9 Jan 2020 01:02:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <406ac609-129e-4e11-8654-e4a48d8f72f8@www.fastmail.com>
In-Reply-To: <1577993276-2184-12-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-12-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 16:34:14 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v4_11/12]_ARM:_dts:_aspeed:_witherspoon:_Enable_XDM?=
 =?UTF-8?Q?A_Engine?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Enable the XDMA engine node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> index 569dad93e162..1a28b86f00ea 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> @@ -658,4 +658,9 @@ &video {
>  	memory-region = <&video_engine_memory>;
>  };
>  
> +&xdma {
> +	status = "okay";
> +	memory = <0x9f000000 0x01000000>;

Can you please add a comment about how the memory range was
derived?
