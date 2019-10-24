Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC4CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CB32166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEj0umb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbfJXNsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:48:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfJXNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:48:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so21038153wrr.1;
        Thu, 24 Oct 2019 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EZ0gauJbDLm6nT++pFl8IpdBYl9f3/pCB6BsG6ZimpU=;
        b=IEj0umb7V/DNnn74s4u91JW4cJLZwnBTLzrk3vURlFx/ucbL1ugoCEj0hdXqyZ5tAe
         R33iEMU2BnKysT7s/Fqw1e2/we0KMBz+Du+kN+s4PNkxc88QUSyPTkWGlNsFvboBH+M9
         7lINu6cB7BNmLb9hi2WVXeMZ3fwB689CC1B6vkngaUusziM3wqIgH+bY4DngvULcRYZS
         mHqE2G/wvVmWJeq5wAV9ytt9ONhwJvTItVr3Ghf9yhnAr5+nnp2Q/VnE1pQDoYY5s4MR
         WWz7EQ/SZVYGEDnyXX0YMIyVoOHku9nVa9kS2Z6U2R5K3UnLjVAKwtziY5YfhyZSWJAL
         oISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZ0gauJbDLm6nT++pFl8IpdBYl9f3/pCB6BsG6ZimpU=;
        b=Fcb7CiGNpFAIxLBIgd0LqPkn9B0UBYJvxj7gqwCQnXItVwAZuAnSLoXdzivOVKXpXA
         8DCV98GG8HPGSLOKXmaH6/37rXg8REUQ0wxa+I2z9wUOZfJkmLkyf7tiVb5sJMbTxI+H
         1p+V006Z3IiSwYhWw3LtwIu+85s1sZK67BJIchxLpd/MyZOmVsoNdtcyDjM68g+gt98V
         z6NbQtLdoHV9s9ZCKYhsxkzwUOCai1LYbi+cNK7YO2zDD2DN50GrTqNN+spp9tvkaIDL
         03hWZE72/gjQoH1srgCJC+O09xIrjDorrcbD/L5X9J7EhXMzb9nWiMhMmGbntvp+x32P
         MghQ==
X-Gm-Message-State: APjAAAWFsDQ51w1FF25IgWls7DFDXbiH6cizfwbRAbY/oQbQm0IyO+h5
        EAWJay7JO/OngRFwPolRuo8=
X-Google-Smtp-Source: APXvYqwkpODXAwasjgKLcXY1OWtr0pF5zM9bczif2plmipl0NDD3sP2jDlEomkFXqJnFmDE1VZZEJA==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr4017887wrj.268.1571924882363;
        Thu, 24 Oct 2019 06:48:02 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id v81sm1532612wmg.4.2019.10.24.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:47:57 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:47:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
Message-ID: <20191024134756.GC2924027@ulmo>
References: <20190623173743.24088-1-digetx@gmail.com>
 <20191024115016.GA2924027@ulmo>
 <55ab29ad-da9b-c178-4480-dc6edb09b3e4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <55ab29ad-da9b-c178-4480-dc6edb09b3e4@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 04:35:13PM +0300, Dmitry Osipenko wrote:
> 24.10.2019 14:50, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Jun 23, 2019 at 08:37:41PM +0300, Dmitry Osipenko wrote:
> >> On ARM32 we don't want any of the clients device to be backed by the
> >> implicit domain, simply because we can't afford such a waste on older
> >> Tegra SoCs that have very few domains available in total. The recent I=
OMMU
> >> support addition for the Video Decoder hardware uncovered the problem
> >> that an unfortunate drivers probe order results in the DRM driver probe
> >> failure if CONFIG_ARM_DMA_USE_IOMMU=3Dy due to a shortage of IOMMU dom=
ains
> >> caused by the implicit backing. The host1x_client_register() is a comm=
on
> >> function that is invoked by all of the relevant DRM drivers during the=
irs
> >> probe and hence it is convenient to remove the implicit backing there,
> >> resolving the problem.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/gpu/host1x/bus.c | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >=20
> > I don't really want to do this in a central place like this. If we
> > really do need this, why can't we do it in the individual drivers?
>=20
> Why do you want to duplicate the same action for each driver instead of
> doing it in a single common place?

I don't mind doing it in a common place in particular, I just don't want
to do this within the host1x bus infrastructure. This is really a policy
decision that should be up to drivers. Consider the case where we had a
different host1x driver (for V4L2 for example) that would actually want
to use the DMA API. In that case we may want to detach in the DRM driver
but not the V4L2 driver.

Thierry

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2xq4kACgkQ3SOs138+
s6FNag//dCQTLu7oPNT3zc3b6EaUkms9Hy4DuTeMGzeKtu+qZRIc8UeavqaUk+1h
XydJK/GxuftWAPot/ZAPPeczZe5hWM7621VwYhCnArmwZkCmcxgiUDNy2hjgmtmZ
K7PjUUhwLHAvckWHxwfaYy8Fd2m+nK2ALvppph7FNsAxfZrZ28KjEGIFx96mGwdv
/uoZt6jlhjvmEk0C5xRI8CGjZSCUy3/HO8j1oTLiE21ErxreCqAUZNXCKC6otQad
5NsRhzYIQA+SUiFx9a/OcvN9weYTk+9T1+6zm6zwxY1lWdMbsqztu8Ucm8Mt6OYC
20wB2GhKJjEZJrcXGf58CfHrsc8Iv5HzB2ozwVQAZjj3GptZZyTA0xNiJYin5Qso
9bTMICJqwwn2XLjKW/4+mqdZtd1/2fbJ3MOqYAwkCPC5PH/97NNN5RpcrQCYzvPF
XCBUuYA86v4T6o1j0NeooKfPFUiPjIfHbyPigPs9Eb5BzMtcxqh3F3VTVZ0tpcZ0
jl9ZbFNUQs690Zwc6MLTXePx58TwWU3GqHR+zcCEgn+1y7sTiZ9ePzDHuKGN8pnC
xpaur5WtxLu28PS2Q6Uu4o+TD1Ey/Ifc1JJlmyoEzHHsdgOfNPIWPs3MYAZS+Nro
IK8LIOje6av2v2hf1Jelpm/PbtIYOLFV2iFgDxofZy/bEoG0Xfg=
=FCO/
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
