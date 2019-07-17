Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841CC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD7321849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdVNP8Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbfGQSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:19:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46031 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:19:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so11538128pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=cncYQI8yvDmuwH2hjd5wGFOP7/lMDoigmo4c0xr02Ao=;
        b=cdVNP8PeWqL5uNhZX3uc7ty7kC23aPPjSM0yYBgOR1h9uidYTgCVCkvhnXr1gpu0Cj
         vfjC3bXkq7QGouQ/VNi2Z93tCm393g7QL+19UhaAcWNbQU3rvmaV5z4GxBB4l8TqNr6q
         WY14CwpS1Oq1f2VPV+Gco3DGthjbRpiF1nRzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=cncYQI8yvDmuwH2hjd5wGFOP7/lMDoigmo4c0xr02Ao=;
        b=hbyl3Lj5LCwgszy5f53Wj9cvuMAZ9cgSBHN/2IWCxLj3OxyHSobiYbtJwwbLrbAzJ/
         O4KZ4v5eEyulSZOLBueIK1e0deTGug/IYoAtRXhnNI8INmXtw44WhY22uzHo8lgP9y4v
         BY3JcgQMJuf38+qG9Ni/h8Qd+SUoYIi1eenWi9aEDql7zg+woOSSjAnABc3VV4vSBB+a
         TO8WrM6THsCRiprY4+O9l52L8oXO0APfJsi1WtSLQ0RiJzRWe3BBhmnQjoKl2Vuzl+BZ
         ooPdh05KBHWR8TZ6oOiyp6iG+d+Z95J51mSoT6REC0IRj3MLU7oh6CeH+0vaD1eBxUv0
         OHwA==
X-Gm-Message-State: APjAAAXxakJEWJER1MiBKhz1KtGTz1XnbaQt+TKcra4GKebtcMJqTXE9
        5iHNc8HZeyK2/3t2BaDaM+OJQQ==
X-Google-Smtp-Source: APXvYqwPbGaNe9vdMOp7CaO912oCLkRHsArhScKvUkPpOmz+FGcYmsosK7KFSH9Lp6vFjPBeZ8LoCg==
X-Received: by 2002:a63:553:: with SMTP id 80mr44071454pgf.280.1563387588135;
        Wed, 17 Jul 2019 11:19:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y23sm26258823pfo.106.2019.07.17.11.19.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 11:19:46 -0700 (PDT)
Message-ID: <5d2f66c2.1c69fb81.de220.6eb6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7daa4875-eddd-518d-2622-754ccfbfc421@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-4-swboyd@chromium.org> <7daa4875-eddd-518d-2622-754ccfbfc421@infineon.com>
Subject: Re: [PATCH v2 3/6] tpm_tis_spi: add max xfer size
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 11:19:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexander Steffen (2019-07-17 01:07:11)
> On 17.07.2019 00:45, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Reject burstcounts larger than 64 bytes reported by tpm.
>=20
> This is not the correct thing to do here. To quote the specification:
>=20
> "burstCount is defined as the number of bytes that can be written to or=20
> read from the data FIFO by the software without incurring a wait state."
> (https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platf=
orm_TPM_Profile_PTP_2.0_r1.03_v22.pdf=20
> Page 84)

Thanks for pointing this out. I think we were using this SPI driver for
cr50 but then we wrote our own version of this driver with the
differences required to make cr50 work properly. I suspect we can drop
this patch, but we've been carrying it forward for a while now, so I'll
have to check with Andrey and others to make sure it's safe to remove.

>=20
> If the FIFO contains 1k of data, it is completely valid for the TPM to=20
> report that as its burstCount, there is no need to arbitrarily limit it.
>=20
> Also, burstCount is a property of the high-level TIS protocol, that=20
> should not really care whether the low-level transfers are done via LPC=20
> or SPI (or I2C). Since tpm_tis_spi can only transfer 64 bytes at a time, =

> it is its job to split larger transfers (which it does perfectly fine).=20
> This also has the advantage that burstCount needs only to be read once,=20
> and then we can do 16 SPI transfers in a row to read that 1k of data.=20
> With your change, it will read 64 bytes, then read burstCount again,=20
> before reading the next 64 bytes and so on. This unnecessarily limits=20
> performance.
>=20
> Maybe you can describe the problem you're trying to solve in more=20
> detail, so that a better solution can be found, since this is clearly=20
> something not intended by the spec.

Right. The burst count we read from cr50 is never going to be larger
than max_xfer_size that we specify in the cr50 driver here, so this is
probably all useless and we can even drop the patch before this one that
adds support for this burst count capping feature.

