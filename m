Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE9FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCBD2467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdzKn5ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLFIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:20:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44347 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfLFIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:19:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id g17so425273qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cdG4+P8dl/vLfckHmVa5Z2wYVvXjkjG1OzxFwP8iLtE=;
        b=UdzKn5ikU0Un5lfc+zyuC2+VIcQnhOH684rQ67PkvQ0sFdVgJSD4rZZCRfAdtqxccE
         hTL+i9LcSaBrf0Vj9LpIj+GHVxcj7JRbdqGrE4mjgLpy4eMq8rDSP8Nsid5lkaGm/5I4
         v18AhAUZCDC7w0k/YP2xBQOE1ZCBy47lwSo9Y9x8J/ivD0ensTP0s2RfmEeNK9bkRV/Z
         Beqh3zT3rWU7P4FrJgPXyDCFS9U4LOVP5aTxNxVLky0YNPErw1KWdlMg8NH6E1+0WI//
         rRclB7cwn51KWoA4IfgAl1073SzkOqu+tZyrAUwt935J4bp3Z6MsT74KaAYfTVaRH+Vx
         1rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cdG4+P8dl/vLfckHmVa5Z2wYVvXjkjG1OzxFwP8iLtE=;
        b=uQx2Tk34VMVHyIUmeJnVtBHVAaFcq09WFCjLMKFAqS1Lhycb4KcL5Hebj0ZJk0fyvz
         diih9LUP6ePh3lJIPXMJIZhUI83VfIqMqClRHqmEi7NDv/FW1BY5idZ3gST7nbqBjyz6
         gw8oEsENVuY2ylMMrFtd8FRlc07E3esUZFnX8qtTFXcwO0hXNTx/EDZALdB2ti+53i2u
         ywk+oMsaxjYK1zNdg+sdC0c3LpSqkZz+NehYZ7CDaQ4gekHzu1/GQwsu3Tjb0AIRgFna
         oA9coiNmHv+AVYJUEXRenySz/2qjILB9Nk5RBLf87xCVjJyrii7t+iUdzCW+CGp5SNYY
         dBpQ==
X-Gm-Message-State: APjAAAUFOKE7QrQ0BBZ5eKFAhaKj7jpm699nTgPIFH+TsB0JW9iFTNyQ
        yGtTYxAdd2H4MNmeTLv9nQ9J1GTFfHaz5ocOEWmXOE646yE=
X-Google-Smtp-Source: APXvYqxqav+rjpdODvRO9LvBxWEIzox1i9v+kUC++h/lGbqRqgNhz5ckGUOFDxAiM80roT+6fW9htRjWpeUzA/0GHd8=
X-Received: by 2002:ac8:3707:: with SMTP id o7mr11404515qtb.8.1575620398561;
 Fri, 06 Dec 2019 00:19:58 -0800 (PST)
MIME-Version: 1.0
References: <201912060818.dgGGxpRK%lkp@intel.com> <CAK8P3a23_rWdmjyZNezd9k=-KL4VZyV+DCLvh-UgCQUQTsysyw@mail.gmail.com>
In-Reply-To: <CAK8P3a23_rWdmjyZNezd9k=-KL4VZyV+DCLvh-UgCQUQTsysyw@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 6 Dec 2019 16:19:20 +0800
Message-ID: <CAEbi=3fN83s1sp6Yt2B6d5M-uJ+TGz_a7-mWTt2LAfrX8B3JmA@mail.gmail.com>
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

Arnd Bergmann <arnd@arndb.de> =E6=96=BC 2019=E5=B9=B412=E6=9C=886=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Dec 6, 2019 at 2:05 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   2f13437b8917627119d163d62f73e7a78a92303a
> > commit: 1207045da5a7c94344e0ea9a9e7495985eef499a compat_ioctl: move tap=
e handling into drivers
> > date:   6 weeks ago
> > config: nds32-allyesconfig (attached as .config)
> > compiler: nds32le-linux-gcc (GCC) 9.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 1207045da5a7c94344e0ea9a9e7495985eef499a
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D9.2.0 make.cross ARCH=3Dnds32
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/scsi/.tmp_mc_st.s: Assembler messages:
> > >> drivers/scsi/.tmp_mc_st.s:3: Error: invalid operands (*UND* and *UND=
* sections) for `^'
> >    drivers/scsi/.tmp_mc_st.s:4: Error: invalid operands (*UND* and *UND=
* sections) for `^'
> >    drivers/scsi/.tmp_mc_st.s:5: Error: invalid operands (*UND* and *UND=
* sections) for `^'
> >    drivers/scsi/.tmp_mc_st.s:6: Error: invalid operands (*UND* and *UND=
* sections) for `^'
> >    drivers/scsi/.tmp_mc_st.s:7: Error: invalid operands (*UND* and *UND=
* sections) for `^'
> >    drivers/scsi/.tmp_mc_st.s:8: Error: invalid operands (*UND* and *UND=
* sections) for `^'
> >    drivers/scsi/.tmp_mc_st.s:9: Error: invalid operands (*UND* and *UND=
* sections) for `^'
>
> Adding nds32 maintainers to Cc:
>
> It looks like a regression caused by my patch, but I don't think it's som=
ething
> I did wrong, but rather a toolchain bug being uncovered by the modified s=
ources.
>
> Are you able to reproduce this?

Hi Arnd,

I am trying to reproduce this problem, but it happened to me.

greentimeh@gamma07:/scratch/greentimeh/nds32/linux <(1207045da5a7...)>
$ GCC_VERSION=3D9.2.0 make.cross ARCH=3Dnds32
cd: received redirection to `https://download.01.org/0day-ci/cross-package/=
'
Cannot find nds32-linux under
https://download.01.org/0day-ci/cross-package check
/tmp/crosstool-files

Can you reproduce it?
