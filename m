Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E771C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528612147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1B+uHOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfCKU51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:57:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42581 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfCKU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:57:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id u7so163700qtg.9;
        Mon, 11 Mar 2019 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oTqIPcquLN0WxH7JpOcWhV3nfI5Ss1yHEcWa/CSFZrQ=;
        b=W1B+uHOze3+y7LtTW3aOCalmIBhvcODWbzGZbNL/WfFZ+mRsUAcRRe1lmZRmGCOoML
         fyFC/+FuYb+5+dFbonZejq8bPWMgbVqyUGqkRRKvkJM4opKCtqYUA1dU+Xx2JniO9Vrg
         KmT/Yq2H6aiUzRedFcb802w7MMLpeBItf/1oeRwmjCJ32Cg5noIbwQ7wIr9vv3ms5tSr
         eVwXzrWikLIui0KiLbPYMCkHmum2EqsYOcoQlRrLUGn+N4Rhig1YHQTv1QtoBigRxTRr
         SbZaUvEgH3q1HCgqq1et3hMIP/xBRNlh2mV8JH5IpEB1Bum4WhpMmyjAREjNBJaA8OWL
         B95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oTqIPcquLN0WxH7JpOcWhV3nfI5Ss1yHEcWa/CSFZrQ=;
        b=hBm5iNrMcAnue5K5j2/jvwN+nXANxZIZEaDQKDzcDhpuw0Mz1N5ozcd7ihIhUs3GzV
         oSnWDvK316slwwevjBYPZOp4EjjVxyK/gjHFaqirit3duxjmRGnphE320N77Q3MhcleD
         IysV33ttuSDdWpXcWQRoYu9W169vn7zyFxTitczJbiUCzmoUKGs8gTEXJ+h/u2pV/V8X
         qP+ZR/j2stTxKEm6TCtP63Tzn09rjgLri7cFurY3214j+AcbRG96L3csQOZwajejHWUK
         Un7cziuvXXDgqvadVAC8t264Hzpr/X7KaVRinjYgU5WPI+acIJ2Xgm3ZYWaG4Esz5n+z
         58Tw==
X-Gm-Message-State: APjAAAXOfCWZ33pys1VrzoBm2mZnPqlcvkGDY5MWpw8OmveU/s8VJuBn
        RF9gIVPliV62Px+6BFSG/cg=
X-Google-Smtp-Source: APXvYqzxuchVkvCkb8IuuayhpFMDjrKoZYSY8r0L9q9wuHTIsvf1OhR6VHEtVsYezOXzQQm6VPo+vA==
X-Received: by 2002:ac8:3181:: with SMTP id h1mr17242637qte.294.1552337844812;
        Mon, 11 Mar 2019 13:57:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id f18sm4582177qta.64.2019.03.11.13.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:57:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E0B14039C; Mon, 11 Mar 2019 17:57:20 -0300 (-03)
Date:   Mon, 11 Mar 2019 17:57:20 -0300
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, kernel-team@fb.com, peterz@infradead.org,
        acme@redhat.com, jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v7 perf,bpf 02/15] bpf: libbpf: introduce
 bpf_program__get_prog_info_linear()
Message-ID: <20190311205720.GD10690@kernel.org>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-3-songliubraving@fb.com>
 <20190311182631.GX10690@kernel.org>
 <b6fb25aa-5bfc-cf97-f960-5966154e5ef5@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fb25aa-5bfc-cf97-f960-5966154e5ef5@iogearbox.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 09:45:49PM +0100, Daniel Borkmann escreveu:
> On 03/11/2019 07:26 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 07, 2019 at 09:57:57AM -0800, Song Liu escreveu:
> >> Currently, bpf_prog_info includes 9 arrays. The user has the option to
> >> fetch any combination of these arrays. However, this requires a lot of
> >> handling of these arrays. This work becomes more tricky when we need to
> >> store bpf_prog_info to a file, because these arrays are allocated
> >> independently.
> >>
> >> This patch introduces struct bpf_prog_info_linear, which stores arrays
> >> of bpf_prog_info in continues memory. Helper functions are introduced
> >> to unify the work to get different information of bpf_prog_info.
> >> Specifically, bpf_program__get_prog_info_linear() allows the user to
> >> select which arrays to fetch, and handles details for the user.
> >>
> >> Plesae see the comments before enum bpf_prog_info_array for more details
> >> and examples.
> >>
> >> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >> Cc: Alexei Starovoitov <ast@kernel.org>
> > 
> > Daniel, are you ok with these changes to libbpf and bpftool? Perhaps
> > those should be detached from this patchkit and submitted sooner,
> > eroding the size of this kit.
> > 
> > Alternatively, if you're ok with it, please provide your Acked-by and
> > I'll process as soon as I get back to it after Jiri is done reviewing.
> 
> Overall looks okay. Are you planning to get these in for 5.1 window? If

I hope so.

> yes, that would be great, otherwise we might need to cherry-pick the libbpf

So I'll try and grab those for my next pull req to Ingo, this week,
will add your Acked-by, ok?

> and bpftool ones from your tree into bpf-next as well since there's just
> too much going on in this area where we'd potentially run into complex
> merge conflicts. In the latter case, libbpf.map would need to be fixed up
> to LIBBPF_0.0.3 as convention is that this is in line with kernel release.

BTW, while running my build tests I had to add this to today's batch,
should be trivial when merging, I think, ok?


commit dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Mar 11 17:07:52 2019 -0300

    tools lib bpf: Fix the build by adding a missing stdarg.h include
    
    The libbpf_print_fn_t typedef uses va_list without including the header
    where that type is defined, stdarg.h, breaking in places where we're
    unlucky for that type not to be already defined by some previously
    included header.
    
    Noticed while building on fedora 24 cross building tools/perf to the ARC
    architecture using the uClibc C library:
    
      28 fedora:24-x-ARC-uClibc   : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
    
        CC       /tmp/build/perf/tests/llvm.o
      In file included from tests/llvm.c:3:0:
      /git/linux/tools/lib/bpf/libbpf.h:57:20: error: unknown type name 'va_list'
            const char *, va_list ap);
                          ^~~~~~~
      /git/linux/tools/lib/bpf/libbpf.h:59:34: error: unknown type name 'libbpf_print_fn_t'
       LIBBPF_API void libbpf_set_print(libbpf_print_fn_t fn);
                                        ^~~~~~~~~~~~~~~~~
      mv: cannot stat '/tmp/build/perf/tests/.llvm.o.tmp': No such file or directory
    
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Quentin Monnet <quentin.monnet@netronome.com>
    Cc: Stanislav Fomichev <sdf@google.com>
    Cc: Yonghong Song <yhs@fb.com>
    Fixes: a8a1f7d09cfc ("libbpf: fix libbpf_print")
    Link: https://lkml.kernel.org/n/tip-5270n2quu2gqz22o7itfdx00@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b4652aa1a58a..aa1521a51687 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -10,6 +10,7 @@
 #ifndef __LIBBPF_LIBBPF_H
 #define __LIBBPF_LIBBPF_H
 
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <stdbool.h>
