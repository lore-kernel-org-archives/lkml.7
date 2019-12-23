Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE720C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 05:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB7206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 05:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thXcged9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfLWFpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 00:45:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45929 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWFpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 00:45:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so14486847qtq.12;
        Sun, 22 Dec 2019 21:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14r7Jxv6ILUGdSVz71xwC9kfft75l4E8nJpVYH9WWxY=;
        b=thXcged9wpzyNLdEezN6APmldUIlcRCNCGUSymSV8otBk2BGTYwQErN8YLse95uzYg
         s7mJJE3P8vraOtSpyaq9JooUQ3XWtI5cOWzwjHnVamWRyvqPxObuHYaujDnNrzrHRHSN
         BbsazzCsd50bAaSDuawk58uuzu9YNPAl3DkUVKC3KgT7u4X+xkQ58apLnTrq5w1PyulD
         dJ3frOdqI+tq2gz3OxssF+xecN91WoTnu1EiZFUQTdDJkmUfJW0YjAZObLTh8Qa4uVye
         JIFwszmSNRtihloTOJOB/wFtKoM0k1DO7Nh4j7FRy6ak+XeQVo8Pvg/oMou8IYYNP0j2
         4A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14r7Jxv6ILUGdSVz71xwC9kfft75l4E8nJpVYH9WWxY=;
        b=TG9/bMMdY683QOy/V5eNEhwUYcZrG4gCVvKjabCSi1ZMc3ydz+O15F0GVEo2sTqqyq
         yIIB7pp0Mr/ZDWJhXpYpstSqD6X3E6YI+sdtrA/zehCXWNXRr3zh3RVxQhfJcnR61L/E
         og/RMIOWDwKkMt4xePBl4x0SAq0EUbqJ2yrGEHtizhrEJqhzTlCcxz2r+CEQi8rKKaGy
         Y6aTLQAgQVWeh4ape1cmIsLHMR6ItoKWLZ4g7nL7A5GhkdzALVhbHbUX+3sethiLN4kI
         nQMgcQJBMrNJwOvlIzcyTy1ni/amSOx/IhG5XKPo2ph4wfuvQjO9p7G6HCN+bORuG4zB
         3AAQ==
X-Gm-Message-State: APjAAAUH1glcZ1abjW/x6DyBZlOSg0RrZkxpZCoSwhGe16YIFJG2TNto
        yMyXpAzML9Hwti1Kq3vdSFkjEd0AxiY5f6UgsUg=
X-Google-Smtp-Source: APXvYqyPEUEUrr706xHAfV1kYlxYzwLwd7Fy0OA702gi2MXx8GsObRDvS+UA6Gron41iv9e9QbpsvPm0TPBQtlPfyAI=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr21075945qtl.171.1577079941253;
 Sun, 22 Dec 2019 21:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20191221162158.rw6xqqktubozg6fg@ast-mbp.dhcp.thefacebook.com> <20191223030530.725937-1-namhyung@kernel.org>
In-Reply-To: <20191223030530.725937-1-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 22 Dec 2019 21:45:30 -0800
Message-ID: <CAEf4BzaGfsF352kWu1zZe+yXSRm4c9LQ0U57VnRq2EdtjeQutw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix build on read-only filesystems
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 7:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I got the following error when I tried to build perf on a read-only
> filesystem with O=dir option.
>
>   $ cd /some/where/ro/linux/tools/perf
>   $ make O=$HOME/build/perf
>   ...
>     CC       /home/namhyung/build/perf/lib.o
>   /bin/sh: bpf_helper_defs.h: Read-only file system
>   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
>   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
>   make[2]: *** Waiting for unfinished jobs....
>     LD       /home/namhyung/build/perf/libperf-in.o
>     AR       /home/namhyung/build/perf/libperf.a
>     PERF_VERSION = 5.4.0
>   make[1]: *** [Makefile.perf:225: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>
> It was becaused bpf_helper_defs.h was generated in current directory.
> Move it to OUTPUT directory.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

Looks good, thanks!

Tested-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/Makefile               | 15 ++++++++-------
>  tools/testing/selftests/bpf/Makefile |  6 +++---
>  2 files changed, 11 insertions(+), 10 deletions(-)
>

[...]
