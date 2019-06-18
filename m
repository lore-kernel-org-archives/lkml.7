Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07790C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA591206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoC6zDdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfFRTti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:49:38 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:41038 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfFRTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:49:37 -0400
Received: by mail-pl1-f182.google.com with SMTP id m7so2542919pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SCzkPutafS6puOzenmw/jtEGahtjfTycw8CEIiSbQ18=;
        b=hoC6zDdIV93amSLFot1BR7nmnxvXEgTTZ2MJ8694yabGA7bGfvVfHTvYNBb2uAHK73
         RFigY5dxByvW0CBNPf3ozXgkP9+XQs9/BMlgN1afYP0eSCmpTkcQIvN5p9G2hLtrnoYl
         mIC4AomWgK1zpD5Cw6onogaUzO52/eMupcHeiXqGz2c8I08qzXS1oiEzceYksw57tiGJ
         Fy2nWWuTODVtz3gSZ5Y+i1UEVwmft5z+JMM2mnB/y9MNUQScOg5eUXhZfuZNJwUVv1rP
         EInECaWQPmaMbyseskPu2FNhhM6ZAkLW6Yh3JJlfm8buCy0dve7e7M1PVr1+zHYAAEbt
         KTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCzkPutafS6puOzenmw/jtEGahtjfTycw8CEIiSbQ18=;
        b=XXfRFiMz4RAwmjqqnpFsNk5aedDQxJKqnrAtB31ifJbyL8xV9fGOk0i+MrZgNyJPd0
         HrMaxoVCW5JlCqxZjssicQdLv+GELVAL8uGaDsZUcpfqiNbeL6YhfUoBbQFe3U54UKnZ
         5Emi+lYSdxUUG6nbzRYSygm0Wpk3Kjg+CY/qdzaCQ2lNQoUPp9JJn0OUjKvIIxUJi6Uw
         JX0l0f6gASGoi+whJ3VW1OXM6mH5ulJctrwBYOoRHdtcKqBrzZ5M3Nf8U13IhzD+gl1U
         0jGw/90+3epHI2mfc5qnCaLHjPw09js8OZ/g6INvWNDvYb1i9RyYYU0wbTfcv9ygaAXh
         3iag==
X-Gm-Message-State: APjAAAXfBBY2MlgIRsvGCdWPehrX2+m6Dwoam/eoj1V8tUXoRvD/a4oT
        eWx/+seRbg/LcuRA36S+HaWQWg==
X-Google-Smtp-Source: APXvYqyfDVhE0Rj7KuDcNm/CG3YH2wDN54io4gffIFDGt0FGePEgYgI5wxJrFEl22T+h4+UcoBFmig==
X-Received: by 2002:a17:902:a405:: with SMTP id p5mr43107506plq.51.1560887376052;
        Tue, 18 Jun 2019 12:49:36 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id y133sm17606800pfb.28.2019.06.18.12.49.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 12:49:35 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:49:30 -0700
From:   Benson Leung <bleung@google.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Colin King <colin.king@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] platform/chrome: wilco_ec: fix null pointer
 dereference on failed kzalloc
Message-ID: <20190618194930.GA209269@google.com>
References: <20190618153924.19491-1-colin.king@canonical.com>
 <CAHX4x85sETNNS8gdQYQniCM=K35DjMjdHOihJ76pGPrAoB9gyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <CAHX4x85sETNNS8gdQYQniCM=K35DjMjdHOihJ76pGPrAoB9gyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, Jun 18, 2019 at 11:15:03AM -0600, Nick Crews wrote:
> Thanks Colin, good catch.
>=20
> Enric, could you squash this into the real commit?

I've applied this to for-next and for-kernelci in chrome-platform.

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

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXQlASgAKCRBzbaomhzOw
wvzvAQCyOTKS1SOAS0+Jun5Ci7dnvQYHXaDKXlumIB/vwgWr0wD/YyL8KgdowZi8
meyb3F1r5KtA3s6FXZ/AN0VbqnHDUws=
=3u8A
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
