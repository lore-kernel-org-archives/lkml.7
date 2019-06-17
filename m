Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF9EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638D92063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrs1M6PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfFQVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:49:36 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:42436 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfFQVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:49:35 -0400
Received: by mail-pl1-f170.google.com with SMTP id ay6so2495003plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H3Fszt1Y3AdZpnj+WeH9b+vUaOMqgjk8732ory9O+K0=;
        b=vrs1M6PVEXsz5PXr9KQC1LoqGXYZtiab2IXzFvTgr5PXWbkPlSebojHfZXmUvWKY2z
         zC2gGqt+JVArV9H0h5Ea+8Y6pKHmDMZeNZ5fdGxvVaF+Qw+pYlEfmNisDUdP60jWQTv/
         Vmk8MeP3NpSubvbIvWVyzORaBXVZ8FzaF/FNDfD3YtH7jcRw+mrQ1zQeQWKarCCfWbTQ
         6x56iYpwX+sl7PBjyUzAST/xCjzJ+8QkbLAR4oRCAqyt0rAysDbRl+WAFe1thY2zIKGh
         sVPlbmwSe3o4lexCJ8ysWruS6Z3eoWN8qOBtZNGXdyG5u/wtxhqd3aa+gsrkuQSZ/93Y
         UKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H3Fszt1Y3AdZpnj+WeH9b+vUaOMqgjk8732ory9O+K0=;
        b=CGk23YSZK3yazV1YnfSoLVWLkiyhXkA6c5jNAD8PzJSp2Rx3QVadDtM611KV9RVNub
         ai/in86AXwmEUZueEZgFroewJNBAE9Tf+kJbaZFd7xdz0KTE8WfEmiYNDrC7RijI1hKb
         ac18c6/e36WlL1vWbhQlmICdiRsFE6Z2/YJkk3YIT2ubSL/UWEnGVEXIi/weV0ZkvkAy
         vC4GghM0FS6zoITK7Wbksyi2tKL49UFdd3/6esMpyJrgSWEwdyD8OBZGsEJN9wrMj8I7
         PssaZPtKhURF5o/oOzK+oZmXJ4T69fykT1EEDIb/NVmw0UsiDRASduNOQ76WAcLkoMpD
         1JmQ==
X-Gm-Message-State: APjAAAW7zbZWgDNTw6pjH7RLPAz8zrx72UOSWDg0FLth1wOE3yd2KI9S
        sZ2IWGsEOFJfACdLLPd32XEy/Q==
X-Google-Smtp-Source: APXvYqzqOG8fr9aMqSVtoSub025NpBTqrwdZo5nVujwuZepuTyZ6FcTQBRkNyY0aIW/l3qsLSfE+Sg==
X-Received: by 2002:a17:902:e6:: with SMTP id a93mr67857206pla.175.1560808173712;
        Mon, 17 Jun 2019 14:49:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id b15sm12350703pfi.141.2019.06.17.14.49.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 14:49:32 -0700 (PDT)
Date:   Mon, 17 Jun 2019 14:49:27 -0700
From:   Benson Leung <bleung@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, bleung@google.com
Subject: Re: linux-next: Signed-off-by missing for commits in the
 chrome-platform tree
Message-ID: <20190617214927.GA68491@google.com>
References: <20190618074607.09dfcdbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20190618074607.09dfcdbd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, Jun 18, 2019 at 07:46:07AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commits
>=20
>   0ac39915c00e ("mfd: cros_ec: Update I2S API")
>   273e4a83784f ("mfd: cros_ec: Add Management API entry points")
>   5fb684b28ddf ("mfd: cros_ec: Add SKU ID and Secure storage API")
>   fa1edb8224c9 ("mfd: cros_ec: Add API for rwsig")
>   a5a60125c987 ("mfd: cros_ec: Add API for Fingerprint support")
>   ff5599529a19 ("mfd: cros_ec: Add API for Touchpad support")
>   a97c5892c8cf ("mfd: cros_ec: Add API for EC-EC communication")
>   381041521d3a ("mfd: cros_ec: Add I2C passthru protection API")
>   d18e0cde8705 ("mfd: cros_ec: Add Smart Battery Firmware update API")
>   e4de049a3892 ("mfd: cros_ec: Add Hibernate API")
>   44f251dc6e69 ("mfd: cros_ec: Add API for keyboard testing")
>   03dc9f7cdc8a ("mfd: cros_ec: Complete Power and USB PD API")
>   a704e1450f07 ("mfd: cros_ec: Fix temperature API")
>   fa5a714e9d54 ("mfd: cros_ec: Add fingerprint API")
>   cbc1d3b7c5a4 ("mfd: cros_ec: Fix event processing API")
>   b841c3496d0d ("mfd: cros_ec: Complete MEMS sensor API")
>   b4e686e9eecd ("mfd: cros_ec: Add EC transport protocol v4")
>   743875b6af81 ("mfd: cros_ec: Expand hash API")
>   051cf1f83491 ("mfd: cros_ec: Add lightbar v2 API")
>   b1bd73c9e90f ("mfd: cros_ec: Add PWM_SET_DUTY API")
>   998b37cad349 ("mfd: cros_ec: Add Flash V2 commands API")
>   d8064663d3c4 ("mfd: cros_ec: Remove zero-size structs")
>   036957c19978 ("mfd: cros_ec: move HDMI CEC API definition")
>   0ee2b17ec310 ("mfd: cros_ec: Update ACPI interface definition")
>   6f6db199e544 ("mfd: cros_ec: use BIT macro")
>   a5f0ac50978b ("mfd: cros_ec: Define commands as 4-digit UPPER CASE hex =
values")
>   de18e8beadcc ("mfd: cros_ec: add ec_align macros")
>   bf96c5f1276c ("mfd: cros_ec: set comments properly")
>   6b854d5fbda9 ("mfd: cros_ec: Zero BUILD_ macro")
>   5a0d32c91830 ("mfd: cros_ec: Update license term")
>=20
> are missing a Signed-off-by from their committer.
>=20
> These were all rebased.
>=20

Yup, Enric and I caught this this morning. You're right, this was an inadve=
rtent
rebase. We'll fix the for-next branch for tomorrow.

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

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXQgK5wAKCRBzbaomhzOw
wkObAQD7eW5bRJ4Ak1XaVa/kycxF5ihB2pyEY6COzEZIueyJxAD/VwiNMIajYfsF
G2gEpF3zaWdQ7JiRR89Ln9/xcTXKSAg=
=NHpQ
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
