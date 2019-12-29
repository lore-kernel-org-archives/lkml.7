Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D29C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2997A222C3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Ollyea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfL2Jg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 04:36:56 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37873 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfL2Jg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 04:36:56 -0500
Received: by mail-wr1-f48.google.com with SMTP id w15so17581717wru.4;
        Sun, 29 Dec 2019 01:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sR3nYQ6CRS7rINde7y6a1YRzAaLchoV1//sjucf9+ho=;
        b=q6OllyeaEfYhO1LKr/NiiVewVNgwX+B+oWJas50yl5bW/RndFI5/y9/w+jXePW0l4S
         GBlv0fzs/OFf4qCuc/AFqpuAuxVUacDlMKhOv3wO6WiaHGjfkTPJtWFu09IYd2t3Cdc5
         VF27k4WOPwWi/OjDeLNS4oOy9fFUcZx5u06J4B5c114xjcWjsZ5mO/CmS05AISrWwq7j
         xBHbW8Gj3gB7rqUTH16djzMyUnjx0AOQPMQPcTfqXiVPYU+RtofAJZQUUDx5pOVP1uez
         jn9ThxJ8ROFEqLaOvFVH4ZqTIj9XXZ1AWHXOCY/SFt/LBo1v2d4KqIbAJdGx3EZ0YS1u
         +2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sR3nYQ6CRS7rINde7y6a1YRzAaLchoV1//sjucf9+ho=;
        b=hNvps+2BHEqD/ZPosoAm1dlx9mYvTKOyPE8ZXaBMwg4npQZRip8XAVXM2GfekH/ckP
         4cTZKTUqCRZIBirMLNABzbRhEgfRHRXV7sSHof7Mqc/QRhKY8v9d4MBNbK9GMZ/ZcXUV
         lE2OGrIOtg0EmoACjo/gtBy7DWAJ1uCtdOk7HaGuH2UKMfYcKWAOiH+6ahAWy97Xfj5U
         0fGb6H3iWhb6mseug90+3j6dm+od+HNEl0yqZW37uKTf9s9/aI5IXPbjjsEnEFQhPfm1
         WEbcd5cdfFZcPOTgJy3HS+kpg+vBK4zdpFJKEENQuXEpP//bGhgvjbpzkfv8ek5UiDgc
         5/RQ==
X-Gm-Message-State: APjAAAU3poCheZpDxqKiFWUN2D+w8Zkr9UCjsLipQS5ZBSUC16azJSB1
        BgmUM+RBo+fqfWK4j/f7tO0=
X-Google-Smtp-Source: APXvYqyV6pl2izDJGWUN9LPMWEU0+kWnRcK+bGnJz3lIzX7VtWVTPJi+pPUSRYAA2bxTXxBZt6V/3w==
X-Received: by 2002:adf:c746:: with SMTP id b6mr57617981wrh.298.1577612212870;
        Sun, 29 Dec 2019 01:36:52 -0800 (PST)
Received: from localhost (p200300E41F32DD00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f32:dd00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id x10sm41510531wrp.58.2019.12.29.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 01:36:51 -0800 (PST)
Date:   Sun, 29 Dec 2019 10:36:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 03/18] phy: tegra: xusb: Add usb-role-switch support
Message-ID: <20191229093643.GA47966@mithrandir>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-4-git-send-email-nkristam@nvidia.com>
 <20191219132650.GJ1440537@ulmo>
 <74d94004-2022-3b04-6cd9-d6b1e9eca230@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <74d94004-2022-3b04-6cd9-d6b1e9eca230@nvidia.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2019 at 12:09:22PM +0530, Nagarjuna Kristam wrote:
> On 19-12-2019 18:56, Thierry Reding wrote:
> > On Wed, Dec 18, 2019 at 02:46:16PM +0530, Nagarjuna Kristam wrote:
[...]
> > > @@ -551,11 +556,42 @@ static const char *const modes[] =3D {
> > >   	[USB_DR_MODE_OTG] =3D "otg",
> > >   };
> > > +static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role =
role)
> > > +{
> > > +	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role=
);
> > I don't understand what "for role is %d" means here. I think perhaps you
> > meant to simply say "for role %d"? Also, perhaps add parentheses after
> > the "%s" to clarify that you're referring to a function.
> >=20
> Yes, intention is to print role, Will update as mentioned "for role %d"

It might be better to print the name of the role here because I suspect
very few people know the value of the role defines without looking them
up. I thought there was already a function to return the role name for
a given enum usb_role, but it seems like we only have name -> enum
conversion. Might be worth adding that, but doesn't have to be as part
of this series.

Thierry

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4Ic6YACgkQ3SOs138+
s6F9Qg//diLO90kPs0EI/W6HXy+wcF1k8DI9KuspMV5DRFTRcqtt6dBJ+2wK3uQh
57OWWgV/+4Fu+QLNp20OSSm1s9GM//iV43ZfoT0J/flkuRLVQNu3rjLmHJG79oQb
pozYgHxEfEqv2uB6ZZmtIN2ev+MEjHWbl9hJ/qwuNdPQTulsDjLk9TIodV/LRGyt
QzAUcyhLfJuEqrVXEYUuvov5Vmf8qm/nQKKoRdcnLGz7pw2o9GlnhIgpXKupD08g
6Z6FWMM3agKXcWB8dVb3UzSbbUrVP9lx9+bOfnVy1QzvjWaRXJFeh0AmNxqdtbJX
NpFR3eZZUkrD2N4mtOqaaiVSoa8wQq5PLOOtIE6QvBBPxk003BmntrlKi3nuxScR
k7YpBrWwxszHiGLEpuPGS9weGV0m7nbkp0x+YEc5JuGyj/HGmyl9P2CbFoHOdBll
YsA90b4DXW2W9k3HV/tAYcQPjRqZ9vf6goHibQWjOgCqTVMwnJHo2i9ThNr2PPUT
/lieJb5M837w/n67TCbwDLad/xX6DnpYts2yFSttElJALSxrPooChhN7Ky8p1hrd
6sans1bQHa9itH4JQOK3ZmQtZEiBhAfXa1VXMiKjmmRUIhhRymediKJSfMucjqkZ
3s+MXSWnzU+ZOqrPu+yf4jceuMDf3rM3Ngb6439HS6iWyOmEd0U=
=tuXa
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
