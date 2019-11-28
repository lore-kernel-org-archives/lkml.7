Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41092C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145F92178F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix8yuAd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1Pw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:52:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbfK1Pw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3fDLclsp32DrX7lHGecyNEsumQtWNMyutGYTGa++y0=;
        b=ix8yuAd0Kk5iCvHL5i15cTO5ZB+bloJnf03jXyqiEAIkE36m0ghe5rK109bWbYbPJCYCqF
        loW7hUaSo86NHpqq0odZMOsWXlvH826JbnO5m+07Npp/K1EERm2xtPpXqHByP1+9AdLCwG
        hpmNrrKNTykem1yrZqAlCc8dvExB+MM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-QZYMkIMQMD2yjpMo7QCV7A-1; Thu, 28 Nov 2019 10:52:23 -0500
Received: by mail-lf1-f71.google.com with SMTP id y195so3429448lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oTYDHNQIqswqEUFec83Wq4PCKAJTly7z4dAKA/xDHuk=;
        b=B7oSsvJMDO9Bc54TVVU99PTtKqkZs7tHsEfrQ4uSccON4C9iWUgoWA1tlV1FpfEwA2
         EoRtGn+CeYOjincWtzHxb8GJ7iwY+7ju7sd7ECquplGty/l65PMyRaq42KlcWj5o3LoK
         pbbKvsHTDmYcXar9IgYbxroH+kLtZCeqzVQw9jyGYzFMoJSx3lrkXHgqGhAGz8KjW2Ay
         sgjg3XnKYXMC4witlU9UsKzteWfF7wruPYyZD4UFINhydnXJLagAh0I+D9G4TC9tabDg
         aWz7o01YyXd7/ekqTGafUs4mSv0ugoebYBxv8r+fp/+1+5dRwnJIa7pn+nqUZgxvXh51
         gwFA==
X-Gm-Message-State: APjAAAX7uqUHZtZpMyeAlspXvOOMAesBdnX5vXxojax2woq5/OMfkpjw
        jN81N0zNfiqnjEHlYpWXylh0LJds89nQFUl4ZdzM3No9G/feGqb0bd4OYeJad2Aeq2a1VWaUc5s
        BoC+K8l4TRsu6KK8On6u7R+mc
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr17468748lfi.98.1574956342342;
        Thu, 28 Nov 2019 07:52:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxaMutvc3D5hmGxAEkL9f+k3ILi2Bmxqm33wKbriT6cekL0COYBq15Gk0c8D3HzjYBnmO+pwA==
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr17468737lfi.98.1574956342155;
        Thu, 28 Nov 2019 07:52:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o26sm8597809lfi.57.2019.11.28.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:52:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A69DA180339; Thu, 28 Nov 2019 16:52:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf v2] bpftool: Allow to link libbpf dynamically
In-Reply-To: <497b4151-9aad-f3a9-3aff-78d665e5f750@netronome.com>
References: <20191128145316.1044912-1-toke@redhat.com> <497b4151-9aad-f3a9-3aff-78d665e5f750@netronome.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Nov 2019 16:52:20 +0100
Message-ID: <871rtsvw0b.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: QZYMkIMQMD2yjpMo7QCV7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quentin Monnet <quentin.monnet@netronome.com> writes:

> 2019-11-28 15:53 UTC+0100 ~ Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com>
>> From: Jiri Olsa <jolsa@kernel.org>
>>=20
>> Currently we support only static linking with kernel's libbpf
>> (tools/lib/bpf). This patch adds LIBBPF_DYNAMIC compile variable
>> that triggers libbpf detection and bpf dynamic linking:
>>=20
>>   $ make -C tools/bpf/bpftool make LIBBPF_DYNAMIC=3D1
>>=20
>> If libbpf is not installed, build (with LIBBPF_DYNAMIC=3D1) stops with:
>>=20
>>   $ make -C tools/bpf/bpftool LIBBPF_DYNAMIC=3D1
>>     Auto-detecting system features:
>>     ...                        libbfd: [ on  ]
>>     ...        disassembler-four-args: [ on  ]
>>     ...                          zlib: [ on  ]
>>     ...                        libbpf: [ OFF ]
>>=20
>>   Makefile:102: *** Error: No libbpf devel library found, please install=
-devel or libbpf-dev.
>>=20
>> Adding LIBBPF_DIR compile variable to allow linking with
>> libbpf installed into specific directory:
>>=20
>>   $ make -C tools/lib/bpf/ prefix=3D/tmp/libbpf/ install_lib install_hea=
ders
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/libb=
pf/
>>=20
>> It might be needed to clean build tree first because features
>> framework does not detect the change properly:
>>=20
>>   $ make -C tools/build/feature clean
>>   $ make -C tools/bpf/bpftool/ clean
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
>> v2:
>>   - Pass .a file to linker when dynamically linking, so bpftool can use
>>     private functions from libbpf without exposing them as API.
>>    =20
>>  tools/bpf/bpftool/Makefile | 38 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 39bc6f0f4f0b..397051ed9e41 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -1,6 +1,15 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> +# LIBBPF_DYNAMIC to enable libbpf dynamic linking.
>> +
>>  include ../../scripts/Makefile.include
>>  include ../../scripts/utilities.mak
>> +include ../../scripts/Makefile.arch
>> +
>> +ifeq ($(LP64), 1)
>> +  libdir_relative =3D lib64
>> +else
>> +  libdir_relative =3D lib
>> +endif
>> =20
>>  ifeq ($(srctree),)
>>  srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>> @@ -55,7 +64,7 @@ ifneq ($(EXTRA_LDFLAGS),)
>>  LDFLAGS +=3D $(EXTRA_LDFLAGS)
>>  endif
>> =20
>> -LIBS =3D $(LIBBPF) -lelf -lz
>> +LIBS =3D -lelf -lz
>
> Hi Toke,
>
> You don't need to remove $(LIBBPF) here, because you add it in both
> cases below (whether $(LIBBPF_DYNAMIC) is defined or not).

Oh, right, good point; will fix :)

