Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB041C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814272183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGnVSxMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbfDQVEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:04:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37153 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDQVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:04:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so29072919qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMvCLLPuHIJPFph8nAmRu4Afmjf/cYzOLw7OI1YqNl8=;
        b=fGnVSxMDz02OLNjluENax9RtpNEjDeiUw3we+ejR8xudyRjAc6LYO4hvx0fvvvHgDT
         3bBFR7r9b4Rtn8K07gj7PAAO12xVCF/tOt0mnguv9B0M8gvEESWCRmuKMoSZesslR1P+
         UFaGgsClMQZMAiwvwIni0g3/SmWpF5N5T+/FKYF3ysrdtSWLDzxw6PteL8z7FGAS/qra
         ZbtgB1SjRxeVH3FDDv9pV9rGkMCqbMkIOmmUBYshVC0CaqduBUQNGtoqAP42M9t7/Gux
         mpSycJsqJoo3aB3MjP6iF41nRUYOfnk4tWoDy16CF8Cq4VEpOOg3TzXvga+X7k8Zv/6U
         Cr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMvCLLPuHIJPFph8nAmRu4Afmjf/cYzOLw7OI1YqNl8=;
        b=Jprqmo03H5XCY8StJtWvTCVJMLBhOeBsBAlMga7RUuz2VpS8sJJvIwMfTvUm74A+qb
         c5CJHPpexdK48FC60rR8UBZ8QU2nI2W6he6vDBUWJ0wOynT14R8MSmRBoRlVGpHRZOwq
         kqtffKQMZ2WY9jtv+ULW4n7jLVHXcLUth498fxn9Kz2j0WfGmcEADzkk4tsWNpiXeuT1
         Dvevaa3hET8S6sJm86bPg2E3G+vhFnsmJMY9KsLy1q2Hhy+KJducrn2Gt1eCyDGRm/uC
         eOJ3PFRXHi8jwiRlXoWbqdec8MiMLLV+nQjrdXhqWX1yMvrKQO2BmiMZkmfg1VdSxhyq
         po4Q==
X-Gm-Message-State: APjAAAUJJWSqHd0HPlo8X1w5qyZE2SRhzpCU0MKPNFXIuyhJ0NVTEjqn
        hVNQNEzu2p07aNixmnxYSYAwL+0n/znWtr70j9+9/Q==
X-Google-Smtp-Source: APXvYqw2RfjdEhmqmmLtUr4eDaogduzccU/0AS8RecOlzKJBJDwbJRc2tuumRkmv+oH+XjL5L1BFvfplT3hDFKUTBv0=
X-Received: by 2002:aed:2b87:: with SMTP id e7mr54876157qtd.190.1555535058596;
 Wed, 17 Apr 2019 14:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181124200628.24393-1-masneyb@onstation.org> <CACRpkdYqxUJKZGHGX0qPVaSVW4vzHYBMp-FARA2uP85W9AX5wA@mail.gmail.com>
 <20190320091727.GA13882@basecamp>
In-Reply-To: <20190320091727.GA13882@basecamp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Apr 2019 23:04:05 +0200
Message-ID: <CACRpkdbc97ypN0D=HH=J6m=wUQq2mGJO16Eit_nUTFH2FUrQEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/panel: simple: add lg,acx467akm-7 panel
To:     Brian Masney <masneyb@onstation.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:17 AM Brian Masney <masneyb@onstation.org> wrote=
:
> On Tue, Mar 05, 2019 at 11:42:15PM +0100, Linus Walleij wrote:
> > On Sat, Nov 24, 2018 at 9:06 PM Brian Masney <masneyb@onstation.org> wr=
ote:
> >
> > > Add binding for the LG ACX467AKM-7 4.95" 1080=C3=971920 LCD panel tha=
t is
> > > found on the LG Nexus 5 (hammerhead) phone. This appears to be a JDI
> > > panel based on some Internet searches, however a specific model numbe=
r
> > > could not be found. I disassembled an old Nexus 5 with a broken
> > > screen and the LG part number is the only model number present on the
> > > back of the panel, so I think that is probably the best ID to use.
> > >
> > > Signed-off-by: Brian Masney <masneyb@onstation.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Tell me if you need me to merge this to the DRM misc tree.
>
> It would be great if you could take this patch, plus the corresponding
> change to panel-simple.c [1]
>
> [1] https://lore.kernel.org/lkml/20181124200628.24393-2-masneyb@onstation=
.org/

Both patches applied to drm-misc-next (will be in v5.2). Sorry for taking s=
o
long, I had some urgent other priorities.

Yours,
Linus Walleij
