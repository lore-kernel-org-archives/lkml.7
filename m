Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D7C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9F21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLE1/iHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfJBPUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:20:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40636 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:20:45 -0400
Received: by mail-yw1-f68.google.com with SMTP id e205so6199875ywc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VaE7w1CaTRczQgzzFI2ExCLX+A6tMdd72aOZN4Z0QKo=;
        b=nLE1/iHWa7XE0yBbCQsMddzPXDMYx7T4sjIBuOZqqXZgejKTiKwtDFPNxWFQbx8KPF
         jszcdAsTTJNxBc1JHRulzs5bfBibve3/UJgW0TMYdIFY5wuxcv0faMIo5dI++rfYLYJt
         /PMsuwgWLH2n3vXCWACK6ITP1xOJpQSf3igP8zQtoza3UOwpT8/dKHsGV1FIyqYMyf9I
         00+ZJFee/TjjHhNh+QCI31xd/7tqwDF01IAQEIjoMF9krRmcoTMDOw5ZuN7I63ACgsG0
         TYqFKEXHnhWWpMZQ3Mg9VyAyNfkTNVBTnSf2DxiAmp1TbQSrrEklfutDIi/HK4Whanqn
         yNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VaE7w1CaTRczQgzzFI2ExCLX+A6tMdd72aOZN4Z0QKo=;
        b=k7zOVNU6+WAnPa6bRbF7/bGCfXwj852a81YdvKfncLpRZz8BInnZte3Q9FJzAH5K/I
         tUzGMgqZvllcoXXVSyGC+NrDtljtZogFS3zIyhsvpf6wIGy1+y4XTchoYhpiNivo2iK9
         ZTDmG7zd0NWOCowIi/EEHKy3KrCwb2yrvhlS0Yvmg3RmqftcbaCaBsQB7I0xvCUnuU/r
         rSt5+w6lD6x+gxGde9qr1arFQXyrAZjmCwv1VEWOkHwzRDZ0A/CzLLwujyecmEFQ6LF0
         hf5NRuhkU4GKbkKv7vhJiXPsFE4+kuwIJDN0gRiWLlv9e5e2fMw+vsK6gZdeN9bi0sQ5
         Ea4Q==
X-Gm-Message-State: APjAAAUt70BesMcAODa6PzXMwcHfDmSc+daSnQPZPPH9CjEM1uoQQJYO
        +Xu8MEM5Su0mn4yC45NKYnDB/gQ+Y5K3/FgurzI=
X-Google-Smtp-Source: APXvYqx7/3JZinR3TrxpzIRdJHu65zew2z/VyGmSS7W5Ui+1dZIXWQ/1ooSR2vIXkGdizxdKtOnY3kC5vWqx2R8BKLI=
X-Received: by 2002:a81:4a04:: with SMTP id x4mr2900984ywa.168.1570029163271;
 Wed, 02 Oct 2019 08:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com> <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com>
In-Reply-To: <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 11:12:31 -0400
Message-ID: <CADnq5_PWWndBomBOXTYgmFqo+U8f8d8+OdJ5Ym3+a2mgO5=E0A@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 10:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 2, 2019 at 4:17 PM Alex Deucher <alexdeucher@gmail.com> wrote=
:
> >
> > I'm getting an error with gcc with this patch:
> >   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource=
.o
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In
> > function =E2=80=98calculate_wm_set_for_vlevel=E2=80=99:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:964:22:
> > error: SSE register return with SSE disabled
>
> I checked again with gcc-8, but do not see that error message.
>
> > > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D -mhard-float -ms=
se -mpreferred-stack-boundary=3D4
> > > +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D -mhard-float -ms=
se $(cc_stack_align)
>
> Nothing should really change with regards to the -msse flag here, only
> the stack alignment flag changed. Maybe there was some other change
> in your Makefile that conflicts with my my patch?

This patch on top of yours seems to fix it and aligns better with the
other Makefiles:

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index ef673bffc241..e71f3ee76cd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -9,10 +9,10 @@ else ifneq ($(call cc-option, -mstack-alignment=3D16),)
        cc_stack_align :=3D -mstack-alignment=3D16
 endif

-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D -mhard-float -msse
$(cc_stack_align)
+CFLAGS_dcn21_resource.o :=3D -mhard-float -msse $(cc_stack_align)

 ifdef CONFIG_CC_IS_CLANG
-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o +=3D -msse2
+CFLAGS_dcn21_resource.o +=3D -msse2
 endif

 AMD_DAL_DCN21 =3D $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
