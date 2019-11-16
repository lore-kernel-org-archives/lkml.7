Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E37C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63CE21479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFhcLuXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfKPP7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:59:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40288 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfKPP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:59:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id f3so13696943wmc.5;
        Sat, 16 Nov 2019 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rbOTnsUq/9DEZdmIKLuf6krWrS7q2mSNEM5xgQhX8+0=;
        b=NFhcLuXrnAq0OYYyA7z8C9bZXa0hHJ+dtzhQ+5umQq2VHZZ5w7c+aeghDO4l677kdG
         eoDpyAbJyngxzbIeVQ29ZCp/ejPP+M+SlTI81bkcBxIgYtG2JqhKNCkbSyWp4AD1JhVp
         3oDXzKFoC5LBtDZait63JpszzFrRh9Phf3YzaJUANIhQ9KI1ON11YQkPUf3QIZyz7wBl
         pTel5NKFmPVS7sorHS0bZrLVIfFG1i5zwUpjT7/L9cao+hEej/9EwNIghcuHWAlF2gxn
         bpMw5WmkvlgPrOOVqj02xFCNTiGEYhPI73+ppPrEgLxpNDf9m6gh84ZU/xaOOemM0Bl9
         KFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rbOTnsUq/9DEZdmIKLuf6krWrS7q2mSNEM5xgQhX8+0=;
        b=j8k4z7lb0TOiqM5HiPa1bNMj/ZgjxlF06OR+fomlyIc8HtIY62S0gie5+p+tZcauSy
         XWr2lDfcogplGB+giYIw74jODZW5zADqQoe2RZYd2vF5AY9IdHEiyyQ9pkz4MJPM3JlB
         7+7dUC+CIHkDg9S0h6i4IPIB24ZE7kpGZM66DD51x8UY3LM8W5osgliHVOabTvmHxqQC
         W3+ey1MyFH3fUaVBn9QcloPmyhSIstebbPAMY87wVaB32jxIqryVEhuLBf2B8bDC4m5H
         ZYTkgLoMNWT5nwZ7biyrJrCxpofRUBu7lPcXCcx6+jgSavDXST81+qhQ1eogx+IHPc++
         e3HQ==
X-Gm-Message-State: APjAAAUaQXD1oskilJjFxCLGpIfQkx6NbbajR9GBuuXHx8wBSNN5OecR
        I+Eqfl6ZzPMHiCo2O5dip+PJDtMd
X-Google-Smtp-Source: APXvYqxsbrRwKJb01nFAnlpTmPL2gVoiHHhMbXxmTojWd+YmwhEjp4ie7IGLxxmhf1RhvFHHAk2v9A==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr21833868wmc.129.1573919987194;
        Sat, 16 Nov 2019 07:59:47 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id m3sm15472137wrw.20.2019.11.16.07.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Nov 2019 07:59:46 -0800 (PST)
Date:   Sat, 16 Nov 2019 16:59:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Giovanni Mascellani <gio@debian.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dell-smm-hwmon: Add support for disabling automatic
 BIOS fan control
Message-ID: <20191116155945.tivygva3rbbdolgz@pali>
References: <20191116140649.114592-1-gio@debian.org>
 <20191116145845.xmhki3ckza26eoln@pali>
 <7bc8ec9a-f559-96c8-36fd-6e11a1420626@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="flg5b24ackzt24u5"
Content-Disposition: inline
In-Reply-To: <7bc8ec9a-f559-96c8-36fd-6e11a1420626@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--flg5b24ackzt24u5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 16 November 2019 07:53:10 Guenter Roeck wrote:
> On 11/16/19 6:58 AM, Pali Roh=C3=A1r wrote:
> > On Saturday 16 November 2019 15:06:49 Giovanni Mascellani wrote:
> > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-=
hwmon.c
> > > index 4212d022d253..67b8c0adede8 100644
> > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > @@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
> > >   static uint i8k_fan_max =3D I8K_FAN_HIGH;
> > >   static bool disallow_fan_type_call;
> > >   static bool disallow_fan_support;
> > > +static unsigned int smm_manual_fan;
> > > +static unsigned int smm_auto_fan;
>=20
> The "smm_" prefix does not have any value here.

These variables store SMM command numbers and seems that in this patch
they were converted from macros "#define I8K_SMM_MANUAL_FAN	0x34a3"

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--flg5b24ackzt24u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdAc7wAKCRCL8Mk9A+RD
UsfEAJoDKRkxM6QIFvf1qBY9lV2BcXUc7wCgzBCg1avUGdNJmdcQX1Q7gmPz7Sk=
=J3Ov
-----END PGP SIGNATURE-----

--flg5b24ackzt24u5--
