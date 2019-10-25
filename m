Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB83CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4923C21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBoQDCUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfJYWLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:11:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYWLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:11:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id v6so3516242wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7btG+d90SYwnoNqBRZbbZw1OPlzcDfT7ckB53vivYo=;
        b=HBoQDCUh5xGz8915X/9rOGy7cvONbOcuJJ/wtl1RUpmrv8B/yV7Eojje9rpEr/nexl
         5Y8yvggxST5F5JcgsPwx1NEHN8NWAm3x7tOg9NRwXcj5Be0aciVwwKACFGauNkPnYWCY
         K+lFxhLtHLYTzjPW9tuaBICefQP4w9Mz0v4Sxm2iIo2tMzmc9ijB2IFxxzGt3fpHoxJh
         saT/TLc69J8RmZs429MFH5WFBKUI8NTgtoGB9l6KXhLSl7zV5aMicCaq4lcCtG/RL3Dm
         sGhdZTqHsBa6WVB/xVQyxNUrj0K757/OtynLqC6QNwPozVS6109VrweuC/aMaRyzMIPs
         +grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7btG+d90SYwnoNqBRZbbZw1OPlzcDfT7ckB53vivYo=;
        b=DrFTG3MumHNYMeilSQJlQ2dQpm9qv4wkprle2mSZY5W/rz7zBKgNln322XjhTToWz7
         KNkO6Fb21GDFBL8dByZo0ujV82eA9hIDrLy0PJsn+SBTLyunDE2Mx1Mlwg3XDUPw0Dra
         MHCIR1oGz0o/qhywdKO8gC+OLEUsmel/gRBNVRPf2fVIhJplO+/6VrQPzsRPZ/XcVBLB
         p5G3WqPDVzw6oQfF0kAD6Q89vKCSY+h9ziCx5MSo2MI8LT0wCooE198Gn6XldU4LL/Cu
         ymAlBjP3pEwyOHo3o9rer2WjEuM9/UD3MzjEJwiOQia7yf0Fi9mNaS7UERk5zZZXltCE
         oMPg==
X-Gm-Message-State: APjAAAWVChQRcnJrB5PDq+TQHqE0GJGJxGg4XFKpN1ffqz/ih+UCACDH
        iBLpZ8H7KVZLnsKA8Nr73Q7xAx96eDPWEgn385XwAw==
X-Google-Smtp-Source: APXvYqzv7TYFut64CUgGPlFk9kax85HqDKeinqkP/aMt4V6mhoX+uLVdUfgV8VOQHr12FZQT+IZDhyO+Sgd+EYTb9PU=
X-Received: by 2002:a1c:a791:: with SMTP id q139mr5199483wme.155.1572041473912;
 Fri, 25 Oct 2019 15:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726194044.GC24867@kernel.org> <20190729205750.193289-1-nums@google.com>
 <20190807113244.GA9605@krava>
In-Reply-To: <20190807113244.GA9605@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Oct 2019 15:11:02 -0700
Message-ID: <CAP-5=fW8k6YWBYno2RWV5_mojn-0crvmPcLynKGBO_3WMCXfEA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix annotate.c use of uninitialized value error
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this wasn't merged to tip. Does anything need addressing
to get it merged?

Thanks,
Ian

On Wed, Aug 7, 2019 at 4:32 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jul 29, 2019 at 01:57:50PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > Our local MSAN (Memory Sanitizer) build of perf throws a warning
> > that comes from the "dso__disassemble_filename" function in
> > "tools/perf/util/annotate.c" when running perf record.
> >
> > The warning stems from the call to readlink, in which "build_id_path"
> > was being read into "linkname". Since readlink does not null terminate,
> > an uninitialized memory access would later occur when "linkname" is
> > passed into the strstr function. This is simply fixed by null-terminating
> > "linkname" after the call to readlink.
> >
> > To reproduce this warning, build perf by running:
> > make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
> >  -fsanitize-memory-track-origins"
> >
> > (Additionally, llvm might have to be installed and clang might have to
> > be specified as the compiler - export CC=/usr/bin/clang)
> >
> > then running:
> > tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
> >  -i - --stdio
> >
> > Please see the cover letter for why false positive warnings may be
> > generated.
> >
> > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
> > ---
> >  tools/perf/util/annotate.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 70de8f6b3aee..e1b075b52dce 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1627,6 +1627,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> >       char *build_id_filename;
> >       char *build_id_path = NULL;
> >       char *pos;
> > +     int len;
> >
> >       if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> >           !dso__is_kcore(dso))
> > @@ -1655,10 +1656,16 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> >       if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
> >               dirname(build_id_path);
> >
> > -     if (dso__is_kcore(dso) ||
> > -         readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
> > -         strstr(linkname, DSO__NAME_KALLSYMS) ||
> > -         access(filename, R_OK)) {
> > +     if (dso__is_kcore(dso))
> > +             goto fallback;
> > +
> > +     len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
> > +     if (len < 0)
> > +             goto fallback;
> > +
> > +     linkname[len] = '\0';
> > +     if (strstr(linkname, DSO__NAME_KALLSYMS) ||
> > +             access(filename, R_OK)) {
> >  fallback:
> >               /*
> >                * If we don't have build-ids or the build-id file isn't in the
> > --
> > 2.22.0.709.g102302147b-goog
> >
