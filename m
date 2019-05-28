Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA64C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418F62075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlczyWHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfE1Q7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:59:23 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33262 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1Q7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:59:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id 49so8233514uas.0;
        Tue, 28 May 2019 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=198KawDApgqJEA2xsNuH8RyjeYS5CPMI9y1k6aRNrNA=;
        b=PlczyWHL/PGe6hA97rtFdVMXuyHUPCzUQkMLPS0Y6Fu1GDNJWqHkOv7KgVdLEKHsLU
         xMdtbufUbg8/oRsZlnoGz/ZPi+b9Ltgl2SpRtORZ2/27PluL+B8Bt+gK7omgnJguAhxx
         WewI0Cqp1X1rDFsXWPAHZsc7wJGggzQ0g7jwYlsP0tmj/Ecp45TVZPybomuyZZZyVXAa
         4kfLSzTnVL1hrz1bti6hsXyfIPcCFzLV/wbYIgfprgoGzqOwV9bCRGSp5vSX4+k2N7m2
         qFgzAEzObNrI7m35YUqqp+ZMLNC7qqT1TNe6P5RB8XddDP2lkDgi+wTJ95/wu9rzEb3S
         YvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=198KawDApgqJEA2xsNuH8RyjeYS5CPMI9y1k6aRNrNA=;
        b=pfgFv8fbHO9y83gmDTHJQPd7aKUM4yHdS4ZBUUKRLJmF4Wv+jXbLYdhaIh+uz582zy
         QNl6YD1xCLaQQqZle9YwgzsN0fGp1Mc1NGZBOKmhDQ67yX26xj8Ix9n7Y37gE4sBtBY6
         bFSMFwmuOGpEEfgznZmpz40c+sU6cHsY7u6bxpB1SmLBW9ZBsvhPK43V4+G/JePKZVXm
         QzhFO6/+J4XC8Of94bSexepkxF8L9fowi9LCilQ33Yq4C5fsQIPFkgLFUuBMdcHqCm4F
         KqLQUmYbEoag1bN+2P8csvEv2NNGNJh1CB08blfz77UtbupaqWbt/GlpnZ7YMM3wshDi
         rVDg==
X-Gm-Message-State: APjAAAX94Q2GyrrvzRN5ObtouzCZI8q6XP90nMh1+w9SoavNLc1tuHjT
        NEVGyDcQ9JYn8APcTXlS6tUjPxeD66ZKygc1Qpg=
X-Google-Smtp-Source: APXvYqxUgPOlrtk3XQ/paCUlBiOOfbrYGdSSNPBoRx5lmEaSTCQKLqgYV+ObQIJpZwChQHhQRj9elqbRwE7TLYNFfaY=
X-Received: by 2002:ab0:1529:: with SMTP id o38mr33614868uae.30.1559062761934;
 Tue, 28 May 2019 09:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190527223730.11474-1-acme@kernel.org> <20190527223730.11474-6-acme@kernel.org>
 <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com> <20190528130421.GB13830@kernel.org>
In-Reply-To: <20190528130421.GB13830@kernel.org>
From:   Shawn Landden <slandden@gmail.com>
Date:   Tue, 28 May 2019 11:59:10 -0500
Message-ID: <CA+49okqAuPrs679GWQhxjyMn4mMhVSH_71Ww6rBbUjsrm2g-dg@mail.gmail.com>
Subject: Re: [PATCH 05/44] perf data: Fix 'strncat may truncate' build failure
 with recent gcc
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 8:04 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, May 27, 2019 at 05:46:26PM -0500, Shawn Landden escreveu:
> > On Mon, May 27, 2019 at 5:38 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > From: Shawn Landden <shawn@git.icu>
> > >
> > > This strncat() is safe because the buffer was allocated with zalloc()=
,
> > > however gcc doesn't know that. Since the string always has 4 non-null
> > > bytes, just use memcpy() here.
> > >
> > >     CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
> > >   In file included from /usr/include/string.h:494,
> > >                    from /home/shawn/linux/tools/lib/traceevent/event-=
parse.h:27,
> > >                    from util/data-convert-bt.c:22:
> > >   In function =E2=80=98strncat=E2=80=99,
> > >       inlined from =E2=80=98string_set_value=E2=80=99 at util/data-co=
nvert-bt.c:274:4:
> > >   /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: =
error: =E2=80=98__builtin_strncat=E2=80=99 output may be truncated copying =
4 bytes from a string of length 4 [-Werror=3Dstringop-truncation]
> > >     136 |   return __builtin___strncat_chk (__dest, __src, __len, __b=
os (__dest));
> > >         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> > >
> > > Signed-off-by: Shawn Landden <shawn@git.icu>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Wang Nan <wangnan0@huawei.com>
> > > LPU-Reference: 20190518183238.10954-1-shawn@git.icu
> > > Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kern=
el.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/data-convert-bt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data=
-convert-bt.c
> > > index e0311c9750ad..9097543a818b 100644
> > > --- a/tools/perf/util/data-convert-bt.c
> > > +++ b/tools/perf/util/data-convert-bt.c
> > > @@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *=
field, const char *string)
> > >                                 if (i > 0)
> > >                                         strncpy(buffer, string, i);
> > >                         }
> > > -                       strncat(buffer + p, numstr, 4);
> > > +                       memcpy(buffer + p, numstr, 4);
> > I took care to have enough context in my patch that you could see what
> > was going on. I wonder if there is a way to make that care
> > propate when people add Signed-off-by: lines.
>
> I just checked and the patch is the same, the description I only changed
> the subject line, so that when one uses:
Functionally, yes. However look at how my version has enough context
that you can immediately know that the patch is correct (instead of
the default of 5 lines):
https://www.spinics.net/lists/linux-perf-users/msg08563.html

>
>    git log --oneline
>
> we can know what is the component and what kind of build failure was
> that.
>
> - Arnaldo
>
> > >                         p +=3D 3;
> > >                 }
> > >         }
> > > --
> > > 2.20.1
> > >
>
> --
>
> - Arnaldo
