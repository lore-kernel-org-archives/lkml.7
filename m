Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D54AC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1042077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfHPRDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:03:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44982 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfHPRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:03:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so10133610ote.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auZ8XpIdeavGGYcqifHW/g6X9+XyC1kdBIzYdU4Zuv8=;
        b=ACMmC5hMOtt5+6yK2Im9u/kqfDwFL31qYoE+UT7DzRt2Wl+YgyuXICSo9qkUsXRle4
         xOcY7WeA5BaQdtLi4lK0YSCirltvwic3IsCZW+P08Y5jsEPWsTH1IdDIdJanK2gJf2rY
         i+wbcSvRMJBCP1ERWuwm6jAqrSArtForuIqJ4Qa2ZKmWUtq1yWnzvmufWe8NxlU5fkWA
         LXRax2lLjGCp2zvB/JvWiusMnuo0EqiW0MTHMed/+7whE2LhscVKmlerJDLFZRNuhqmG
         a3TO8Cxe9VzPOj/OyfoL1Eds0aXfSlhi6llF1JwWdEhpT0HtGuFyRHYMbfaOzNYKOhfI
         gm3g==
X-Gm-Message-State: APjAAAUr4qu1ooV8qYS87zcpiK5nFVMZLMxirTXqDJx/C3TDxCsRVhdN
        oRCYPUPbp5T7puw1SqZe9qYccGb5Tkw=
X-Google-Smtp-Source: APXvYqwZEBwjSp/dSsO2yA2zFZTsdvTaL8dsMEp6tYv8LQcWnNYs+zOubBwHu4vCyVIFtrS5Vu8nng==
X-Received: by 2002:a9d:6a89:: with SMTP id l9mr8418041otq.172.1565975009217;
        Fri, 16 Aug 2019 10:03:29 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id c5sm2279791otl.29.2019.08.16.10.03.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:03:28 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l12so5310809oil.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:03:28 -0700 (PDT)
X-Received: by 2002:aca:1a0e:: with SMTP id a14mr5475846oia.51.1565975008300;
 Fri, 16 Aug 2019 10:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
 <1562165800-30721-4-git-send-email-ioana.ciornei@nxp.com> <CADRPPNT9LGdMWuBcBnvWXhD8Q-qbTNOzbYp1dRrt0NXb2DBgDw@mail.gmail.com>
 <VE1PR04MB64636237CB3B1B2A93E0507786AF0@VE1PR04MB6463.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB64636237CB3B1B2A93E0507786AF0@VE1PR04MB6463.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 16 Aug 2019 12:03:16 -0500
X-Gmail-Original-Message-ID: <CADRPPNS5BEvFFWe2azOcdikDvLvsUQT03dRF-aahNnD7izPfsQ@mail.gmail.com>
Message-ID: <CADRPPNS5BEvFFWe2azOcdikDvLvsUQT03dRF-aahNnD7izPfsQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: fsl: FSL_MC_DPIO selects directly FSL_GUTS
To:     Roy Pledge <roy.pledge@nxp.com>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 9:59 AM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> On 8/15/2019 7:09 PM, Li Yang wrote:
> > On Wed, Jul 3, 2019 at 9:58 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
> >> Make FSL_MC_DPIO select directly FSL_GUTS. Without this change we could
> >> be in a situation where both FSL_MC_DPIO and SOC_BUS are enabled but
> >> FSL_GUTS is not.
> >>
> >> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> >> ---
> >>  drivers/soc/fsl/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> >> index b6804c04e96f..7e62c1d0aee7 100644
> >> --- a/drivers/soc/fsl/Kconfig
> >> +++ b/drivers/soc/fsl/Kconfig
> >> @@ -22,7 +22,7 @@ config FSL_GUTS
> >>  config FSL_MC_DPIO
> >>          tristate "QorIQ DPAA2 DPIO driver"
> >>          depends on FSL_MC_BUS
> >> -        select SOC_BUS
> >> +        select FSL_GUTS
> > NACK.  Although DPIO only exists on SoCs with the GUTS block for now.
> > There is no direct dependency between the two IPs.  I don't think we
> There isn't a hardware dependency but the DPIO driver does call
> soc_device_match().  If FSL_GUTS isn't present we can't distinguish
> which SoC is being used and the driver isn't able to setup the correct
> stashing destinations.  Is there another mechanism we should be using to
> get this information?

The build will still succeed if SOC_BUS is not defined.  The only
thing is you cannot get the SoC information.  If the driver is really
depending on the SoC information, it probably should "depends on
SOC_BUS" instead of "select SOC_BUS".  My understanding is that the
stashing is an optional performance optimization of DPIO and DPIO can
still be working with out it, right?  If that is the case, we probably
should do nothing here.  Or create another stashing related option to
"depends on SOC_BUS".

Regards,
Leo

> > should add this dependency to make FSL_GUTS not configurable.  Here is
> > some explaination from kernel documentation:
> >
> >         select should be used with care. select will force
> >         a symbol to a value without visiting the dependencies.
> >         By abusing select you are able to select a symbol FOO even
> >         if FOO depends on BAR that is not set.
> >         In general use select only for non-visible symbols
> >         (no prompts anywhere) and for symbols with no dependencies.
> >         That will limit the usefulness but on the other hand avoid
> >         the illegal configurations all over.
> >
> > We probably shouldn't let it select SOC_BUS either from the beginning,
> > as the basic feature of DPIO should still work without defining
> > SOC_BUS.
> >
> > Regards,
> > Leo
> >
> >>          help
> >>           Driver for the DPAA2 DPIO object.  A DPIO provides queue and
> >>           buffer management facilities for software to interact with
> >> --
> >> 1.9.1
> >>
>
