Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430ACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140FD21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbyPJZlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfJVG7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:59:22 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43986 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731023AbfJVG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:59:21 -0400
Received: by mail-vk1-f193.google.com with SMTP id i21so1301710vka.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48GsjoJkha+FkK4BjEpjxR+SeBNRB+aPyJf6ECBpNI8=;
        b=hbyPJZlxSdwm88myuhdtJEWIniVP1HiyEFgnExhI8LirSFCoAssFt32rZiA6ATyVm1
         RfPrjPXMTCjoAwM+OIdY+RZmtVg+qMxVFAFdE1sSNExUcHfa5QU/axOjkyW9NIhXAnMw
         12HfGq8+/d7D00ifWT3bp1gIIGhSCTcWH+AOmyLfDPf2pm+QQayGYH6BM5PnZcao+fGx
         EN2Ht1omTOCmgsUVR6YVT2YLw5ezM3kXz8KQFgXSzvnivqvBoEff2XKL34V5JzZ7ygvs
         6ovL3ZC5dP+zoCqhRdoblDoZCU9DAwv3bVwBcsq87BrFkpXHAkgA+4tHyuorekroJaA5
         kHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48GsjoJkha+FkK4BjEpjxR+SeBNRB+aPyJf6ECBpNI8=;
        b=IPPMIN80eeIeb4whjkJ2u59Rhq2ATtRJfsEfGQj7GxZCoaxaSHbc+M4pB7vJtMsbV/
         /zJXc0rM0jVv3bDaF5FvXahpJ9I9FjsEvNykVI1hVz5I4gkLfig6ZAxcMreC1P/Fah1+
         Mk77tPESjm2Ug/M3URZ09yzW/ruo5mGvZg3+CAI1Ha/CgUL6O2dnuz+vPE8+fPRhdxMc
         B4XpZmawITcRh96FJbK7UKfYKJmJ3aiG1D1C3FeS1O6CxmvAE7qo/wT/b5leLYeQgTYU
         kT+A6H+A8dj6qA0B3/12MJx3JLOe4MAw+yE7ll1fGwDLUNih6yZRdBj5+jTT2SDO+xnG
         3B2Q==
X-Gm-Message-State: APjAAAUReropq4Je9vPwPK3vlSfQAdf+KCetjiRZ6lIwFcNofnMtsbk0
        4ZKkEq/zuPX+LEWGZzo9lM8PQOhgjN+OZNru9l/XWA==
X-Google-Smtp-Source: APXvYqyQp/ZBzqbnbb99OA7AcxXgKHIl2AlPbDn895oCL9HPi5AEBH3Op7dbJ+nVlsWjQf3q2l3n/Tbcy8/XA0+cyS0=
X-Received: by 2002:a1f:a293:: with SMTP id l141mr1033147vke.43.1571727560670;
 Mon, 21 Oct 2019 23:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571510481.git.hns@goldelico.com> <9bd4c0bb0df26523d7f5265cdb06d86d63dafba8.1571510481.git.hns@goldelico.com>
 <20191021143008.GS5610@atomide.com> <3FDBE28F-B2C5-4EDE-905C-687F601462B6@goldelico.com>
 <20191021171104.GY5610@atomide.com>
In-Reply-To: <20191021171104.GY5610@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Oct 2019 08:58:44 +0200
Message-ID: <CAPDyKFryqo3wF-GphhytNqrDL4rbZ7Qou1Ki3e2_5w-yh2o=uw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] omap: remove old hsmmc.[ch] and in Makefile
To:     Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Trimmed cc-list (could be a good idea for next submission as well)

On Mon, 21 Oct 2019 at 19:11, Tony Lindgren <tony@atomide.com> wrote:
>
> * H. Nikolaus Schaller <hns@goldelico.com> [191021 17:08]:
> >
> > > Am 21.10.2019 um 16:30 schrieb Tony Lindgren <tony@atomide.com>:
> > >
> > > * H. Nikolaus Schaller <hns@goldelico.com> [191019 18:43]:
> > >> --- a/arch/arm/mach-omap2/Makefile
> > >> +++ b/arch/arm/mach-omap2/Makefile
> > >> @@ -216,7 +216,6 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)          += board-n8x0.o
> > >>
> > >> # Platform specific device init code
> > >>
> > >> -omap-hsmmc-$(CONFIG_MMC_OMAP_HS)  := hsmmc.o
> > >> obj-y                                      += $(omap-hsmmc-m) $(omap-hsmmc-y)
> > >
> > > The related obj-y line can go now too, right?
> >
> > Yes, I think so. It is a construction that I have never seen before :)
> > Therefore I did not recognize that it is related.
> >
> > > And looks like common.h also has struct omap2_hsmmc_info
> > > so maybe check by grepping for hsmmc_info to see it's gone.
> >
> > Yes, it is just a forward-declaration of the struct name with
> > no user anywhere.
> >
> > Scheduled for v3.
> >
> > BTW: should this series go through your tree since it is an
> > omap machine?
>
> Or MMC tree as that's where the code change really are.

I am okay with that. I will have a look at the series and provide some comments.

Kind regards
Uffe
