Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EC2C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9E2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F/ZB6ORa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfFNSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:13:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40159 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfFNSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:13:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so1910972pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:subject:cc:user-agent:date;
        bh=ZLVDWUWwWY4MpQ/fxABhQErt5/T/sQKzxrLl0+83gd0=;
        b=F/ZB6ORavFWyfK9TSla7/HqOfq2c2l0pz5qJuy3jEPcr17gJLZgyiFcEiReWczZ4bi
         f9ONz8SUO9N76h1XRciw/qHw+mWnSHHTiG9dg/RyWE2MMARvWcv+Dn6aEfA+HuZpomSK
         p3L4+/pudF2hA5CGZXA3FcqShuGYAY3jI5KKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:subject:cc
         :user-agent:date;
        bh=ZLVDWUWwWY4MpQ/fxABhQErt5/T/sQKzxrLl0+83gd0=;
        b=IKgQUm6xvalwUSFC2NfyY5uX8Otb45TtFnbqe5Pb3H//cQs+ONJLXWFZkC49O6qQnL
         zuMqQhwhZnaEWcyv7+N7Sozo8rye3tYq3y91L17TgSEuyvLIL2F35N27e8ltK9lyizWJ
         sirnNMGHZ/u2U5N4dQnLSJt7ny/gd+RIw2me1kcJb93gw7rnjnNXwYzk6K8HYP29qrQL
         1LPIgPYoZ/fdc0+/0ytxGD5tAQicuR07v4NxvJKAWgdyGa2rHXZf05mp04XzwONZ9HvE
         l/judbYbtGlQsDTbxg70YhDgAY9lFj3QfO+s0wTZWFR42kyJOzWjcIwdIw+PlxILTVO1
         4+vQ==
X-Gm-Message-State: APjAAAXXCsMhvMvcCvAcZNhTua0tJXb8aOMOZK0YdTVqn0+DAIVCgCmx
        IRwRyPJWybhADXheCV9LAbCOtQ==
X-Google-Smtp-Source: APXvYqwhGwL7yshptV+gRwCd63XpWKvE0KUQQrTCSKiIt6r0u4yc69kfnzZn5k0V6NZrfaFRfW4W1Q==
X-Received: by 2002:a63:e44c:: with SMTP id i12mr11731959pgk.297.1560535994544;
        Fri, 14 Jun 2019 11:13:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e22sm3590678pgb.9.2019.06.14.11.13.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:13:14 -0700 (PDT)
Message-ID: <5d03e3ba.1c69fb81.9c2c8.aa89@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190614152700.GE11241@linux.intel.com>
References: <20190613180931.65445-1-swboyd@chromium.org> <20190613180931.65445-2-swboyd@chromium.org> <20190614152700.GE11241@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 14 Jun 2019 11:13:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-06-14 08:27:00)
> On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 1b5436b213a2..48df005228d0 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -132,6 +132,8 @@ struct tpm_chip {
> >       int dev_num;            /* /dev/tpm# */
> >       unsigned long is_open;  /* only one allowed */
> > =20
> > +     unsigned long is_suspended;
> > +
> >       char hwrng_name[64];
> >       struct hwrng hwrng;
>=20
> I think it would better idea to have a bitmask of some sort that
> would have bits for 'open' and 'suspended'.
>=20

Sure. I can combine is_open and is_suspended into some sort of 'unsigned
long flags' member and then have #define TPM_IS_OPEN 0 and #define
TPM_IS_SUSPENDED 1 defines?

