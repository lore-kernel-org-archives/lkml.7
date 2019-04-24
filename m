Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07572C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30FD2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdfhxIWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfDXHE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:04:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36054 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:04:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so14935163edm.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5pGOaG8MPp7tXmKA36KJWx/VIbN3u87ZToPqyRTuZEc=;
        b=NdfhxIWL0tqgFIA6Z3BUjbIeOjTdANw8F2fNFRAvuoypeiCrukDoCiqlLM0XlNHueX
         oXt2+SE5+jtuqQX/dYX+9c+F3CvHdjnglYboVEOrTE229CcpwK0wBUwucpxIBUG01R5W
         MyVhBQcPqjPNkpr/JYrf6P5EIzaEDrZ7EoEZbca0lKnJ6w/pC4yNTDi6vm3G9E7kOtKZ
         /nhTMvi2gh4EQX3yYryTei81yriHZGz2QV5aT0vywM2+I28Gf7VnDQG9RJzFiR46fY3p
         uF11b8J5BZTRs9ROw5QurBMf14F5/1PGDyD5sS0smBNCYCwO4Yj+vopexCRdBJLk95iL
         IfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5pGOaG8MPp7tXmKA36KJWx/VIbN3u87ZToPqyRTuZEc=;
        b=F9jwIM3CVIw/jJybpeRc+7k3Br1t6r02fUrRxpIBA6DrugfS1AYG7VJ/esuji3Nn6A
         VDdgsxy+8EBr2AxNXnx40k5hH476RHrHKpQ8Gfewxt6usXW0BJJ1iSHv3E0CVCC4IX4q
         B5FkeArSbb3DbGfjSOoPYubg899dHGET1Vg8Hwmd07zm/LFPcteUAq7K9fcZP21oWBCk
         qui+K36/vz0EjBFDHgmKfkbjT/o4YMXiHYPm1VF+j9HLvmkNCMcQwCLQ8IiirIpQLl2e
         casVE8SSnyn6jSVOpudxWy1d3KIRhKj6we3/f8qxQ1dNk2IxTioyrTjZNuvdL4awnqhT
         Xokg==
X-Gm-Message-State: APjAAAWqOqiFP+Du+iUrtT9mVq9ihxbD3DWG7e0dFPinP9UcaLwFm6ZB
        wPYquU0dy8IG+FDXGgEAdYUxoLdNrVC/15sALQE=
X-Google-Smtp-Source: APXvYqw4KrPOik3r6ghlk+Q1ZL9H8+3C7zYS2LlcDn74/Ym+VCdsLzw9KgvSl31jznhUB48jHYiHNFXsx4DkfFZWKGg=
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr15390109eju.119.1556089466661;
 Wed, 24 Apr 2019 00:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <1554280633-11457-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNASUtor7Cxq35EUrNo0qhi8Kd9Tmfgg7mfiBg=NPtgb30g@mail.gmail.com>
In-Reply-To: <CAK7LNASUtor7Cxq35EUrNo0qhi8Kd9Tmfgg7mfiBg=NPtgb30g@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 15:03:50 +0800
Message-ID: <CAEbi=3f2J3gOP5zOcbCsOBLS06oyWGoiVfn_ZCfUpvNHKc3HKw@mail.gmail.com>
Subject: Re: [PATCH] nds32: vdso: fix and clean-up Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B44=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:37=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Hi Greentime,
>
>
> On Wed, Apr 3, 2019 at 5:38 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > - $(call if_changed,...) must have FORCE as a prerequisite
> >
> > - vdso.lds is a generated file, so it should be prefixed with
> >   $(obj)/ instead of $(src)/.
> >
> > - cmd_vdsosym is a one-liner rule, so the assignment with '=3D'
> >   is simpler.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> Ping?
>
>
> >  arch/nds32/kernel/vdso/Makefile | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/M=
akefile
> > index e6c50a7..01a9610 100644
> > --- a/arch/nds32/kernel/vdso/Makefile
> > +++ b/arch/nds32/kernel/vdso/Makefile
> > @@ -28,7 +28,7 @@ CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
> >  $(obj)/vdso.o : $(obj)/vdso.so
> >
> >  # Link rule for the .so file, .lds has to be first
> > -$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
> > +$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> >         $(call if_changed,vdsold)
> >
> >
> > @@ -40,9 +40,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
> >  # Generate VDSO offsets using helper script
> >  gen-vdsosym :=3D $(srctree)/$(src)/gen_vdso_offsets.sh
> >  quiet_cmd_vdsosym =3D VDSOSYM $@
> > -define cmd_vdsosym
> > -       $(NM) $< | $(gen-vdsosym) | LC_ALL=3DC sort > $@
> > -endef
> > +      cmd_vdsosym =3D $(NM) $< | $(gen-vdsosym) | LC_ALL=3DC sort > $@
> >
> >  include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
> >         $(call if_changed,vdsosym)
> > @@ -65,7 +63,7 @@ gettimeofday.o : gettimeofday.c FORCE
> >
> >  # Actual build commands
> >  quiet_cmd_vdsold =3D VDSOL   $@
> > -      cmd_vdsold =3D $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
> > +      cmd_vdsold =3D $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o=
 $@
> >  quiet_cmd_vdsoas =3D VDSOA   $@
> >        cmd_vdsoas =3D $(CC) $(a_flags) -c -o $@ $<
> >  quiet_cmd_vdsocc =3D VDSOA   $@

Hi Yamada,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
