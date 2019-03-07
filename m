Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCA6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C76420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWMd6NRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCGUNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:13:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43758 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:13:42 -0500
Received: by mail-io1-f66.google.com with SMTP id y6so14706082ioq.10;
        Thu, 07 Mar 2019 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CxfmkaTe+SLFchAVeUhtfdbkP2N5yDM0YsbCbvNGTU=;
        b=dWMd6NRrstaNGu21WHTRqrsFdgeYfa7sJFHdmAUORtVW7V+OZM/o1DN4bZcXdKyXZq
         6i6P8Fac3p5xfyuOgaTLKMVsQdCCH9nQw1fRZ4lHjHmB2lKvndplcdrz79PgvpIgg+1v
         UGLTyALImWYXmivOGa+x/JIV1evpvJJ5vVrnVqWQwO+qJT/HJlxl17b7145FHLb5Kjkg
         iJYC6jCmAlqrBeF9Y6ASVy+Lyq6HIa7pJgLXA5x2FRGUnZMgyLN0YlGiI68d/6J+t3mw
         d33/ejQpbm4bsMni4Kc2Nf07n1mZy6RQQQnYh2Sqtgw+LkLPsia6xjCM4LHCLVg1XndF
         Q27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CxfmkaTe+SLFchAVeUhtfdbkP2N5yDM0YsbCbvNGTU=;
        b=bih37J6pe5I3DFMWGzc1C8QXsDH4qRInv5u+r0mpbMXCOIAv6aR+MkQaXWszi4o67z
         d2zAM2JXXdxVb58adCJlXVltB2PHACtulC2m10qErXerYHKpub7BHHoiS1ql7LrC/mx5
         OmgKmLP9pALNdV7rLZBXQXaE30c+PYTHG/9zMzfoJ7J4sBhRfn8d+nzPGIUycNdXxS2s
         yv/2riqb2fbCjsxk/W8lEYi1A5kxDl4tMstQQMNCxLie6ml/8SVXtNvekqUgHsVNf7iC
         jBvvAirMRjoVy5pv4Us41hW3qMmvtgZzDbQTd7XDGn41hEKtON63MXA8kjFNhXPBrseB
         rnVQ==
X-Gm-Message-State: APjAAAXg0ldHT+Z9CNQEJj5qGgIihCnhdNR/bu75ZJxpXqrDHwwZP8Gp
        mAi2Eza2ds+Qi8jwsY1m0j9YlFhaIa6ADMPMHj8=
X-Google-Smtp-Source: APXvYqw8BPO/C44mEMiguDrL1oklthAeMfMejkzweughPEBAuiHwDIYzov7HO3BQLZzlL7DV8WP+/bpMJ0rno9pv8U4=
X-Received: by 2002:a5d:8701:: with SMTP id u1mr7813573iom.69.1551989620631;
 Thu, 07 Mar 2019 12:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com> <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
In-Reply-To: <20180430092947.GC2270@ulmo>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 7 Mar 2019 14:13:29 -0600
Message-ID: <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 4:30 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Apr 30, 2018 at 11:03:25AM +0200, Linus Walleij wrote:
> > On Thu, Apr 19, 2018 at 5:14 PM, Grygorii Strashko
> > <grygorii.strashko@ti.com> wrote:
> > > On 04/19/2018 09:05 AM, Wolfram Sang wrote:
> > >>
> > >> We should get drvdata from struct device directly. Going via
> > >> platform_device is an unneeded step back and forth.
> > >>
> > >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >> ---
> > >>
> > >> Build tested only. buildbot is happy. Please apply individually.
> > >
> > >
> > > for gpio-omap.c:
> > > Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >
> > Hm I only see the responses not the actual patch, I guess I will find it
> > sooner or later.
> >
> > Wolfram: if I don't find it, poke me with something sharp so I get to apply it.
>
> I had the same problem, turned out this got classified as spam by Google
> for some reason. Maybe try your spam folder?

It's been almost a year later, and several Linux revisions, and this
still seems stuck somewhere/somehow.

adam
>
> Thierry
