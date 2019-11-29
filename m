Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2B217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIne5VQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfK2OAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:00:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726770AbfK2OAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575036049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b1qvJKJMmgAGkM2d8KkALdWXaJTGyaCyZOeDvMEs3E=;
        b=TIne5VQgFbTwGC4vDB8AMmUexEEx/atuHlZ9Bt7dq0K9QdkoWWhsntxLOU4RMNGI6ZeYLY
        tOoc1awdYeo59xw/mBQRSSscjiwAmoYm/2wTOfanXJiInpWXbTdr+GyFyFni1gcl67s1Qz
        D/nOb0gqHbz1Y+r8HOrvGDrxOr6qVYU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-U9lMvnUiMxyo48S5VRgpFw-1; Fri, 29 Nov 2019 09:00:44 -0500
Received: by mail-lf1-f69.google.com with SMTP id u17so6269939lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 06:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nznlG+jEmJBUCeGnvKlHOT18vQFcrvM/gSvDwhtrSfY=;
        b=f+P6pMQwQGGAu5llg5XgxFWE1pwUuJzAb764IfVRuMMWAhfXFlaH4WGGOqSsp2r9jO
         EgC/Z8B1qgGW/ak6sxUgYTE7v9iFnuJf+3W9TNyFZHJAd3Yi4Qohp6U+lZbnoJOI+iea
         5J67IwN/DN3iF0pSoy8fp97xEhQNYUEMK8Sd7QqlDlHPVJUK648Mp9mIqfFyHKcOdSM1
         L4fI+s468McU06ObfZZZ/IDV1axAju3SjzrXBbkQEXGNKRWorafXvw77sIk6qFf7bxR7
         A4H8M/h4aZ05CmNkpnn0TTTLFb4tXFk9CP7do4a73dPOPSKcRJ4V25iFBAlnXfkhIaON
         LOuA==
X-Gm-Message-State: APjAAAXyoqhCWmMz4laU3PHcnm1iQU9NzFvegJGKOW0q55dtGacduGKS
        5fKh+XpyasrQK+SMVQLTdkx6qPxgx30uBLz7tdiy52fqlSC61ZV7/iz1q/jEMD3EGUgo7VoKg0p
        W2UKvIbINJYGZ7PfOWn8OEeex
X-Received: by 2002:a2e:8855:: with SMTP id z21mr39422142ljj.212.1575036043050;
        Fri, 29 Nov 2019 06:00:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqz28Bd8f/J7BOBAW2B1uN/PHxldgbyIJWg1HRDOQRKNKQNE9kOVrRrKRXQ/FeMftWLjXGZeSA==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr39422099ljj.212.1575036042728;
        Fri, 29 Nov 2019 06:00:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m9sm1211958lfj.57.2019.11.29.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 06:00:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4ACC9181923; Fri, 29 Nov 2019 15:00:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, kubakici@wp.pl
Subject: Re: [PATCH bpf v3] bpftool: Allow to link libbpf dynamically
In-Reply-To: <f6e8f6d2-6155-3b20-9975-81e29e460915@iogearbox.net>
References: <20191128160712.1048793-1-toke@redhat.com> <f6e8f6d2-6155-3b20-9975-81e29e460915@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 29 Nov 2019 15:00:40 +0100
Message-ID: <87a78evl2v.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: U9lMvnUiMxyo48S5VRgpFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 11/28/19 5:07 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> From: Jiri Olsa <jolsa@kernel.org>
>>=20
>> Currently we support only static linking with kernel's libbpf
>> (tools/lib/bpf). This patch adds LIBBPF_DYNAMIC compile variable
>> that triggers libbpf detection and bpf dynamic linking:
>>=20
>>    $ make -C tools/bpf/bpftool make LIBBPF_DYNAMIC=3D1
>>=20
>> If libbpf is not installed, build (with LIBBPF_DYNAMIC=3D1) stops with:
>>=20
>>    $ make -C tools/bpf/bpftool LIBBPF_DYNAMIC=3D1
>>      Auto-detecting system features:
>>      ...                        libbfd: [ on  ]
>>      ...        disassembler-four-args: [ on  ]
>>      ...                          zlib: [ on  ]
>>      ...                        libbpf: [ OFF ]
>>=20
>>    Makefile:102: *** Error: No libbpf devel library found, please instal=
l libbpf-devel or libbpf-dev.
>>=20
>> Adding LIBBPF_DIR compile variable to allow linking with
>> libbpf installed into specific directory:
>>=20
>>    $ make -C tools/lib/bpf/ prefix=3D/tmp/libbpf/ install_lib install_he=
aders
>>    $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/lib=
bpf/
>>=20
>> It might be needed to clean build tree first because features
>> framework does not detect the change properly:
>>=20
>>    $ make -C tools/build/feature clean
>>    $ make -C tools/bpf/bpftool/ clean
>>=20
>> Since bpftool uses bits of libbpf that are not exported as public API in
>> the .so version, we also pass in libbpf.a to the linker, which allows it=
 to
>> pick up the private functions from the static library without having to
>> expose them as ABI.
>>=20
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> v3:
>>    - Keep $(LIBBPF) in $LIBS, and just add -lbpf on top
>>    - Fix typo in error message
>> v2:
>>    - Pass .a file to linker when dynamically linking, so bpftool can use
>>      private functions from libbpf without exposing them as API.
>>=20
>>   tools/bpf/bpftool/Makefile | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>=20
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 39bc6f0f4f0b..15052dcaa39b 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -1,6 +1,15 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +# LIBBPF_DYNAMIC to enable libbpf dynamic linking.
>> +
>>   include ../../scripts/Makefile.include
>>   include ../../scripts/utilities.mak
>> +include ../../scripts/Makefile.arch
>> +
>> +ifeq ($(LP64), 1)
>> +  libdir_relative =3D lib64
>> +else
>> +  libdir_relative =3D lib
>> +endif
>>  =20
>>   ifeq ($(srctree),)
>>   srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>> @@ -63,6 +72,19 @@ RM ?=3D rm -f
>>   FEATURE_USER =3D .bpftool
>>   FEATURE_TESTS =3D libbfd disassembler-four-args reallocarray zlib
>>   FEATURE_DISPLAY =3D libbfd disassembler-four-args zlib
>> +ifdef LIBBPF_DYNAMIC
>> +  FEATURE_TESTS   +=3D libbpf
>> +  FEATURE_DISPLAY +=3D libbpf
>> +
>> +  # for linking with debug library run:
>> +  # make LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/opt/libbpf
>
> The Makefile already has BPF_DIR which points right now to
> '$(srctree)/tools/lib/bpf/' and LIBBPF_PATH for the final one and
> where $(LIBBPF_PATH)libbpf.a is expected to reside. Can't we improve
> the Makefile to reuse and work with these instead of adding yet
> another LIBBPF_DIR var which makes future changes in this area more
> confusing? The libbpf build spills out libbpf.{a,so*} by default
> anyway.

I see what you mean; however, LIBBPF_DIR is meant to be specifically an
override for the dynamic library, not just the path to libbpf.

Would it be less confusing to overload the LIBBPF_DYNAMIC variable
instead? I.e.,

make LIBBPF_DYNAMIC=3D1

would dynamically link against the libbpf installed in the system, but

make LIBBPF_DYNAMIC=3D/opt/libbpf

would override that and link against whatever is in /opt/libbpf instead?
WDYT?

> Was wondering whether we could drop LIBBPF_DYNAMIC altogether and have
> some sort of auto detection, but given for perf the `make
> LIBBPF_DYNAMIC=3D1` option was just applied to perf tree it's probably
> better to stay consistent plus static linking would stay as-is for
> preferred method for bpftool, so that part seems fine.

When adding LIBBPF_DYNAMIC in a packaging script, we *want* the build to
fail if it doesn't work, instead of just silently falling back to a
statically linked version. Also, for something in the kernel tree like
bpftool, I think it makes more sense to default to the in-tree version
and make dynamic linking explicitly opt-in.

>> +  ifdef LIBBPF_DIR
>> +    LIBBPF_CFLAGS  :=3D -I$(LIBBPF_DIR)/include
>> +    LIBBPF_LDFLAGS :=3D -L$(LIBBPF_DIR)/$(libdir_relative)
>> +    FEATURE_CHECK_CFLAGS-libbpf  :=3D $(LIBBPF_CFLAGS)
>> +    FEATURE_CHECK_LDFLAGS-libbpf :=3D $(LIBBPF_LDFLAGS)
>> +  endif
>> +endif
>>  =20
>>   check_feat :=3D 1
>>   NON_CHECK_FEAT_TARGETS :=3D clean uninstall doc doc-clean doc-install =
doc-uninstall
>> @@ -88,6 +110,18 @@ ifeq ($(feature-reallocarray), 0)
>>   CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
>>   endif
>>  =20
>> +ifdef LIBBPF_DYNAMIC
>> +  ifeq ($(feature-libbpf), 1)
>> +    # bpftool uses non-exported functions from libbpf, so just add the =
dynamic
>> +    # version of libbpf and let the linker figure it out
>> +    LIBS    :=3D -lbpf $(LIBS)
>
> Seems okay as a workaround for bpftool and avoids getting into the
> realm of declaring libbpf as another half-baked netlink library if
> we'd have exposed these. Ideally the netlink symbols shouldn't be
> needed at all from libbpf, but I presume the rationale back then was
> that given it's used internally in libbpf for some of the APIs and was
> needed in bpftool's net subcommand as well later on, it avoided
> duplicating the code given statically linked and both are in-tree
> anyway.

Yeah, I do think it's a little odd that bpftool is using "private" parts
of libbpf, but since we can solve it like this I think that is OK.

-Toke

