Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCFC43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58487206E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vY1igBXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKPPDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:03:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfKPPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:03:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id f2so14112553wrs.11;
        Sat, 16 Nov 2019 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ts/Cau9oznV84QKj9dFCVAYvzPmUjunHN+Y97FI+mBs=;
        b=vY1igBXZRByDldpJLifqIVJ9g1gaOPLjqrsOdaOwznC8QWDmvF88gQgWaUJElqppxv
         vxLG9W3LCH1VdZsjaW5cfTjKC1FIHFIovqLeV0JBK9jMlTu70auTpdczF88JGNLHiBA7
         5g8sROuwUoj/tyyqjTgZCchq11oW7RqjDWkDGqlq4FVHCq1IIoF3ZMpC03Dt046V/IWG
         2FlR9DdnRr+7zhkRpwd8cuCJH2czgUdoBkHNvyWqUvfUnf6pGzs6J1F531YXjbQo/CaZ
         GfN0nIlpTcbXrmeLB6OW4SanlJyyKqzg9uWZ0CtgA2GpMUJZEvM67d+aarvhq0qlWePu
         sgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ts/Cau9oznV84QKj9dFCVAYvzPmUjunHN+Y97FI+mBs=;
        b=T6ehTn+KdpNZ6/w5A+H5dyD6C/jsauK7Tce/of6+0RmyD4Po2bME0/wOu6h1Ad+Cwy
         Nz+ySMK8ypg8ZpyiENqnyGcZiUjxGKBtEzyfp1UvZYdb28/BTAJzEMb4OafmfQsQP05N
         CCqOm3lyhFQoCQdjFvOnDcpTjiOnTHINq/AcsgHUqgTILohKJ0OpVClpuYsb6ZpyZ5zr
         OF5n6oXdCXxtF450p1oeiF4FnUxvgT5ZShPe0b2Z7SifX0z6ZEcPUuEcvc2rUT0WRDJJ
         SG1tVBM0dNAR2WOU0HbrQ65RscQ12IU+iJnebiRde1gKYm7fZZv9gCzhNUw2MiWjA/cm
         3fmA==
X-Gm-Message-State: APjAAAWty9fP3oJ70TlLE0J3mc4oHmmiuwvvUx9KSN+o2YY/x+BfGsyi
        EKzXKsECGbZuG4znQfQBLMA=
X-Google-Smtp-Source: APXvYqwhXdR402iqMvF8f/j3Zulop2bF3MFttatFbIkCn1lzVFrLzQ4dLrgzNllrMYhcZnxmpE6E5g==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr22071427wru.146.1573916592737;
        Sat, 16 Nov 2019 07:03:12 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x205sm15663732wmb.5.2019.11.16.07.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Nov 2019 07:03:11 -0800 (PST)
Date:   Sat, 16 Nov 2019 16:03:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
Message-ID: <20191116150310.dlhjrr3kyh7fsykf@pali>
References: <20191114211408.22123-1-gio@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7tkusd6mbxqavr5z"
Content-Disposition: inline
In-Reply-To: <20191114211408.22123-1-gio@debian.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tkusd6mbxqavr5z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 14 November 2019 22:14:08 Giovanni Mascellani wrote:
> +#define I8K_SMM_DISABLE_BIOS	0x30a3
> +#define I8K_SMM_ENABLE_BIOS	0x31a3

In my old notes I have written these two comments:

0x30a3  disable the Fn- key combinations (except the volume functions) key =
and disable BIOS auto fan control (no args)
0x31a3  enable the Fn- key combinations (except the volume functions) key a=
nd enable BIOS auto fan control (no args)

So seems that these two commands have some side effect on some
machines.

For 0x34a3/0x35a3 I have only these comments:

0x34a3  disable BIOS auto fan control (no args)
0x35a3  enable BIOS auto fan control (no args)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7tkusd6mbxqavr5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdAPrAAKCRCL8Mk9A+RD
UjJRAJ95ij/W/aSdbiOocV6rkc/yhSY40gCbBACMEV+fSdVywC+gLlNb25KF7nQ=
=MQjG
-----END PGP SIGNATURE-----

--7tkusd6mbxqavr5z--
