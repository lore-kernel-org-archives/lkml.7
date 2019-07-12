Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A688AC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7190B21670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="IlAFH8R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGLRbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:31:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46357 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfGLRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:31:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so2696859lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=870SKb1WXY+omp2lETWZ2U7iRGmwAjuFse4c4kqsXQ4=;
        b=IlAFH8R8ZJ7jFXFCHbST8+Q1pLalP/oV1VC4slaoVML0jO1R1c7kXp9ag0nVAJ5gnT
         Acg1Tj4MinWdu8blrGgpoWctkx7XJu1dWECsF+Ecljky00SQ4iAviTgC0ditJB3gW5vQ
         Lrwq1ywc7DKxdIaM0TZag112YBUeBNMXNptzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=870SKb1WXY+omp2lETWZ2U7iRGmwAjuFse4c4kqsXQ4=;
        b=Cvm9E6fvBzaAFFmEQXztHWVHDAgSex3gD8xCooCDCoZQao96y3qjU/tfqZmP09lDoI
         zMlJHDm8oKAvpFPZ30MlWQDntR/RvOaHfxa7AqqicylVOddh/1bkFXIHoOuhZzH1Odgw
         yclhL6BVUFyBJrkOYRNv8hWGvxJWX/Y2dnXrQUeTRpcEJXCIzrQ+V+HS9aPGaIr80Ri2
         9pQg50623sB9jDLf+etsCvldgh2zXi6xiXn22QOxZzjqv3u0zcEQouvh4w6YJFW9926c
         2CEE+6l3+1HXCQokjSv05EqnwtIg4pjXyphpM3dqytwc+4OQE8kIBhs9Vx+aMiO3gUT6
         JDBA==
X-Gm-Message-State: APjAAAVVSkpYLhA366gzO2jgqHCcu+w/Zxasf2adWUzgp88zZeki6T+/
        CRSqW1sgfdGM+uYuS54j6svw2wKBIwERJJ65JSZsCQ==
X-Google-Smtp-Source: APXvYqzf9DWEr46hd2t3H6bd9Xv9rO0KN/ZiuYUHisPvmT42M5q2kUcXJUCIlRGvY/z/Q+wQz14fSUGSTbMIi3B1wmQ=
X-Received: by 2002:a05:6512:48f:: with SMTP id v15mr1332007lfq.37.1562952696564;
 Fri, 12 Jul 2019 10:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190708163121.18477-1-krzesimir@kinvolk.io> <20190708163121.18477-3-krzesimir@kinvolk.io>
 <CAEf4BzYra9njHOB8t6kxRu6n5NJdjjAG541OLt8ci=0zbbcUSg@mail.gmail.com>
 <CAGGp+cGnEBFoPAuhTPa_JFCW6Vbjp2NN0ZPqC3qGfWEXwTyVOQ@mail.gmail.com> <CAEf4Bzb-KW+p1zFcz39OSUuH0=DLFRNLa3NYT4V_-zz0Q_TJ5g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb-KW+p1zFcz39OSUuH0=DLFRNLa3NYT4V_-zz0Q_TJ5g@mail.gmail.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Fri, 12 Jul 2019 19:31:25 +0200
Message-ID: <CAGGp+cGgwO2YEtERi7aVz7+iex3x+MzT9+2Lst1JteS9DLAc=w@mail.gmail.com>
Subject: Re: [bpf-next v3 02/12] selftests/bpf: Avoid a clobbering of errno
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        xdp-newbies@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:59 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jul 11, 2019 at 5:04 AM Krzesimir Nowak <krzesimir@kinvolk.io> wr=
ote:
> >
> > On Thu, Jul 11, 2019 at 1:52 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jul 8, 2019 at 3:42 PM Krzesimir Nowak <krzesimir@kinvolk.io>=
 wrote:
> > > >
> > > > Save errno right after bpf_prog_test_run returns, so we later check
> > > > the error code actually set by bpf_prog_test_run, not by some libca=
p
> > > > function.
> > > >
> > > > Changes since v1:
> > > > - Fix the "Fixes:" tag to mention actual commit that introduced the
> > > >   bug
> > > >
> > > > Changes since v2:
> > > > - Move the declaration so it fits the reverse christmas tree style.
> > > >
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Fixes: 832c6f2c29ec ("bpf: test make sure to run unpriv test cases =
in test_verifier")
> > > > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > > > ---
> > > >  tools/testing/selftests/bpf/test_verifier.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/te=
sting/selftests/bpf/test_verifier.c
> > > > index b8d065623ead..3fe126e0083b 100644
> > > > --- a/tools/testing/selftests/bpf/test_verifier.c
> > > > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > > > @@ -823,16 +823,18 @@ static int do_prog_test_run(int fd_prog, bool=
 unpriv, uint32_t expected_val,
> > > >         __u8 tmp[TEST_DATA_LEN << 2];
> > > >         __u32 size_tmp =3D sizeof(tmp);
> > > >         uint32_t retval;
> > > > +       int saved_errno;
> > > >         int err;
> > > >
> > > >         if (unpriv)
> > > >                 set_admin(true);
> > > >         err =3D bpf_prog_test_run(fd_prog, 1, data, size_data,
> > > >                                 tmp, &size_tmp, &retval, NULL);
> > >
> > > Given err is either 0 or -1, how about instead making err useful righ=
t
> > > here without extra variable?
> > >
> > > if (bpf_prog_test_run(...))
> > >         err =3D errno;
> >
> > I change it later to bpf_prog_test_run_xattr, which can also return
> > -EINVAL and then errno is not set. But this one probably should not be
>
> This is wrong. bpf_prog_test_run/bpf_prog_test_run_xattr should either
> always return -1 and set errno to actual error (like syscalls do), or
> always use return code with proper error. Give they are pretending to
> be just pure syscall, it's probably better to set errno to EINVAL and
> return -1 on invalid input args?

Yeah, this is inconsistent at best. But seems to be kind of expected?
See tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c.

>
> > triggered by the test code. So not sure, probably would be better to
> > keep it as is for consistency?
> >
> > >
> > > > +       saved_errno =3D errno;
> > > >         if (unpriv)
> > > >                 set_admin(false);
> > > >         if (err) {
> > > > -               switch (errno) {
> > > > +               switch (saved_errno) {
> > > >                 case 524/*ENOTSUPP*/:
> > >
> > > ENOTSUPP is defined in include/linux/errno.h, is there any problem
> > > with using this in selftests?
> >
> > I just used whatever there was earlier. Seems like <linux/errno.h> is
> > not copied to tools include directory.
>
> Ok, let's leave it as is, thanks!
>
> >
> > >
> > > >                         printf("Did not run the program (not suppor=
ted) ");
> > > >                         return 0;
> > > > --
> > > > 2.20.1
> > > >
> >
> >
> >
> > --
> > Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
> > Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iag=
o L=C3=B3pez Galeiras
> > Registergericht/Court of registration: Amtsgericht Charlottenburg
> > Registernummer/Registration number: HRB 171414 B
> > Ust-ID-Nummer/VAT ID number: DE302207000



--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
