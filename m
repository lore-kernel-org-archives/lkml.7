Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E5CC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCD220716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm5impAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSNK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:10:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:10:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so5363990wmj.4;
        Thu, 19 Dec 2019 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljoBAaiqPyKfB+/r9kIia5fJ5IasKjoTnuUoooLCttY=;
        b=lm5impAQ0SE0Y/wC+5Pk1ACo0MPPy5wep3laEXykpRaVCp8IUUduHvD3AJ37kT/j8t
         0ZQLyqJlEbqFHc0/5SRLY9SpbT41RT5pS8JNQsdAfz6FSGvT5q0l4kz4ZYoxPVEgy5cT
         7fm9m+3QAZqo49qFw+WM4nCPmRHOSSRDRgOIO3AarsQL6XtD09bl8qmVua2YRXoayxW4
         FxXUYMBHREZoizEBb7BbDlkFgQw1qw7IoySyJRaLsUeUatxYNp998ixQJhAhWNpgZnO8
         FBrAeDexfQNixkqREJ7mwIawSUi8l4r5rZqLuVImrbXpZqE4nDn++RE/F74HKsFA3/qQ
         iYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljoBAaiqPyKfB+/r9kIia5fJ5IasKjoTnuUoooLCttY=;
        b=LGR4PPZL0ouyuIuEizYPtCYECdxNO+DeaJmAhaQtSpGFWK14wYXwJwder1abzUdsDQ
         TrGE1WRJSvMCDsBFhHKojLrLhorbqZHtsOunA8nhHw5Kv4MIEqFIzu2kpdT5N61KBTwV
         vyOBfPnaPHcmWXfeVT5KT3INGH2iU/9q/eKTJVNcFsEf8Gt5RmWQ5wJlX0QhF8+jfgIS
         k9DG9j3PbC43Zp5HKobEuHPHFYrEuoTFROYzAZ16t7dhQBrs2yQjVAUMoHkSfQAz0ffD
         bctPcIgneRf/1IpoLq641Ilsbk2cOGoFi1CaBv4+dflBCJvsrxHislfMaprB1QEEUcUc
         08og==
X-Gm-Message-State: APjAAAW7SiTnWES2XlITFFwYNyrnrfII0nRKq1ExfKb3xpTZMw7BdwGn
        Ecojn7dxb9klHfLV6kRqCzQ=
X-Google-Smtp-Source: APXvYqx8uT+10Z7eyNA+PeiVmGb1Ij2ylbRV0dPAiWh2OWGqT/mE45vcobzMn33JKMrglsNOTcggFw==
X-Received: by 2002:a05:600c:2509:: with SMTP id d9mr10171463wma.148.1576761023046;
        Thu, 19 Dec 2019 05:10:23 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id k19sm6006039wmi.42.2019.12.19.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:10:21 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:10:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 02/18] dt-bindings: usb: Add NVIDIA Tegra XUSB device
 mode controller binding
Message-ID: <20191219131020.GH1440537@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-3-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <1576660591-10383-3-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 02:46:15PM +0530, Nagarjuna Kristam wrote:
> Add device-tree binding documentation for the XUSB device mode controller
> present on Tegra210 and Tegra186 SoC. This controller supports the USB 3.0
> specification.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - used enum instead of oneOf and const.
>  - Moved reg, reg-names, clocks, clock-names to property section from all=
Of.
>  - Limited allOf to min and max items based on soc.
>  - Updated description for power-domains.
>  - Added V1 reference
> ---
> V1
>  - This document is yaml version of [1], with difference of usb-role-swit=
ch
>    removal.
> [1] https://patchwork.kernel.org/patch/11156253/=20
> ---
>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 +++++++++++++++=
++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xu=
dc.yaml

Acked-by: Thierry Reding <treding@nvidia.com>

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37drwACgkQ3SOs138+
s6FUQQ/+OrJZ0hWoS78OvNSUKU7kj5/4HMxKtRlJYDRrzGmyKWyIWZYEqVDysdia
j4v1eFU5qv4WaMLtfM+S9lgRgK5lOJq0rmYll+dhyYdeemeIkg3rSYIOzvSLUONV
5mKh6rke3+0LgVXL5Vw3iZxBp47n5rlUVKDsRGgUzPF5VgF5VsCRO9Pl0qIi+q3l
e9TqdpDTY6AKTYzIL1Gg3nty+gURZ1t1wUYXDJq9GSzUBYu2fNG4F9NmI3XmcKzu
19g6rC39FV1aqyjqVJ2pSDNhjI8zBXNNVvTl7RFLo7EyVoECnsVYwYp30gQzNrmm
NJfNinkKZBXx5jGlGsGK/HuRal5umvY/2Hvz6CmFpT2NwI249kAb06xG0KfOK1h+
q5IgZiSE+60cEXHPEcqz209306XjLELsYrlAP6IcI+3nBAZq+y8s5fgs35wJ5PfH
3cjQvS1IZiDH9P5pqE8zq61/jhLgGgPEpAixEr0twvZ9UPhw0yDr6K5YN1tAgQaG
TYdl47GxYlDMHUOOq+6T8yUlqhcOqmNhyV0aVHDao9LLSBNOs7AxiLSFC1a2Ef+O
FQWcikXoLaPW7o5y1Qp7VRMEvHVWGLYBPdO/pfTnlKDdW1WQ9qPfY10RSociPJTw
+2bHzACFUla3quMKz+NruDHjDxcSug+qq/OfTVXG6yMviOYX/zY=
=tlfO
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
