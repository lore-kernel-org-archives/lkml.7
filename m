Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B1C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24642173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OyAOY+Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLFCRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:17:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46067 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLFCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:17:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id c2so2119118qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7nqYbyImNHiFpr/sdLKezCDkfvpWUIGHEps4auL6otI=;
        b=OyAOY+WxofZvoHYOFa+KgN5Esyu+JNPI7VoizBAhQrW31wnnadZ4714g/3/kitlwHb
         lLqP/3z0Wz7a1zCu5ibuE4vuK029RRGgYycZ2r3gRsg7FZWVVkiD7kHHYfedkAmBc/q/
         adhDSw4mU4Ke8eIxGqrtkrRNQMDLsGY3KmmZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7nqYbyImNHiFpr/sdLKezCDkfvpWUIGHEps4auL6otI=;
        b=CF4ZNzdcr6Xd8n6WYVdzQrIZ9wjgkImX8ThzGhl1Z+Ch4x5W3V9LVqEeHb1bBcLVF8
         pboHnMyk9cgiKdoJP8lwdsl9Q2m1PepYR0w4elAbdfFrAxPLsvnU4DKNZ2aPKQWLDP37
         1qvp91zFoTgUMC1K7PPctYi+Wn+oGRgkfwVaf1bYdPSxwbConqXRm9Y2S1Q569m2lOoH
         wda/+/O4aIbJWLlfjr++ZT7pWHzvErUJMhHZhzkvW9L8f97GJmh23UUBELbJdpQArDWw
         EeOqcj9nwpxbfn2MzN1M0uIpBEIv/sALiohWUEd0owONlhqhNQNk6Wy4Hv804VGRhhvf
         QmfA==
X-Gm-Message-State: APjAAAWL++4EwnRkZpXJsXKCyimXsb8La8PMfy58U4Nnme5dniYn7CXa
        5DojeCjxHXnmSnSWqL7MiFxEVlQkx4VVIsX8v53jAg==
X-Google-Smtp-Source: APXvYqxUFaxqvw35Z+g8FNWXH59BzvlUeULxPsOF2JvBaMn6LEflHXKnZSoQfJvi4TvWBW9yszkPsMonm/0abquH+cE=
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr10912455qvb.163.1575598655186;
 Thu, 05 Dec 2019 18:17:35 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org>
In-Reply-To: <20191205123302.GA25750@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 5 Dec 2019 18:17:23 -0800
Message-ID: <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
Subject: Re: perf not picking up symbols for namespaced processes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not very good at this, but the following works for me. If you this
is in general vicinity of what you expected, I can email patch
properly.

Initially I hoped that setting dso->nsinfo->need_setns to false in
dso_open would do the trick, but it did not work.

$ cat 0001-perf-fallback-to-opening-dso-from-outside-of-mount-n.patch
| sed 's/\t/        /g'
From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 5 Dec 2019 16:27:48 -0800
Subject: [PATCH] perf: fallback to opening dso from outside of mount namesp=
ace

Some tasks enter mount namespace for isolation and this fallback
allows perf to read symbols from binaries that live outside of
mount namespace of the running task.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 tools/perf/util/dso.c    |  7 +++++++
 tools/perf/util/symbol.c | 20 +++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e11ddf86f2b3..dac6bf42e43e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -527,6 +527,13 @@ static int open_dso(struct dso *dso, struct
machine *machine)
         fd =3D __open_dso(dso, machine);
         if (dso->binary_type !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE)
                 nsinfo__mountns_exit(&nsc);
+
+        if (fd < 0) {
+                fd =3D __open_dso(dso, machine);
+                if (fd >=3D 0) {
+                        pr_warning("Using debug info for %s from
outside of its active mount namespace.\n", dso->long_name);
+                }
+        }

         if (fd >=3D 0) {
                 dso__list_add(dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a8f80e427674..e85d57dfcc14 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1679,11 +1679,21 @@ int dso__load(struct dso *dso, struct map *map)
          * Read the build id if possible. This is required for
          * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
          */
-        if (!dso->has_build_id &&
-            is_regular_file(dso->long_name)) {
-            __symbol__join_symfs(name, PATH_MAX, dso->long_name);
-            if (filename__read_build_id(name, build_id, BUILD_ID_SIZE) > 0=
)
-                dso__set_build_id(dso, build_id);
+        if (!dso->has_build_id) {
+            bool is_reg =3D is_regular_file(dso->long_name);
+            if (!is_reg) {
+                nsinfo__mountns_exit(&nsc);
+                is_reg =3D is_regular_file(dso->long_name);
+                if (!is_reg) {
+                    nsinfo__mountns_enter(dso->nsinfo, &nsc);
+                }
+            }
+
+            if (is_reg) {
+                __symbol__join_symfs(name, PATH_MAX, dso->long_name);
+                if (filename__read_build_id(name, build_id, BUILD_ID_SIZE)=
 > 0)
+                    dso__set_build_id(dso, build_id);
+            }
         }

         /*
--
2.24.0

  /*

--
2.24.0

On Thu, Dec 5, 2019 at 4:33 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Dec 04, 2019 at 07:46:10PM -0800, Ivan Babrou escreveu:
> > We have a service that forks a child process in a namespace-based
> > sandbox where the mount namespace is intentionally designed to reflect
> > a totally empty filesystem. Our use case is very similar to Chrome's
> > sandbox, for example, but on a server. Within the sandbox, not even
> > the service's own binary is present in the mount namespace.
> >
> > Process tree looks like this:
> >
> > $ sudo pstree -psc 63989
> > edgeworker(63989)=E2=94=80=E2=94=AC=E2=94=80edgeworker/sbox(255716)=E2=
=94=80=E2=94=AC=E2=94=80edgeworker/zygt(255718)
> >                    =E2=94=82                         =E2=94=9C=E2=94=80=
{edgeworker/sbox}(255719)
> >                    =E2=94=82                         =E2=94=9C=E2=94=80=
{edgeworker/sbox}(255720)
> >                    =E2=94=82                         =E2=94=9C=E2=94=80=
{edgeworker/sbox}(255721)
> >                    =E2=94=9C=E2=94=80edgeworker/stry(5803)
> >                    =E2=94=9C=E2=94=80edgeworker/stry(63990)
> >                    =E2=94=9C=E2=94=80edgeworker/stry(106218)
> >                    =E2=94=9C=E2=94=80edgeworker/stry(191905)
> >                    =E2=94=9C=E2=94=80edgeworker/stry(255695)
> >                    =E2=94=9C=E2=94=80edgeworker/supr(255717)
> >
> > Here sbox processes do actual work living in an empty mount namespaces
> > and stry is a helper process for error reporting. All tasks come from
> > the same binary that lives in the root mount namespace, launched by
> > systemd.
> >
> > During "perf script" run on a trace obtained from the system there are
> > these possible outcomes:
> >
> > 1. The first pid to be processed is a non-namespaced helper and
> > symbols are present.
> > 2. The first pid is not found and symbols are present.
> > 3. The first pid is a sandboxed task and symbols are missing.
> >
> > Symbols are missing, because "perf script" tries to jump into an empty
> > sandbox and find a binary there, when in fact it lives outside:
> >
> > getcwd("/state/home/ivan", 4096)        =3D 17
> > open("/proc/self/ns/mnt", O_RDONLY)     =3D 5
> > open("/proc/255719/ns/mnt", O_RDONLY)   =3D 6
> > setns(6, CLONE_NEWNS)                   =3D 0
> > stat("/usr/local/bin/edgeworker", 0x7ffedb9b3ca0) =3D -1 ENOENT (No suc=
h
> > file or directory)
> >
> > In the second outcome we don't have a PID to figure out the namespace
> > to jump into, so this doesn't happen. It's a good fallback, but it was
> > a bit confusing during debugging.
> >
> > It's not entirely clear to me why sometimes a helper PID is picked,
> > even though it's not the first sample in the recorded trace (at least
> > not in the output). This happens deterministically, or at least
> > appears so. In my process tree it's 255695.
> >
> > I think perf should try to fallback to the default namespace to look
> > up symbols if they are not found inside to cover our case. Relevant
> > piece of logic is here:
>
> That should work for your use case, as you're sure that looking up by
> pathname only will find, outside the namespace, the binary you want.
>
> Even with pathname based looukups being fragile, it works for your
> usecase, so please consider providing a patch for such fallback,
> together with a pr_debug() or even pr_warning() if this don't get too
> noisy, to warn the user.
>
> - Arnaldo
>
> > * https://elixir.free-electrons.com/linux/v5.4.1/source/tools/perf/util=
/dso.c#L520
>
> --
>
> - Arnaldo
