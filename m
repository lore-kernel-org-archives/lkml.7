Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48044C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FBC218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfzVUKLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbfIGSN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:13:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIGSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:13:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so6618209pfb.7;
        Sat, 07 Sep 2019 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqHYZLutmMZ+3gMlYgMzWUPkTeS750+QJLG76FxtJNo=;
        b=PfzVUKLsocbeEuSnj5bm9x2dSTwd6yGnAoCLr2qVD/CzhZDjgXDb89INZPRVJWcKdT
         RmPdJPvTRHgGKmA2ct92WGUdd9AsR23aFrVUGmxdumk7OiNJ8bFX7OXZk8r4dW0bBBGN
         yrpW67nboPeh3hhnY67GAuzKvN++UE9V7lQFmfot6wp0ntmn0F7t42ddrWFiDTNDxiMC
         ECUS1Ecu43EU2twm6uT22eMGnznpotrYUJVzxdS/4wLi6cEB/xLj6VAP2gOrhBnBvktM
         /JN6pExBYaB1qfCz3Q7R6GPzpUkl8DPkX00ykb0VYhUGXJ2fqCMyy1wX2f+OZjaaOWEw
         dJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqHYZLutmMZ+3gMlYgMzWUPkTeS750+QJLG76FxtJNo=;
        b=MY2xKtxGdv10YlEFHYzowRt6toK+WS6yiUuXANY/JR1DoEiGs5x6MhLzc2/NCo0tks
         zEteqXACMdbDiCtdKrAxk/mJf4iwW6S1zBgO4v36MzHSgTZaUE+dZTdotCNBOr3UHkpw
         7NjrIafnl8iderHOHj385Pb4FyhAoxpzw08Xd2ARDMA3xJ5Vuw6S/WHoIsVYaG0goN5x
         1sbvEhtFX3prygeQUAZcCmTGC5aQW28DL3moNdWV6x0E7XLpko8oCOYt5ajCeT/DIphF
         06MkW6x8As/aTnyBBt485kwojHIyEDHK/HWuaAcuL7JF5YxJcKmIgfUmfmdfA7JFKM+F
         r2Kw==
X-Gm-Message-State: APjAAAX1sGl/1yLudSaFltC3yOT75ieIiBYmJ305jb1LnWbLPD26aeiu
        uwruWXwAMyi6zoOKqPm5HaADBDicfXeeMRZaRcAFrfV9td82jQ==
X-Google-Smtp-Source: APXvYqxm8X4QtH8Tq84PuuUvLoXlsR+q0q7eYbFRmZ3IWrN6O2FiF6cJY3g7HFULHm1lDTI5P8sk2m8wFeYlVY6usYI=
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr16965169pjb.132.1567880037349;
 Sat, 07 Sep 2019 11:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190905120311.15286-1-prarit@redhat.com> <e02287479ad936142a21cbd7c6c00947ca0c5088.camel@linux.intel.com>
In-Reply-To: <e02287479ad936142a21cbd7c6c00947ca0c5088.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 21:13:45 +0300
Message-ID: <CAHp75Vf3KWLue_2UfNTNhDrXBX0YA+FRindbfX0sOzjhUcwKTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] tools-power-x86-intel-speed-select: Fixes and
 updates for output
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        David Arcari <darcari@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 10:58 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2019-09-05 at 08:03 -0400, Prarit Bhargava wrote:
> > Some general fixes and updates for intel-speed-select.  Fixes include
> > some
> > typos as well as an off-by-one cpu count reporting error.  Updates
> > for the
> > output are
> >
> > - switching to MHz as a standard
> > - reporting CPU frequencies instead of ratios as a standard
> > - viewing a human-readable CPU list.
> > - avoiding reporting "0|1" as success|fail as these can be confusing
> > for a
> >   user.
> >
> > v2: Add additional patch to fix memory leak and remove help text in
> > 8/9.
>
> For the series
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>

Pushed to my review and testing queue, thanks!


> >
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: David Arcari <darcari@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> >
> > Prarit Bhargava (9):
> >   tools/power/x86/intel-speed-select: Fix package typo
> >   tools/power/x86/intel-speed-select: Fix help option typo
> >   tools/power/x86/intel-speed-select: Fix cpu-count output
> >   tools/power/x86/intel-speed-select: Simplify output for turbo-freq
> > and
> >     base-freq
> >   tools/power/x86/intel-speed-select: Switch output to MHz
> >   tools/power/x86/intel-speed-select: Change turbo ratio output to
> >     maximum turbo frequency
> >   tools/power/x86/intel-speed-select: Output human readable CPU list
> >   tools/power/x86/intel-speed-select: Output success/failed for
> > command
> >     output
> >   tools/power/x86/intel-speed-select: Fix memory leak
> >
> >  .../x86/intel-speed-select/isst-config.c      |  21 +--
> >  .../x86/intel-speed-select/isst-display.c     | 120 +++++++++++++---
> > --
> >  2 files changed, 98 insertions(+), 43 deletions(-)
> >
>


--
With Best Regards,
Andy Shevchenko
