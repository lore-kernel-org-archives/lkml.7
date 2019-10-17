Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE95FECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C1C214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571316689;
	bh=sQ+DxCGeQ0mlvpyLnb6FadsDNvc+04AsUqn6blWWlhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zYYWZAD3ddjCocwx0eUjY/o9NLtbuAknmJinqeoWOgZvWjzHrwRCaIV9lWDqjUiGh
	 onaspEaZLSr8g2PQxoDHMTEfxkWkmm2y0HUrvNNfCLh38vLzjG5RsJcvw+EVVXEUrA
	 n/8wvfIny87Oapdg5lRutYpXWCcQpjvS85W5/nz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfJQMv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJQMv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:51:27 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236C721848;
        Thu, 17 Oct 2019 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571316687;
        bh=sQ+DxCGeQ0mlvpyLnb6FadsDNvc+04AsUqn6blWWlhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcSb9ggiRnsWdJzZWetrsxQE3tf92CUwKRmF279d7iYyoX/ufnROXGUEId611zn5Z
         XodmZEPYum1dM8lqkp1amZwCRyM/C+y3WJM+cgO2Hm43jYddkhAAEyNVz2b2j+588W
         mNF3xIza28G0eaoa/GNM3l96aCWMF0/zdFsqgz6U=
Received: by mail-qt1-f178.google.com with SMTP id 3so3400815qta.1;
        Thu, 17 Oct 2019 05:51:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXRaOWQwVWNd6EQ3Dbu7+XGpFOBoLkNcYPxv/bbRVOBjuF8mZ9U
        aPMpr9xjLKrlWinjvNRYXEJjFO2FoAINtvPjMg==
X-Google-Smtp-Source: APXvYqxeW2IAd2AP8ZW5RbDgGYwFwbonLP6xTHncsjhCwxYv4tAD340Bpzn3T1H3yN6DoLcGfukIvZB8a5TJ6hqbegM=
X-Received: by 2002:a0c:ed4f:: with SMTP id v15mr3435333qvq.136.1571316686182;
 Thu, 17 Oct 2019 05:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191016143142.28854-1-geert+renesas@glider.be>
 <5da7a675.1c69fb81.a888.0911@mx.google.com> <CAMuHMdXnTOaM+4SUkzpYXNeFbJtaG_kRzFLJRhVPCVNcOUB0qA@mail.gmail.com>
In-Reply-To: <CAMuHMdXnTOaM+4SUkzpYXNeFbJtaG_kRzFLJRhVPCVNcOUB0qA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Oct 2019 07:51:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL9YPowxntVPax868hi+sN3vgCa2aSSySzjg==--c7aDA@mail.gmail.com>
Message-ID: <CAL_JsqL9YPowxntVPax868hi+sN3vgCa2aSSySzjg==--c7aDA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: Use platform_get_irq_optional() for
 non-existing interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 1:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Stephen,
>
> On Thu, Oct 17, 2019 at 1:23 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Geert Uytterhoeven (2019-10-16 07:31:42)
> > > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > index 9efae29722588a35..34da22f8b0660989 100644
> > > --- a/drivers/of/unittest.c
> > > +++ b/drivers/of/unittest.c
> > > @@ -1121,7 +1121,7 @@ static void __init of_unittest_platform_populate(void)
> > >                 np = of_find_node_by_path("/testcase-data/testcase-device2");
> > >                 pdev = of_find_device_by_node(np);
> > >                 unittest(pdev, "device 2 creation failed\n");
> > > -               irq = platform_get_irq(pdev, 0);
> > > +               irq = platform_get_irq_optional(pdev, 0);
> > >                 unittest(irq < 0 && irq != -EPROBE_DEFER,
> >
> > This is a test to make sure that irq failure doesn't return probe defer.
> > Do we want to silence the error message that we're expecting to see?
>
> I think so.  We're not interested in error messages for expected failures,
> only in error messages for unittest() failures.

The unittests start with a warning that error messages will be seen.
OTOH, we didn't get a message here before.

Rob
