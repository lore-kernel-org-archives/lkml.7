Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560DBC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2406B21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kjoCNPk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391390AbfEXSMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:12:36 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52178 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfEXSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:12:35 -0400
Received: by mail-wm1-f52.google.com with SMTP id f10so2844747wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TLYdg3oHGqzqv4K2ZAz9J+M2UOea4Uk7MyQC23T2q1s=;
        b=kjoCNPk9VlZhrE39XO7cIcyE8n7+k/mnEEV8ZgMEe8KlkkYtUDVmpxDgV+KfAEtMse
         ZwieEqW7l+PvaiPGEh9AkYcRFZep/XqnU41tJfQDST1XcfV0hRHXoELnzAOHt643959S
         wcjVeWK6vd1iZ4N3gaEa/ePLt1C0CdWkUCu6BJ+16KjSKEHLntoskBsO3PAu7sZ38P1F
         n+mxFhm9L/kTX3T0jUcPoEeEPtxrlxCp3jjgXQKPplu5X4es+EdMr6EQz7bpy9Jj2sdy
         IZ95KlD+j3POmKeF+2xtfFOVvfTZeU6sxSg+l77oqziSlwgj3IqxP9uMhF8fVmRTlHqq
         mlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TLYdg3oHGqzqv4K2ZAz9J+M2UOea4Uk7MyQC23T2q1s=;
        b=e1TtP+vlNOnPG41XZDXhJNouZrhegpdMbEJdIDxauQE+ARPH4P16cWomLyNgdiKH6g
         DAFmwJampXrxxMKmr+z/IkdnPiOnkQCHzVqmCpz/LnD35cosKzQJSNqm/GvSEMUO2eaO
         EklYq79GZ2qq9Dp+1RyLoXJuiO2wyy707kxpiSDHrlOTL7qYoGQD349C2qBtxfRe5wp3
         3hvycDSzBAyrmMXGTud6FtlNKJ9teDp9LiUTH1cm5RDQUaNSbHLP1eJkWJ+PCOHYUSsn
         nFZP1tPlq1iJU+RL6GZ7rKDtzmBSR80rkd1Nb5W/TBkQhFeaTFKzkqjq5zftNpGI80tJ
         c03w==
X-Gm-Message-State: APjAAAUK+KlNHFPxDSjJIh6E6xEMP8TYqk8HB24h8CaDmIF5dgBCFR1L
        4J743w9iG+ghxy6R5G5ChHMfdw==
X-Google-Smtp-Source: APXvYqzuIcFRlOMoU/xAjY0kFO3p9TD7dWZFKSvsB1X51zMIoTDznINkHFR4oliNhZ3l2NoKpwLZeg==
X-Received: by 2002:a1c:254:: with SMTP id 81mr791770wmc.151.1558721552439;
        Fri, 24 May 2019 11:12:32 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x1sm4993488wrp.35.2019.05.24.11.12.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 11:12:31 -0700 (PDT)
Message-ID: <5795a73002f2c787b545308585f0437eb5aa2f72.camel@baylibre.com>
Subject: Re: [PATCH] clk: fix clock global name usage.
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        baylibre-upstreaming@groups.io
Date:   Fri, 24 May 2019 20:12:30 +0200
In-Reply-To: <20190524174454.8043420879@mail.kernel.org>
References: <20190524072745.27398-1-amergnat@baylibre.com>
         <20190524143355.5586D2133D@mail.kernel.org>
         <c89ecb6f328014ce22ae5d6c634e5337dbbf3ea2.camel@baylibre.com>
         <20190524174454.8043420879@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 10:44 -0700, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-05-24 08:00:08)
> > On Fri, 2019-05-24 at 07:33 -0700, Stephen Boyd wrote:
> > > Do you set the index to 0 in this clk's parent_data? We purposefully set
> > > the index to -1 in clk_core_populate_parent_map() so that the fw_name
> > > can be NULL but the index can be something >= 0 and then we'll use that
> > > to lookup the clk from DT. We need to support that combination.
> > > 
> > >         fw_name   |   index |  DT lookup?
> > >         ----------+---------+------------
> > >         NULL      |    >= 0 |     Y
> > >         NULL      |    -1   |     N

These two I understand

> > >         non-NULL  |    -1   |     ?

If fw_name is provided, you have everything you need to get the clock, why the ?

> > >         non-NULL  |    >= 0 |     Y

If both fw_name and index are provided, how do you perform the look up ? using
the index ? or the fw_name ? 

> > > 
> > > Maybe we should support the ? case, because right now it will fail to do
> > > the DT lookup when the index is -1.
> > 
> > Hi Stephen,
> > 
> > We are trying to migrate all meson clocks to the new parent structure.
> > There is a little quirk which forces us to continue to use legacy names
> > for a couple of clocks.
> > 
> > We heavily use static data which init everything to 0.
> > Here is an example:
> > 
> > static struct clk_regmap g12a_aoclk_cts_rtc_oscin = {
> > [...]
> >         .hw.init = &(struct clk_init_data){
> >                 .name = "g12a_ao_cts_rtc_oscin",
> >                 .ops = &clk_regmap_mux_ops,
> > -               .parent_names = (const char *[]){ "g12a_ao_32k_by_oscin",
> > -                                                 IN_PREFIX "ext_32k-0" },
> > +               .parent_data = (const struct clk_parent_data []) {
> > +                       { .name = "g12a_ao_32k_by_oscin" },
> > +                       { .fw_name = "ext-32k-0", },
> > +               },
> >                 .num_parents = 2,
> >                 .flags = CLK_SET_RATE_PARENT,
> >         },
> > };
> > 
> > With this, instead of taking name = "g12a_ao_32k_by_oscin" for entry #0
> > it takes DT names at index 0 which is not what we intended.
> > 
> > If I understand correctly we should put
> > +                       { .name = "g12a_ao_32k_by_oscin", index = -1, },
> > 
> > And would be alright ?
> 
> I don't understand why this wouldn't have a .fw_name or an .index >= 0,
> or both. Is there some reason why that isn't happening?

And now its me not following :)

In the case I presenting, I only defined the (legacy) name because that we want
to use. In another thread, I'll explain the particular problem that make us use
this legacy name, I just to dont want to over complicate this topic now.

> 
> > While I understand it, it is not very obvious or nice to look at.
> > Plus it is a bit weird that this -1 is required for .name and not .hw.
> 
> Sure. It can be better documented. Sorry it's not super obvious. I added
> this later in the series. We could have:
> 
> 	#define CLK_SKIP_FW_LOOKUP .index = -1
> 
> and then this would read as:
> 
>         { .name = "g12a_ao_32k_by_oscin", CLK_SKIP_FW_LOOKUP },

Sure but it is still a bit ugly and un-intuitive. If I only defined the legacy
name, it's pretty obvious that what I want to use ... I should not have to
insist :)

And again the fact that (legacy) .name is silently discarded if index is not
defined, but .hw or .fw_name are taken into account no matter what is not
consistent

> 
> > Do you think we could come up with a priority order which makes the first
> > example work ?
> 
> Maybe? I'm open to suggestions.
> 
> > Something like:
> > 
> > if (hw) {
> >         /* use pointer */
> > } else if (name) {
> >         /* use legacy global names */
> 
> I don't imagine we can get rid of legacy name for a long time, so this
> can't be in this order. Otherwise we'll try to lookup the legacy name
> before trying the DT lookup and suffer performance hits doing a big
> global search while also skipping the DT lookup that we want drivers to
> use if they're more modern.

You'll try to look up the legacy name only if it is defined, in which case you
know you this is what you want to use, so I don't see the penalty.  Unless ...

Are trying to support case where multiple fields among hw, name, fw_name, index
would be defined simultaneously ??

IMO, it would be weird and very confusing.

> 
> > } else if (fw_name) {
> >         /* use DT names */
> > } else if (index >= 0) 
> >         /* use DT index */
> > } else {
> >         return -EINVAL;
> > }
> > 
> > The last 2 clause could be removed if we make index an unsigned.
> > 
> 
> So just assign -1 to .index? I still think my patch may be needed if
> somehow the index is assigned to something less than 0 and the .fw_name
> is specified. I guess that's possible if the struct is on the stack, so
> we'll probably have to allow this combination.

Maybe it just solve the problem, I don't fully understand its implication. I
might need to try it, and see

> 

digressing a bit ...

I don't remember seeing the index field in the initial review of your series ?
what made you add this ?

Isn't it simpler to mandate the use of the clock-names property ? Referring to
the clock property by index is really weak and should discouraged IMO.


