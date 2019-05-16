Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119EC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC37E206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="V1k3/XZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfEPJ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:29:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39878 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:29:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id f1so2074706lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HM9SvHS2yQg5lQDqjeY//dYhXZJ7+P9Sm7ZfbrJXCXU=;
        b=V1k3/XZxzovk7JJHkqCg3cH/W8kUyNgUXSi9/WPf1de6k7MSutSrHrHYIUTtkb8ngW
         5t2E2dQf3TQMSjodY05gI/CccMyZ379RU0hPVE/6M8CMJdW8Oyq8nKSvhuU5Kd2WQLcd
         LBf/nrR0cKxOB5jBDoYvUDwEadTJwcnV6WymY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HM9SvHS2yQg5lQDqjeY//dYhXZJ7+P9Sm7ZfbrJXCXU=;
        b=Ug8RlmGsLdjxLRHzZv/jy7cXWnUHaGILcjMeN49WXtfyWNmdDI+sKf3FuYZWUbbAdX
         ltYLT3MwMolInU0aS0UYO+sHHWgwIGFIy6jZoPZ5U181s1UVqivJp/Dhps4YbxdHI0w8
         J0rD4aZFBO0MPCEEfKzzgW/l7W0idNyk8cMxwadobIBxzqiOI7cTiPZsPi5rDsIUAO5q
         FgqmDYOEtYldPARsCxMHOWoXG1pzyltSnVfzo1ADkmbmwpARydd9ywaA2UaDvyVNHRpj
         gyVpblNT/R2lUbTf3Uiy9jr/oo2Y/s7Bi9uDhUB870MeqWvJBfc7tLAq1BbWS6api4uO
         cJig==
X-Gm-Message-State: APjAAAVX1DwJOZ4PjbnbCulhMmuZWgBfBsrOtX2LsRiBBLBdJZNEA4Ze
        o+V+wLtE3XW3TthvHREwDpdVKUjopc/gt8pCwh6InQ==
X-Google-Smtp-Source: APXvYqyvsOQM7w9EXRxEbtugoxgrFvrhiv21XJSHhpquhJVqYnCi1hEcUbucEs9/tSacw8t+EJ9lQo5qhf1d1S/q+2k=
X-Received: by 2002:a19:ae14:: with SMTP id f20mr22736742lfc.49.1557998989943;
 Thu, 16 May 2019 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190515134731.12611-1-krzesimir@kinvolk.io> <20190515134731.12611-3-krzesimir@kinvolk.io>
 <20190515144537.57f559e7@cakuba.netronome.com>
In-Reply-To: <20190515144537.57f559e7@cakuba.netronome.com>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Thu, 16 May 2019 11:29:39 +0200
Message-ID: <CAGGp+cGN+YYVjJee5ba84HstSrHGurBvwmKmzNsFRvb344Df3A@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester
 could not run a program
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     bpf@vger.kernel.org,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:46 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Wed, 15 May 2019 15:47:27 +0200, Krzesimir Nowak wrote:
> > This prints a message when the error is about program type being not
> > supported by the test runner or because of permissions problem. This
> > is to see if the program we expected to run was actually executed.
> >
> > The messages are open-coded because strerror(ENOTSUPP) returns
> > "Unknown error 524".
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index ccd896b98cac..bf0da03f593b 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unp=
riv, uint32_t expected_val,
> >                               tmp, &size_tmp, &retval, NULL);
> >       if (unpriv)
> >               set_admin(false);
> > -     if (err && errno !=3D 524/*ENOTSUPP*/ && errno !=3D EPERM) {
> > -             printf("Unexpected bpf_prog_test_run error ");
> > -             return err;
> > +     if (err) {
> > +             switch (errno) {
> > +             case 524/*ENOTSUPP*/:
> > +                     printf("Did not run the program (not supported) "=
);
> > +                     return 0;
> > +             case EPERM:
> > +                     printf("Did not run the program (no permission) "=
);
> > +                     return 0;
>
> Perhaps use strerror(errno)?

As I said in the commit message, I open-coded those messages because
strerror for ENOTSUPP returns "Unknown error 524".

>
> > +             default:
> > +                     printf("Unexpected bpf_prog_test_run error ");
> > +                     return err;
> > +             }
> >       }
> > -     if (!err && retval !=3D expected_val &&
> > +     if (retval !=3D expected_val &&
> >           expected_val !=3D POINTER_VALUE) {
> >               printf("FAIL retval %d !=3D %d ", retval, expected_val);
> >               return 1;
>


--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
