Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB69C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CAF22CEA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jk4dW+/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfHSRKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:10:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfHSRKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:10:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so1250258plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=Q5LjT2ulgbJMIcnXziCS32ArOw8FLJpPq0N2+3+iSu4=;
        b=Jk4dW+/LwN6k/bNAcq0KPPAUpc24H3TC+TLKxUEQ3bhKuFr1oQ8S1aHZXN/CKrI0wV
         jZd2fO/fFAahPYk4qF+l0SQSdiE8VJGvaCKjTb6Fhwr6ZzF8ddomL3CF/aN2lzXAwHO3
         /X5T1v7JA4S55Jky3E+HExMyytOt3M4eKTuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=Q5LjT2ulgbJMIcnXziCS32ArOw8FLJpPq0N2+3+iSu4=;
        b=Ys/4OmCyShLDnkipXCteaOOq8UZcd7DxvxKbc/M3D1TmV396p4y7eLIBZdapz2RVTA
         0PP7z0kw2ev9aV3mMuaMj9JP65Y1hWD+vKWmSmRx5zn9c8HZYMAVGupyEYdQgfDvlq0+
         SBLnpDUMQGImg+Ig1/BagFilT8tfwD4lp1NOg4PIynOX++yFFZisih6aRHpTv7LVBX70
         I9ssKYom+FaeuaHtiCO6iWfR2VIJvEItXUpxawTy20EXQu7wWz7lKvWPvLC5//7Wapcc
         OielsqzDb07fYRBs+SnRZJqlQQOe7KnVeGA5R+qmvl7HqBFBt/PBllf1jbFMsrZNZjQZ
         FQ6g==
X-Gm-Message-State: APjAAAVis9Y+IMJLRMIdDxkaNic7cKx2Omz1b1pLuMBBXpicPCfF6FS2
        Uf1UQnEdSQv+yuTISfXpTdOfdg==
X-Google-Smtp-Source: APXvYqybFuJuc6ce88amVXBCJHbvICuLITkB68+9d3DrSh+8NFW3c8v3hvDLcMGBKhpBmHlYtNP5Lw==
X-Received: by 2002:a17:902:988d:: with SMTP id s13mr15192166plp.139.1566234609437;
        Mon, 19 Aug 2019 10:10:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z6sm25497112pgk.18.2019.08.19.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:10:08 -0700 (PDT)
Message-ID: <5d5ad7f0.1c69fb81.ebfc2.7e1d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819164005.evg35d2hcuslbnrj@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org> <20190812223622.73297-5-swboyd@chromium.org> <20190819164005.evg35d2hcuslbnrj@linux.intel.com>
Subject: Re: [PATCH v4 4/6] tpm: tpm_tis_spi: Export functionality to other drivers
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:10:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-19 09:40:05)
> On Mon, Aug 12, 2019 at 03:36:20PM -0700, Stephen Boyd wrote:
> > Export a new function, tpm_tis_spi_init(), and the associated
> > read/write/transfer APIs so that we can create variant drivers based on
> > the core functionality of this TPM SPI driver. Variant drivers can wrap
> > the tpm_tis_spi_phy struct with their own struct and override the
> > behavior of tpm_tis_spi_transfer() by supplying their own flow control
> > and pre-transfer hooks. This shares the most code between the core
> > driver and any variants that want to override certain behavior without
> > cluttering the core driver.
>=20
> I think this is adding way too much complexity for the purpose. We
> definitely do want this three layer architecture here.
>=20
> Instead there should be a single tpm_tis_spi driver that dynamically
> either TCG or CR50. I rather take some extra bytes in the LKM than
> the added complexity.
>=20

Ok. I had that patch originally[1]. Do you want me to resend that patch
and start review over from there?

[1] https://lkml.kernel.org/r/5d2f955d.1c69fb81.35877.7018@mx.google.com
