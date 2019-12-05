Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E8EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B573B206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ny1hHF6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfLEDqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:46:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44073 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLEDqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:46:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id b5so2133875qtt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ORECt6z+ycDjfptUtQ2najrif2bAPibjEeq++PAuMhg=;
        b=Ny1hHF6G+OWWdUUeOmHg6E8RMSsl645UfKNGSn/v31VjPXZJ9nNaR6qEfddBubtJDT
         z88BHtZ+QKUYENeT4cWi+9cUSV5alAgAZ0PdiZ8tWKgOIZyA0jCACAz+gQqqVXkLIVhZ
         EZIbVMoqhO8pHjdw0I3D9VuRW47bSgbOLPKH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ORECt6z+ycDjfptUtQ2najrif2bAPibjEeq++PAuMhg=;
        b=saykqQ/ZQ/sLyx0Yo9I8dCH1BZFMqLpHD8MtPjkxUDkDqvbnpGSuqCw9PNI0lfasg9
         Gdcbzk4YYeAgcHPoCFQlUVe0+oSdoFFfGFVWpiW2rgZXEbA5eus/wJV5e2YTjn7ZYbzJ
         p+o6sp9l3ULZIk5vMeM/z+XGlQh6aExOudPH3TZIsXf7hsZQRcxNJS/NMiY22S0sI+AU
         vOgbjaimomIz3c0QheQANAhblJ4jyfY39IKCi/JUWw0niVpnj+kMGnjFxaH0vCMWjPN8
         /GSQyetgnk2j41i5P77e2Fvaq6I9qwrW8xxQKqSmT5M/PLsvxwOKJQ63vAdS3loD1oxF
         IKWA==
X-Gm-Message-State: APjAAAWzNHpC6NfpCAz94QL72NBTqNGwwgb4ydGVckf3QlAL4EzuQMez
        P4osG2aofUsaeFUPkIwiwvsjNxqnEfWXeHc5tLDSMpqJKZo67g==
X-Google-Smtp-Source: APXvYqw2Do/tFhwEzuYj4/1wo+tcwhsNKZbNVXOM8wVGAsZyZ3bels4i3qVIRmXVcjaz4C+VGAG74r0LO+VOIgxVCvU=
X-Received: by 2002:ac8:7609:: with SMTP id t9mr5893105qtq.341.1575517581012;
 Wed, 04 Dec 2019 19:46:21 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 4 Dec 2019 19:46:10 -0800
Message-ID: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
Subject: perf not picking up symbols for namespaced processes
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a service that forks a child process in a namespace-based
sandbox where the mount namespace is intentionally designed to reflect
a totally empty filesystem. Our use case is very similar to Chrome's
sandbox, for example, but on a server. Within the sandbox, not even
the service's own binary is present in the mount namespace.

Process tree looks like this:

$ sudo pstree -psc 63989
edgeworker(63989)=E2=94=80=E2=94=AC=E2=94=80edgeworker/sbox(255716)=E2=94=
=80=E2=94=AC=E2=94=80edgeworker/zygt(255718)
                   =E2=94=82                         =E2=94=9C=E2=94=80{edg=
eworker/sbox}(255719)
                   =E2=94=82                         =E2=94=9C=E2=94=80{edg=
eworker/sbox}(255720)
                   =E2=94=82                         =E2=94=9C=E2=94=80{edg=
eworker/sbox}(255721)
                   =E2=94=9C=E2=94=80edgeworker/stry(5803)
                   =E2=94=9C=E2=94=80edgeworker/stry(63990)
                   =E2=94=9C=E2=94=80edgeworker/stry(106218)
                   =E2=94=9C=E2=94=80edgeworker/stry(191905)
                   =E2=94=9C=E2=94=80edgeworker/stry(255695)
                   =E2=94=9C=E2=94=80edgeworker/supr(255717)

Here sbox processes do actual work living in an empty mount namespaces
and stry is a helper process for error reporting. All tasks come from
the same binary that lives in the root mount namespace, launched by
systemd.

During "perf script" run on a trace obtained from the system there are
these possible outcomes:

1. The first pid to be processed is a non-namespaced helper and
symbols are present.
2. The first pid is not found and symbols are present.
3. The first pid is a sandboxed task and symbols are missing.

Symbols are missing, because "perf script" tries to jump into an empty
sandbox and find a binary there, when in fact it lives outside:

getcwd("/state/home/ivan", 4096)        =3D 17
open("/proc/self/ns/mnt", O_RDONLY)     =3D 5
open("/proc/255719/ns/mnt", O_RDONLY)   =3D 6
setns(6, CLONE_NEWNS)                   =3D 0
stat("/usr/local/bin/edgeworker", 0x7ffedb9b3ca0) =3D -1 ENOENT (No such
file or directory)

In the second outcome we don't have a PID to figure out the namespace
to jump into, so this doesn't happen. It's a good fallback, but it was
a bit confusing during debugging.

It's not entirely clear to me why sometimes a helper PID is picked,
even though it's not the first sample in the recorded trace (at least
not in the output). This happens deterministically, or at least
appears so. In my process tree it's 255695.

I think perf should try to fallback to the default namespace to look
up symbols if they are not found inside to cover our case. Relevant
piece of logic is here:

* https://elixir.free-electrons.com/linux/v5.4.1/source/tools/perf/util/dso=
.c#L520
