Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A835AC06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8158F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YIOBu6r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406228AbfFKRd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:33:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32917 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404408AbfFKRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:33:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id p4so9489436oti.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8nzla2nhdrhp+/IZCs1+OTgK//WXZgK4kNyZnUr2Po=;
        b=YIOBu6r/nImhIKSwlRcFGhLbbEem2jjbzfIQXh2YW0B/MeYaZ9NEnCchaYX1ftEUP7
         WXu0ggkj2bWy6Wv8GeH6ZODRSthNZKVorXwVQJzuc0+Ta+11fr0FamnTgyc3a0tuqp+2
         LL9xs08ntR78279L5hwL/2t4knnvPcLASo9js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8nzla2nhdrhp+/IZCs1+OTgK//WXZgK4kNyZnUr2Po=;
        b=T539OtNnhLfj0Kp4YwIh66MyqxpCZCBCRNd4hcHUVW7hgDsPkxwzjRjwFAmigPcTEy
         DVuFvtWa/9534CbyGz3gKSdpnZ5gvwruuEnSKFKuNfxaKnfbzuAHt6OzMDv4xAnogwXe
         gFrtIH9pEFGbEAf8cbGfI2NY+fAeWPpco1gX19Vt0nTdwIN0B0AY/BsatdegnFK6T3qI
         O50auU+F5j7xTXziWz7f+uQtp5k5Jps5PxTelgfAews9ujdz6drkKLAfTpjyUHPk+er5
         smSR3rGDk49spROr9ON0tkDYFx5+e7Fc7RTpUb0C/zzHfW1inNHnDNCW5pB1tT2VseI8
         +R+w==
X-Gm-Message-State: APjAAAVl/I1HKoKX7UdhbVRY+TeIUHbhAulN0pRmXQ+RruFoalDOLSd5
        Q7jBoHEQ/5DNVdB76KUu45Q0AIRoSYhIbOf4VNIXXg==
X-Google-Smtp-Source: APXvYqxnz+b1dgfxUNemPnCVMNQTkUC3TiOTKiiZdSO87P9fj+aapXwt3TlYybkYT6OHd+4V0lFC7SthgjCLuoxomAs=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr4008898otk.204.1560274407636;
 Tue, 11 Jun 2019 10:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <87k1dsjkdo.fsf@turtle.gmx.de> <20190611153656.GA5084@kroah.com>
In-Reply-To: <20190611153656.GA5084@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 11 Jun 2019 19:33:16 +0200
Message-ID: <CAKMK7uH_3P3pYkJ9Ua4hOFno5UiQ4p-rdWu9tPO75MxGCbyXSA@mail.gmail.com>
Subject: Re: Linux 5.1.9 build failure with CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Joachim <svenjoac@gmx.de>, stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 5:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jun 11, 2019 at 03:56:35PM +0200, Sven Joachim wrote:
> > Commit 1e07d63749 ("drm/nouveau: add kconfig option to turn off nouveau
> > legacy contexts. (v3)") has caused a build failure for me when I
> > actually tried that option (CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=n):
> >
> > ,----
> > | Kernel: arch/x86/boot/bzImage is ready  (#1)
> > |   Building modules, stage 2.
> > |   MODPOST 290 modules
> > | ERROR: "drm_legacy_mmap" [drivers/gpu/drm/nouveau/nouveau.ko] undefined!
> > | scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> > `----

Calling drm_legacy_mmap is definitely not a great idea. I think either
we need a custom patch to remove that out on older kernels, or maybe
even #ifdef if you want to be super paranoid about breaking stuff ...

> > Upstream does not have that problem, as commit bed2dd8421 ("drm/ttm:
> > Quick-test mmap offset in ttm_bo_mmap()") has removed the use of
> > drm_legacy_mmap from nouveau_ttm.c.  Unfortunately that commit does not
> > apply in 5.1.9.
> >
> > Most likely 4.19.50 and 4.14.125 are also affected, I haven't tested
> > them yet.
>
> They probably are.
>
> Should I just revert this patch in the stable tree, or add some other
> patch (like the one pointed out here, which seems an odd patch for
> stable...)

... or backport the above patch, that should be save to do too. Not
sure what stable folks prefer?
-Daniel

>
> thanks,
>
> greg k-h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
