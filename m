Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DE02087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe9wcRSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfCPJSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 05:18:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55550 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCPJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 05:18:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so8591345wmf.5;
        Sat, 16 Mar 2019 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zKKKz3nMBTcSbKsh0WhgYuN18v3yLB9eD3tOHXzds4g=;
        b=qe9wcRSZixmGkIZYd/JsOmh8CEBkFJNU+VelBqpOlgahLxP/lLfbl1YWykwTBUOA9D
         9L/8QPX7VP+tDVSQuS0jOmBlj369sA1DvocJoAb2hw3SmFOrR7jH8r3vtbJvBUJi+k2d
         ptpGFWXclKoImpKKUw6jSZmi9yKwMZmxxgm6irXYWvJjM6Pq2u3OoRp2mcWF0+RSNpNF
         4uhUNRtk4egXSyC4XgVvc5cCD+fS/3Z/22XIyyHOm89zOpDXuy/NjDU7VIUk7VhCSv3J
         c525d2xzK82s+q+hx8PXopC6Oib0ayhUkkXQTESyu/xNfvFGPtS5chhKhetla1bN7FY5
         uPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zKKKz3nMBTcSbKsh0WhgYuN18v3yLB9eD3tOHXzds4g=;
        b=dOBXvo1exO2KK7fl+OSHbOU5W/lip1s+JHnV6fz+qeNez7jltMsaGChfBFhuSeuCwl
         v4RbHTVlYenaE19zYexuv2A51LQjVQm6Zb4561f3wlkSTaDb7jYD5PWoxesPtjoKn979
         mCij+YQF8X2U1TEkyK+XP/x0NZb7NQMlbjn5giTHDWxKu6EihkWjD49MhQPfmV/dXnYJ
         JimkJNGnieakq8f5zF7I8sTyOj86alZRHMImU7jqe4RCykns8hK3MS/9TTVqktt8z4/o
         mJCoJQbHbZdXPhUknykSgGFMhCMBelBjiQNL2EruDVgJzDn6wQg0bmK2v/9ucxtxtJ8s
         HEHA==
X-Gm-Message-State: APjAAAX8ccuPJyFg41jxsCUYznntXbe2RQ0+eh0tJbiLKUlRGZnIzrLI
        NxhzlTZea1n8Tto+4LFQTqzVvpwF
X-Google-Smtp-Source: APXvYqwIRzeBTIYKt58y5KtCN8RZFHzYwj/ebEXW5qtaOrefGTwTNFi8A4VYns0htcRnr0GtJAD2Ag==
X-Received: by 2002:a1c:4044:: with SMTP id n65mr4939148wma.85.1552727879746;
        Sat, 16 Mar 2019 02:17:59 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f20sm8297862wrg.91.2019.03.16.02.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 02:17:57 -0700 (PDT)
Date:   Sat, 16 Mar 2019 10:17:56 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Renato Soma <renatoys08@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH 0/1] platform/x86: dell-wmi: Uncomment events that were
Message-ID: <20190316091756.2zfccpnhfnjogktp@pali>
References: <20190316010942.6448-1-renatoys08@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6w46kk2sexf7xswx"
Content-Disposition: inline
In-Reply-To: <20190316010942.6448-1-renatoys08@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6w46kk2sexf7xswx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 15 March 2019 22:09:41 Renato Soma wrote:
> Hello,
>=20
> I noted that by pressing the "Dell Audio with Preset Switch" on my Dell
> 5420, notification messages are displayed at dmesg.
> That is happening because the keys are commented out and marked as
> untested.
> Since the logs purpose are there only for notification and considering
> the history of cases similar to this one, this patch aims to ignore
> those logs. Furthermore, this patch fixes the comments related to the
> keys, since they are marked as "Windows Mobility Center" button, which
> is incorrect.
>=20
> Do note that the event 0xe02a is generated when pushing the button and
> the event 0xe02b is generated when releasing the button, hence the
> comment on the code.
>=20
> Finally, as explained earlier, this was tested on an Inspiron 5420, but
> this model shares the specifications of the Inspiron 7520.
>=20
> Thanks,
> Renato
>=20
> Renato Soma (1):
>   platform/x86: dell-wmi: Uncomment events that were untested
>=20
>  drivers/platform/x86/dell-wmi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Hello!

Looks like that those keys are not as obvious as you wrote. Look at my
email with some investigation about Dell Audio With Preset Switch key:
https://www.spinics.net/lists/platform-driver-x86/msg15593.html

Also there is another user who wrote about 0xe02c key generated by
Inspirion 7520: https://ubuntuforum-br.org/index.php?topic=3D105434.0

You can a testing machine 5420, can you prove that behavior described in
my previous email match also your machine?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--6w46kk2sexf7xswx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXIy/QgAKCRCL8Mk9A+RD
Us11AJ444ojAGASjhjxkOWqx2zPN/PfFLgCaAsZAG7JyVs2JiLhWC71qfhcqZgk=
=7+LT
-----END PGP SIGNATURE-----

--6w46kk2sexf7xswx--
