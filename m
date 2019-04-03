Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EDBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE487206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1z7hqcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfDCPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:47:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:47:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so22036282wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yz/4CyqHDMrLkZdlukictkm21VWz7WjVM0p13FQfods=;
        b=T1z7hqcXiqPgjp9q4TB+FpRpfolX6d9Yr5mh20RiHgJ2GFVhNvjqGv5Y/Y+cdBGz7Z
         YV1T6QvvNxCcHzYLkhMKkW4M5K0nxnpsfgeJXqqizaudExF2TEdhRqQK0Xfv4/5S6sBV
         oqdljNLVF7sa+eZk+KG/SNURy6JauQw37mzgnLN2PawWnjiJxThfxkHUha7DcSWzKzlM
         /OQfBx5dPYExs6BZvh9xFcrC7xxMbDzbbxguujjiLgnxTPU1M+Op1lem8lma0A/+Qalm
         aA0oNhdm7HeolSuFPxYm0NLoqsmXJvnsIb43UQVJVtTYx1gKvyXuFbTfxFvAUeAoF6m1
         9mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yz/4CyqHDMrLkZdlukictkm21VWz7WjVM0p13FQfods=;
        b=Kr0mziPYg3rxA7zFlv8IJYsLEeJL7de1jvCmYUqB0iila+RcDpNeyaG8vFzeIJlRUU
         87vm2NEwvNy1R/Ok+Gd0UMMvo1v7IYaw6WLqqAzsX7+mESYt4Oihj2RC/fR8ydBwvaTi
         80XHOQSo1i0oFId8vhmPwzdgHpHE5/s3ji9HkzwKM/lUusMneJ1TgaHcjKv1WLs5XqAZ
         VAaSKU/QUcz1QNT4z+UTZgvoIB7janeGDpz1Bn2rohiF3z4Pu8A8knCP1tGgGKupM3Zk
         DBiA7phP0alqOepA/I7J7vmHX7lmqtwZKavYVRkms/h5prmdhBc/uYe8wmeqReec5Myo
         NmJA==
X-Gm-Message-State: APjAAAVUqoZTSQfi/mW/vrmk6nNa7IiwhuUWBsDP+bePVmfjN/WuwIhq
        uFfr86x/XLTkawn4xc93V6RmMWPE
X-Google-Smtp-Source: APXvYqyCdYWdsdcRGkwrcv/6uxvQHxIlX3cfdD0SoDswCzlHUnn2PTOmNiM6ZTsXuLaJahbwMIVV2Q==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr211219wro.40.1554306460696;
        Wed, 03 Apr 2019 08:47:40 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id h12sm13149992wrq.95.2019.04.03.08.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:47:39 -0700 (PDT)
Date:   Wed, 3 Apr 2019 17:47:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v7 1/2] dt-bindings: panel: Add Feiyang FY07024DI26A30-D
 MIPI-DSI LCD panel
Message-ID: <20190403154738.GK5238@ulmo>
References: <20190212204109.3528-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Content-Disposition: inline
In-Reply-To: <20190212204109.3528-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 02:11:08AM +0530, Jagan Teki wrote:
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
>=20
> Add dt-bingings for it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v7, v6, v5, v4, v3:
> - none
> Changes for v2:
> - new patch, derived from another dsi series=20
>=20
>  .../display/panel/feiyang,fy07024di26a30d.txt | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/feiya=
ng,fy07024di26a30d.txt

Applied, thanks.

Thierry

--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk1ZcACgkQ3SOs138+
s6GcCQ/+LQI8IF4Q8eAZLnbV3bA9PSR7289XV0YvLHoopVOHI5BdSa0HRhukuDDO
DtdMr8JrNaRw8nm2YgNNlc/fMndb8znB1K0Cm7TalT+/KN8i/KPXaVlvhdl68Bam
39V1h/i5Vp8ozMvz1YY1jbMHOy2gI7NoqkrG4bhbqVCgqhskh5Gv1hczNwo20Jgu
EOQjeDPuCfmBHmAsXDSHFwSo2bW+YaTPJ3tUCaAsmWLBek05yFyug5+Ds2iDfMb6
SwbANCxiR6TmTQIllZZ3NZeK0CYFgK9I2MSEbVASaq6nJX8aB/ZYujSwHVDSBcoo
AcwYCvf5OzpnUmxwclYPdW7w3mKlUcon6DtA2QCbeuNXK2pvUIX2MALkyAWXVV8I
6VBO7ZpDLgsh4zgtYIM096VuQMcv36+DasLEmZ20eLybGaqB5o9zhUKUDJsCvpOY
7LcLfg6tfsFT5NaPK1TZQF97HmYnMmgRfWuS2UeieLPvAIrODG7646WpJGZ8uJpv
bb3o+Z/UabOqspue33ldrWtf+FJhhTlhjySxc5xFi+8GREPclPahIUUhLh7coD6W
rGSkemBHW8Iwg7rIyerR+4nfY6zJCxXVx441xuOqGBDhZYQPfCbTrymwAOj/0WUZ
oAuada6Ue8bmCLmQcmG8kbrE9yzQlzWn2ZGpskND6DsP5WAWSN4=
=GgYe
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--
