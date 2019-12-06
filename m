Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E4DC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F132467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxzHy3KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLFIiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:38:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35096 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfLFIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:38:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id s8so6466234qte.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XULIdLphJK4qhxzEMS6r2yIrpC7a9xcmw/dOBrCCHnI=;
        b=ZxzHy3KZPXua8EgoH1fYq6c6L99fALxELCYRV2aXAnlHF2bS8HCMol/iAk8kKemUFU
         7hvvB9V8yE1GdD7LK0rZ4YCrp9q0A9ojDtRLQhKB/Hnasjv2oJQ2RmrnQ6GgqPlN0wrP
         QCxLviZNEiMaT8clvyClMTq0zbuLMdgB2aw3+Xjc6aOgTXQEH4RYRVNHFuyMiTVsY3fH
         4f4kKF8o95RLZFoQVwidWOU1W4AVMFdtYVsLiC4+uD3IjiI/MrDCM5vK+Ok3nJmwwpBB
         qmoVVw8Q3dcOt4Yxeua+DH2cDCQ2B4O0v2dV9zenkoZPyc6Ic2D4fayVC97wQF3fkQ3z
         wA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XULIdLphJK4qhxzEMS6r2yIrpC7a9xcmw/dOBrCCHnI=;
        b=SJgsjDXXy4T2TvfuQwEICGf5hNj74zHUtscaKBQ/yKSVcPTe7TC/ylan8kmcT/9+1Z
         qlLqzccpQ6aVX1G1I4CU+GYQqH5sxgG/AEePM4EVEaMjFyv503Nl3/CIJcmaWEkwSDZo
         2x/DALz8hLvE2MD3jEqGT6iHlaVEoznzd4qkf8MTE1F29m9T/vU7c3QiZFv0Vn5J/oci
         7a3ADJxJJKDrxqUJEkMQWQNqUlS+136Q60YT/fOMS7oVkHhGpc4eOSSClaho08+5foB3
         bD1yQdw4jaDkO0pQmS1gOs87LwrhJ6wqieEK9wB/yFZJsdCsq4GYQjf6IzmPHulPF+vJ
         6KtQ==
X-Gm-Message-State: APjAAAXO1cyojcqn6RUmE+04ceGxLoAKDjcg+/XEKqcQNjJXP6fRKRQF
        XllP+WPZ0t4W0WNK3KWKBJ204b9zfgQXlXl3Mtw=
X-Google-Smtp-Source: APXvYqytAoVioaolXPFeQOsQ1aeD3jkaPTX+RX7lY+dQPxZI6yABwCQKvblEpvDu+P99UBx+Qedtff5HSH9xuXHnrEo=
X-Received: by 2002:ac8:5548:: with SMTP id o8mr12003824qtr.338.1575621532837;
 Fri, 06 Dec 2019 00:38:52 -0800 (PST)
MIME-Version: 1.0
References: <201912060818.dgGGxpRK%lkp@intel.com> <CAK8P3a23_rWdmjyZNezd9k=-KL4VZyV+DCLvh-UgCQUQTsysyw@mail.gmail.com>
 <CAEbi=3fN83s1sp6Yt2B6d5M-uJ+TGz_a7-mWTt2LAfrX8B3JmA@mail.gmail.com>
In-Reply-To: <CAEbi=3fN83s1sp6Yt2B6d5M-uJ+TGz_a7-mWTt2LAfrX8B3JmA@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 6 Dec 2019 16:38:15 +0800
Message-ID: <CAEbi=3cojt1shc84zH3tGtxK98rQ=PbGhkirWCe7C+JSj5jpFw@mail.gmail.com>
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
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Arnd Bergmann <arnd@arndb.de> =E6=96=BC 2019=E5=B9=B412=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:00=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, Dec 6, 2019 at 2:05 AM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> > > head:   2f13437b8917627119d163d62f73e7a78a92303a
> > > commit: 1207045da5a7c94344e0ea9a9e7495985eef499a compat_ioctl: move t=
ape handling into drivers
> > > date:   6 weeks ago
> > > config: nds32-allyesconfig (attached as .config)
> > > compiler: nds32le-linux-gcc (GCC) 9.2.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout 1207045da5a7c94344e0ea9a9e7495985eef499a
> > >         # save the attached .config to linux build tree
> > >         GCC_VERSION=3D9.2.0 make.cross ARCH=3Dnds32
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    drivers/scsi/.tmp_mc_st.s: Assembler messages:
> > > >> drivers/scsi/.tmp_mc_st.s:3: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> > >    drivers/scsi/.tmp_mc_st.s:4: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> > >    drivers/scsi/.tmp_mc_st.s:5: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> > >    drivers/scsi/.tmp_mc_st.s:6: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> > >    drivers/scsi/.tmp_mc_st.s:7: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> > >    drivers/scsi/.tmp_mc_st.s:8: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> > >    drivers/scsi/.tmp_mc_st.s:9: Error: invalid operands (*UND* and *U=
ND* sections) for `^'
> >
> > Adding nds32 maintainers to Cc:
> >
> > It looks like a regression caused by my patch, but I don't think it's s=
omething
> > I did wrong, but rather a toolchain bug being uncovered by the modified=
 sources.
> >
> > Are you able to reproduce this?
>
> Hi Arnd,
>
> I am trying to reproduce this problem, but it happened to me.
>
> greentimeh@gamma07:/scratch/greentimeh/nds32/linux <(1207045da5a7...)>
> $ GCC_VERSION=3D9.2.0 make.cross ARCH=3Dnds32
> cd: received redirection to `https://download.01.org/0day-ci/cross-packag=
e/'
> Cannot find nds32-linux under
> https://download.01.org/0day-ci/cross-package check
> /tmp/crosstool-files
>
> Can you reproduce it?

I can reproduce it now by adding these 2 lines to make.cross.
177                 nds32)
178                         gcc_arch=3Dnds32le-linux

It will be built failed with gcc-9.2.0-nolibc toolchain, but it can be
built pass with gcc-8.1.0-nolibc toolchain.
