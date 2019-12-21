Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C270EC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9738521655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576916765;
	bh=yfe0+gECfjMeOf0g0RcldzMBeVJshSQYvuPVRG8ahjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ilJVDW4LKI4YtYpLAkE9ulBpy9S60YAWpFUSiu4AwxVk8OT9S3GAUzlzMaaGYZurX
	 YmnpMdt7drxKGLB6LPq0jvA4AVyZ7jUW8bdEPmP3stZFOnvZ2a8p5kMHftPVNyogor
	 MkQAG7KqBM+tcc+f+/FGb5bsJYJknaksv88BsouA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLUI0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:26:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46184 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfLUI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:26:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so11521914wrl.13;
        Sat, 21 Dec 2019 00:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebebit982XGYe1EwFDTKTd7VGALTM5sbxVsHsfjIDWQ=;
        b=gxmSEryIwfcMS8axId+olPN2w2nQcn0PRimbn9oFyeFs2bKrs+Zo/0BddqjPV/4lDw
         /7xrlppAavltFCSovWs5HtlhAH/StSo8htTkzbCB/eJJgorM4A93+Id3wuuU56cd0LJM
         JVIpORvoEEXp4ixYiJh8sluPNe4QRtLpjB4yS1zpWt5IlwYVDY0LPfOvKIrklIJ/WBid
         V6fYzCiw0LAKRgb9OkMVnqYNj0DVVQRVLYQkknAM0wtLccxwjtRu4t7HLgMQzLovbOyf
         g8fyWvUlbFNoGGJUGqyyjXcmxMoXfW69Lm99N7MWCuGbQ+W+/cObgUb+TrnalnGi/7wF
         mB+A==
X-Gm-Message-State: APjAAAUxNLxHsE68wIz0UFJo8ZfzlzNeSks0/TXJ83vnDvZA2riHtvSs
        OlDOJFqTIVoBv9IAiICRHa4kzLab8cP8/muVP68=
X-Google-Smtp-Source: APXvYqyN/nlNTFjkh3vUc6+Q4oiDMIMZ7Sb2NgmXZ/Bu4shjyF92sRXQoJhRgCnhGsD4kOK/5wTbswDB5YTozKzjnOs=
X-Received: by 2002:adf:ef10:: with SMTP id e16mr18632785wro.336.1576916762285;
 Sat, 21 Dec 2019 00:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20191220032558.3259098-1-namhyung@kernel.org> <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 21 Dec 2019 17:25:51 +0900
Message-ID: <CAM9d7cg0A0+Oq5uDS6ZJNzAgFsWc-Pd30GYC0+PxEXdcxAxBKg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Dec 21, 2019 at 5:29 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I got the following error when I tried to build perf on a read-only
> > filesystem with O=dir option.
> >
> >   $ cd /some/where/ro/linux/tools/perf
> >   $ make O=$HOME/build/perf
> >   ...
> >     CC       /home/namhyung/build/perf/lib.o
> >   /bin/sh: bpf_helper_defs.h: Read-only file system
> >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> >   make[2]: *** Waiting for unfinished jobs....
> >     LD       /home/namhyung/build/perf/libperf-in.o
> >     AR       /home/namhyung/build/perf/libperf.a
> >     PERF_VERSION = 5.4.0
> >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> >   make: *** [Makefile:70: all] Error 2
> >
> > It was becaused bpf_helper_defs.h was generated in current directory.
> > Move it to OUTPUT directory.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
>
> Overall nothing is obviously broken, except you need to fix up
> selftests/bpf's Makefile as well.

Thanks for pointing this out.  It's because bpf selftest also needs the
bpf_helper_defs.h right?  But I'm currently having a problem with LLVM
when building the selftests.  Can you help me testing the patch below?
(It should be applied after this patch.  Are you ok with it?)


>
> BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.
>
> Also subject prefix should look like [PATCH bpf-next] if it's meant to
> be applied against bpf-next.

Will do.

Thanks
Namhyung

-----------8<-------------
diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 866fc1cadd7c..897877f7849b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -151,9 +151,9 @@ $(DEFAULT_BPFTOOL): force
 $(BPFOBJ): force
        $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/

-BPF_HELPERS := $(BPFDIR)/bpf_helper_defs.h $(wildcard $(BPFDIR)/bpf_*.h)
-$(BPFDIR)/bpf_helper_defs.h:
-       $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/ bpf_helper_defs.h
+BPF_HELPERS := $(OUTPUT)/bpf_helper_defs.h $(wildcard $(BPFDIR)/bpf_*.h)
+$(OUTPUT)/bpf_helper_defs.h:
+       $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/ $(OUTPUT)/bpf_helper_defs.h

 # Get Clang's default includes on this system, as opposed to those seen by
 # '-target bpf'. This fixes "missing" files on some architectures/distros,
