Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4A0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34112173E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558387415;
	bh=IW+5mHGpA0bgpHCzqQex+WHBWoSsXAFa4h82j6x+6vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hz6Go2O9DsigI2TAyrYEJRJSwSmDM67/XFSv1oMqBwy7zJ0BMtyEYeheyhCBZziq/
	 gGgi+qh3vJFhCXlqN1aKZiLBBbXoVP9UqN+vN0oSqqCkSmCJn96YpYi4/xIognfN8N
	 yAObjcGXbAyvxO+mWpQre6uiDLFLJU66oh0yu8W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfETVXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfETVXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:23:34 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A0321743;
        Mon, 20 May 2019 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558387413;
        bh=IW+5mHGpA0bgpHCzqQex+WHBWoSsXAFa4h82j6x+6vE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oTbHiOhQ5lsiGkc7xDnXPUpFW8zzXo0z1X/PDK/sjC2At7Yu4xVg7wCAAYnPwicNz
         EColuidx+DTG7SXkNxyLkC8LRtJa2HLGcHbq8fsFXMYSe3A/YSLywCy2Zb1aNVEmIE
         FDCg+QfaSkcAvax38MZe1b2tBgvyWFum5x7OstCA=
Received: by mail-qk1-f171.google.com with SMTP id g190so9747126qkf.8;
        Mon, 20 May 2019 14:23:33 -0700 (PDT)
X-Gm-Message-State: APjAAAVIXCfhyIPqTC3fMigUuIcOnuVJEEGxCEOasEjP19Ai/EIHp3Pr
        MsAkoVOMi1oFSPCs1ntM9REUNJJbDkknWE6VlQ==
X-Google-Smtp-Source: APXvYqziqsGRtOmZNok9nspJtGsXG8UlOp7PiuNHDbZmboo2ExW3i4G315yKYHlLbNvnYQT2SE9RX5ceKUG6BS08kmo=
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr52539989qkk.184.1558387412477;
 Mon, 20 May 2019 14:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190510194018.28206-1-robh@kernel.org> <20190520131846.tqx7h7sjyw6sgka5@flea>
 <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 May 2019 16:23:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAP85+KnQtq-xaOdX-BetB0pA7+LT8vd6w=Yz4VWnQJg@mail.gmail.com>
Message-ID: <CAL_JsqKAP85+KnQtq-xaOdX-BetB0pA7+LT8vd6w=Yz4VWnQJg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:35 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 20, 2019 at 8:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, May 10, 2019 at 02:40:18PM -0500, Rob Herring wrote:
> > > Convert the vendor prefix registry to a schema. This will enable checking
> > > that new vendor prefixes are added (in addition to the less than perfect
> > > checkpatch.pl check) and will also check against adding other prefixes
> > > which are not vendors.
> > >
> > > Converted vendor-prefixes.txt using the following sed script:
> > >
> > > sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > As vendor prefix updates come in via multiple trees, I plan to merge
> > > this before -rc1 to avoid cross tree conflicts.
> >
> > I just tried this with the 5.2-rc1 release, and this very
> > significantly slows down the validation.
> >
> > With a dtbs_check run on (arm's) sunxi_defconfig, on my core-i5 with 4
> > threads, I go from 1.30 minutes to more than 12.
>
> Indeed. 6 min to 45 min for allmodconfig. However, it's only 5 min to
> run checks with only this file. I'd expect a more linear hit. Maybe
> we're exceeding some cache size and thrashing.

Looks like the problem is a cache. The python regex cache. Changing
re._MAXCACHE from 512 to 4096 fixes the problem. I can set this in the
dtschema lib.

Rob
