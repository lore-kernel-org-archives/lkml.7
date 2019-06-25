Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C5C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36BF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561472767;
	bh=O6AXf/DyRDLOn9NPLCpej84UeR2WezCnkvp4XKyJzzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tae75iSNL0u9LL/Qe30QXQUU4mgaYr5yrkWhSGcaeh+E2QJkNnfVbQmSJUrUfEfRt
	 TowK/Q5b6pYH/IkFnAaG2t9Orpf7dZgcQCtQQYs3azjshScsFdLO93pLBVTfbhDxyF
	 wv6dT0yTzkL7l+3QB48jBY1F8nVAbElAtg9w+vvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfFYO0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYO0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:26:06 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57C52168B;
        Tue, 25 Jun 2019 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561472765;
        bh=O6AXf/DyRDLOn9NPLCpej84UeR2WezCnkvp4XKyJzzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KsuUk7mSNplqf8/tk2M9YTB9f40AKsvTVrOhUv0pB44x7j2CG4+vXw39YgKLqOT+/
         DTn2ZZUWWg7tHjemLZU4Du7R21PlxYeJWTdyMIBFmiT3wAJuaGfsHBXRCpBmEmPmq1
         9ANy6VV2Zi66L8UGvwgFsoqMaNuErhEjCjW/L/j0=
Received: by mail-qt1-f175.google.com with SMTP id d23so3213570qto.2;
        Tue, 25 Jun 2019 07:26:04 -0700 (PDT)
X-Gm-Message-State: APjAAAXuS/qyCYS3kOlNrZDCIRKCkA8NmLgOOHc1RYJ9xwI68VsrXN1c
        8QhJZKK3Nrk3cf6lG7S3WdBS/+M3pVNV/OpJbw==
X-Google-Smtp-Source: APXvYqxUTYLPlSnkrI0aZx53sOAqRFA18v5vioDTrIGFaeyy1WiJA6yC0931kiCv4v228poHZKovX+TYxFfLmkH2ync=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr63405459qve.148.1561472764055;
 Tue, 25 Jun 2019 07:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190624215649.8939-1-robh@kernel.org> <20190624215649.8939-11-robh@kernel.org>
 <CACRpkdYKE=zLJhmTeTWYGRCQNt3K8+rNNqsp5UDa2d31GG6Y2g@mail.gmail.com>
 <CAL_Jsq+uCMKhUFgCCK3uUetL9OwokQPaq74GJHQS2VS=UjVH8w@mail.gmail.com> <CACRpkdYnSZibUyhe5D8W259fCJBm05rG0_EmX+uoi=uqbrqEYA@mail.gmail.com>
In-Reply-To: <CACRpkdYnSZibUyhe5D8W259fCJBm05rG0_EmX+uoi=uqbrqEYA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Jun 2019 08:25:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+45dKRMdRCjfKgEkvsk1MLyeXnY4fjZmh50WLweyJfCg@mail.gmail.com>
Message-ID: <CAL_Jsq+45dKRMdRCjfKgEkvsk1MLyeXnY4fjZmh50WLweyJfCg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: display: Convert tpo,tpg110 panel
 to DT schema
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jun 25, 2019 at 12:47 AM Rob Herring <robh@kernel.org> wrote:
> > On Mon, Jun 24, 2019 at 4:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Mon, Jun 24, 2019 at 11:59 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > > Convert the tpo,tpg110 panel binding to DT schema.
> > > >
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Awesome, fixed up the MAINATINERS entry and applied and
> > > pushed for DRM next with my Reviewed-by.
> >
> > You shouldn't have because this is dependent on patch 2 and
> > panel-common.yaml. So now 'make dt_binding_check' is broken.
>
> Ooops easily happens when I am only adressee on this patch and
> there is no mention of any dependencies.

It's a series. I would assume the default is 1 person applies a series
unless explicitly stated otherwise.

> Can I simply just merge the panel-common patch as well and we
> are all happy?

I have drm-misc commit rights too, so I'll apply the whole lot when it's ready.

> I can also pick up more panel binding patches, IMO the yaml
> conversions are especially uncontroversial and should have low
> threshold for merging.

Yes, but the threshold is at least 'make dt_binding_check' should not
break. But don't worry, there are 2 other breakages in linux-next
currently.

Rob
