Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D94C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09122183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbcbKAEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCST0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:26:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37481 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCST0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:26:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so79084pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f0+T7zWohPwolHQY1HCZCr1y4WDZ9X5+AeDqKQvQhCg=;
        b=KbcbKAEHc3H2BhKekcvp51QQrYOE/B4LXYSbuWoGHCtyV5nQTVLNLkETtaJaWtKiu0
         lH8H/qIB5mHuOiOqHw9337BqAZOAHa3s/JW0ptCokGYrD+ex0gnHoAGE9qxmhhVcChNW
         JsCZmKIgGzMUE5xumc4jkc7oLKbPj8oWqk8o3lW2kDwB2pfE7LNgVlQeFdNJkeX3EUFe
         qui5Cmh51IGDi85KaciINYWzn8y/yy/6mNuTCOC26uZLv+pSastH5DdQnbTKCKvxDtJQ
         RcrCvtwGV+jGE1nlYIvgf86fvn3upWX+5YhEs7MBlhJlISPTdqVIoJZVZfy+lGmbtzK5
         v/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f0+T7zWohPwolHQY1HCZCr1y4WDZ9X5+AeDqKQvQhCg=;
        b=AoLx2vwILCI9RKluwaY5xuu6Qdf/BcFGrX9n4wYjtJ2YsTDJFtKqfInCKhlBp3ncLb
         xOEZLYlYL29Et1NN4sBFC5WctuVCPUbG//U6L+r/K8YhZvyU3RcCrassC5pSr9xVxXXx
         WrX3ZPZSHgIFJiPVwRwz5JXTeQUTAXjDsMHssYmjksGditQWCrcpBSisjujXV+N9xbdL
         i9i5opWdQoWTxM/4mLjDKySiH4wC1mYk1u6Pf/db4Hw0siciHjBiptACxqVpdwxs9ThC
         XxdKL4wTbFpllhN7u2YbAerIqVPb5+xTWCQz4THD7GWK1IGimFMyLNg0VUX2COYzGrC8
         uMew==
X-Gm-Message-State: APjAAAVNZN0ufJ4TA87uhWwaqTyagzqDMEUFPe2TYHBstbeVXAEInGv9
        Qq8vFrkm5Jy0hRWOESPMbi6Y0g==
X-Google-Smtp-Source: APXvYqx6UCIUqEd8Dutxy/7llqmK4qeyYk9ngAmZufCXQsXKM4KJRwI00ZYLVTbjZ1zxhvE0IWxEWw==
X-Received: by 2002:a62:3585:: with SMTP id c127mr3938060pfa.71.1553023596700;
        Tue, 19 Mar 2019 12:26:36 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id s79sm29067532pfa.61.2019.03.19.12.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 12:26:34 -0700 (PDT)
Date:   Tue, 19 Mar 2019 12:26:30 -0700
From:   Benson Leung <bleung@google.com>
To:     Guenter Roeck <groeck@google.com>,
        Urja Rannikko <urjaman@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, bleung@google.com
Subject: Re: [BUG] cros_ec_debugfs causes a WARNING trace during suspend on
 ASUS C201
Message-ID: <20190319192630.GA228799@google.com>
References: <CAPCnQJ=zoWFU7YESpONjwRC4ccVo_StYbY=dgait-Yp4Ptb5=Q@mail.gmail.com>
 <CABXOdTe7gssZqHziUFjWQ5WROmMbHEVzej8j8toq1kkBrSQS+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <CABXOdTe7gssZqHziUFjWQ5WROmMbHEVzej8j8toq1kkBrSQS+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter, Urja,

On Tue, Mar 19, 2019 at 06:37:08AM -0700, Guenter Roeck wrote:
> Hi,
>=20
> On Tue, Mar 19, 2019 at 3:37 AM Urja Rannikko <urjaman@gmail.com> wrote:
> >
> > Hi,
> >
> > I was testing 5.1-rc1 on my C201 when i found this, dmesg of a
> > suspend/resume attached.
> >
> > Based on a quick look at the code it looks like the reason is that the
> > suspend and resume calls try to cancel/schedule log_poll_work
> > unconditionally but this device doesnt support reading the console log
> > so the delayed work struct was never initialized.
> >
>=20
> Thanks a lot for the note. I'll send a fix later today.
>=20
> Guenter
>=20

Thanks for the report and quick fix. Guenter's fix has been merged and shou=
ld
be in 5.1-rc2 when Linus cuts it.

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

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyRQmMACgkQHwn1ewov
5lgtvg/+LyvCneKBIPyq77p9o/CGFpeXbmIQUeEP9MsuIfqquk4Wb5MGYhDQoVIR
SORnoSMDNxmnTKvCoE9gKasKfIgbNeph32rTze8rxEUB5j14h2zVvrUDiI043jAo
LvS3L4P2YqposLrRkqXhgSIVoG1UJon4ePz4Xwgd5AOI0rEytgXfDMvvAT2xQtfo
lsFZ2YatnBA19DArXyZed429+kMgymXhmepw7cVZVX8ZuUoRqLqTGH91w3OEZBiZ
zxuXqYZKhZOMfd2pkI0UOlybpnpPiBwmk8LNNh0y960ewu2tLezyvSf3NBp5Q6cj
XlgtpqV50/OX87gZbcJWoksHFoEtHX1HvtzzCDMH2U8IciY7oHfGnC2k0v+RQz3E
YpjlFT2aRyeryE3zoLC4WJaYrr/tgVAYyFBxYiur7oIUKdu3vaWf640ZGrbrPCw8
bGtKaCDRjmQ65flEb12g756miXSFuuTJHdozj0sylz/YPWTAefQRHiGF2/LdzLe6
UgfMsHRq7itcgR2c8tSMph/iLuMKr4fvmawZnDXHQtce+ydeaNo2nrAghFUusJzO
22TPuXlP0fMaJGbbqYeGhIDjIlPMuukrnnuAufznvOsPpZmq3V1GWRrH8CzBsUEI
+ORq8+lt+9CLlTksUqrLpxMUDd7grJtEl4zMmEsFxhJb9YWEDwA=
=WFKq
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
