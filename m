Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DEC24676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrI64WUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfLRRDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:03:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfLRRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so3071233wre.10;
        Wed, 18 Dec 2019 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+uy5zP3meKzkv/NinszsZWPQS2A8V/33nWC88wzzls=;
        b=YrI64WUUeUN+A8VS4amQoyk+nd2EZBeDxRblO3z6WPhDJSsIxhh2jwRRBbwUcuND+D
         ZAYnPM+p0kkLdFlzdzNoyJQa/5GaqQe9u9tBQxLgzIQOkMGnE+hbE5mP4Pk/6QzGwtgs
         /yM6hAQq7tWK/WcrNfLuCIlTQ5kqHAsonoaNxxaj2fFxTeejrApEVFMpJ7/KoobbYmtV
         nrUnV89txR9e0ZMmnv7ER+pE/a4JKkbNV4Rm/bR/r979oWa5I3GgcN9TbKS9kDsQQ/ya
         Ss4NquesYFTUG5ZI7h7PDWAqWeJKktcC+VKMpfJWMrmubpmqmEoxStozU/ytT6Eg2uFv
         tKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+uy5zP3meKzkv/NinszsZWPQS2A8V/33nWC88wzzls=;
        b=SqxKT2tAZWQiuxrA9Jym59d8NLzWn8Ka3QmlK+EbT/kgPhFHy7cj9Al5eLPotqtNFV
         wQkHEFrA8+k+Mroj4IyxNS7t6nba1PsL9ougZAGp4JN3HsGE8weM/kJR1rAyXF3eVhy6
         tcYaVn1j0OKnuYBIUaRscWmNr1ITm899V7yaAnAemRkbJ6XYV/eQNPbUr8Hzj24eeL4F
         SEvH96CYF4xcHT+tJm96elBzf/AL1rPDM9bVPwP1sRfKYoTbh4nDjqF0IyKNRCTT5WXZ
         4UoRIVeWRqqY4bLyJOKqO9RzmAoRURZC8QqesoEIiQY9AblpPBOFTDNs29DMfa2B+oqR
         I0wg==
X-Gm-Message-State: APjAAAXqPUuoaeRFQssvIdybvBjXbk2Dq3EQizkcvXhyjgrDr9t/aq7+
        YMmZBG+LIfvtvxc7DbvG5xDJWkzOA35GLmeBpvY=
X-Google-Smtp-Source: APXvYqxjQjHvn8BSQ2XJQaEZ3Un+sEhBY4NNwov3uPaKjq4im6mZBqwMjGF+YB5UTRuPzIIWUKdRK6pLDh+t7DzrLbY=
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr3947271wrs.222.1576688598045;
 Wed, 18 Dec 2019 09:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20191211080109.18765-1-andrey.zhizhikin@leica-geosystems.com> <20191218143325.GE13395@kernel.org>
In-Reply-To: <20191218143325.GE13395@kernel.org>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Wed, 18 Dec 2019 18:03:07 +0100
Message-ID: <CAHtQpK5zNdiD58Q=vVgHrp7GQ+kNb4D7HTzSuNGyX40O-=mCMA@mail.gmail.com>
Subject: Re: [PATCH] tools lib api fs: fix gcc9 compilation error
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        sergey.senozhatsky@gmail.com, pmladek@suse.com,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 3:33 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Dec 11, 2019 at 08:01:09AM +0000, Andrey Zhizhikin escreveu:
> > GCC9 introduced string hardening mechanisms, which exhibits the error
> > during fs api compilation:
> >
> > error: '__builtin_strncpy' specified bound 4096 equals destination size
> > [-Werror=stringop-truncation]
> >
> > This comes when the length of copy passed to strncpy is is equal to
> > destination size, which could potentially lead to buffer overflow.
> >
> > There is a need to mitigate this potential issue by limiting the size of
> > destination by 1 and explicitly terminate the destination with NULL.
>
> Thanks, applied and collected the reviewed-by and acked-by provided,

Thanks a lot for review and collecting this patch!

>
> - Arnaldo
>
> > Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/api/fs/fs.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> > index 11b3885e833e..027b18f7ed8c 100644
> > --- a/tools/lib/api/fs/fs.c
> > +++ b/tools/lib/api/fs/fs.c
> > @@ -210,6 +210,7 @@ static bool fs__env_override(struct fs *fs)
> >       size_t name_len = strlen(fs->name);
> >       /* name + "_PATH" + '\0' */
> >       char upper_name[name_len + 5 + 1];
> > +
> >       memcpy(upper_name, fs->name, name_len);
> >       mem_toupper(upper_name, name_len);
> >       strcpy(&upper_name[name_len], "_PATH");
> > @@ -219,7 +220,8 @@ static bool fs__env_override(struct fs *fs)
> >               return false;
> >
> >       fs->found = true;
> > -     strncpy(fs->path, override_path, sizeof(fs->path));
> > +     strncpy(fs->path, override_path, sizeof(fs->path) - 1);
> > +     fs->path[sizeof(fs->path) - 1] = '\0';
> >       return true;
> >  }
> >
> > --
> > 2.17.1
>
> --
>
> - Arnaldo

-- 
Regards,
Andrey.
