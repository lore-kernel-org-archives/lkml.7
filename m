Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BBC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822CC217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahdEKFGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfEJVqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:46:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36583 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfEJVqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:46:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so3416126plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CypxHt1sI2HFVc20aRWi1Iy+wmFvcX4HUufWa3L5NtU=;
        b=ahdEKFGH657NxRSXetF4YIdbDu+7xuiBUH3XkB/btnCaCBenwx8GQzU4L3s6XoXN9m
         78C9R/U8CTGACerCOrt51OZm2VLdnMhrpw9L2n/RHvNedU3JvCr0y5L+Q/FL3WVjMgKc
         ICqGlTDxiwzLZnSw1foolMZweNxWkafbp2t/FSvYwwBlAXglYUvUrqXGBfmgCMgH1SYq
         hqAgMHmu8whHVWA0K8yzNj8lgiJhmlHQ9zy/GZl1/LQggLxbdEcyacIZQx/9LGqsm1cQ
         4/+hmQuYbeTWUlnHZAAo4R1Nbgd3MJGTJrHNvmAhCNpC05wlq8F3NHMO/q+IbT0NHaHc
         XzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CypxHt1sI2HFVc20aRWi1Iy+wmFvcX4HUufWa3L5NtU=;
        b=oLhGMHEwhjcPOo+FlF/owjqpxOuGGtjVUPOD+PnR2xnx86V7lj/nX0QX3oWAOf+UVF
         gL+AkB7t8BgXKCH7dwXB6TRtvVOKtLOyF1CYFBjNYG2aUplFYrMdryLbvLXrfi+3lwVk
         4HYDtV5DYb/1zvb7fC+AwIlQxR/8e0zQFaRFw99zmTLPA2hJAjosYFgKYX/tVRHvQT11
         uzsPBGAi6k6HIaOjHCZ32oW4fCjxh/Mf1tcwncxYSzX2VAt/rptuIGTJKRwV7bpcFW38
         vcmRZLpNkAlQSQdBV9uA+qWaoIfxkwAIduyBEc2KwLo9d+jQYeMWvRYnsfLZjbrZuEF8
         SpUw==
X-Gm-Message-State: APjAAAV44uKe5WzAvAQqujglBgmB+VFVG0hOrybWEMS372tZEybumy8G
        dohJdh9xQgNofqd7W6A6SNg9QQ==
X-Google-Smtp-Source: APXvYqwYK1LRY/zykcry4kocjMHlnViiLHRg4/Jq/d2FPkuTmkKravH6h5IBIcmuDxExL80HBy2BWg==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr15506483plr.223.1557524788114;
        Fri, 10 May 2019 14:46:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id v1sm9467395pff.81.2019.05.10.14.46.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:46:26 -0700 (PDT)
Date:   Fri, 10 May 2019 14:46:22 -0700
From:   Benson Leung <bleung@google.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Always add of_match_table
Message-ID: <20190510214622.GA63153@google.com>
References: <20190509181750.134960-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20190509181750.134960-1-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Evan,

On Thu, May 09, 2019 at 11:17:50AM -0700, Evan Green wrote:
> The Chrome OS EC driver attaches to devices using the of_match_table
> even when ACPI is the underlying firmware. It does this using the
> magic PRP0001 ACPI HID, which tells ACPI to go find an OF compatible
> string under the hood and match on that.
>=20
> The cros_ec_spi driver needs to provide the of_match_table regardless
> of whether CONFIG_OF is enabled or not, since the table is used by
> ACPI for PRP0001 devices.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>

Looks good to me.
Reviewed-by: Benson Leung <bleung@chromium.org>

I'll leave this to Enric to merge to our for-next.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzV8SsACgkQHwn1ewov
5lgtdxAAixyvYNuxuXb3R0XUwoZr4OW17jwYk1zu4/Y4tsaMWY0ZS0RyInFygScC
+70a6qG+DNtmPaHWOajFIlFjaGPpteaIizPUPzglGgqF6vy+901oenxEtqapcq+U
c7kq0PZaRpRH789s8CYomzz7zMYxy+58lrBgGki+0tlRz44NMEKPR4N+wTo9zF0h
Omj0cjKfiCUHsKAn/pe+oye+a9Xqj+CyyPByAobY0haTrDPtwgNrn5ma0SXxQDPz
VlelhEMJxsVsxHJ394zhGNRYmiHMbG+PHbOMXCtndf9qO7lERa9PlvQObvjG9TSj
56vf4fib3Mx3Oc32yLtBxDKvoDglpSO/WV6Yc0vsGTPLblgVU/Zi1oYchvT0mJsD
CwlsFoLB5uWKpLOvwxw5VXY4WdlAuyHT2ja6nshIJBJgagEMzMllPlikHWE5RmFu
v83EzzUS6Tzzs2cURsTRkPS6nV56EUANWJ8xI7rFzi/VVBCQD9FV1RrPXwIqIj0i
7rThUyaP0tPjN0bX//2HqlLN7Nd0z437NsE9eSHi3wv0wQFyoEaI3+SA9fKod+Ww
R416YDmZEeLNqPup1DOTQRyLxF7LkEBzhT2ptDInH+shOKADeJZRrKZ/+twOZz3C
nSeiW4QnjpKLqV6C2yUp3kS2yX3+I+iEXePRNLr9A+lr0Ho6JSQ=
=rt78
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
