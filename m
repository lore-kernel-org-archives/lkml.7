Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1808213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw6DjXkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCSOOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:14:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33774 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:14:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so16542511qtb.0;
        Tue, 19 Mar 2019 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OM9owmwvKRS01OI4mK1ktnHM+nGcsAzeMPtQsvOFsxA=;
        b=cw6DjXkKsX2RCbHWu7BlikbxmOwKfI/JbZmSLNau7AiuP7zXY8DjL3iIJGRajaA09y
         u38pEugm4Gj/z2MbY2kHxYadQTMZcHcWs+7ebpxccxyqK8G4gmEJSsQLUs6jyssE6nQz
         aBesHbk92I+w/C8ycX1lbEX+3YzVFv4Ffm96owMGFRurrRiAvi8jpbFO25M/nEGvXAl5
         jduMJveWG+ZbgofEMW/D6E6JWEOfgKWJ96TeVVa02X519jbsacnv7lKhHx8umca7wDn4
         XMkYu96udlQ5Ci551JdAEMyqOWcmptCHDI3jdWLkIFMiYndzKUDpGhwvjUbgeolrhR0V
         /9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OM9owmwvKRS01OI4mK1ktnHM+nGcsAzeMPtQsvOFsxA=;
        b=sClCYKPuLQttKpDoNnDk3IdWPHlaQxrEWufUa9BYVzNAsETUXWtoWV15Vu8qXaCUEu
         JBT68BvJeFILgkNJhIVJOsNSqFX0WlqoT/Nn/wa4cBApOC1dOKXdAuUACPclBO0bEBQP
         /STtSSnm2R414Qq++u77tIgB8RsfDRMrO4qIPe8v/TWOktouq8wiQwjri/Dl8wUyrthd
         ApnHzsa+AH6USQ6Oe2lAAgtxwBD9XgO/SYuieyX7wsVu3WJQOwOlLBErHe4yHKwxuo4X
         pY7o9vFaZIPqzBSDqxxNs4x86AbUlYutkG1BVvNzUKNS/1UVSlfuomBhN+ZQPQNeEztL
         GVXQ==
X-Gm-Message-State: APjAAAVWw4WKZbs33jv3GskpUaywm/772KeDn/UxU1Sfs/ruT6kOl6vv
        qfFLi8CupJKCX8lcrcRGqhU=
X-Google-Smtp-Source: APXvYqzQQKrMbYmFelByMvgkqglJFpyxuTO93PTIIN6jn4ftggyMAhNaVrzWtF92QunfMucxqHzqsw==
X-Received: by 2002:a0c:8864:: with SMTP id 33mr2074982qvm.155.1553004880191;
        Tue, 19 Mar 2019 07:14:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f66sm7295653qkj.11.2019.03.19.07.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 07:14:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFB834039C; Tue, 19 Mar 2019 11:14:35 -0300 (-03)
Date:   Tue, 19 Mar 2019 11:14:35 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190319141435.GD3029@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org>
 <9BC22A6D-B0A7-47B6-9526-E32924EF409D@fb.com>
 <20190319135813.GC3029@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319135813.GC3029@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 10:58:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 19, 2019 at 06:05:30AM +0000, Song Liu escreveu:
> > test-disassembler-four-args.c is an existing test used by bpftool.
> > It was added in fb982666e380c1632a74495b68b3c33a66e76430 .  

> > > After applying this test it "works":

> > >  make: Entering directory '/home/acme/git/perf/tools/perf'
> > >    BUILD:   Doing 'make -j8' parallel build

> > >  Auto-detecting system features:
> > >  ...                         dwarf: [ on  ]
> > >  ...            dwarf_getlocations: [ on  ]
> > >  <SNIP>
> > >  ...                           bpf: [ on  ]
> > >  ...                        libaio: [ on  ]
> > >  ...        disassembler-four-args: [ on  ]
> > > 
> > > Because you added it to FEATURE_TESTS_BASIC, and this means that if
> > > tools/build/feature/test-all.c builds, then what is in
> > > FEATURE_TESTS_BASIC is set to 'on', but you didn't add anything to
> > > tools/build/feature/test-all.c, so it works because all the other
> > > features are present.

> > > Take a look at:

> > >  2a07d814747b ("tools build feature: Check if libaio is available")

> > > To see what needs to be done.

> > I used different versions of gcc to verify that current version of the 
> > patch works for both test-succeed and test-fail cases. I guess something 
> > like the following is needed? But the test does work without it. 

> Even with the file below, it fails, as:

> [acme@quaco perf]$ cat /tmp/build/perf/feature/test-all.make.output
> /usr/bin/ld: /tmp/ccTj7iV6.o: in function `main_test_disassembler_four_args':
> /home/acme/git/perf/tools/build/feature/test-disassembler-four-args.c:9: undefined reference to `disassembler'
> collect2: error: ld returned 1 exit status
> [acme@quaco perf]$

> Then we do the test for each of the features and _then_ this works:

> [acme@quaco perf]$ ls -la /tmp/build/perf/feature/test-disassembler-four-args.*
> -rwxrwxr-x. 1 acme acme 2098312 Mar 19 10:51 /tmp/build/perf/feature/test-disassembler-four-args.bin
> -rw-rw-r--. 1 acme acme    1079 Mar 19 10:51 /tmp/build/perf/feature/test-disassembler-four-args.d
> -rw-rw-r--. 1 acme acme       0 Mar 19 10:51 /tmp/build/perf/feature/test-disassembler-four-args.make.output
> [acme@quaco perf]$
> 
> So there is still something missing, i.e. which objects to add to the
> test-all case, I'll fix it.

This was missing:

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c51b59e43dcc..4f491ad4f492 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,6 +227,8 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lopcodes
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables

----------------------

After that, and with a clean /tmp/build/perf, re-running:

  make -C tools/perf O=/tmp/build/perf

we get:

[acme@quaco perf]$ ls -la /tmp/build/perf/feature/
total 2888
drwxrwxr-x.  2 acme acme     400 Mar 19 11:08 .
drwxrwxr-x. 16 acme acme    4280 Mar 19 11:08 ..
-rwxrwxr-x.  1 acme acme 2680352 Mar 19 11:07 test-all.bin
-rw-rw-r--.  1 acme acme   38753 Mar 19 11:07 test-all.d
-rw-rw-r--.  1 acme acme       0 Mar 19 11:07 test-all.make.output
-rw-rw-r--.  1 acme acme     168 Mar 19 11:07 test-bionic.make.output
-rwxrwxr-x.  1 acme acme  140960 Mar 19 11:08 test-cplus-demangle.bin
-rw-rw-r--.  1 acme acme     101 Mar 19 11:08 test-cplus-demangle.d
-rw-rw-r--.  1 acme acme       0 Mar 19 11:08 test-cplus-demangle.make.output
-rwxrwxr-x.  1 acme acme   17976 Mar 19 11:08 test-jvmti.bin
-rwxrwxr-x.  1 acme acme   17984 Mar 19 11:08 test-jvmti-cmlr.bin
-rw-rw-r--.  1 acme acme    1107 Mar 19 11:08 test-jvmti-cmlr.d
-rw-rw-r--.  1 acme acme       0 Mar 19 11:08 test-jvmti-cmlr.make.output
-rw-rw-r--.  1 acme acme    1014 Mar 19 11:08 test-jvmti.d
-rw-rw-r--.  1 acme acme       0 Mar 19 11:08 test-jvmti.make.output
-rwxrwxr-x.  1 acme acme   18368 Mar 19 11:07 test-libbabeltrace.bin
-rw-rw-r--.  1 acme acme    1470 Mar 19 11:07 test-libbabeltrace.d
-rw-rw-r--.  1 acme acme       0 Mar 19 11:07 test-libbabeltrace.make.output
-rw-rw-r--.  1 acme acme     179 Mar 19 11:07 test-libunwind-aarch64.make.output
-rw-rw-r--.  1 acme acme     163 Mar 19 11:07 test-libunwind-x86.make.output
[acme@quaco perf]$

I.e. test-all.bin got built, and if we look at it:

[acme@quaco perf]$ nm /tmp/build/perf/feature/test-all.bin  | grep disassembler
0000000000061f90 T disassembler
0000000000062110 T disassembler_options_cmp
0000000000061fb0 T disassembler_usage
0000000000061f40 T main_test_disassembler_four_args
000000000006b7c0 T print_i386_disassembler_options
[acme@quaco perf]$ 

I.e. the -lopcodes was added to the test-all.bin, and as we include that
itest-disassembler-four-args.c in the test-all.c file, it gets linked
and that test-all.c build doesn't fail, so all that is in
FEATURE_TESTS_BASIC is marked as present, CFLAGS +=
-DDISASM_FOUR_ARGS_SIGNATURE gets set, etc.

Now the test is really being performed, the test-all.bin feature
detection fast path is working, proceeding.

- Arnaldo
