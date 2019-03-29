Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95287C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F57A20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abgA4ldZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfC2Rb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:31:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40704 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2Rb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:31:58 -0400
Received: by mail-it1-f194.google.com with SMTP id y63so5111814itb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CT1S4WF0PIybjWUgCPksx4RM1Wndcf68hwh+FEW6MXI=;
        b=abgA4ldZi3N3dPN71bFforMewAWVB1+KtCrRIXK33x0pZigw3We+wcKM2MeTKlbVov
         Oo4efh+1Q/9s+AjzpU+EUYx8JSNn1T/jk5JtayUN91+XFtt2spn+l0bIl6uJpk2rybbv
         IRCVUv9yzs5jHN5pzerQebb7tCA/oWWE0pI5wLFQEleCYl+ZgAlUii0FhCGPqUI4lgKP
         sNnwPD926dxTr780XbhWL6oyenFdSEYtKownpv3IEVRbsYkNyxsv+WoNo/o1lWex6Jg0
         O2OiQVLL2OK1ec7jp53TQajWh/n+4FSWlwKlnX3xLrNjmnH+/p8FnvGp9pAHMb3CF27w
         nL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CT1S4WF0PIybjWUgCPksx4RM1Wndcf68hwh+FEW6MXI=;
        b=BsVee9s28EJHEgm4T2nNhw9MJn3Cm2Lck7RoWwM/BvQ2tSabZOJjqgQUb2bZF0VXl4
         FxHRRB0a69G/P16cQrYH+ipC4xQqm/lfb1/OmH+4udejWjnOJY0oQsM9WBiBKRreIzJn
         Y6hfb1xqmAppfQPcw/LgyRa7RmKM/AtDDR7DtlX0G0ni3zrUY5Ox8OaYa2qVhDS8t2Dr
         PMB2KM8T+c2JJpOETzeEoJQH/D+maeBZb/Hbjzlhq/vllR+ADfpWmOF2w5CfTvlV0Hze
         nJOHCbQsVQpkE0hLGeIhHDjHtVvaMzBMA6i0SKsPINRGvGK57hYAVK8kNhBJH71floy1
         pc9w==
X-Gm-Message-State: APjAAAUHlwwu5QpAD8AdiE9heeUy3HJRXsPmfNiQeiwXCrPvKBKPAAf3
        +M3vraPtDqVk5Z+dKs2yAWicMifadqmSXysLF6lN3Q==
X-Google-Smtp-Source: APXvYqwZDaHtoEgwaQZKQCWm9v61QfGQhTZwtqSauDzO4SWQvc1ajeBDJO5nN3YH1UxEFW7O9l3FtuG1XWHJtI+GIbs=
X-Received: by 2002:a05:660c:346:: with SMTP id b6mr5126683itl.40.1553880717087;
 Fri, 29 Mar 2019 10:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190328235752.334462-1-tmaimon77@gmail.com> <367707d3-9f3f-e15b-1db3-eedb2e23981d@codeaurora.org>
In-Reply-To: <367707d3-9f3f-e15b-1db3-eedb2e23981d@codeaurora.org>
From:   Benjamin Fair <benjaminfair@google.com>
Date:   Fri, 29 Mar 2019 10:31:20 -0700
Message-ID: <CADKL2t6yRietvA5QrAroLxNOKYaS17k=sEjZXtVGCJZ43x_0jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: fix bad pattern in ARM/NUVOTON NPCM
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, joe@perches.com,
        avifishman70@gmail.com, Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Tali Perry <tali.perry1@gmail.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 7:07 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 3/29/2019 5:27 AM, Tomer Maimon wrote:
> > In the process of upstreaming architecture support for ARM/NUVOTON NPCM
> > include/dt-bindings/clock/nuvoton,npcm7xx-clks.h was renamed
> > include/dt-bindings/clock/nuvoton,npcm7xx-clock.h without updating
> > MAINTAINERS. This updates the MAINTAINERS pattern to match the new name
> > of this file.
> >
> > Fixes: 6a498e06ba22 ("MAINTAINERS: Add entry for the Nuvoton NPCM architecture")
> > Reported-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>

Reviewed-by: Benjamin Fair <benjaminfair@google.com>

> Cheers,
> -Mukesh
>
> > ---
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e5a5d263f29..8b305d2f2a8a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1900,7 +1900,7 @@ L:      openbmc@lists.ozlabs.org (moderated for non-subscribers)
> >   S:  Supported
> >   F:  arch/arm/mach-npcm/
> >   F:  arch/arm/boot/dts/nuvoton-npcm*
> > -F:   include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> > +F:   include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> >   F:  drivers/*/*npcm*
> >   F:  Documentation/devicetree/bindings/*/*npcm*
> >   F:  Documentation/devicetree/bindings/*/*/*npcm*
