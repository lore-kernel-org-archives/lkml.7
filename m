Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330BBECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C91E2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ/G0g8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfJNNR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:17:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfJNNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:17:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so16743931wmc.1;
        Mon, 14 Oct 2019 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BSVT6/rt9caDK62gYBDnDh5e/nv1bV+8wumCRGej6zY=;
        b=aQ/G0g8I6kNE8fOdXRgLPoYpiISVXLPukBvLP5vPS8vSrLcmsHWiNNMQtV/3bhkTFl
         jf6g+PvsSBsxkUNfmsoYQskfdcnAzOxC5l02hDDCRmYFVHRvHe6V9tXRXlFnr7+U8NVW
         2KR7qk6ywYdpxdSSVF/CHRStr/94Kx0CbP8qdxWDyuGglwq6tl4RLRkIeAhqCSuTo+an
         U/M/5D21bKkeZv9eBoNJqSK/H8CkP3TNw9SD2M+twxTyohpJJdId7DLQ1Zvy8IQB6Yng
         cXClxAK6st/hvyfVY4SiA3hgdw60yF4iPilbjiUhkIqcw6WDCD5st5oC2qL/6ctOMF+0
         JduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BSVT6/rt9caDK62gYBDnDh5e/nv1bV+8wumCRGej6zY=;
        b=A1msMrrtntF1Z/66ApEQGmY8UN7W6hbxK2D8ZIwf2aCS/BRVIEhW3ATmu1n+7jRcIN
         7anctX8z74th2gx8ca4VdEgZIzgoKeZtlkEAqcI19rybDGkAVjhA0StcGtt+Qr/I9Iie
         5CTxKEnuvRBf8C0nuD/ISpmXB93Zja4kcT25ad6graqkEogoC07O02mA2cM1XkyVn93t
         JqSrinJs68vASRk7tMC50KZqkq+JlkZZh9Q25qaSwfOBkDHBvGIbMv/QJaeQIoT3MxC/
         AuOR4D1B1qYRgS/5RYZBnXj+O3uO5JofUmqVoJE59x+ANWkKTkwwr5AgXOyfAilGiE8j
         TF6w==
X-Gm-Message-State: APjAAAWBQczd5/6x1yloGSbJ0XSeep1eWy1nDBRIy/A5sEQuAIVrhEzV
        6qOXcGY1+0wNSfKLu6KbPuE=
X-Google-Smtp-Source: APXvYqwtnutp4lo0pHwlyN5XuihN3EaRu+UPIJGENSCr6Sqg5W1GxgswhnEWZN1nfVIEg3eltKAKgw==
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr1827206wml.154.1571059074747;
        Mon, 14 Oct 2019 06:17:54 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c21sm13316525wmb.46.2019.10.14.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:17:53 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:17:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     JC Kuo <jckuo@nvidia.com>, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Message-ID: <20191014131752.GF422231@ulmo>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-4-jckuo@nvidia.com>
 <20191009233900.GA9109@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <20191009233900.GA9109@bogus>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 06:39:00PM -0500, Rob Herring wrote:
> On Wed, Oct 09, 2019 at 10:43:41AM +0800, JC Kuo wrote:
> > Extend the bindings to cover the set of features found in Tegra194.
> > Note that, technically, there are four more supplies connected to the
> > XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
> > , but the power sequencing requirements of Tegra194 require these to be
> > under the control of the PMIC.
> >=20
> > Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
> > possible for some platforms have long signal trace that could not
> > provide sufficient electrical environment for Gen 2 speed. To deal with
> > this, a new device node property "nvidia,disable-gen2" was added to
> > Tegra194 that be used to specifically disable Gen 2 speed for a
> > particular USB 3.0 port so that the port can be limited to Gen 1 speed
> > and avoid the instability.
>=20
> I suspect this may be a common issue and we should have a common=20
> property. Typically, this kind of property is in the controller though=20
> and supports multiple speed limits. See PCI bindings for inspiration.

Given that support for gen 2 speeds is dependent on signal trace length,
it doesn't really make sense to restrict the whole controller to a given
speed if only the signal trace for a single port exceeds the limit for
which gen 2 would work.

Also, the USB PHYs are in a different hardware block than the USB
controller, so this really is a property of the PHY block, not the USB
controller.

Thierry

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kdYAACgkQ3SOs138+
s6HMkQ/6A3Fj9ZJJsdJnHLfvMDhmqc/ZtjXEf75kGFK8o5zyYn7mMEiIX7UJwn0v
u17ZP3AEz0nPbMpQ6VFkAH/JijR1m4P2vtl4/sxEpqWUpllPgb7cmK2ZefL8Wa5/
+tha3SoS//h5XjI/lwVfaxnzJyE7owSaumpZG5NzR5fk4UWcUOzmZXAQSedOKppX
3Jh5+pMwNenrbzvqxt0w1Lv0L3KMRH8rZN/r4m2WXNKqc/Zsb+zGAyF9uXylNd33
Q29CpQvAJZwuyPj1NGsSJqwo/rl65QiHmXqwJh8azlUL9LBpGurYtox1kytVbtrY
zxBxtLPuCabG5EvEPlGv0yv0no4kMvnZu1qCG10veWGkOGq7XHGyG8jdyBJDhBgt
Ahin5YDmVrfG1c5balwzNgE5ZMNOF074JgcL2MZN0ac5NKky2yFPSvdBxJvGLt90
etu2wctrjXOUmUj4Lr8mOh3QTD/mVHecHRfCWpSaaasDlQPj9g3NvCxvut8RWHDH
z9irlyyUI5ahytdR1bxhq3UsuDDT3W6rRrVuwjo3Rw37NYwaa4M7ppB4Zqv8rUkz
BGM9UTk+K39ZBBYYcHxdAJ1x5EChqh2WzAC/nGiwVd2hbgqj1I2zpZMSALBTUtlg
fno5aAC10Un6nevQlxAJ/yBxynSbGEhBWt1yVXKzdHSJhB6VKz0=
=+5Sz
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
