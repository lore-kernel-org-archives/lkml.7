Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD5DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829282087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJUKQPS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392496AbfHBWcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:32:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34597 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392462AbfHBWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:32:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so36703472pfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=n5198bNj6xPak5lp58GNW9TiROyPem4hWkPcBo68qJw=;
        b=fJUKQPS4pUns/qKXB+E5BbeFgPkGidQpfEH8g6hM69aPN76Y1i67uQjOOeHi7lrYPo
         d3WKO/R9GPfN1KmGOxeAUoqQ55H5FFnoARVKVbO1GFDznbpI+vtlz706kJeP2LPv/jFa
         weroVvlRGLXE51CXD9p4jLERwtuQBpgfNSiOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=n5198bNj6xPak5lp58GNW9TiROyPem4hWkPcBo68qJw=;
        b=VOe7fNkt9pc1PicAoqgp7PO2t9jr8/aymtt0uwwTa5RztTBajORurcL6Xe9sNry/13
         70t1ie2Ma7z4e9209m8PZO8JtcQvJMfS6jSYOSDRVJEWSX+cSEJ1ZRkdE3eUSHGYUacj
         MJLMVRDLwUf9LNLLICcMdvrJxO7xck+FXmT7R8VpiwkeQhVAPSusRHz5fsoNY04WgEYF
         vCZ4RLf3EF0yNrhsKc+vt37TI7oQrqGPFxTjuLOJEBQmenWtSSfdWZfTRQKybNZ4MUWE
         eHbC4qOA7r/tSFWQ6JxEthsSoI8ewz/tjMg5/dBHoII29U7uRxsLvf0NCQWxE9mzyfI1
         7yBA==
X-Gm-Message-State: APjAAAW15JwMpgm83BHyjazXbvuJBjV7nunuzcX/yo54cPDWekTGAd0J
        skiMZF3WQo2IAdmVswEezRkYnw==
X-Google-Smtp-Source: APXvYqwfzXrcyiQxegqrN4/Tyx7c3hgH+H9yHvJhJCR5t6RjCTviiais+rAQt8xp6KJPksScapQpRQ==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr6096070pjs.55.1564785169042;
        Fri, 02 Aug 2019 15:32:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 4sm88158926pfc.92.2019.08.02.15.32.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 15:32:48 -0700 (PDT)
Message-ID: <5d44ba10.1c69fb81.a5654.3c8a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190802204318.5aktcn7xnvzcwvqj@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com> <20190802204318.5aktcn7xnvzcwvqj@linux.intel.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 15:32:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-02 13:43:18)
> On Thu, Jul 18, 2019 at 06:47:14PM +0200, Alexander Steffen wrote:
> > On 17.07.2019 21:57, Stephen Boyd wrote:
> > > Quoting Alexander Steffen (2019-07-17 05:00:06)
> > > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > > > From: Andrey Pronin <apronin@chromium.org>
> > > > >=20
> > > > > +static unsigned short rng_quality =3D 1022;
> > > > > +module_param(rng_quality, ushort, 0644);
> > > > > +MODULE_PARM_DESC(rng_quality,
> > > > > +              "Estimation of true entropy, in bits per 1024 bits=
.");
> > > >=20
> > > > What is the purpose of this parameter? None of the other TPM drivers
> > > > have it.
> > >=20
> > > I think the idea is to let users override the quality if they decide
> > > that they don't want to use the default value specified in the driver.
> >=20
> > But isn't this something that applies to all TPMs, not only cr50? So
> > shouldn't this parameter be added to one of the global modules (tpm?
> > tpm_tis_core?) instead? Or do all low-level drivers (tpm_tis, tpm_tis_s=
pi,
> > ...) need this parameter to provide a consistent interface for the user?
>=20
> This definitely something that is out of context of the patch set and
> thus must be removed from the patch set.

Ok. I've dropped this part of the patch.

