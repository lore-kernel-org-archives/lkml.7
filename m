Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AACC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D67624658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i300ShWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFKPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:15:49 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32899 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:15:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so6689309qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VU3mVyUkXK8D+5hcPVZwalL5AuDR8H2cjqY0VrfsIGs=;
        b=i300ShWIGz7B69dphO/d6qYVCvhOcTJlYu0V2vvAYKjePCceV9peff0AoaANqUbv74
         DqVEbA/siL/dTwELPyh7q5131eBoHuY7WVIJ32rXrEEa/hT3wYfv+zR5iMIXtfyZtWHF
         ARCNZwG2+md5GSmY4V1hoJMYv0UJYHgj8bPkh9kyHjKrJdKjtZWyfQL2HG9HaViWZD/G
         QT5vhIyhOBpy6btdS22c8PaSSbpDjfF2IbTFCRAou32sqphSmpIOGJ/VXNfHrCZybydL
         CXZHJj0PVs4s26ODNoqedb7VD/FH+6skhC66zbnxoHf2Y1cPyDIZ+4QQAt8ncABiRx6D
         5Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VU3mVyUkXK8D+5hcPVZwalL5AuDR8H2cjqY0VrfsIGs=;
        b=cPbTliHO42+49POgCYwUXgFA3HGrJ++I7U1SZVjRRAuJSHDvrXYyRupmT2/ZawhZ/n
         VmfRWiin49tCyABQX+nJizZd01ZXo1uj4I/7vqF/Ed7Ra3CqV5hV06CemXRBVV8u3TKu
         C0QSAGkg6aippcG+ovdpV1UG6+cy5czSN3xw9onvqxr+TM25RycQVewoDVrCsB34wuW7
         cHrkINuxW5/tZETwC3pSwtusXKjNbvL5cw8mae69hJZ4EJUxheybsi2q8+hQZj9Fxa9o
         4S1CKmWXBeUyWzN7dBGZ+3zEVOeBolzQZ+iICJ2sUx8PYvuHiteaVCp3YW1VsJsJnQDw
         5B0Q==
X-Gm-Message-State: APjAAAX5xF/U4PhaGEt1Q2vnTZ+9mdFHAbALfkDblLs8801T1z+c0wza
        PFZ8wK2A6GKfcVY3MV42wbm4n7Skq4s3C+7a0aE=
X-Google-Smtp-Source: APXvYqxY9dcx2Z6byMD1F4fMuzUxiO7a38mr6r2HY6ouS9dDdbVJ2ZmnkjTwGDDJd483UzUblF2oNS+osC3VvPvUP9k=
X-Received: by 2002:ac8:5548:: with SMTP id o8mr12269193qtr.338.1575627346187;
 Fri, 06 Dec 2019 02:15:46 -0800 (PST)
MIME-Version: 1.0
References: <201912060818.dgGGxpRK%lkp@intel.com> <CAK8P3a23_rWdmjyZNezd9k=-KL4VZyV+DCLvh-UgCQUQTsysyw@mail.gmail.com>
 <CAEbi=3fN83s1sp6Yt2B6d5M-uJ+TGz_a7-mWTt2LAfrX8B3JmA@mail.gmail.com> <CAEbi=3cojt1shc84zH3tGtxK98rQ=PbGhkirWCe7C+JSj5jpFw@mail.gmail.com>
In-Reply-To: <CAEbi=3cojt1shc84zH3tGtxK98rQ=PbGhkirWCe7C+JSj5jpFw@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 6 Dec 2019 18:15:08 +0800
Message-ID: <CAEbi=3fJM9B_UnkuVOKW2oD8AcdvOYh1ozheGi9pAGvm7MjtFw@mail.gmail.com>
Subject: Re: drivers/scsi/.tmp_mc_st.s:3: Error: invalid operands (*UND* and
 *UND* sections) for `^'
To:     Arnd Bergmann <arnd@arndb.de>, Nickhu <nickhu@andestech.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greentime Hu <green.hu@gmail.com> =E6=96=BC 2019=E5=B9=B412=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Greentime Hu <green.hu@gmail.com> =E6=96=BC 2019=E5=B9=B412=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:19=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Arnd Bergmann <arnd@arndb.de> =E6=96=BC 2019=E5=B9=B412=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:00=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Dec 6, 2019 at 2:05 AM kbuild test robot <lkp@intel.com> wrot=
e:
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
> > > > head:   2f13437b8917627119d163d62f73e7a78a92303a
> > > > commit: 1207045da5a7c94344e0ea9a9e7495985eef499a compat_ioctl: move=
 tape handling into drivers
> > > > date:   6 weeks ago
> > > > config: nds32-allyesconfig (attached as .config)
> > > > compiler: nds32le-linux-gcc (GCC) 9.2.0
> > > > reproduce:
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         git checkout 1207045da5a7c94344e0ea9a9e7495985eef499a
> > > >         # save the attached .config to linux build tree
> > > >         GCC_VERSION=3D9.2.0 make.cross ARCH=3Dnds32
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    drivers/scsi/.tmp_mc_st.s: Assembler messages:
> > > > >> drivers/scsi/.tmp_mc_st.s:3: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > > >    drivers/scsi/.tmp_mc_st.s:4: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > > >    drivers/scsi/.tmp_mc_st.s:5: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > > >    drivers/scsi/.tmp_mc_st.s:6: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > > >    drivers/scsi/.tmp_mc_st.s:7: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > > >    drivers/scsi/.tmp_mc_st.s:8: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > > >    drivers/scsi/.tmp_mc_st.s:9: Error: invalid operands (*UND* and =
*UND* sections) for `^'
> > >
> > > Adding nds32 maintainers to Cc:
> > >
> > > It looks like a regression caused by my patch, but I don't think it's=
 something
> > > I did wrong, but rather a toolchain bug being uncovered by the modifi=
ed sources.
> > >
> > > Are you able to reproduce this?
> >
> > Hi Arnd,
> >
> > I am trying to reproduce this problem, but it happened to me.
> >
> > greentimeh@gamma07:/scratch/greentimeh/nds32/linux <(1207045da5a7...)>
> > $ GCC_VERSION=3D9.2.0 make.cross ARCH=3Dnds32
> > cd: received redirection to `https://download.01.org/0day-ci/cross-pack=
age/'
> > Cannot find nds32-linux under
> > https://download.01.org/0day-ci/cross-package check
> > /tmp/crosstool-files
> >
> > Can you reproduce it?
>
> I can reproduce it now by adding these 2 lines to make.cross.
> 177                 nds32)
> 178                         gcc_arch=3Dnds32le-linux
>
> It will be built failed with gcc-9.2.0-nolibc toolchain, but it can be
> built pass with gcc-8.1.0-nolibc toolchain.

It seems nds32le-linux-objdump -hdr xxx.o will generate different strings.
For example:
00000050 <.L2^B1>:
This string is different when generated by 9.2 toolchain and 8.1 toolchain.
"^B" is treated as 2 character in 9.2 toolchain
"^B" is treated as 1 character in 8.1 toolchain

This causes ./scripts/recordmcount.pl to call `$cc -o $mcount_o -c
$mcount_s`; failed to cause this issue.
I have a quick patch to fix this build error, but I am not sure if it
is a good solution.
Maybe Nick could have a look at it?

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 3f77a5d695c1..807b61fc5f5d 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -551,7 +551,8 @@ while (<IN>) {
        # if this is either a local function or a weak function
        # keep looking for functions that are global that
        # we can use safely.
-       if (!defined($locals{$text}) && !defined($weak{$text})) {
+       if (!defined($locals{$text}) && !defined($weak{$text}) &&
+           $text !~ /^\.L/) {
            $ref_func =3D $text;
            $read_function =3D 0;
            $offset =3D hex $1;
