Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F110C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB38207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih6Ql7nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbfITQRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:17:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37646 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403914AbfITQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:17:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so7345771wro.4;
        Fri, 20 Sep 2019 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WbM1UehvjdVvJ4J2BB4Tg0AKhU90H8Oji3wdpICxaVw=;
        b=ih6Ql7nH3XDikHvhiqHRsmC3qemJqZ2qcbpr3hagfcdUWEwSF6WxPOZ7TKJJY2KZkw
         Ir/bZyBLXgiQCJZsjmZwNC/OQqQIHfpdMMbmbk4tv+ugqrCo39mjoAAUvS6DYynvreUQ
         mD0MfDY0eMjlFDpTUF3H7clh8D+aVjIvvHrDQLXVlNp0GkeG1Es/GATddUzmTgmEs8W5
         fVA79L5g3+CLQ3wTSV0TdQp3zFqzz0EOfWoMHHDsy5kWcTPhQcvs5eHIDLlMSNibAqF0
         3Or0kbRnXpJJUBZLaHkvNDD8t+Zyf6oABkJktft/zrq1EchK7jpWBT+6zi1iIWv+ONU2
         /kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbM1UehvjdVvJ4J2BB4Tg0AKhU90H8Oji3wdpICxaVw=;
        b=jPDs7vy4oqjWlPfMM+nn3n1gtUXfr7l5Sa7wrMf1G1BuBJyVSvTdi4KdcwWESJE2mf
         2xZALRqMhhq91Oarjfg8epMExauv89zcqnIU3fYRcXuWA12KdpFp9Sh5h44k3MbCuKiJ
         8h6Nt+XKMrNOa0EvoPrvjkJNy78x+8GKEa0SwjGd3BwfVm61hJlS63FJ6EsKPk5ijURN
         zemGFKVCakD2HyuwfL7Si7t+ppi/dWLoijqiG83mPfjQ8f5CCKmO48YBbl6YY74wmwP6
         NRlbPdKAF5a/4S271ZhXxkcvgBxe/2y1fk4SX2frI6fG9rPz+TtXXyis76/ES2Joe9Kf
         hiFQ==
X-Gm-Message-State: APjAAAWH7ns7/SF1dyG66ckRcXsvpa/tcEwDlQnf/p/SuTKIK0mE6hSz
        XMz8YMKouJZXSttk/bRr3qZDpxL+
X-Google-Smtp-Source: APXvYqyoMTkwUtjpNyX+gCAF/dbks5dD25LybGF+t+STe5yB86Th9Uefs76pdkTOCqsNUb8Ht5rORQ==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr12121321wrp.290.1568996233471;
        Fri, 20 Sep 2019 09:17:13 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id l11sm1826386wmh.34.2019.09.20.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:17:11 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:17:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mmc: tegra: Use proper DMA mask
Message-ID: <20190920161710.GA14499@ulmo>
References: <20190920145317.11972-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20190920145317.11972-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2019 at 04:53:15PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi,
>=20
> this puts together the two patches from this thread:
>=20
> 	http://patchwork.ozlabs.org/patch/1146705/
>=20
> there hasn't been any activity there for a couple of weeks, so I thought
> I'd just throw them together and update the second patch to work on top
> of the first one.
>=20
> The goal here is to avoid the use of bounce buffers and fix IOVA space
> issues when an IOMMU gets involved. The first patch introduces the
> ->set_dma_mask() host operation as proposed by Adrian and the second
> patch is just a rebase of Nicolin's Tegra SDHCI patch that uses the new
> host operation rather than doing it as part of ->enable_dma().
>=20
> Thierry
>=20
>=20
> Adrian Hunter (1):
>   mmc: sdhci: Let drivers define their DMA mask
>=20
> Nicolin Chen (1):
>   mmc: tegra: Implement ->set_dma_mask()
>=20
>  drivers/mmc/host/sdhci-tegra.c | 48 ++++++++++++++++++++--------------
>  drivers/mmc/host/sdhci.c       | 12 +++------
>  drivers/mmc/host/sdhci.h       |  1 +
>  3 files changed, 33 insertions(+), 28 deletions(-)

Ugh, great. I misspelled linux-mmc@vger.kernel.org in my aliases file...

Ulf, Adrian, do you want me to resend for archival purposes?

Thierry

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2E+4QACgkQ3SOs138+
s6GPBBAAk7XJ/Lol5uZEzvcyyk08wiz0RTwLbRzmTL3kDd+2Ee9FyCjFpGdDnhtQ
ytD4cErUshQ0la0jw0hYrVutGIbOA1F5LOAYflc40D6EXiMAdUYmWUWOfXEzwgQg
rbQnsJqmBTcJ+W1g97BsBSZxRc+ou5w9MBdIaG2As7VAg9+9KjoGMfhN6u5MiGlb
Kz9IAfzDPIyZvDnbW5323tjprroVl4fF3CFEB/k+sSivoEb50dHj6fgXNskji9Pd
SEiTDYXNKHRCHRkmIFGwFR+V0/0sOHucvS5arAaXRRslhXzUHh0aFxrG4nPV0hSZ
u8oW0RF9WCd7Ba+Apu6LnMMKj4zUsWyrejN6sw3A+0DbX14flLXWDA2S26YqSfBu
kt/dloh5rfOj6YhvkHjW2tWZY7A0LlbJGYjMeJ5Qg28oLqOZVbBbFizeo1KCPmCZ
JfPh+qTfmWAyoL9zRj7GfFXBhMUntnMAM0HWl3TIETAzjSKqNnwfM0n6NzxjC1Jq
mWgZcBin6PIjjmiU/LOc22vbvMZWWrd5IMIL+YfPy4MdkvbMGex1Hl4IRWHHYfvA
FpUFMQjuSklTSw5svmHmvJ9O4ZO/lbBU1vdktYT6+tx8wouTnFczfqpAGy2SNyXy
/sTEDBJOKeB7pDl8QFTTmraThmihFgYPytelzYE5VpVlqv1ldww=
=AdTM
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
