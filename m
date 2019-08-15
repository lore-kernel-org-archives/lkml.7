Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0F2C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A0D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPrbVHFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfHOXFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:05:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37497 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfHOXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:05:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so1366722pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPt+lD53UMmWuKSJSUmfcWxGBTRSp/XxZ/GGdWGHTvg=;
        b=cPrbVHFEyHC+uvkIilU4GIY9SyYx/S0ZZtKFPQAt4vRxN/T5cNs5cO+Ihx54yxNs9y
         d5hpJS6osCY3OrNh3cPpLfWemfKgqQ6cXt2lKm286OHdPaAPus4hwQc31PT7QFQyJ/f4
         TEZ6ekHrzcQ8HflG8Di+MA1uPRbKplWE/ZSg37dWv5AcLrB4HMXzVQ0VpAyfoLw+z+AV
         610gol6FrJP7CHIZKxfiDv4GKmuTohad7BYwTOEZPRHc+pz36khtHygP/4uzoF/ZXfpL
         LZ0kCaH0bxBa+7ELQz29uwSzs+3PKATciJTbkYv3yk6GUDZs/Z6Yj5ew630EzyMdiuE1
         3cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPt+lD53UMmWuKSJSUmfcWxGBTRSp/XxZ/GGdWGHTvg=;
        b=rYLRotBgPM4l23Ce2CNR19crSkjh/jHl4z6iQB9E60ZOMZVXoXGWbYtpluRXPEimug
         f8A1G7+wr1T70E4uX71Nz+NypiR0CLMOCdivOvE0Fi4CIHi8owOcKQjhFcGBGbsV14m4
         sBoHVlqUzb+9Pex+f0rdW48NOurLMTmDsUqh72wc23xwNDXUNPSpc/f2RnhaTEFyWakN
         rwdpEAJ5NJ1hIFZG8FSEj3H/IVwORO7aLSOPuvTG4gSTZHSfHCuS6elXgy1de72xYGSm
         8cs65kviA0DExAaJ5xFCg6wuuJVTvoy9uuvIxCOud5Q33qXU3O+NgI9PUTII5SekDr6T
         1E6A==
X-Gm-Message-State: APjAAAUdb/SmAh12piKso6c9EKpYD1GdqIg4a+kk21G/u3Y+Oyz9PY9z
        FTX4NPdh1EiB/W7pxWATv+R2oWVyJOtj+hs4Tpc6nQ==
X-Google-Smtp-Source: APXvYqzZ1Dj1S+kEiduAjq/Oq400aLK2gSwv+Mb47pdY97i+JKU/RVJ+Ju3f4ogpqOE2DVajTFA98xhjDfaDMXYNyUk=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr5358843pgb.263.1565910330216;
 Thu, 15 Aug 2019 16:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190815182029.197604-1-nhuck@google.com> <20190815204529.GA69414@archlinux-threadripper>
 <CANiq72nM4d-rc_qUMUEisXyEU9A0mbW=O_w5X0zoqWNPLacuNw@mail.gmail.com>
In-Reply-To: <CANiq72nM4d-rc_qUMUEisXyEU9A0mbW=O_w5X0zoqWNPLacuNw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Aug 2019 16:05:19 -0700
Message-ID: <CAKwvOdm4Lsj1mPn3+FtPDrNVSQovsw8Fe9u6Yw3te7pD-izAog@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Require W=1 for -Wimplicit-fallthrough with clang
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Joe Perches <joe@perches.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 3:59 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Aug 15, 2019 at 10:45 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > * Revert commit bfd77145f35c ("Makefile: Convert -Wimplicit-fallthrough=3
> > to just -Wimplicit-fallthrough for clang") for the time being and just
> > rely on adding -Wimplicit-fallthrough to KCFLAGS for testing.
>
> I would avoid applying commits that will have to be reverted just for
> Clang, particularly since it is not fully supported yet.

"not fully supported yet" you say? *drops monocle*
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS?h=v5.3-rc4#n4001
-- 
Thanks,
~Nick Desaulniers
