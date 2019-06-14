Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D525C21773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGWAB+CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfFNTKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:10:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNTKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:10:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so2044556pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lqY9qj3FXvhL7X9FVCyVKf2cgudUiUC+bfdYqXqJGI=;
        b=nGWAB+COOBn9dBGJOKudwxLl47G+Wjd0XYP9j9MypIG0IlGsdC4zR8kCZ968KGFC8d
         wsmF1jw3sTo3pvrUBj/IQ1XBBaYfM7v9lmx9IMFHVBBDbChmr6hBF/Abb3pr9gafYlEZ
         J6D1ZtmOxqPiE2VHTueKPcHzaa9cMzBfzVSAruOrGOaKHCEcNsn8A0SYL9kvHBpTKtrH
         x7AJ49cWSSGmfh1zXp/QIaFLSwJwQfh+zUZsz15UeX/9EW6Rzrcc+5PgNxlLd1nXQE3+
         zW4Keh32+wFPOXQ9Vd54TtLxOYz4Rsw9CqSGZT3pIqblUd4hHICBp/ErvzQ0ei+u3nUg
         dSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lqY9qj3FXvhL7X9FVCyVKf2cgudUiUC+bfdYqXqJGI=;
        b=HsfEPOBgk/GvnNxx3/lE1JqDCDEGUH5aXnoJ8d1ZQsish1s2/dxDMwLj5G73cEYDKN
         ISvWsE0iAje0bzqh4QMXZ3x9itBaQl8038y0t4Abb4njujMKD3VAwSUx0DCOksAgicWZ
         rbGbDiUBztnDfS+B9fyLkjM1h7C4iXyjTEwtRWdBmw0Tw4pJBTop0Y2PHFJA/jUclhWu
         NWoCHpPHOBQ92hzAMFoSutU4kwItOebxjqSnnklDgphLzuKq20eiqy5a1c6HLEIqq/9s
         698Xav3WVdUBBLNjj/0S7e09oJpbQe0slrrd8BgZIkNDNC4v3bkSTPOkhCODHBzecKhg
         9EtQ==
X-Gm-Message-State: APjAAAWY9GSr3lbj4+88t7WndSxvP394kkRw78+pdb6W5n25f+uWxWwD
        6C1H/ffiY3kHMpSzDslkxyEf5329sKnNAw==
X-Google-Smtp-Source: APXvYqzhOnQwTfs+iDSGdltJmmDXV4ZTX5Vx1XafZKS1r8efkdns+RLWJpHjxTOHA4rF+IUpqUyLdQ==
X-Received: by 2002:a63:c10d:: with SMTP id w13mr1699713pgf.28.1560539402988;
        Fri, 14 Jun 2019 12:10:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id w132sm3479366pfd.78.2019.06.14.12.10.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 12:10:02 -0700 (PDT)
Date:   Fri, 14 Jun 2019 12:09:57 -0700
From:   Benson Leung <bleung@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Enrico Granata <egranata@google.com>,
        Ting Shen <phoenixshen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        gwendal@chromium.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Message-ID: <20190614190957.GA243443@google.com>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
 <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
 <20190614185533.GA142889@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20190614185533.GA142889@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Jun 14, 2019 at 11:55:33AM -0700, Dmitry Torokhov wrote:
> On Fri, Jun 14, 2019 at 11:27:03AM -0700, Enrico Granata wrote:
> > On Thu, Jun 13, 2019 at 11:54 PM Ting Shen <phoenixshen@chromium.org> w=
rote:
> > >
> > > http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> > > the event_type field, the receiver side should mask out this extra bi=
t when
> > > processing the event.
> > >
> > > Signed-off-by: Ting Shen <phoenixshen@chromium.org>
> >=20
> > Reviewed-by: Enrico Granata <egranata@google.com>
>=20
> EC_MKBP_EVENT_TYPE_MASK is not in Linus' tree. It would be better to
> merge this path through whatever tree that is bringing in that
> definition.
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yup, this looks like it's coming in through Lee's MFD tree, a series from
Gwendal to update cros_ec_commands.h.

784dd15c930f mfd: cros_ec: Fix event processing API

That commit is in the immutable branch for v5.3 here:
 git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v5.3

I'd recommend the chrome-platform tree since we'll be pulling in that IB too
for some other refactoring Enric is working on.

Thanks,
Benson

>=20
> Thanks.
>=20
> --=20
> Dmitry

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXQPxBQAKCRBzbaomhzOw
wjbnAP9f8fuB3qp/BLcnKIDCaVJuUkXv7kRFVev0gUsyOwWh+gD9GYkTyM0et9Iq
t823F3GYAzo2PQLkdpuRbESWLoCW1wU=
=Lfmp
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
