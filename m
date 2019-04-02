Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4022084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy3TwQLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfDBN7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:59:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43079 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbfDBN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:59:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so16777867wrx.10;
        Tue, 02 Apr 2019 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+YAIsaUonuJ0CXpack5AH0JLpWXREmJ9u8Txkxg1oA=;
        b=gy3TwQLblWIldW7slGgq4o9jMM9/a8f0WSMek5xEwSdQFm9tQLeYP1i1iMQYQeRB4x
         uj4I6GQS/xD+eQzIjy4/pDqE5qcL8GDZIfiqEhnH3SCwNzi0caTBtd+uVO8np8nSFWSw
         7pLHhDMlD0HvsSsFxmzZcLZmJa5Ov5u8U3jgAg4BNyHAhVEMMcORpfF21bajhtopLpEo
         agofYLrJpyx8Z2Dbmak4G+uQdRz5JMptWS56KFk7aHHIx5ONhMR8AeJ5f+9Ih/EZWRet
         4nDcjZ/Ni2qjWmFzfYg6qTeKU5HUGdV/9ZghzlZ8aWNbbgdjw9Txa0XtIR8a+Z/OV62t
         uqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+YAIsaUonuJ0CXpack5AH0JLpWXREmJ9u8Txkxg1oA=;
        b=GKkRorjKcwp4XNXxA/+/qVKGujhT9KnVHL+MyStyDwuhweMjS1e5Awl6BOY1fINfZC
         jdNa3jd5DcNTAPBOJYUiBuYOjJowBcqkIxTyY1fLlGyQtJCUibFWqaVCzQbJdn2dh6XE
         ujsZ9rL07XMpamjwfs6BdgawimMyav8J+GXCPY+PPSbFJlNzx21TvLNpHLKxAhea7Bob
         Fzor3RvFDqS/357I9kOt/8JSPQ4vDOoRMw4Hao14qrIlkorLhsfTFLVBHKvXkgk+mhwf
         SKmkevIzA3joyXNKPi1h641aFFrvw82fNeRrl/8Zzs+02VS2TCEWwyXRvZOVw0l8uqqS
         dOTw==
X-Gm-Message-State: APjAAAUg9qNnov94AnH5o452Qa7m1iyDOK43vlbMZkyUC6qAiheWKpoS
        V4S6P52Q82/S0B8W677im8w=
X-Google-Smtp-Source: APXvYqwt/Z5Sihqk3IxtVBMDGtffW3lGwN2my4VX1Nb7KG2l2u9+8frZSwNucnYef9+JCChaoI47ng==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr46877293wrq.279.1554213572483;
        Tue, 02 Apr 2019 06:59:32 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id c16sm11971563wme.31.2019.04.02.06.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 06:59:31 -0700 (PDT)
Date:   Tue, 2 Apr 2019 15:59:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 16/16] staging: media: tegra-vde: add proper SPDX
 identifiers on file that did not have it.
Message-ID: <20190402135930.GA8017@ulmo>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-17-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20190402103203.14959-17-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 12:32:03PM +0200, Greg Kroah-Hartman wrote:
> There was a single file for the tegra-vde driver that did not have SPDX
> identifiers on it, so fix that up.  At the same time, remove the "free
> form" text that specified the license of the file, as that is impossible
> for any tool to properly parse.
>=20
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-media@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/media/tegra-vde/uapi.h | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjar4ACgkQ3SOs138+
s6F8vg//XivzJ1gwvjS012CuQJEuX4qSY6iQSKVELNsZhg8SKlGPzfByDHcLwU3o
ZEpmAVPPnzFgIgKfCq5patZ5frY8DHG4Vdew9NEElWyI66ZkkOG1w11y4WONdsB3
FZX0G383M9ZvDLOjGbNQ0GczJFCgJFIetTyoF+vBTWvVGkQoooYfVXPzysYviOaM
mDJEm8gNvtHua2WQCipEaQFhZ3bV1BIGkPIvyFRyje8XKDQcuqjGkHGVTkJTm/2b
tTKMtSLb3dWMctRTnC1MpjnRlgtMyQGCFBmohS6vGihtoA07W4UPRxjPdNSKgLj4
wa72Vb/hyoxEdharm00fO9bRXNNMxqiYaHNKVR9i1MbjODw2y1FXKfygCGKnyH46
q8TjYvSDzVrElXhRYDHVBb7d+FyIb8CXTI0SABd/keYXu7ZLDjo81NRJUSXrSzt3
G9tohg9xyzWcjnkw5TgbHik/3nCp0K+ReGXsyRMJ7YHDL+7M1XMLqfkzQRRs5egs
lRYSK6SK0roK7Qy5Oc/q/dq8UoJfypugDBtgK8VGwu5BMM5UFN/VbtSN+d7AUcnY
SGc5mZZCtu/Rxw1RajCudy+pGDHdJWfMq9TCIknFf1vma1dSs8PtXaSb9Zfti990
SQ5QHWV42Xcf72ZJxp2CkNTJSDhQ3BUG7AgAewwVsGj2hC6onvw=
=3Lp1
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
