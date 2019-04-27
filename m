Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B19C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CB62054F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqIPRF8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfD0GtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:49:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40490 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfD0GtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:49:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so7429460wmb.5;
        Fri, 26 Apr 2019 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TxzmXQ4iORt2UcFz9EquDcBC3mHixJZvDIwSoDC63PQ=;
        b=JqIPRF8GeKiVOS2q2IDbHBL0u8khGR2Oy+cVDwpIluiCyphu19baWqW3lmuW/QJpas
         GNXStmixxSLXi31OAg+matfx5g9LACa0VFXYKpbUPRcc6zQwwvqGRVcGmzk2+DoivsGF
         yUod0smBT8u5wB4rl62aIs5AAQYPjYwTwpG6AMNmx5DdDIQZSSB7Wj9MCZnk4cjB3Seo
         yJG0EXMm5t9KRSftp+mKDltKb7yz/mxas3EC8GA/MlzEP1GEvhSwKd2uqMKUJ+Fa4Ua8
         DJ6gjPRpGiMzA42+01Wr1WzHOgHX8sjIm+0lZXNutVfkq0/q/oVv4F6IXIi1G4JIjpye
         Qzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TxzmXQ4iORt2UcFz9EquDcBC3mHixJZvDIwSoDC63PQ=;
        b=qF5G9mRh5TyMstEccmLM10kfWrefVbg2WDMh2EH1nKrkHAhxOQJiZWkbVUuuZd7uBM
         NN7I1rtEpDem1TTivBcxIs0EopOEMW1QvKRZ2ZNzxcIgDvIlJD2of+RCDeGRX6HwAylh
         skPbR8OAX0s1UXCBccyL2IwnAn/gNpa7W+cZzrIDhxoACfajiiFFxQ+RSmP75osPDR/k
         Ci1mGoGTzPOq8ONqJaoZGTqGM9Wq1yXBWrzcugO8eW88foIAEOiHIbnlo/UX4dgsjc+1
         a3zl8TyxMWv5s5cs1n4xQANQRwqh4MG8vKhLOar0d5QFC89txu/5JAU/lmWsHJI2VLni
         R1OA==
X-Gm-Message-State: APjAAAWw+yj+da322vK4krMoaexuas7y5yqYzc2NRlsHh9q8Hg2xLrpw
        knzi2sjXqQeIIelaW9/meAs=
X-Google-Smtp-Source: APXvYqzcxzWN2HDnYgG56XPSqB6+xZ3rQoSCd5XG733z7ZclaD1f2XWxI+TEgwvnk1Nzernvsa5ljg==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr7039641wme.78.1556347738093;
        Fri, 26 Apr 2019 23:48:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b184sm189391wmh.17.2019.04.26.23.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 23:48:56 -0700 (PDT)
Date:   Sat, 27 Apr 2019 08:48:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <Mario_Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>,
        Takashi Iwai <tiwai@suse.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Message-ID: <20190427064855.omawrv2vmcehsspb@pali>
References: <20180131120348.azy25aqvn5wrdkeh@pali>
 <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
 <20180212153012.vffvjmz26ifyxbj5@pali>
 <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
 <20180213150004.5d2v7y7wwuure4io@pali>
 <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
 <20180213165023.xmzovx7fd3gdljxw@pali>
 <20180226203255.lnnzipipjz5l2itz@ninjato>
 <20180308225330.5ywfokfhxcl5j3ju@pali>
 <20180418114610.rohdk5mnzv4km4z2@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mvpru5kfdrmq6sqf"
Content-Disposition: inline
In-Reply-To: <20180418114610.rohdk5mnzv4km4z2@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpru5kfdrmq6sqf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 April 2018 13:46:10 Pali Roh=C3=A1r wrote:
> On Thursday 08 March 2018 23:53:30 Pali Roh=C3=A1r wrote:
> > On Monday 26 February 2018 21:32:55 Wolfram Sang wrote:
> > >=20
> > > > I'm not maintainer of i2c-i801.ko, Jean Delvare & Wolfram Sang are.
> > > > Therefore instructing future contributors would be up to them.
> > >=20
> > > This is really Jean's realm.
> > >=20
> >=20
> > Jean, ping.
>=20
> Jean, gently ping again. Waiting for your maintainer response/decision
> on this problem.

Jean, one year passed without any answer. May you response to this
thread about this patch?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mvpru5kfdrmq6sqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMP7VQAKCRCL8Mk9A+RD
UpvnAKCTDm3RX8cPc1mcZbuH/1GAVEkwlgCgmt/6wZDdcJMcJNBFkEhvi8oD/ig=
=FtHj
-----END PGP SIGNATURE-----

--mvpru5kfdrmq6sqf--
