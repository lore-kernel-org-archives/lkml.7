Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D4BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FDD206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGuOw0pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNVv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:51:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:51:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so8555609wrv.4;
        Thu, 14 Nov 2019 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=haBGKl+ANQR4zXT0STzQg1STB7t7ktHMtbdYa5MVzdc=;
        b=WGuOw0pEFyVoZj3a8m0LSSx0eryuJMYi82HOfCwqg7FoTovJNSwdbMQG71tBwJXpvq
         cXfoyyWx6oGD2G8n8IlKwoKH32PwE9GyuXDEwZoWScnBL2rCfixVC1Ntt9nxER6aP2ry
         91HnmSKDa38xIxHRTlY6SFcFE2rXkPr9rDB5+cSk1Gkhtmf0t0lWhxCfyXTsE+q00xrh
         ZpWfQhHESrTqUTgVdyv1A3TWe+RoG3fWgj/BX/91Eyjo5RGjoR2tMHEKGaXDNyeZD2R9
         SLqhYaAD+BESU3KJqlCmQT6kFr0JSi+DLguHlkz6ek8nnEmbP/OOqc7EPoAB1J/jHZAB
         /LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=haBGKl+ANQR4zXT0STzQg1STB7t7ktHMtbdYa5MVzdc=;
        b=hayd93AfukCZBFKP1pBRZBFQ4mUUkqlWvb8bdt0xH8Z3pYJC7L8Gayo99BES/SiyW6
         HVX76y8NuKN2Og1xidKr4XbSdYDCoiK2V5VZzk2Lg68SuyENEx+K++TATf33ed7vBoAA
         cisUOTSDgu+OaQs4YD+a/GZMxSaWhLax4OspoNw3WCs0FojERQ+B8y0tAbhFUyXxhKkk
         XKnbZGYLYTyswzIZNQK+V5kSYUv1OaSxL5aG6+njDJgi4pFEptjAzdB5T3leC8mu4kgP
         A7hM8KG+RDDEzUxhV93cbroaukrEx+XksoFAQjEaAGZppOsHjki+rEv0D3Cjxbck8vwu
         g7Tg==
X-Gm-Message-State: APjAAAXPCRI0nKy8QeDfjneFvHojxUAaOPAfKs2UzoYMhiCiI46D851q
        0X2mASfVHScwGKoniiKcdvzk7+wO
X-Google-Smtp-Source: APXvYqzMcD2UZl3Oa97YDQxkjGNc3eorc9Qb9+xhZn4zNo6EVpBSIEqmfhJdwW2Fn0rlYKR/erhIYQ==
X-Received: by 2002:adf:fbc1:: with SMTP id d1mr11422029wrs.267.1573768316062;
        Thu, 14 Nov 2019 13:51:56 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z17sm8324627wrh.57.2019.11.14.13.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 13:51:55 -0800 (PST)
Date:   Thu, 14 Nov 2019 22:51:54 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Giovanni Mascellani <gio@debian.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
Message-ID: <20191114215154.hze2avicv7pwiksp@pali>
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qyg2dmvyfnwsnflo"
Content-Disposition: inline
In-Reply-To: <20191114213901.GA28532@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qyg2dmvyfnwsnflo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 14 November 2019 13:39:01 Guenter Roeck wrote:
> I can see two possibilities: Either add a pwm1_enable attribute to
> be able to set manual/automatic fan control,

I already proposed such patch in past:
https://patchwork.kernel.org/patch/9130921/

> > @@ -43,6 +49,8 @@
> >  #define I8K_SMM_GET_TEMP_TYPE	0x11a3
> >  #define I8K_SMM_GET_DELL_SIG1	0xfea3
> >  #define I8K_SMM_GET_DELL_SIG2	0xffa3
> > +#define I8K_SMM_DISABLE_BIOS	0x30a3
> > +#define I8K_SMM_ENABLE_BIOS	0x31a3

This is model or BIOS specific. For example on E6440 are used 0x34a3 /
0x35a3 SMM calls. Because of these platform specific problems we have
never incorporated this patch into mainline kernel.

Also note that userspace can issue those SMM commands on its own (via
sys_iopl or sys_ioperm), fully bypassing such "protection" proposed in
this new patch.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--qyg2dmvyfnwsnflo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXc3MeAAKCRCL8Mk9A+RD
UvWYAJ9O9wwQgkPz8MsClELRJDVyVIhAqwCgtdzteh/xzor3GbpmAGf4IvDv9j4=
=j2gv
-----END PGP SIGNATURE-----

--qyg2dmvyfnwsnflo--
