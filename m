Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C44C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20D020854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW/bNg9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCSNVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:21:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35791 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCSNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:21:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so22036092qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6xQLzLjON/fGXa/2mLahHLOGkWeJ4HAYM2bQPijfEBY=;
        b=WW/bNg9hBvoXolIUz9XFO8KngjkJnWleG4JDrZbVWLfzXcdLMKY37DPQDXiqGt1psp
         ATv/b/Jac+KiyQ1DAnZ3f6x7MVIaV7WX/b4sB1eBLyY9d0Jyz1XoULyoEe92bHQ4WSQh
         MW2EpB7HImwT4lKiV37QvgOf6zPisbaN7B3yv5vKwS/jv6/suxVkPO57bMC+x6EmSAEg
         IeJASMQ7ZSqDxXY9+TbsXJGqFH98KLRR78MbO4ZJIRd0q8svhgNPUhu8FgHrDN11Xz/B
         A7v/mHMJWl5mw4xKQZcz+mZAUqa2sT2ZmQpd9qBzG+S4VsIlF4YJn2t1F7aKuG2HXFrd
         a47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6xQLzLjON/fGXa/2mLahHLOGkWeJ4HAYM2bQPijfEBY=;
        b=R3R70Hcug4tb4tlzlKTPJA2zR0mRbB9N7+nwHeq+FCMCk64HoJnXuzAdCTwldkNiPi
         LZA1wK8jnFiBUSn68JsFfiqi5+xvJBbeNwaT26QINMHEJbgVISCjuvPe2XPppvoCnfUB
         qCGXZU/jwstEjK3PxA3DjrbR9s6LBBul1CEeULKTC6Zs4s9RAD09i90VUptwFiTcI3tn
         Thl1OId8LLE6pXyVUU/pQ0O0d8p4/j/urJHvXS0L2d02pt10wvlYA6dqwuwjqAE4r8jX
         ZBJjDpVBV0ttbW6gjVqQ3ZPxTwgn9flaXFVHktPh/tP3NEZLvgCksxaJtfldKk2RDh/n
         BEow==
X-Gm-Message-State: APjAAAWaV9XheRPCbZPm5uAnXv9yv+9kqgt3q3xv8wJYHmOcmzLOvA6C
        uX3nW5fPRUqHHiObpfKx7EsxftJe
X-Google-Smtp-Source: APXvYqxf0hsLbrB80yGyk9yscHFJdGsns8m3Z6kxdsb941OTik/2P5/Y7SoCgcH8wVKLZ2Rdv6wpHA==
X-Received: by 2002:a0c:9e65:: with SMTP id z37mr1763034qve.152.1553001678525;
        Tue, 19 Mar 2019 06:21:18 -0700 (PDT)
Received: from jfdmac.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id j9sm7200684qtb.30.2019.03.19.06.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 06:21:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 2/2] w1: fix the resume command API
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <20190318092737.8170-3-manio@skyboo.net>
Date:   Tue, 19 Mar 2019 09:21:16 -0400
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6836A9A3-AF86-4E2F-9215-647CB36E22DA@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
 <20190318092737.8170-3-manio@skyboo.net>
To:     Mariusz Bialonczyk <manio@skyboo.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mariusz,

I appreciate your work on this.

> On Mar 18, 2019, at 05:27, Mariusz Bialonczyk <manio@skyboo.net> =
wrote:
>=20
> =46rom the DS2408 datasheet [1]:
> "Resume Command function checks the status of the RC flag and, if it =
is set,
> directly transfers control to the control functions, similar to a Skip =
ROM
> command. The only way to set the RC flag is through successfully =
executing
> the Match ROM, Search ROM, Conditional Search ROM, or Overdrive-Match =
ROM
> command"

Indeed, figure 12-2 flow chart shows that SKIP_ROM resets RC to 0, then =
RESUME
looks for RC=3D=3D1 to enter the control function "mode". Nice find!

I don't know however if other slaves are like that. Since the true =
impact of
your suggested change is indeed null on the bus (bit count wise). I =
guess even
this specific slave case is enough to warrant the change in the subsys.

>=20
> The function currently works perfectly fine in a multidrop bus, but =
when we
> have only a single slave connected, then only a Skip ROM is used and =
Match
> ROM is not called at all. This is leading to problems e.g. with single =
one
> DS2408 connected, as the Resume Command is not working properly and =
the
> device is responding with failing results after the Resume Command.
>=20
> This commit is fixing this by using a Skip ROM instead in those cases.
> The bandwidth / performance advantage is exactly the same.
>=20
> Refs:
> [1] https://datasheets.maximintegrated.com/en/ds/DS2408.pdf
>=20
> Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
> Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

Reviewed-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

> ---
> drivers/w1/w1_io.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
> index 0364d3329c52..4697136b9027 100644
> --- a/drivers/w1/w1_io.c
> +++ b/drivers/w1/w1_io.c
> @@ -432,8 +432,15 @@ int w1_reset_resume_command(struct w1_master =
*dev)
> 	if (w1_reset_bus(dev))
> 		return -1;
>=20
> -	/* This will make only the last matched slave perform a skip =
ROM. */
> -	w1_write_8(dev, W1_RESUME_CMD);
> +	if (dev->slave_count =3D=3D 1) {
> +		/* Resume Command has to be preceeded with e.g. Match =
ROM which is
> +		 * not happening on single-slave buses, just do a Skip =
ROM instead
> +		 */
> +		w1_write_8(dev, W1_SKIP_ROM);
> +	} else {
> +		/* This will make only the last matched slave perform a =
skip ROM. */
> +		w1_write_8(dev, W1_RESUME_CMD);
> +	}

This may be a subsys maintainer's style preference, but perhaps the =
verbose comments
might be better suited for the git commit message. Could this then be =
shorted to

	if (dev->slave_count =3D=3D 1)
		w1_write_8(dev, W1_SKIP_ROM);
	else
		w1_write_8(dev, W1_RESUME_CMD);

Or maybe:

	w1_write_8(dev, dev->slave_count > 1 ? W1_RESUME_CMD : =
W1_SKIP_ROM);


I am also ok with this proposed version, hence the "reviewed-by".

> 	return 0;
> }
> EXPORT_SYMBOL_GPL(w1_reset_resume_command);
> --=20
> 2.19.0.rc1
>=20

