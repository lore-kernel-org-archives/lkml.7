Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07435C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDAF21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFHkQXLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfK1Auo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:50:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37274 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK1Aun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:50:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so23234750qtk.4;
        Wed, 27 Nov 2019 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:message-id;
        bh=iHydohAPOzO89msLeZh6Uwj6AIghWzgwnlhHO0NzO6g=;
        b=bFHkQXLFu7iTjmmzSIGubl0LahGtEszr34tCeYHWaXu2wSHYyHif7Z4NFNLLYf6X14
         pMnqfQo0cfYcKpeQh4RhY0H7ZfkXGMXB7Uzz8aARgiaUyPLnpTTFgBKRxqPw9sXfjSia
         43sDnNdvGsTQEkmOldJazVnvc37MdVe8S3h59aNJBVP3g3PWk0QLFP7b+MIYiGvNyO3K
         WmcRIaLXoCcjq/zwk9el787AGFygnbjHeYY+ci6s2DyKD6KzGbKFbCDbLZg0cXbxRcpx
         c5u9Qc5u3pdWXSljc98z8CdBNEi5TLNgens6V0XVASkaOGMYfDdkcK4a8vE7GG+emOtP
         XURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:message-id;
        bh=iHydohAPOzO89msLeZh6Uwj6AIghWzgwnlhHO0NzO6g=;
        b=P2X+bhuV4miu+jQKZ83Kjl2qADOLJFvzKeRQq+T1kHwBjDv/5PsORdOi1U24jjwd9o
         rQaJK3dmeJD2tjgG6kt/4uxGOx8DQ7Txg0TfhhRNWG21oRkh5mJVMQTiv9LSKJXs0kj3
         UqRDQnctbx/kD4RNRDV7WP9ad7ojalMXmNjCdDqrMPWogkh3SlYdUlBQRzLKaCMTK2y4
         5bOohT5AuelAAHNrwP24ooutKkAkXWhKTWLHjvOo54fuNhEEF4VIfBpk0niPwxkOoRuN
         O7oOvVODh9kBF9Sw/KqFzfs/tA5aPaWdTFVmTGqzmp+y3CqTU2mFsyT9ReqdzlR4cSFY
         iwfw==
X-Gm-Message-State: APjAAAW9tFpG/dz6IAo08TvCq7L4pNVz+O4Ruinb0Fgf3DJFmF8Gr9d1
        Fj/CS1uj04bzNRQmdfmgJBrBbsno7/OZsg==
X-Google-Smtp-Source: APXvYqwkJnMz10psfooH3RBiJ+kgfUX+1FgROPL2MkbMEcIfXI0xQtFsRRqGDhgk6VPaKH7nsZQpbw==
X-Received: by 2002:ac8:661a:: with SMTP id c26mr43028921qtp.317.1574902240900;
        Wed, 27 Nov 2019 16:50:40 -0800 (PST)
Received: from [192.168.86.249] ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z6sm7629261qkz.101.2019.11.27.16.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 16:50:40 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Wed, 27 Nov 2019 21:51:15 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAADnVQJCMpke49NNzy33EKdwpW+SY1orTm+0f0b-JuW8+uA7Yw@mail.gmail.com>
References: <87imn6y4n9.fsf@toke.dk> <20191126183451.GC29071@kernel.org> <87d0dexyij.fsf@toke.dk> <20191126190450.GD29071@kernel.org> <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com> <20191126221018.GA22719@kernel.org> <20191126221733.GB22719@kernel.org> <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com> <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net> <20191126155228.0e6ed54c@cakuba.netronome.com> <20191127013901.GE29071@kernel.org> <CAADnVQJCMpke49NNzy33EKdwpW+SY1orTm+0f0b-JuW8+uA7Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        =?ISO-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <2993CDB0-8D4D-4A0C-9DB2-8FDD1A0538AB@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 27, 2019 9:31:41 PM GMT-03:00, Alexei Starovoitov <alexei=2Esta=
rovoitov@gmail=2Ecom> wrote:
>On Tue, Nov 26, 2019 at 5:39 PM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Tue, Nov 26, 2019 at 03:52:28PM -0800, Jakub Kicinski escreveu:
>> > On Tue, 26 Nov 2019 15:10:30 -0800, Stanislav Fomichev wrote:
>> > > We are using this script with python2=2E7, works just fine :-)
>> > > So maybe doing s/python3/python/ is the way to go, whatever
>> > > default python is installed, it should work with that=2E
>>
>> > That increases the risk someone will make a python2-only change
>> > and break Python 3=2E
>>
>> > Python 2 is dead, I'm honestly surprised this needs to be said :)
>>
>> It shouldn't have to be said, and probably it is old school to try
>and
>> keep things portable when there is no need to use new stuff for
>simple
>> tasks like this=2E
>>
>> Anyway, it seems its just a matter of adding the python3 package to
>the
>> old container images and then most of them will work with what is in
>> that script, what doesn't work is really old and then NO_LIBBPF=3D1 is
>the
>> way to go=2E
>>
>> In the end, kinda nothing to see here, go back to adding cool new
>stuff,
>> lets not hold eBPF from progressing ;-P
>
>Absolutely=2E I think if some distro is still using 32-bit userland it's
>likely
>so much behind anything modern that its kernel is equally old too
>and appeal of new features (bpf or anything else) is probably low=2E
>So if I were you I would keep 32-bit builds of perf supported, but with
>minimal effort=2E

I try not to assume too much, just try to keep what's being tested to cont=
inue to at least build=2E

>Re: patch itself=2E
>I can take it as-is into bpf tree and it will be in Linus's tree in few
>days=2E
>Or I can take only tools/lib/bpf/Makefile hunk and you can take
>tools/perf/MANIFEST via perf tree?
>Whichever way is fine=2E

Take it as one, I think it's what should have been in the cset it is fixin=
g, that way no breakage would have happened=2E

- Arnaldo

