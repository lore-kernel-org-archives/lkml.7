Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C2C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E192077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="B0hpeXFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSFtAj6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgAIGCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:02:36 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56123 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgAIGCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:02:35 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5323321BF7;
        Thu,  9 Jan 2020 01:02:34 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 01:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=ppk6M6O6bxPK+JewvhdNsOJ1iYuNVFY
        lJvw1PiZgh8Q=; b=B0hpeXFPAmqPgfvxlO1xgdGc9W4ovITpbnU0RsbA1Z5pNPQ
        7dRZ1UCJQLxqtc3EsCctkZQxpbJqJ4tpBEypoOYDQ0T2Z+8z5gqvzoHdnsBiG8Yd
        lYx3Ev7jmZWNzbBi0SAZeP6U+P9qnqzJ1dgPTysjnIYbPNfFNmbyRPwWP82oHAxq
        WYjiGLwrBCKaCZpqNzXFqN9Z4tgiW7gjthsaxc3ZJTgKeN3AIyULZzOGxPWEkWmm
        vFM5GM35nCJZ6JakcmAnOV/d25qXCYETYgLCPuR7TbByCOehK9X1YZv0Y10X1GLA
        xXcE+4qBM9kY6Rx7u2ixfbOCmAnFrWL3BDYzbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ppk6M6
        O6bxPK+JewvhdNsOJ1iYuNVFYlJvw1PiZgh8Q=; b=kSFtAj6j6HtWpkHKTAI8Cq
        7C57n/SAS3iEbp0KB4iJTYbrNNIEbEJBkFuGmHbAUYiWrVRFvKoePLlmYkuxU39C
        Coth+kwtf/ieLc823Fu2QNgnnTNjLtvLPYJmFEI03AwOfH6MLCxYeskxVLkZNqvC
        FW3QC5vgaTpc6QZXKDJPwyyL2LRen6eEiJIrDOkKwR3R9YABwh/0P8qB/pCBdusT
        NifP7oxIv41Lfovjm+90xQ5W2DSsWebAHY+FUaAiRLYxRnxIjvAjn+6njrlD2FKT
        BlDH9cjSLUD+fWOSZIaRDVIdDfoaRs4YOIGk0x8qOhTmg6Jbt2BCyFlZ8N+PKKYQ
        ==
X-ME-Sender: <xms:-sEWXjpUgwtbXt30ED_DEhtYGbopYmtI0LvMsVX-S2QogaiIgk2OEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:-sEWXrDvjiy4rSKux5RzcKiWm9srq7NdIO6zuaprIyQ4_5aQ2HAujA>
    <xmx:-sEWXsMiVs-QJC4e1jEJuVJ_0N3RYdihXR0rCalhppO7fa-CRkOtug>
    <xmx:-sEWXqmBdnKpthE31yp8pbtEJ1NglT8E3Uds2OzOIzMjZIEVBZKRbQ>
    <xmx:-sEWXuf9_HayNTQAZa2x6ywxPcOJampgeOG5SU4vf1qMIYCuzOFIDQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 281D0E00A2; Thu,  9 Jan 2020 01:02:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <fa16ef12-b301-4a1d-aaf4-ee8fcd0f398e@www.fastmail.com>
In-Reply-To: <1577993276-2184-13-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-13-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 16:34:32 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 12/12] ARM: dts: aspeed: tacoma: Enable XDMA engine
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
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index f02de4ab058c..2e5cd51db7c2 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -1193,3 +1193,8 @@ &pinctrl {
>  	pinctrl-0 = <&pinctrl_lpc_default>,
>  		    <&pinctrl_lsirq_default>;
>  };
> +
> +&xdma {
> +	status = "okay";
> +	memory = <0xbf800000 0x00800000>;
> +};

Can you please add a comment about how the memory range was
derived?
