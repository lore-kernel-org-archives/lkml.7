Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA768C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72B421743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8q8WGxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfGQRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:22:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44954 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfGQRWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:22:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so11147431pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=l2ulz+HEZ33TLtGD0gtyTHpRn0lM8VKKeKFHaHpL698=;
        b=Y8q8WGxHQQll47oGZMGDyQeU9t4dUPA+MBl5AUYiBoRR/gNrknxYpikGgCHTVq8WA6
         iFKJS7m79cR/x0ODwjsBeAGh11f2A8JJ3glgAg7yT9UXyUlRJwPbXftAvjnAFx/nEBn/
         REQVFCLRerodwlpY2V4mzgpjgU1C3OjDrwW00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=l2ulz+HEZ33TLtGD0gtyTHpRn0lM8VKKeKFHaHpL698=;
        b=TDZkB9+pfkR/XbmG2d2W4WsH8BBxc9Znp76qiDqs5BaL3YkBU4wXzQXBku165wl2NC
         phnf9CAWOf3G5FDPNro2ffIXG7A9u0md25L4xK62YRB73ANykHrliju4ofMuicxp+IVB
         0Uz2uPmmeyEjLwOXxivG3/nsXsNaxS8p3Qige+xjDTyLh3y3roNT1maQDMwyWteBDawW
         Hjg9TrhcfV/ejSgpWfbv0rlQydeLARNXMCVBNkOPhYidu1MLEbknhkC6iGdlmRYu5cE/
         2TwBMh64ztHT/b5eM3u58bf61BsqmbGnXmGCqcEzlmhBwXpCZ7mbWP92f5feV7A5vyKR
         uz5g==
X-Gm-Message-State: APjAAAW6OGXsA9esRomN+ZPB3EXQnp9/FoqbcSpPYETtcyw0dtLzE9/r
        9MZJ3M/dIve0mqHlGEK6yPaUCg==
X-Google-Smtp-Source: APXvYqyWQKoNBIXLCon0D7eQpNio5dhXZcv2k6RF9k4MMwut6x0yKBuJ5c1e1zhHJI+aGoqMy60GIg==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr43006226pgh.149.1563384142245;
        Wed, 17 Jul 2019 10:22:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f12sm22308136pgo.85.2019.07.17.10.22.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:22:21 -0700 (PDT)
Message-ID: <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717171216.GK12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca> <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com> <20190717165628.GJ12119@ziepe.ca> <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com> <20190717171216.GK12119@ziepe.ca>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 10:22:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> >=20
> > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > holds almost nothing at all when the two drivers are modules.
>=20
> I'm not sure it is an actual savings, there is alot of minimum
> overhead and alignment to have a module in the first place.
>=20

Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
symbol. A module has overhead that is not necessary for these little
helpers.

