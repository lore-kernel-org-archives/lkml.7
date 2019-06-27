Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE48C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC8921670
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idXEdo1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfF0B50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:57:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43062 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfF0B5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:57:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so745590qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFpCSIKqUTaSdQa6AjPKq4KCFabDQrXJZuHVpPg7HKo=;
        b=idXEdo1QwYbytVDpNXkEkdX8/t35kPlei6VsmEBnn+F3/uyYqvdeJVRVLjbFYGkSdW
         069R4QjGA0Sgwffj6jPbX28UsZZd20p+1IJes5/RhaupHGcrciou1DWObuic7PP7BUpi
         4hSWOHOT+KhmM67ArVA9UZ4pT1eE+BpR+WN6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFpCSIKqUTaSdQa6AjPKq4KCFabDQrXJZuHVpPg7HKo=;
        b=I7G3gPfe9xHnsww5B1KtxtbXFQ597Y/hy63y2oNoCyl8lqEmpDb15Pyqr4sRcE2tKU
         LBMou8Nyu7boQN0jD6thkyVfSIgSc2Uplz11GrkVvf/5f4fSBr8ZgbALxoWz4hq0JSi+
         eJY3jefALyymFQ04FgS8shLJz9wnW0Dpsb+3qC5eTKACQn4dmv3wEeOArdH2huQbOSC6
         mzQiiFNDEw6OLWIdpk4T0vpT8Jp2a2Q25d7TIqhYGkMiE6RkQIT833pSZNiuHYykEGCz
         KVWcXCNUBXSUMdgAqfVlQkZGnwP+EdBZqtYRJjR8E29hZDrIlefcAvWYWxC7wvf8kQp0
         ExzQ==
X-Gm-Message-State: APjAAAVCr6v2jk12YBy9O++yRGAEOmv4zLxbbNHzEMLB2hO7zTHCfs7n
        SdiXHgGowC61G2pEKI6zY6+LEKfgcu8nZLpbhRYiyQ==
X-Google-Smtp-Source: APXvYqz5LlZK/6rUOBQ3yxentgu5mEv7e7YsHnNE5sl7t3NOP5POPDG3I9WocL0HdlftQm+oMkHKI4t+1AMytFozxak=
X-Received: by 2002:ac8:2f66:: with SMTP id k35mr931446qta.174.1561600644176;
 Wed, 26 Jun 2019 18:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235011.7b449eb0@canb.auug.org.au> <CACRpkdaHyb=o=9YzSvKWRbbyPCbsOUxC=zoz+acnTWNvp=vu5w@mail.gmail.com>
 <CANMq1KCUfsKdJD8=DKR7ya-zhV0fgpHBi=PUtD030nFo8k9_ng@mail.gmail.com> <20190627114831.5a13dc0c@canb.auug.org.au>
In-Reply-To: <20190627114831.5a13dc0c@canb.auug.org.au>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 27 Jun 2019 09:57:13 +0800
Message-ID: <CANMq1KB+wmSU5S=extD_Pe-bG+v0vAdm4NsnMzmkkEcVi+mMjg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 9:48 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Nicolas,
>
> On Thu, 27 Jun 2019 08:32:34 +0800 Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > Ouch, sorry, for some reasons I thought it was 10, not 12...
>
> It used to be 10, but will slowly grow over time.  That's why setting
> core.abbrev to "auto" is best (or leaving it unset).

I'm not that smart, I count the digits manually ,-( Anyway, TIL `git
log --pretty=fixes` and I'll use that in the future, thanks. And my
"auto" setting uses 16 digits, it's ok to use longer ids, right?

BTW Documentation/process/submitting-patches.rst on linux-next/master
still says to hardcode to 12.

Thanks,

>
> --
> Cheers,
> Stephen Rothwell
