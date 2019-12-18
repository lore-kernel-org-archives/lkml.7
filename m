Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26440C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7121582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NnqUQOUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hE1MbfWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLRIu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:50:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58557 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbfLRIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:50:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 11B1B2226D;
        Wed, 18 Dec 2019 03:50:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 18 Dec 2019 03:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=61X8RsHQ6EcABsEBMC0ORNRgE7k
        pSZ2Lgfyht6KUc/c=; b=NnqUQOUIzLPienFd2UfAtNd1PGcPFcf1vAtIjTHMfTm
        fNJ4OtsgwjwP0OEGsdjnjto3ynJGwUI2bJ3t7MVeIP5TWK3xVMzi3sp64shaQI/G
        7CLVE2z4nXz/hXmle3n5/Jf5E8oIkI4s6lEtr0qWlTPQY1mdsStoJSFdee6JzErh
        GUmY4A8kNh+Gc358cXJHvsgK1XVrWVTbgP3sGd2Apt55BCv1Z3lBWZtGGx8NqSTC
        wH3xxIV17ds8LZvM/yan7ZC4gYPBpy3yk131CGn65RyFpxwWwvyXr7aYMhrb0Zpa
        LFAA1gdz1FZJAshGuJmbQf5a0VSoOwiuDvsVkTsfpcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=61X8Rs
        HQ6EcABsEBMC0ORNRgE7kpSZ2Lgfyht6KUc/c=; b=hE1MbfWTPexMYS+fl981oP
        XhjnDjTLq5/ckbPkrZeXDQ/Rf0248+k8jqw5/4vOgWyfTi0ixs3rnRIdjXupZWkU
        1e/p/yxwSvBsxumo+Pljln97f4iemNdzOwxC2GNungKIuX88qGLKAvdVtWeuaXzS
        EMRscJG7GkRkm/J1jwJwG1BXOf4r2cw7AvRdBaZDugMRq8UioRBgF0QpBd7Wgsdp
        VIKNxUSwleImVZJRfMSp8lesdORVcwDt5IA//Ibpc4FbH65S++qcc6fara7IgeXi
        9V2ANg7/J4mUVpWziQGt3Q/F/iXkf2LgppungbTHXWxkd3ZSEz+WfaIQh064fVaQ
        ==
X-ME-Sender: <xms:bej5XSM0CQAZvUUIygTF4i9YRMNnaSK1Qgci6r7aAEzswGSzb9Ru0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkpheple
    dtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:bej5XRQFU5WkuKmO5oMNJY03BfhDDKsIV619yRaVoKS6fIcDCTTNmw>
    <xmx:bej5XUtCJRuGR1hzUHWtW5HOII1DvNXRcMpqDbp3W2EKlkLjhdCTZA>
    <xmx:bej5XdLFuw2COBFGafQYgKfmUY62cZjJzAP5pWC6gUIl4IOdxFHcpA>
    <xmx:b-j5XYZ05xI3R5mCmIDNHJfH47_itId8YtG5dXsOvEQo37Yzls1yuA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFBEF8005A;
        Wed, 18 Dec 2019 03:50:52 -0500 (EST)
Date:   Wed, 18 Dec 2019 09:50:50 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: display: panel: Add binding document
 for Xinpeng XPP055C272
Message-ID: <20191218085050.bjlpbavxwua4copu@gilmour.lan>
References: <20191217222906.19943-1-heiko@sntech.de>
 <20191217222906.19943-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217222906.19943-2-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:29:05PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>
> The XPP055C272 is a 5.5" 720x1280 DSI display.
>
> changes in v4:
> - fix id (Maxime)
> - drop port (Maxime)
> changes in v2:
> - add size info into binding title (Sam)
> - add more required properties (Sam)
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
