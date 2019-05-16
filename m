Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852E6C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5130E206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="BQLpv+w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfEPJbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:31:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38327 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEPJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:31:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so2453889ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=scP5pJngsU9KJ/PvOc7PkGn3ctf+6jypjet7NqrKqmA=;
        b=BQLpv+w5ngjqKJjwCym2ZWvuhIyTXrQXe/cH0kkyhS3AsX/8P4b2Uup0CJ63BRhZw6
         0f6scy9IOKguNgia+DARy/Pgsf9ihVfdo+x2VptKljZpgjcpQh2K6bqp5DpPLMTCR1Ms
         G/Ir19EM1+91HaPREMy7MEtETZbC78Ge1OCtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=scP5pJngsU9KJ/PvOc7PkGn3ctf+6jypjet7NqrKqmA=;
        b=bPa+AqhTIfWtNidjxjz2G6x5crJnlKicPA66PdMXTc7FiCErXrUNI+4PhODdG9nccN
         7fXMZydNiphM8nyTQqwRJFqcFiB0Mf9KXOuQ60X0B5Cc9PNeUWiottoupNfbO5bowIFz
         ZDpNRk2kVycaI77+hbnm9TaIZAJD70Yutc7JwRNYPYkLFBGnFkMHbqhzI2NLqT/1R5jG
         CzgdwsDeLuFD7U0nZw/0gHRdoRplJgOcaTmUb0n3f2OLZNm9EUEu09euzCjMyLCi7QAR
         VyRX6gntEQdrZkMPlsHXdNYa1Q8K2LMBlqL7Vr38mmJrZiTIzshjR90Jx/olJjLLBXJn
         a0oQ==
X-Gm-Message-State: APjAAAUDewxE+nGdgiVnF9mLqHjdx9STD2YJe9y8SnXjOHdMTUQJjyOb
        Js5IbVGZzFZg2Aqvv2YujP7jhsdqEthZodNWhidkoQ==
X-Google-Smtp-Source: APXvYqwNaOEDdnyE4kovKiBd0lYy36SnZeTUeTmEcc48z/VV0dfPM42qlRB+DSHJU6bby/xttsO3fxo4hMv92OjcJ48=
X-Received: by 2002:a2e:74f:: with SMTP id i15mr22844265ljd.156.1557999075116;
 Thu, 16 May 2019 02:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190515134731.12611-1-krzesimir@kinvolk.io> <20190515134731.12611-4-krzesimir@kinvolk.io>
 <20190515145037.6918f626@cakuba.netronome.com>
In-Reply-To: <20190515145037.6918f626@cakuba.netronome.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Thu, 16 May 2019 11:31:04 +0200
Message-ID: <CAGGp+cHqJZFfYt9VUAuQ7SpCZZ9ijoreKVBumc+wnGfw7pAXTA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/3] selftests/bpf: Avoid a clobbering of errno
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     bpf@vger.kernel.org,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:51 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Wed, 15 May 2019 15:47:28 +0200, Krzesimir Nowak wrote:
> > Save errno right after bpf_prog_test_run returns, so we later check
> > the error code actually set by bpf_prog_test_run, not by some libcap
> > function.
> >
> > Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Fixes: 5a8d5209ac022 ("selftests: bpf: add trivial JSET tests")
>
> This commit (of mine) just moved this code into a helper, the bug is
> older:
>
> Fixes: 832c6f2c29ec ("bpf: test make sure to run unpriv test cases in tes=
t_verifier")

Oops, ok. Will fix it. Thanks.

>
> > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index bf0da03f593b..514e17246396 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -818,15 +818,17 @@ static int do_prog_test_run(int fd_prog, bool unp=
riv, uint32_t expected_val,
> >       __u32 size_tmp =3D sizeof(tmp);
> >       uint32_t retval;
> >       int err;
> > +     int saved_errno;
> >
> >       if (unpriv)
> >               set_admin(true);
> >       err =3D bpf_prog_test_run(fd_prog, 1, data, size_data,
> >                               tmp, &size_tmp, &retval, NULL);
> > +     saved_errno =3D errno;
> >       if (unpriv)
> >               set_admin(false);
> >       if (err) {
> > -             switch (errno) {
> > +             switch (saved_errno) {
> >               case 524/*ENOTSUPP*/:
> >                       printf("Did not run the program (not supported) "=
);
> >                       return 0;
>


--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
