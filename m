Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8460C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E354206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5c8EusF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFTU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:29:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34540 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfFTU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:29:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so2316640pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JEFir2f91v73nekkwcA/r3dp6L112/g4gH1PpqAdrc=;
        b=v5c8EusF9ITFTP4DK08HqE6nXYSl1rHuc1AHqHehPJx12PE3Zc2nHCkX/AWSdZ6FZF
         nQmrtwYX9mvK74iIh/t7AJdwKr/ILOsZftB+QSk4XRjzwt9ZCkxO3d0bvLu0E0NziXOl
         cWxHDGYAYDxM62VFRLzgZGnB+r2Zza1EXnWoVeO0h1o/iPsLdfMTlaWLCnDLurQ5GIqX
         jJDzIC8A9KSE3naGVZmDZRqldU9EZFXFww8hJz+qfnqeppgUePTRjE6yLrBTsf/q0+9s
         +mFkOY/xucJj/h1hsXJzyh6iWZJXpp98u4R6rbaQEcLR+h87PqRwHT3L1l/Ak60kqga6
         XBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JEFir2f91v73nekkwcA/r3dp6L112/g4gH1PpqAdrc=;
        b=eP1zthin+JOsX7JJ0zCFNnWgdpx+GxwOx3rGWKX1BVTIYDtoQ6yS3Qi1jjkgACp+tf
         FhQcOK3AsMdfP2A4nOjW7gX2xokM/2LEJUEe7j2z0Jde/J3SCDt2dm4gt3CnspVV9/i2
         OjKNJJQiKIrnnaRhFRZkbpHJjuBW+vGnKt2paM2MW9QxwwRA6DjF/NPXXttxqazdvS1z
         zIHlhH29Tkx+Zt3hgPRYC3LHZncnKuOPpvRdapY//cG0y4uc9G28XPxRyXnKL/kAeJal
         lN2EGIId7933NAIePZgNkwMbWL15WJI1ZDoqvAezg4vsAZYCsmvkd50pRkEU7wCLOTaI
         oFhw==
X-Gm-Message-State: APjAAAXNh1Cb2racR4TfreaNlsW8P24yq6B9f/bdpVisjlJwQSYq/cuU
        F0nF9PrNhDwIFvdeAtTKMeCGBBSn43iXqRQcOlQUIw==
X-Google-Smtp-Source: APXvYqz9YdnYhDW70Z3csaomKtslVjyTnCmLX2S88WyqkoxdnVU1AOktxDryJSI1sQQGT7nNmjuI/WkfAL7KmOM2fR0=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr1529248pjs.73.1561062598008;
 Thu, 20 Jun 2019 13:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190620155505.27036-1-natechancellor@gmail.com>
 <CAKwvOdk7ZTcWEXPTBASPzk1SjOdnONawtQJkR-jU=REFSo1hVQ@mail.gmail.com> <20190620201549.GA65397@archlinux-epyc>
In-Reply-To: <20190620201549.GA65397@archlinux-epyc>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Jun 2019 13:29:47 -0700
Message-ID: <CAKwvOd=okFdfSfGpXTAUqyF=vfnaZFgdwHC-i+CnaFxGSh2Thg@mail.gmail.com>
Subject: Re: [PATCH] mtd: mtd-abi: Don't use C++ comments
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 1:15 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Jun 20, 2019 at 12:56:58PM -0700, Nick Desaulniers wrote:
> > Should there be a fixes by tag?
>
> Normally, I would have added one but this issue has been present since
> the beginning of git history. According to Thomas Gleixner's pre-git
> history tree, it would be:
>
> Fixes: 7df80b4c8964 ("MTD core include and device code cleanup")
>
> but since that hash doesn't exist in the normal git history, I don't
> think it is worth adding. Of course, if the maintainers want to add it,
> I won't object.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

LOL good point; I wonder if the stable maintainers have thoughts on
that or how they expect us to signal that case if we even need to do
anything at all.

Either way, thanks for the patch and
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
