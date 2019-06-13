Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A14C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A1621721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKeuB0I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfFMSwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:52:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfFMSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:52:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so6605122wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wF2lkDhjSFApoIX2SzKaCuD9I+vf8Vpj5caLDxf35+o=;
        b=AKeuB0I58ke460ynxyqX4+mFv2g4TegQbeImOxNCfMfyFsDied0f2UkwWeSUzabyxL
         XN4/m+xKjVR2ysnHrDJhul5Ezm6ZNBX0sNHXzUcrn8/Om/ayxXPeQKR6C8DzXSUwBOIi
         BxW28g4p2jpnLM6+DphXrs6V1LAi4d00MesmFGsBroqcJ/yT9HIfIfu9f4WwtVvhsW9p
         PaSpOCjpMWgWYBtZIR0nSJ8fRPP9cvokb2vDJqm/kHSpejndIsa+O/i9TvnawipNO9q+
         X51wWbjK5F22t0ic653gOiEOxyVVJAqbV69W0+6xOvnelXd8GxCioB9EAnuHVYp4zLjX
         d7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wF2lkDhjSFApoIX2SzKaCuD9I+vf8Vpj5caLDxf35+o=;
        b=Rj4Qjm5iBSZE6nXvLrxlyANlnOXzev+W+OEJs69nkv2HKK6JdwgMGZTVVZyf8tQrrC
         ByjsztziWL48o+Qwed79hcd7FMD1ONDCm9PZEYs7kJ1I++Yqh9ZgAN+R7o7hosiuHCZX
         a5O3zc3ikzks1D44LjC5UC4H+2pnzzQaHDrswka8SxIpHATbbAaOfz5K8Rorrf2mjMZR
         KP8mmubj/G4nK21pxvS3WZGusivCgz6Mtbe4Pn3dk4B/AFNBXQL0LIlG8KQoyJPiWCN0
         8IjLYNG/3lvroeZMI4ZI7kRAC2nkoPHW9Sz6lXMSIauVT1fntUgvG/SDnp1K9lDxehQt
         wfiA==
X-Gm-Message-State: APjAAAUVr4YrDtXXqW31U2DydquPEW9L507vplf85OChEYAkKO18sB3S
        rvidmcd7sm+ToSyabUqXOBdxGr2yKJde0+Itk+I=
X-Google-Smtp-Source: APXvYqz65TzXVExemKM65WYyNEKOoA5AJHrWLhsVDtVW9SOWURsb3zfBCUNgnQbyfrShxmr87zPG9wDFtS2xCWSEGOk=
X-Received: by 2002:adf:f68f:: with SMTP id v15mr10763850wrp.4.1560451966892;
 Thu, 13 Jun 2019 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190613023208.GA29690@hari-Inspiron-1545> <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
 <20190613184217.GA2385@ravnborg.org>
In-Reply-To: <20190613184217.GA2385@ravnborg.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 Jun 2019 14:52:34 -0400
Message-ID: <CADnq5_OSjJad7QGOCrWQL+LcjtCHQsCefpJ=K0mYUayFe9bUAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Gloria Li <geling.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:42 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alex.
>
> On Wed, Jun 12, 2019 at 10:35:26PM -0400, Alex Deucher wrote:
> > On Wed, Jun 12, 2019 at 10:34 PM Hariprasad Kelam
> > <hariprasad.kelam@gmail.com> wrote:
> > >
> > > this patch fixes below compilation error
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: =
In
> > > function =E2=80=98dcn10_apply_ctx_for_surface=E2=80=99:
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2=
378:3:
> > > error: implicit declaration of function =E2=80=98udelay=E2=80=99
> > > [-Werror=3Dimplicit-function-declaration]
> > >    udelay(underflow_check_delay_us);
> > >
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> Am I right in assuming you took this patch?
>
> I expect that new code using udelay was added to the amd tree,
> and when merged with drm-misc-next it failed, because drm-misc-next no
> longer had drmP.h included so no implicit include of delay.h
>
> The root cause was that my original patchset should have been based
> on the amd tree, and applied there :-(

No worries.  I've picked it up.

Alex
