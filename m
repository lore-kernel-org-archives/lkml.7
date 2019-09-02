Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E0C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1022342E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oip+ogEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIBHsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:48:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32917 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfIBHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:48:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id o9so3196114edq.0;
        Mon, 02 Sep 2019 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MIh0fbAwfCuAufcRCsUhFopk9+6nBJdUhOmxxWypwRk=;
        b=oip+ogEKN+dFGw76d6Vbq5npgv5b9O4TzFG2x1cdx41wwU4aWh4Jm0UHgeWrVl0N2q
         sCPrcQQyZsB4R8xRd5MdoNqwUzfmVA+CzVewjKL5B7H3ZbnWe4hYUHqgStZ4bsGApa1v
         IwAGQbbWMV3wn3JDu0+AjX+tkmQHxXfa1bO6L5xQICbMcLgsNi04DSEE0Kj7nHfaXNa/
         7UMD3JVhZ7jCFuEEiry9J5k6fmEoPZg72DqSb74pe82irITtCbNErwWSZCwYqys/fOP0
         pqPW280ZCmoOkQ6c7QWNTkfgFADo8v4LnaXfkEn40OC+Sfl+/JnYzNg0HSZGe8LExt8/
         00bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MIh0fbAwfCuAufcRCsUhFopk9+6nBJdUhOmxxWypwRk=;
        b=bIlmrKeIckJ/LXKOE1MeB0OtBd5IXgiS03F+OAMJWDH4qiF3t3dJSoDW04WwBiVaiD
         maLciAScDSD80F+stkWUU7fJlJ20el+z5GiOeKNLYnXx+t4L3KOvFTHeXl0x0qZxMPj1
         3zvYJROexS3/+KZTtFjCc2RIgSR1VXI68FpvoXP0fYg9v2tOI6v6c/Bl8LHuMJoYSFf1
         P9epkbn0JorNZp/RLa2lGvJ48dPgcPlSCX+DcOxGIf70wOGDs29tGOze5jWy7UGS1CZs
         FLLNNsxcLiui18g875nQlZ2gHBzGWVyUxDam/hCs3XS3+KIp1Aq+N1EOFi0yfJvPou+3
         tigg==
X-Gm-Message-State: APjAAAXtwWJZ3HXN2ZfYhNyEakkZlx3a9oAQIP+Di7g7YRIih1rb2B+7
        kGmv6at0QDu39Sl2F2vz3+g=
X-Google-Smtp-Source: APXvYqyIVn7jDmlnuR4YbcabcNuaYpup4CxQuEInsDxMFQQvXiX4hq353ztcVF/hW461Pkzhk/qpIQ==
X-Received: by 2002:a50:f04e:: with SMTP id u14mr22971329edl.247.1567410490810;
        Mon, 02 Sep 2019 00:48:10 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id be17sm733876edb.87.2019.09.02.00.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 00:48:09 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:48:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] phy: tegra: xusb: remove unused variable
Message-ID: <20190902074808.GC930@ulmo>
References: <1567394159-22572-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <1567394159-22572-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 11:15:59AM +0800, Chunfeng Yun wrote:
> The local variable @priv is set but not used, can be removed
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1syTgACgkQ3SOs138+
s6Ggyg/+JTfKlub2rlBotR8tVq+WnX4mOXHTpdHY2C6sec6x8dSNg7ASmQ8mPheO
kvlojh5AYFPZAeunSAE28f6WmKLTL1mOp4QvipmBfuNgzf9o0gDJqlAAXxffiCG3
1nUDkM6x8/83lYLC5oF0ML4XbDsemDC7rnbBtsu79F7A1ETPX2N6EF8QM9y4FPzz
VAP7hNjOHI07c9zPuseEz5TrC3Ts/jH22/x9hefRwTmRlt+DmCjujz5zAKd0Nc4S
5In8xmT9WSDDDPf+ENjwZA1gASFyLEPKFM8qsqp3DpY/qH9ik9qszey+WHdAhNSy
dGdBiQI3C2MHQG6ZGB/7etLnp2kGN4334KU0Df282/gcW9kQuW4/2niqgH1dgYve
2cIuN6N0Tn14hUl/VgOcMG/S8C0ykZ6Z/ghuZOrXLtHAIeUWLc2nUkU14/MZ/6Jx
L63bB5RdVyglvjmsLWnxZ3mVEonTgwA6K86+jUI1ojotyaHMC8GJGxZoS5LUeU6A
Y2OXgKXYXakxjtrb9QCMeVx1vkBsVuqeU5BQdfgsp3ueZ+5CZE+MiWHQs2uifAz4
suDUyv4okbf1HRh7/F+I6i7QYk6TRLB7vf18QFVcJxNZfze8sQMe3sN+y6b/wvRp
NPeDuuljtSyJBdITIAbiMzG38znpSF+k+BEDmogHtRnSNx7w1tE=
=jMD6
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
