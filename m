Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5BEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DB220820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbnR6SgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfHLTle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:41:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44718 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:41:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id c81so1200700pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9ULtG2G11QpFccQoEesKvps5pyWLLNLNLE39lbGndA=;
        b=ZbnR6SgFlx796r//7kvxc5LQhRkwJA83fYojeTlfr+jgGd+dgheLeaMkKiMmcegB9j
         ppfJsVarjskbv1HLKHIBVSGfRTd9Z5CVxK1+XMSQI094Pb6gUTU0Jl6Wy5mKpb8wARwU
         zBfLTuxvAO/Q0eAzoDyrCA3uGXQdimeik/SNjZIVgYaAmbPHmNa04iKCPfdRX5vM/b+s
         Gvq4By3VGPpaF661sNOI/yBPyy7XU1AifrVy+C9Pu/scfPBGmDuyY5+o65mHz5Npjh8p
         Vto9wikHnFRWw3fSevtHBTqqjLHmhoKuA/ywdDalaskAb5nxYYEo9ok0KDKQZ9R+7p9C
         aq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9ULtG2G11QpFccQoEesKvps5pyWLLNLNLE39lbGndA=;
        b=hnjaZg79mWc6FMiP/5MbE35ptPyDmWgXCdkJGEeHfW0G5YIZ6xp6zaAxCCK5fXp8cS
         5VA7v9ApusXiuf6Pd3xx7SdwXX6XSxuj8gHUUUyrCXoEusRUXhU1yJE4LkjWqhfcCfOM
         rvYhMNvTn3VO19Zpi9FAhbsYd9E80TgqtWFnHSRj3u/o0eSa2Xzq+WKlzfg1Z4A0tK5S
         iXkr9Aj1AupFrsVk/IGiRf4kSRzrrbKZ/RlJMouV7cJGZV1Jnv3O+J06ySrkmI5Z0Jt2
         OzHHtig/rCDLG77VBdRleIpXD+MaTOA3+cdLTB2jW1SLGCm7Lb/NtUo7x0VolFBG7djb
         4fDw==
X-Gm-Message-State: APjAAAWjj74EYdYEd4zCq1ESxPZYrIk7vl1O7KhltWNBJpKzu2ZsfP1W
        tdYnkMQCQCcQIvsYZHZp6ocScofYGcMyKqJEDojKgQ==
X-Google-Smtp-Source: APXvYqzSSNS4svybYmOUiWvGdPmN4hWWl8HBvs6GBy/wM7mIEWEyUBHJeJdTx/DfJn50CXv4B5Z5qJnPJgNBJCv4QqQ=
X-Received: by 2002:a63:60a:: with SMTP id 10mr31136337pgg.381.1565638892699;
 Mon, 12 Aug 2019 12:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
 <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
 <CAKwvOd=n_8i6+9K=g2OK2mAqubBZZHhmJrDM0=FtT_m0e0D5sQ@mail.gmail.com>
 <4580cd399d23bbdd9b7cf28a1ffaa7bc1daef6a6.camel@perches.com>
 <CAKwvOd=293uFBT1hLrC-vE9ekd2YOaTiiXj1HVeGfTjAk1rGvg@mail.gmail.com> <225af64a285ed0760a893e2dae45f1054e2cf82f.camel@perches.com>
In-Reply-To: <225af64a285ed0760a893e2dae45f1054e2cf82f.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 12:41:21 -0700
Message-ID: <CAKwvOdk1USOoRK0u0STmB2+gyTCxB_X-ZMW1OGV0xcf4O7n1aQ@mail.gmail.com>
Subject: Re: checkpatch.pl should suggest __section
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:27 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-08-12 at 11:20 -0700, Nick Desaulniers wrote:
> > On Fri, Aug 9, 2019 at 4:17 PM Joe Perches <joe@perches.com> wrote:
> > > On Fri, 2019-08-09 at 16:04 -0700, Nick Desaulniers wrote:
> > > > > how about:
> > > > > ---
> > > > >  scripts/checkpatch.pl | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > index 1cdacb4fd207..8e6693ca772c 100755
> > > > > --- a/scripts/checkpatch.pl
> > > > > +++ b/scripts/checkpatch.pl
> > > > > @@ -5901,6 +5901,15 @@ sub process {
> > > > >                              "__aligned(size) is preferred over _=
_attribute__((aligned(size)))\n" . $herecurr);
> > > > >                 }
> > > > >
> > > > > +# Check for __attribute__ section, prefer __section (without quo=
tes)
> > > > > +               if ($realfile !~ m@\binclude/uapi/@ &&
> > > > > +                   $line =3D~ /\b__attribute__\s*\(\s*\(.*_*sect=
ion_*\s*\(\s*("[^"]*")/) {
> > > > > +                       my $old =3D substr($rawline, $-[1], $+[1]=
 - $-[1]);
> > > > > +                       my $new =3D substr($old, 1, -1);
> > > > > +                       WARN("PREFER_SECTION",
> > > > > +                            "__section($new) is preferred over _=
_attribute__((section($old)))\n" . $herecurr);
> > > > > +               }
> > > > > +
> > > >
> > > > I can't read Perl, but this looks pretty good.
> > > > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > I'll add a Suggested-by: for you.
> > >
> > > But a Tested-by would be more valuable than an Acked-by if you
> > > don't actually know how it works.
> >
> > $ git am joes.patch
> > $ echo "int foo __attribute__((section(.hello)));" >> arch/x86/boot/a20=
.c
>
> Does this compile?
>
> checkpatch is not a compiler.
>
> I think you need
>
> __attribute__((section(".hello")))

PEBKAC
=E2=9E=9C  kernel-all git:(section_escaping) =E2=9C=97 ./scripts/checkpatch=
.pl
0001-x86-boot-hello.patch
WARNING: __section(.hello) is preferred over __attribute__((section(".hello=
")))
#20: FILE: arch/x86/boot/a20.c:164:
+int foo __attribute__((section(".hello")));

total: 0 errors, 1 warnings, 4 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

0001-x86-boot-hello.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
--=20
Thanks,
~Nick Desaulniers
