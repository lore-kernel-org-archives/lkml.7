Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EA5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E41218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM1l5Qkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfJBJk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:40:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43797 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfJBJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:40:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so18825919wrx.10;
        Wed, 02 Oct 2019 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7+HG4NilW59A5ESK7jbhVXvazT7i3A75xS1VC6Mz7T8=;
        b=HM1l5QkdhFrxLb8sFjl64pHUh8T1h9thIzlQPE/9mm0cJ+a11htZm1twN6GU88p7eB
         uVXshZBHMrVV+NkkaU43KwBVuFt+bPa3OA78tHQD5GOMPt1DcpjvApWmIRUt7fvsFOiE
         NWyCEUdYeh4O5Rofq80BdeBdoDQhFYmWWYXsI2GNVMLN18ZqIOmhKPubiEzHxPGgGsJ3
         cuFHgn6oRvSxX8lrsGkdJDqTcn+KN0xsWaZadRMd+k77wBo/wsHsw6M6vDZ0Xoxyu4V9
         s5LOWtKqGXHpGCzZmdpGO984WB9b4UlPVLEAr8OFcKTiNiPpl7sU7LwM/uP7+3a6y0w7
         4mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7+HG4NilW59A5ESK7jbhVXvazT7i3A75xS1VC6Mz7T8=;
        b=Wns9jl5+kbFjFBF7vzHiFgKBirLEoNbkdVx0okLW4xIlIKlofkz/z1k86M4UDICztr
         RItB2D1mjmP9A5OTGmvUJP4+/0HG4o3EKQEH5es6R5OiMc1+Yhpyc82wO9LEobm1iq7a
         SG6eamDsc21AxX5NLON/C33+axsY54z963ikLwHXnx/ZMzQjcuQg+3ceHZUKQSKTLNOK
         zyAjL3PaHQAEK61vRpQh7m/4b1Bne/U850eT6nN21HitFVx8we8AcfC1W6cRL/ZbMGm0
         kXtg9OrGdR8SxX67Pe8ncI5AunLqGuG96Oj3Qg1pbH19ZVSgCJjCgxNGxmK5ehWU8d83
         J+LQ==
X-Gm-Message-State: APjAAAU+EUhD+12WFDDmtZUbYQnIVRLvCfI3fZK/lw2Zep63t0g4PBi8
        D7rHoH3RD+dcnVc8oBZXcjs=
X-Google-Smtp-Source: APXvYqzoi9GkS+0cUBszcVqSntVKo/zCHwONJWP+67EhNGhTaBCv6Mgr4HopNu3W7Qsz3GCYIxwaWw==
X-Received: by 2002:adf:9b81:: with SMTP id d1mr1146871wrc.157.1570009254965;
        Wed, 02 Oct 2019 02:40:54 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c9sm5459036wrt.7.2019.10.02.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:40:53 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:40:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 2/6] usb: host: xhci-tegra: Add Tegra194 XHCI support
Message-ID: <20191002094052.GC3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-3-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-3-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:00:47PM +0800, JC Kuo wrote:
> This commit adds Tegra194 XUSB host mode controller support. This is
> very similar to the existing Tegra124/Tegra210/Tegra186 XHCI, except
>   1. the number of ports and PHYs differs
>   2. the IPFS wrapper being removed
>   3. mailbox registers address changes
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UcKQACgkQ3SOs138+
s6HHLA//YBnOoAm2X3mFPUPSTtCfo7+h1y4hsbXuPMvKd1Fkl26dAr+L5f00ZUNW
zZQg5WJqV1c+ZzUebxtcfPbBSjDpoqvBqAW8heJSBX700v/nJmIyETStDaApUbmd
wkCNGpwik68b2s1+B99y5vDr2btCspIDBkVq0U5rrNC3dbb7TZW4oGKWis3Iuo6K
Qh0qSpwy8lLult05RkzLENTjwtpzG4bN+K9MksdmI2gVFpSOxyGE5imHXIpSHSwJ
P4IAd/pGZOvsTwT/LGIq7bNt/mAMigD46AGjtaE3w+owvzMSH8GRYtJuQeFjjCyg
6Hf4WITjYVFJA5K2DaklvwSSNCsjWiwTB+Rfeds9CG5hYTbGIv+b4lTj8HYPzY+t
67EpqDT0OsFrg7VjzHNvIzoDkTnG2Kh+DBFVUjkJoqcFQY714+ek1VT0M4UWTpJe
JbmCjUC3GrosVC/wPl2hjS3jsoDFSwZwK5TMYzkTw3r8GX7oTJ4HBxZgFdbqqC9D
NPVREICBVqDq/AdTqxf3YEyB19blCIBUGvuq8CNTRwSrPFkAaqAQD8G/zAx8ETr4
nKEq3jmqPRIc0Yn4H3PYavEGOlNpDvMEtJixwBibkC0ujivV5tnsTuYT1BXlOSgZ
2fIMYaYL3isOYsscCSiJIz2S52NLMAfRSdtC3oxUehiVlXIKZhg=
=NBTc
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
