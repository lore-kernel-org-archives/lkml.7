Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA708C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879DB2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4O1Tlmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCOVSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:18:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44665 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfCOVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:18:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id a3so7169070pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhaACbu283jkmNCTeYJ352N38Gmocor9TOUev/P1Zxo=;
        b=J4O1Tlmq/BXgbPVMHDNJJMAYHav4mH5MGqH8IaBrbeqzUMPqk3Bg1BV4D//AJicu4b
         03+ySXf8AvPo4jl+noQGo7/+snZeHY40XwEiV5+nHZBSlcWrGywfelTjw/0XkDnj9ev9
         Z1dbuS23AOzM135myhVZRe0B/Moh83NQvEXuGRa1wB/oNMKQvwIM1WXxPSxomn9+Ctd/
         3uyGGUsIkc+ZUVwtNwBhSCOAchc2MrrUtlV+uAzy2weVQe64FL6G+71CR2xOaPNiAkvV
         Bj/3lPDOHvMsw4MlFZ+VcLpxiMRasyH/qnwDt32SSur7+P7RDHL2+mQ1erDgUGIVdh66
         2sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhaACbu283jkmNCTeYJ352N38Gmocor9TOUev/P1Zxo=;
        b=SmJqRFap9ui3r+6AjaHwI+Q3M8bg2dwCe1BomTgUSp3qPyYwSWrRdpHH6aOE2YieFk
         czd5IC3Apz3rBrbbeyDaWnZagPkNdmjMk/hsYdHw3WmJEzLK6GHDJF4V+jXoE8sBXO/Z
         f0H6jPROnASwsaRpgLB3E0nzzQGhljtG+ATPcN3wTtm6LijUzq1boXwUwUswKNReM9h5
         s41Ws8OLPhylo0TtT0qGiUxiT0KKZhrvSBMgDmdFTqAO2NN2Y2oqCr7UuQdVkLtmpWRi
         P0gvvQdRhTANPM5gyiZ9vZlEOreTub45eHpvipRyOl3rGP9uHpvPi9VUj76LJZpDrV39
         ps+g==
X-Gm-Message-State: APjAAAVTUer2D2vUOPu/eJrKJOrZR7Z++xU387ExQlPtZCpt6RZXAh9K
        lqSMqt6rmVIBHQkPBFqu+hx/CA==
X-Google-Smtp-Source: APXvYqzzQIYOkz+Bj6GwOoHfUhF0BLdKdPLVmnnE7NqrBxBjPcuDH25K64fSVhjd0LNEw+Wgnj/Diw==
X-Received: by 2002:a17:902:9b98:: with SMTP id y24mr6383746plp.167.1552684732828;
        Fri, 15 Mar 2019 14:18:52 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id m20sm9590418pfj.142.2019.03.15.14.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 14:18:50 -0700 (PDT)
Date:   Fri, 15 Mar 2019 14:18:45 -0700
From:   Benson Leung <bleung@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, bleung@google.com
Subject: Re: [PATCH] rtc: cros-ec: Fail suspend/resume if wake IRQ can't be
 configured
Message-ID: <20190315211845.GA165708@google.com>
References: <20190315185112.97699-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20190315185112.97699-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, Mar 15, 2019 at 11:51:12AM -0700, Stephen Boyd wrote:
> If we encounter a failure during suspend where this RTC was programmed
> to wakeup the system from suspend, but that wakeup couldn't be
> configured because the system didn't support wakeup interrupts, we'll
> run into the following warning:
>=20
> 	Unbalanced IRQ 166 wake disable
> 	WARNING: CPU: 7 PID: 3071 at kernel/irq/manage.c:669 irq_set_irq_wake+0x=
108/0x278
>=20
> This happens because the suspend process isn't aborted when the RTC
> fails to configure the wakeup IRQ. Instead, we continue suspending the
> system and then another suspend callback fails the suspend process and
> "unwinds" the previously suspended drivers by calling their resume
> callbacks. When we get back to resuming this RTC driver, we'll call
> disable_irq_wake() on an IRQ that hasn't been configured for wake.
>=20
> Let's just fail suspend/resume here if we can't configure the system to
> wake and the user has chosen to wakeup with this device. This fixes this
> warning and makes the code more robust in case there are systems out
> there that can't wakeup from suspend on this line but the user has
> chosen to do so.
>=20
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-By: Benson Leung <bleung@chromium.org>


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyMFrMACgkQHwn1ewov
5liCbQ//csr76yg/XYgehOEgHVm4eOYVsF7AYJ2B/pdlWtCl+vXh95VOX5AeaUlt
L67dOSZ6HBE3Z/4dh5qQcec4+l7SMsqR0GhW4kv/aaPB7oJuCWpIz9MGa3tjhMec
NgnwzdXoV4Rrbq5I9Bd4uX9MNGw2DC15BhFTureDEd/TNpAPHB3a3T48mNdMqMcS
xldgkcCvesf/o87bl33NotOu4QGhK4T0EdKVKOrX+oYlA1DkF+TpEx43LvRnuIhM
hOuLNW8ocJQycJJVq8TQHvl7BmMGAPyTs3b5vg17MI7Uq+27Q9w6vK/wDWmfjC7L
PPBlYQw+lAEW96wMCtG3eqahEEx0ULVlnNuwgxIhXCfiYSFLdawPrYGfaeDl7wl8
DXXjOwGCZqF0WRsp/aOf81kXrclpunAuQlePTnq1Nv6jq2i2fXw4yPi9895eoJaF
qUjHlxEX9nyxeaR7n/8uWhJBDTxrKZZKdL4sXJqIOvJbk/cJe1xcRoi41zxwlUhk
qA3RYdF5o2+KM7YmB+Y1X0l4H5epSrkA/DJKHueDhuehIW6IWrP7mUv44hN2Lkff
bzW8JmzQy8ilitQs91oJ7J9i8HnoVmKnUdZj8/LHM+EqRQg/pCJJuOdRK1LorLhL
NzbtXLZLzoHy2Rsz8YMTj2NUDVNju8UFanPiR5uvr4M7VXZroLg=
=dNaK
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
