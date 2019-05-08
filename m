Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19180C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF10204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHartrG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfEHPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:51:22 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41734 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEHPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:51:22 -0400
Received: by mail-ua1-f65.google.com with SMTP id s30so7542951uas.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0+i9e5mIEn3rqSN9LgCUbC0Q8KXmle2bNSZz9uk/D0=;
        b=dHartrG0pnAxze09Q/OtM6IG1uxSV/PvDV9j0oxDlVKKb2h7aaldV397hX1Mq/x86e
         zwPrwM9sTsbPUgkg6dmMgn+4qgx+Bpio+OUc54RUBEcp+4qBLiA/e55Sw1L1KXOMz4x7
         S8RKLl7jH8js3Gyn95doc2ozC39rKeKL5orTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0+i9e5mIEn3rqSN9LgCUbC0Q8KXmle2bNSZz9uk/D0=;
        b=kaw/P3R/15nWV+f3G+C4W8uqjCJyLQ77101FazTuDtD1xx6h65YThgqS6bf2MJu/bI
         61YBKwcHcQTeQ2U9JGO2Pu7q+jqmV3vyqAXH4a5DFdAuu/i48goTbNKsLKQjt+CsnHTX
         h+dkTNp6PgFOuvHiNkyjzpkvrNOP+khdCpRCoR4KJ6hWffxwsX2fXgtR0eCeIQ1smcDK
         YGg6NGR/8CSCN1ft53Mxeogj2XCjPXemhVdnbUqalDHbRbb/62L0TdC2i6sPqJtzD3F9
         yrL2NtkRt+bi+A0X6tTlKpjzfMEETIvTR2FpcU5RlF07tEd4ASo505cf9gZiB41GrbGB
         KTog==
X-Gm-Message-State: APjAAAVLvGBmh8Nw2HbIh+H2lJ2f7qsMjh0c4ThrlGbCMhDx80pf913j
        KIskuaG48nBiAhnS+j28sOba2alruwk=
X-Google-Smtp-Source: APXvYqxJbWrXB3tgcBvCqu6FLRs/0bOqwc9kMnJWveJovV64W49g+HhegYEmAspHvH5K2htxK9TnAw==
X-Received: by 2002:ab0:4ad7:: with SMTP id t23mr7919647uae.63.1557330681342;
        Wed, 08 May 2019 08:51:21 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id o126sm3057758vsc.6.2019.05.08.08.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:51:20 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id c24so6067757vsp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:51:20 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr20090469vsc.20.1557330679806;
 Wed, 08 May 2019 08:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190507044801.250396-1-dianders@chromium.org>
 <a3573253-e3de-0a82-8af3-6bacea20bd97@gmail.com> <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
 <18324244-cca8-a836-5c2e-c626ca8771aa@gmail.com>
In-Reply-To: <18324244-cca8-a836-5c2e-c626ca8771aa@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 May 2019 08:51:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFNjvm9Swe_jRO1X3yn-OV596_4yhA9m_yD4Coq1qTWw@mail.gmail.com>
Message-ID: <CAD=FV=WFNjvm9Swe_jRO1X3yn-OV596_4yhA9m_yD4Coq1qTWw@mail.gmail.com>
Subject: Re: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 7, 2019 at 3:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/7/19 10:59 AM, Doug Anderson wrote:
> > Hi,
> >
> >
> > On Tue, May 7, 2019 at 10:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 5/6/19 9:48 PM, Douglas Anderson wrote:
> >>> We'll add a dummy to just return false.
> >>
> >> A more complete explanation of why this is needed please.
> >>
> >> My one guess would be compile testing of arch/sparc/kernel/prom_64.c
> >> fails???
> >
> > Ah, sorry.  Needed for:
> >
> > https://lkml.kernel.org/r/CAD=FV=Vxp-U7mZUNmAAOja5pt-8rZqPryEvwTg_Dv3ChuH_TrA@mail.gmail.com
>
> Got it.  I went and looked at that.  I think a better approach would be to
> check parent node not "/reserved-memory".  I am making this suggestion in
> that email thread.

OK.  Assuming that people are happy with that approach [1], we should
consider this patch abandoned.  Thanks for your reviews!

[1] https://lkml.kernel.org/r/20190508154832.241525-1-dianders@chromium.org

-Doug
