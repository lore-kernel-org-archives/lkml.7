Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B589EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8959421881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nN25bX7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbfHHQop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:44:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41548 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732572AbfHHQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:44:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so121199233ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdKChiO6toradfdA1i6Jwh7yiUgV/BOpjgptiTpJXTc=;
        b=nN25bX7pb6egOKBjU+l2ju89PKwN/5apoENIzX1yELI4kWtTHv02FC8vmZ5UY5HgdY
         N0hM9lnejemrdoHWz7YV2JwiOcYaVcO0RE4nBEwv8TFYoMqpzNn1u7FJpugxUj/FB+rB
         qpQ6yLSPsVmThmT5atHi74jQNdieykgqiXoGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdKChiO6toradfdA1i6Jwh7yiUgV/BOpjgptiTpJXTc=;
        b=Tk78oVCHPmX1EZMucv8fWCwUZva2YpQ0TLhowfZr4Qm2ToER98f8FPfXfhxYVQpt/9
         d1h4Bzg9fUXA3bS57wnfi9jZLuOZpgCtIaAA3tH/YE2lycdEE37XIK/2NZGY3La3zmqm
         7e/3CZEXuMyGAMyXmVBLVbYQAVTCcNe2isLfI5SutWUyAK9plMARSOaP9APB3eexlmkv
         TFFtoBE+X5TXnBFXLqZMo42WKO296bW9ddVtgTbygtVBibaKpl9qpWEP+1WbsdAd8niB
         1OvhhOz7DxD+PJjr+ZYMfonjgwpJbvtecyOuGjk+rMo5ksSRQnoTHfZmz0zJSAvoYDj7
         FYPg==
X-Gm-Message-State: APjAAAWAwp48cvWPkN4vzf7TZgnqkAFqbrshCaoMiNMHAGTY4svNdAUW
        meU209fgPPUqE57AmNlF82lRqnkJkgxsAESbAiU0DUPRqoQ=
X-Google-Smtp-Source: APXvYqzEoYGvoalYE9dVirABjTjcHh9LZvDh0CA4mUt+tKEDBTe88c3+j/qr32L9yYNNrYvPSZymRl+NG991z6cfJJI=
X-Received: by 2002:a02:c549:: with SMTP id g9mr17312340jaj.14.1565282683214;
 Thu, 08 Aug 2019 09:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806143457.GF475@lakrids.cambridge.arm.com> <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
 <20190807123807.GD54191@lakrids.cambridge.arm.com> <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
 <20190807164958.GA44765@lakrids.cambridge.arm.com> <CAJs_Fx71T=kJEgt28TWqzw+jOahSbLQynCg83+szQW7op4xBkQ@mail.gmail.com>
 <20190808075947.GE30308@lst.de>
In-Reply-To: <20190808075947.GE30308@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 8 Aug 2019 09:44:32 -0700
Message-ID: <CAJs_Fx5fJ31CsFODBgBbhcCvoxSX_D1NHDjQs4LtJ_0GwuxMVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 12:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 07, 2019 at 10:30:04AM -0700, Rob Clark wrote:
> > So, we do end up using GFP_HIGHUSER, which appears to get passed thru
> > when shmem gets to the point of actually allocating pages.. not sure
> > if that just ends up being a hint, or if it guarantees that we don't
> > get something in the linear map.
> >
> > (Bear with me while I "page" this all back in.. last time I dug thru
> > the shmem code was probably pre-armv8, or at least before I had any
> > armv8 hw)
>
> GFP_HIGHUSER basically just means that this is an allocation that could
> dip into highmem, in which case it would not have a kernel mapping.
> This can happen on arm + LPAE, but not on arm64.

Just a dumb question, but why is *all* memory in the linear map on
arm64?  It would seem useful to have a source of pages that is not in
the linear map.
I guess it is mapped as huge pages (or something larger than 4k pages)?

Any recommended reading to understand how/why the kernel address space
is setup the way it is (so I can ask fewer dumb questions)?

BR,
-R
