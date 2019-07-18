Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2679C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473B9217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FO34q6ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfGRSLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:11:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37157 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:11:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so12984241pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=Oi/2nSCZl5jDAyx1D0V8Sj3D1U9nmMvuGs/3txN4dLs=;
        b=FO34q6uaLm8zMLwroznowA90kyY++czA2WHQyfaV6mnFjf5jGTFt08+9o3lcflz51w
         CbSuz9XwblHT6uHyAlDWGJkWmLmlqahDMTRbZYp5mhhtX3q62nkwkuuQixIQKnE1MeS+
         0Di5Gc3s2khA32/6ABJgAZIn0GoG21hfmCrNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=Oi/2nSCZl5jDAyx1D0V8Sj3D1U9nmMvuGs/3txN4dLs=;
        b=AtnLjNwou6814nIwKq0QrqbNJdISHcSXXhDqPDtuSE27MMwNlBz9np2AhHuuixkvol
         zY3B2t7fNsLKx07avPGcmR8e9pmDezhQlqXEHglenyUOjuzlkFh0tuChveNgHWllpmNh
         gBxWCbho0ea6IlK9w3QdbD/UqESAYs2PT09yIDrI0T9JPHSV8r3OAmYXb2VBGQ64fnjb
         bHEqidKRfhWqD3itUaRQ9qMMpeOmAt0sReAqgsPBHa5z08d6DgEb7KLD8JOtvXMA8MBG
         fKZB3EP6sdfZAFtjLsxkBpSbmXmDOKxvwEd57aFMNVKiU8bUJIW8C0+LeZq+G1LnnwxT
         vaOQ==
X-Gm-Message-State: APjAAAUxZWhoXYoSsIoT6sNHMd3bZ5Z+/fAJRzDjkAp17u6i9RVCp4Xo
        UA7KoPHN8IyxR+SRa60+OvUZzQ==
X-Google-Smtp-Source: APXvYqzc2W0dJuZWhL96do1jYvmcyY4eFtxD6hnBLu62vFihqIE/+ygYbrFC5jZvdYvepduXEJyOPQ==
X-Received: by 2002:a63:d944:: with SMTP id e4mr48646810pgj.261.1563473482422;
        Thu, 18 Jul 2019 11:11:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm35259648pfn.177.2019.07.18.11.11.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:11:21 -0700 (PDT)
Message-ID: <5d30b649.1c69fb81.f440e.9a0a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <5d2f955d.1c69fb81.35877.7018@mx.google.com> <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
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
Date:   Thu, 18 Jul 2019 11:11:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexander Steffen (2019-07-18 09:47:22)
> On 17.07.2019 23:38, Stephen Boyd wrote:
> > Quoting Stephen Boyd (2019-07-17 12:57:34)
> >> Quoting Alexander Steffen (2019-07-17 05:00:06)
> >>>
> >>> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping
> >>> tpm_tis_spi, so that it can intercept the calls, execute the addition=
al
> >>> actions (like waking up the device), but then let tpm_tis_spi do the
> >>> common work?
> >>>
> >>
> >> I suppose the read{16,32} and write32 functions could be reused. I'm n=
ot
> >> sure how great it will be if we combine these two drivers, but I can
> >> give it a try today and see how it looks.
> >>
> >=20
> > Here's the patch. I haven't tested it besides compile testing.

The code seems to work but I haven't done any extensive testing besides
making sure that the TPM responds to pcr reads and some commands like
reading random numbers.

>=20
> Thanks for providing this. Makes it much easier to see what the actual=20
> differences between the devices are.
>=20
> Do we have a general policy on how to support devices that are very=20
> similar but need special handling in some places? Not duplicating the=20
> whole driver just to change a few things definitely seems like an=20
> improvement (and has already been done in the past, as with=20
> TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to=20
> tpm_tis_spi.c? Or is there some way to keep a clearer separation,=20
> especially when (in the future) we have multiple devices that all have=20
> their own set of deviations from the spec?
>=20

If you have any ideas on how to do it please let me know. At this point,
I'd prefer if the maintainers could provide direction on what they want.

