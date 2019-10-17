Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA52BFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D68E20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407855AbfJQG7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:59:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44512 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392672AbfJQG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:59:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so1217015oie.11;
        Wed, 16 Oct 2019 23:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAM1QnlrpsM8TOCfZsHr08AYy86y8/SONo11Ddop3Cs=;
        b=b+FAQWEbTlLRU9rkE6MK+AnnO8lChnKASzG5hTShbua64pCKYitUUdUwt3Cmg2Fzel
         W8SYZCGE1qNsLfyt/LpxYcwaoBk1DFqT1++h0pw9Gn+CI0un7IFRQf60+p4pChvkfQGg
         2lLPb83vTqbRmt0g2ENd+Xvtsnt6zdlvuQkFAtAxvQ6hZuKD4l/kwNfA+KkuZj6tlN9L
         6QqNg9OgdyV1HruWECeCdIJQKxJrymOH3wbs98l3Un0zTYffDOOz0V2t0a0Ma7Esfai+
         CL4tYlxlhNgTobQc0mhyufVLpS/cfIqWY9SQXw4XuylNDwruCYv202++Tyc0xBtvD6J9
         Ft4A==
X-Gm-Message-State: APjAAAVmbURUHw9vH/C54Q2Ang5hzV0Z/1abHNyoXd2eH6dPmm9mFVFE
        L3ojn1j9URlUG2wpV1tjeDYmKhexaZRctpZBYOw=
X-Google-Smtp-Source: APXvYqwCWIWA46c9+2ibu2lu2wxMYclDxWIc7LElIoklo6xwtdbTkcmnF9WWwh63zDbG9fhts78KRSf4tfIJNtTn9/0=
X-Received: by 2002:aca:230c:: with SMTP id e12mr1755052oie.153.1571295577291;
 Wed, 16 Oct 2019 23:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191016143142.28854-1-geert+renesas@glider.be> <5da7a675.1c69fb81.a888.0911@mx.google.com>
In-Reply-To: <5da7a675.1c69fb81.a888.0911@mx.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Oct 2019 08:59:26 +0200
Message-ID: <CAMuHMdXnTOaM+4SUkzpYXNeFbJtaG_kRzFLJRhVPCVNcOUB0qA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: Use platform_get_irq_optional() for
 non-existing interrupt
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Oct 17, 2019 at 1:23 AM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Geert Uytterhoeven (2019-10-16 07:31:42)
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 9efae29722588a35..34da22f8b0660989 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -1121,7 +1121,7 @@ static void __init of_unittest_platform_populate(void)
> >                 np = of_find_node_by_path("/testcase-data/testcase-device2");
> >                 pdev = of_find_device_by_node(np);
> >                 unittest(pdev, "device 2 creation failed\n");
> > -               irq = platform_get_irq(pdev, 0);
> > +               irq = platform_get_irq_optional(pdev, 0);
> >                 unittest(irq < 0 && irq != -EPROBE_DEFER,
>
> This is a test to make sure that irq failure doesn't return probe defer.
> Do we want to silence the error message that we're expecting to see?

I think so.  We're not interested in error messages for expected failures,
only in error messages for unittest() failures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
