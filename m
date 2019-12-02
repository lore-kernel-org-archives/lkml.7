Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FFCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A69720675
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1QVSALt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLBVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:15:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33304 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725834AbfLBVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575321342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqtlBsiEAqeGMc0cL3Eo0rcvGHxRZBHUuo8q1j2NE4s=;
        b=L1QVSALtK7bLtld1kDku1SO/FiDQMMpACJV8ZSIpXo5zhFstXXmNcTVEQEDSCfdNucLOQ4
        UhUYOXIuFPkYcj8K4k6estFZJUBQz1qsTrjeQ7tFPtAUxIHzNxfIcSa2pj/TBIO1gxM8qY
        Rh733rt54ed3Nh7646CVuj6TNqFb/cA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-as5ybKEDPtmoWu6R-mYHTw-1; Mon, 02 Dec 2019 16:15:39 -0500
Received: by mail-lj1-f197.google.com with SMTP id z17so137926ljz.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/ouSM1lVnL67PQdTS392czOikDoAX/1OhtnSM6w3ioA=;
        b=HAhtY4/50PZsNk8Xb6fOjzkosQH2F4JH2+lru/05QAu7PFYgw4Qy/g9BmkX2pvkdTq
         lKuuDhz822pOgkY85Q3bcnLH5tbt0LazCQQweG9qUrezDp8NszUAz1pH5AUxv9wDln+y
         rPgfyBg4Y40PNO2m/UIeZ7urQLznexU3jodLs4KKVjUYDSRo9gMwcZJbFCIRvKhfQTl0
         j3VyQIuSAOE/+AivICGv4Jjwxc54RvMAWwsv71syd81sndcP5lWcWZRx8CEY0oAwpUV+
         YvJyKBqNtjqbQnOflGckW2R8zavo7glL+VQHlQcN0W2q71/WQDoIydPHxvIbCeEO5jxs
         opyg==
X-Gm-Message-State: APjAAAU4LBpaYcgyF2E6/VNOnuwxoNCwmVTcdRXI7pCKsLLDmHfvFXRe
        IU2FSrxdz91/wVKWxsMiy2j5J0ME1WnnsP4uV91TuSmE2tJQO4piI7YMZjCCExFlF8R5JEUAkrZ
        ImvhnTA+309mh3P8TQz/rDrjl
X-Received: by 2002:a19:7513:: with SMTP id y19mr705322lfe.78.1575321338273;
        Mon, 02 Dec 2019 13:15:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqziTKggxyGWF5SicqNPqS1v54yq5kpVC6lMuqwhb8Et+uHGtiCio39/jHThcVA8JC6aYFLaUw==
X-Received: by 2002:a19:7513:: with SMTP id y19mr705299lfe.78.1575321338031;
        Mon, 02 Dec 2019 13:15:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m15sm340543ljg.4.2019.12.02.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 13:15:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 002971804D1; Mon,  2 Dec 2019 22:15:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCHv4 0/6] perf/bpftool: Allow to link libbpf dynamically
In-Reply-To: <CAEf4BzY_D9JHjuU6K=ciS70NSy2UvSm_uf1NfN_tmFz1445Jiw@mail.gmail.com>
References: <20191202131847.30837-1-jolsa@kernel.org> <CAEf4BzY_D9JHjuU6K=ciS70NSy2UvSm_uf1NfN_tmFz1445Jiw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Dec 2019 22:15:35 +0100
Message-ID: <87wobepgy0.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: as5ybKEDPtmoWu6R-mYHTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Dec 2, 2019 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> hi,
>> adding support to link bpftool with libbpf dynamically,
>> and config change for perf.
>>
>> It's now possible to use:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1
>>
>> which will detect libbpf devel package and if found, link it with bpftoo=
l.
>>
>> It's possible to use arbitrary installed libbpf:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/libb=
pf/
>>
>> I based this change on top of Arnaldo's perf/core, because
>> it contains libbpf feature detection code as dependency.
>>
>> Also available in:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>   libbpf/dyn
>>
>> v4 changes:
>>   - based on Toke's v3 post, there's no need for additional API exports:
>>
>>     Since bpftool uses bits of libbpf that are not exported as public AP=
I in
>>     the .so version, we also pass in libbpf.a to the linker, which allow=
s it to
>>     pick up the private functions from the static library without having=
 to
>>     expose them as ABI.
>
> Whoever understands how this is supposed to work, can you please
> explain? From reading this, I think what we **want** is:
>
> - all LIBBPF_API-exposed APIs should be dynamically linked against libbpf=
.so;
> - everything else used from libbpf (e.g., netlink APIs), should come
> from libbpf.a.
>
> Am I getting the idea right?
>
> If yes, are we sure it actually works like that in practice? I've
> compiled with LIBBPF_DYNAMIC=3D1, and what I see is that libelf, libc,
> zlib, etc functions do have relocations against them in ".rela.plt"
> section. None of libbpf exposed APIs, though, have any of such
> relocations. Which to me suggests that they are just statically linked
> against libbpf.a and libbpf.so is just recorded in ELF as a dynamic
> library dependency because of this extra -lbpf flag. Which kind of
> defeats the purpose of this whole endeavor, no?
>
> I'm no linker expert, though, so I apologize if I got it completely
> wrong, would really appreciate someone to detail this a bit more.
> Thanks!

Ah, that is my mistake: I was getting dynamic libbpf symbols with this
approach, but that was because I had the version of libbpf.so in my
$LIBDIR that had the patch to expose the netlink APIs as versioned
symbols; so it was just pulling in everything from the shared library.

So what I was going for was exactly what you described above; but it
seems that doesn't actually work. Too bad, and sorry for wasting your
time on this :/

-Toke

