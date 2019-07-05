Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A5C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6972082E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562328949;
	bh=2lOkk2WrCmEuGNSloYfpFkod1yrqn2kQgwbDSSnvXkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=173QTQw1jE4duEAWZq5oyykbyO9JIcadvyg9hYBm4Kz5TRpphlMHEj7N0R5TtfqmP
	 ftw8/ZBYutctBlo5jqaFoMYvhCBejrm7+9oV0dj1AtUKXq9x4KUeFk0Tn3z9UdVamo
	 ik8q6iyu4bbk98njpI1/Qa4C8AYcC7YMkjaj/3Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGEMPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:15:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfGEMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j3lgZr5PhIwsop5RCxeelLiraufpXEP7Y5EXfLHxN4Y=; b=hAYQlw4PRYrgwlGaAkQ/4wA7G
        TP0lpCsujJkEtK292CBw1OMzakLEIfE/1kBviVMFeBl1bil5alPmT7CwQVE0scMA2Yt8zitziOyKx
        Twvf//bKTdx4ML8P8uJ6VDrcVYIerXzo8AUOHz3OOtquKv+chJ5C+U9LMFILUwu2uDO2M=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hjN4z-0003hS-E5; Fri, 05 Jul 2019 12:12:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 459BD2742B0F; Fri,  5 Jul 2019 13:12:40 +0100 (BST)
Date:   Fri, 5 Jul 2019 13:12:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
Message-ID: <20190705121240.GA20625@sirena.org.uk>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org>
 <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2019 at 03:08:37PM +0800, Tzung-Bi Shih wrote:
> On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:

> > +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> > +                                     bool plugged);
> > +

> The callback prototype is "weird" by struct platform_device.  Is it
> possible to having snd_soc_component instead of platform_device?

Or if it's got to be a device why not just a generic device so
we're not tied to a particular bus here?

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0fPrcACgkQJNaLcl1U
h9CqOgf+J1iCd1w3ReqbJfzVnRPz1davoLs8e6k9u638UeMZX3sVMS9fyeTcQtrX
XpRecrQsk7CUGoFb2ji0GxnHSXWnEwnIPCRmBzoDwSmsX+33TYQI1aH+m2ZeAgjv
QqHqk0vNtFAlsttbNMTvbkkkSYAAbOPW8K8AEL54U1X8EJBpqV8ljUj85yDazCou
SCsQUj0LlLqN6+Gm1LmXH81KdHY06t8i7yxPATgspDLgEJYi4WwdrIyqKAtl+k92
iAuK8BXYQJO14ZrV/8f0TJbHnrszfO3RJw0UqXdZ4YMvsw0KmrNj9jYv/cL7yD8F
AUeTwhBtKU+Jd353cqjNMhjYBXwEUg==
=+Q0m
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
