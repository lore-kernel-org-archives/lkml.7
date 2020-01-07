Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE0CC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16F2206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Qe+Akwoz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtsWrF22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgAGHzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:55:04 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45077 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgAGHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:55:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A2F47220C7;
        Tue,  7 Jan 2020 02:55:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Jan 2020 02:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=yn5V1ILcZ0kXEAzZg+JzlKT4KJW
        MwKW3bisUeNMYdZA=; b=Qe+AkwozbnL83siBhs0HNucL4maZbd3UdlHCmHzdsSu
        FTGLuq6x3VAo4j4jbLLXs2zuWxsvkEF5Pwc5jlFlNTpdvGdaYNh1hYaeA9opoA/0
        oD3/aoXaQVsxWR2V1MG+r30RBvTWbv9SyKEFAVSX6XBt2dYpcdFZL5kXUXoE2p0N
        dxfMuUFEJQSONLs/HaHLFPfBqI7Hjh55AqlAHJrrntB9bwGaUxBSm6yJhsdXHFBw
        gpDoLgWVxh1kdrxjBvOH1t1Q78PPUgE91tyjVQfwPeJdjHfchas5WQkmBAMqAfuY
        HadpnksNT3I3MHAmrwGVakUOl8l6Y413Vt8H2okU/QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yn5V1I
        LcZ0kXEAzZg+JzlKT4KJWMwKW3bisUeNMYdZA=; b=FtsWrF226MAkiL1ot199v5
        6kBiNJx+xvOOcyNlkejkrscTtWt3VbJCwaRZaqKWTYMyH8MnBy4FhQ+HhLGmM1dr
        xqtwBmfUxxVFVgDT+ahvar/jDfexus5RrvJKlbEvv8Hm7oA0LYG8/4NoQUTEz6OE
        glwXaEltNAlikG3CqJ/sX0PDokrkYoeH5sCNnm7LZh1OPrumkaGM6DYA3iG9Blpb
        /P+BDRtTLN5/1rM61O8K2UkUIQuyxkRdcBGQDMxGFUyka617CDP0XjvwhLw0fFFA
        WgjzxMqe1pUl8ksueuyOJJRjNZBB8UahlBgY2Jo+cHMtkRktJK4t+NtTZE2zmT5g
        ==
X-ME-Sender: <xms:VTkUXkUyRI46-g7DlLfiv26dWN7Zo82Ry6PvyzTprHw5JPuSS7EPFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkpheple
    dtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VTkUXp3ZpLGFt3ZoNob1bAOZGAn0QMBRMyiFsAV2TMFHH3Lzo7GfNA>
    <xmx:VTkUXlcTghyGXhUBnzKq3cJsYr1jFomlHdqEx-9Jy4M9RWQ_1oyhjQ>
    <xmx:VTkUXmVoGho5uV6TNIez03CgbqaKp5FPpFVfgRhI7GooZwAhp6rdLQ>
    <xmx:VjkUXuy2tBvO5JyTLRCPOgdGiSGlY439d9Ouj6NhkF_9_lZbP9KUpw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62A5B80059;
        Tue,  7 Jan 2020 02:55:01 -0500 (EST)
Date:   Tue, 7 Jan 2020 08:55:00 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kishon@ti.com, praneeth@ti.com, jsarha@ti.com,
        tomi.valkeinen@ti.com, mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v3] phy: Add DisplayPort configuration options
Message-ID: <20200107075500.br66fzynztpl6jc5@gilmour.lan>
References: <1578313360-18124-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="du7252vquuj4pt2d"
Content-Disposition: inline
In-Reply-To: <1578313360-18124-1-git-send-email-yamonkar@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--du7252vquuj4pt2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 01:22:40PM +0100, Yuti Amonkar wrote:
> Allow DisplayPort PHYs to be configured through the generic
> functions through a custom structure added to the generic union.
> The configuration structure is used for reconfiguration of
> DisplayPort PHYs during link training operation.
>
> The parameters added here are the ones defined in the DisplayPort
> spec v1.4 which include link rate, number of lanes, voltage swing
> and pre-emphasis.
>
> Add the DisplayPort phy mode to the generic phy_mode enum.
>
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--du7252vquuj4pt2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhQ5UwAKCRDj7w1vZxhR
xXypAQDrUSF7C03RKFJRzD9tHtHNlDkcVO86S8hSOKHQRGzFFwEAkJlAb74qa+8U
+zrWeY3JxNz41kmUxYlakFQ2ySqNgwc=
=l0UX
-----END PGP SIGNATURE-----

--du7252vquuj4pt2d--
