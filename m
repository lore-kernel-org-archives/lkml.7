Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D3C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68682083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G323DOy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfGRSHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:07:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38635 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:07:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so12984763pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=RfJJrqNKOzq6VDv125Le7JKqtC6afIuDcC8YnNoBhb4=;
        b=G323DOy8Qtdxgqnd7ouF0tWuJJet9oIDHekAC7buRtLAYXheqmYkHWkOylaZi0o7d2
         qo/89211ZPMF9WSjTsF43vMS2WPMhjTfwg6/4ihQSl+wBcSqAn9uSkfwwFi+RjQCnvLT
         8UxiRvPCD8ia8FvvqBcEDkSjbnWanlOwldmzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=RfJJrqNKOzq6VDv125Le7JKqtC6afIuDcC8YnNoBhb4=;
        b=MI8oxdeCE0O1R9WedWeN2RLJVeK6i0skFtVM0rEOFLF3zPKA5jpHtQLg0m+6E6T01X
         gltBbKKFU5/gcBn2XgdB0QqUJBYgHhiPZmgy/CfR6+px6a+mHR65R5xck/umu1ripchD
         D8Mmn7S2T+PnpLZutabjEv9T6xGHrlVOt+017FeoK9bMAGbb+K0PHpdnAjc+XtV78i01
         RVMLx5FQ3kmnBMuyNsEtZUTVUP1R1+k5tGShvrLNzNB7woKHTPHfz2sylJWmKw67h8Kz
         8gz/2QAkxYNKgGVPDEATa3rDi/6LPItZm2QdcJO5J+Dn/WMYorWRMtUHOzjJqO9rv3Oc
         vS6A==
X-Gm-Message-State: APjAAAWXGlHB2TmtqCEFq7Yh+1kQgO/FEFWOAgUkC44KUO6TMHy8YDLT
        n7Nl5G9JKIau0J++LVmHX/7NQg==
X-Google-Smtp-Source: APXvYqwm+2673851A87QEwYFYQPn7iAopuHOMaT0+cJdMe69eScqaIX4MdE7FGTTC71lBd2bhj+FAw==
X-Received: by 2002:a63:b919:: with SMTP id z25mr48637711pge.201.1563473256202;
        Thu, 18 Jul 2019 11:07:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o14sm26175175pjp.29.2019.07.18.11.07.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:07:35 -0700 (PDT)
Message-ID: <5d30b567.1c69fb81.e6308.74a2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 18 Jul 2019 11:07:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexander Steffen (2019-07-18 09:47:14)
> On 17.07.2019 21:57, Stephen Boyd wrote:
> >=20
> > I think the idea is to let users override the quality if they decide
> > that they don't want to use the default value specified in the driver.
>=20
> But isn't this something that applies to all TPMs, not only cr50? So=20
> shouldn't this parameter be added to one of the global modules (tpm?=20
> tpm_tis_core?) instead? Or do all low-level drivers (tpm_tis,=20
> tpm_tis_spi, ...) need this parameter to provide a consistent interface=20
> for the user?

Looking at commit 7a64c5597aa4 ("tpm: Allow tpm_tis drivers to set hwrng
quality.") I think all low-level drivers need to set the hwrng quality
somehow. I'm not sure how tpm_tis_spi will do that in general, but at
least for cr50 we have derived this quality number.

I can move this module parameter to tpm_tis_core.c, but then it will be
a global hwrng quality override for whatever tpm is registered through
tpm_tis_core instead of per-tpm driver. This is sort of a problem right
now too if we have two tpm_tis_spi devices. I can drop this parameter if
you want.

>=20
> >=20
> > Do you want me to describe something further?
> >=20
> >> For example, struct
> >> cr50_spi_phy contains both tx_buf and rx_buf, whereas tpm_tis_spi uses=
 a
> >> single iobuf, that is allocated via devm_kmalloc instead of being part
> >> of the struct. Maybe the difference matters, maybe not, who knows?
> >=20
> > Ok. Are you asking if this is a full-duplex SPI device?
>=20
> No, this was meant as an example for the previous question. As far as I=20
> understood it, cr50 is basically compliant to the spec implemented by=20
> tpm_tis_spi, but needs special handling in some cases. Therefore, I'd=20
> expect a driver for cr50 to look exactly like tpm_tis_spi except for the =

> special bits here and there. The way buffers are allocated within the=20
> driver is probably not something that should differ because of the TPM ch=
ip.
>=20

Ok.

