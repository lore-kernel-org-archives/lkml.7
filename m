Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B96C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F462082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KE53O3Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEFRll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:41:41 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37952 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEFRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:41:41 -0400
Received: by mail-vs1-f68.google.com with SMTP id v9so868222vse.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dH/alIcSKffA1y2RRlZpvtM5MZ4euuymjniYCSBueNk=;
        b=KE53O3Y8F/GfFN+9A4pCqL+PxAzhiCWWW4PA5x7wEj5ThydBOQWLySloLsIj1r94/l
         jge3nd+TBY5mcxaVry8MdgIBTFR2FuPHrxJ2jWnfa90EasrHNeOepJlAzznWKOeQGtwp
         uuOmngpZD6le8N8O0uiBiOjnOAbTxdVZCjHZhGQDixeIoy/oBSc/IZVKAP4q9xRSgg4W
         cUXcmYsQtJJhZJEVvqptHnyfSqCp/zwykrlrE7OYpCm71Ir/uOeR9h2ctg04s8FvQOGj
         /J/1gmdLZMW7oe6cJGAIaivR3YgmhWlYZggjlPgl2s03vtClNZzBgwj3R66mWkF75Zxz
         4Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dH/alIcSKffA1y2RRlZpvtM5MZ4euuymjniYCSBueNk=;
        b=OgpLw63fMSsWV3WlOrbKKFAWCph9SR6oI1HTUYV+XYuqHTfMs39LbyRI9FVi05K1EN
         bn57ch7AORYLOqC4V9JFlsncvy9evNSp77DxTyLKPDDdn7FIrKxBMUB/V/TGzMrPRL15
         ejpz/pVtAiq+ctWahMd9OHDGHMhFZ+sPpMJLW9ft0LXQLDGsMO1UTWX565vTJht4mTrU
         rwKNc9TtlJip9KgMparSNT/2buuzCvrkArE1M4brjRk3v16EMGkUuSktT2Et6nV3JG4Y
         5PnwswUGeXCCBWHQsRenhDl7nViSNyjo6lia/U04KFaZKy8UrYK7BbQDW5Elsn1CFRII
         r/9g==
X-Gm-Message-State: APjAAAWawP+Jf0ufpcxjo2DPkn2mGj/SBBBx4+m1ILCxU5bQaOMnvl+L
        CMNmxwmfsR1KkNUDTph7R7I4F/Sh0WAHv94cEUE5VA==
X-Google-Smtp-Source: APXvYqxyqvGFoX7WBWffNIKwJK+F9jk9BgOypI6lRO8xNum7HGbXRziLtoNK+1GxA8rZtYpvDoC6d7TT7WItEsI3tAo=
X-Received: by 2002:a67:e9d0:: with SMTP id q16mr14654015vso.178.1557164500244;
 Mon, 06 May 2019 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
 <1557147240-29551-2-git-send-email-sagar.kadam@sifive.com> <20190506131919.GC15291@lunn.ch>
In-Reply-To: <20190506131919.GC15291@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 6 May 2019 23:11:25 +0530
Message-ID: <CAARK3H=fY=Y9GDR-t6RLBV4wOEduPD++F5NKAayNGeuHudrtew@mail.gmail.com>
Subject: Re: [PATCH v1 v1 1/3] dt-bindings: i2c: add documentation for adding
 SiFive I2C driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, peter@korsgaard.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 6:49 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 06, 2019 at 06:23:58PM +0530, Sagar Shrikant Kadam wrote:
> > Add DT binding for OpenCore's based i2c device as found in
> > FU540 Chipset on HiFive Unleashed Platform (Rev A00).
> >
> > The doc explains, how to add DT support for I2C devices.
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  .../devicetree/bindings/i2c/i2c-sifive.txt         | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sifive.txt
>
> Hi Sagar
>
> Please extend the existing i2c-ocores.txt file, not add a new file.

Hi Andrew,
Thanks for your review.
Yes I will extend the i2c-ocores.txt to support sifive devices, and
will submit a v2 of this patch.

>
>        Andrew
