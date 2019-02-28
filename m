Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F90C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7771A218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDnVbm4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfB1CfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:35:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56166 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbfB1CfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:35:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so7778907wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufkKUPGhZtWYHIJ6EOYJ6kb2NVVZjZEaho4MM+K7NWI=;
        b=tDnVbm4HvO3FzrHbC7LasjxcUW4swbWM/0dFf/YIza0j8A98CKnryjcI2dx/gsAFGU
         e7R2VbgARmaJu3gupfYP3JPDh2Nq45XChLjKWuTlcDOuBxH9OOjwhdbqCUFNlu4ZSTot
         aPSfsyyYHPoKvbcp/rV7+K0zTtWRWzVMpMLZVsrUSpUrO7uieMyfcK+C3565P8XM5Myv
         Mg3rMpMpnO/YzzPBm/Z/uHKYM/Uh23WiAnBnlrlHC3JLuV8AqMswO5bDYlypd/Hg2B5R
         b84Qie2nwD+mKPbFvOsi2+4vI86bmVZYKlUAHDVXoR118o/ZT43V8cS3B/qQeKGGTZEu
         q2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufkKUPGhZtWYHIJ6EOYJ6kb2NVVZjZEaho4MM+K7NWI=;
        b=uLE3eH6E8qcn5V7nuk87E56znbMxdRiNpJHg3LJ7ewY6w8hAZTWlab5DaixhlGwaX1
         QXHb9SONJYni85O0UE1KKhEzDh8s1mC3WIIznZYrESG6Z81Qh1TtADvd28L0qfHMXooA
         b9uMSl0m4xIHAp4YTp5raEVUT3NaVpR0PzNC1o4mPsogneQ5Rmmo8ueuf+buCHYx1COa
         JtUs84B0cg9rDjAkVNy9hpFlh1fR2rHmXnSCiDJq6DvUTA5eTrjN/CBqU1SN8AGWrnL7
         CjHtkIqRu9foBQ29YTekTpOufzaPoDL+gqszg7OnddFnW7saPC2KPX8BT2C2/m+a1Zdz
         42XQ==
X-Gm-Message-State: APjAAAU3tZ1R7kLzLypuuMFClCQlRE2tixwXOJx6AUH7b5sbg97tx5uY
        A7kh6yKM5lASfEeqYBlIIgmh4zq2l2ho9A/4gCA=
X-Google-Smtp-Source: AHgI3Ib0D9K/DpKWlCEtPKIBG0TyWE8D/x/8S7IL/BPRw5zFE2SUYgpUyy26Mg1/OuWy9E2fu2e+nutX3QK7484j12c=
X-Received: by 2002:a1c:670a:: with SMTP id b10mr1326650wmc.82.1551321312283;
 Wed, 27 Feb 2019 18:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20181210234201.4850-1-natechancellor@gmail.com> <20190222124845.GA18614@archlinux-ryzen>
In-Reply-To: <20190222124845.GA18614@archlinux-ryzen>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Feb 2019 21:34:59 -0500
Message-ID: <CADnq5_NC_3zeMN2EE5T-eQy2JY1cAxHxdcGsUiP-vs-Du0Q=Eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by reference
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Sorry for the delay.

Alex

On Fri, Feb 22, 2019 at 10:36 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 04:42:01PM -0700, Nathan Chancellor wrote:
> > Clang warns when an expression that equals zero is used as a null
> > pointer constant (in lieu of NULL):
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> > warning: expression which evaluates to zero treated as a null pointer
> > constant of type 'const enum color_transfer_func *'
> > [-Wnon-literal-null-conversion]
> >                 TRANSFER_FUNC_UNKNOWN,
> >                 ^~~~~~~~~~~~~~~~~~~~~
> > 1 warning generated.
> >
> > This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> > state using drm VRR properties") and it could be solved by using NULL
> > instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> > pointer. However, after looking into it, there doesn't appear to be a
> > good reason to pass app_tf by reference as it is never mutated along the
> > way. This is the only code path in which app_tf is used:
> >
> > mod_freesync_build_vrr_infopacket ->
> >     build_vrr_infopacket_v2 ->
> >         build_vrr_infopacket_fs2_data
> >
> > Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> > modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> > the value so we can avoid dereferencing anything by just passing in
> > app_tf's value to mod_freesync_build_vrr_infopacket and
> > build_vrr_infopacket_v2.
> >
> > There is no functional change because build_vrr_infopacket_fs2_data
> > doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> > as not calling build_vrr_infopacket_fs2_data at all like before this
> > change when NULL was used for app_tf.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
> >  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > index 620a171620ee..520665a9d81a 100644
> > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
> >
> >  static void build_vrr_infopacket_v2(enum signal_type signal,
> >               const struct mod_vrr_params *vrr,
> > -             const enum color_transfer_func *app_tf,
> > +             enum color_transfer_func app_tf,
> >               struct dc_info_packet *infopacket)
> >  {
> >       unsigned int payload_size = 0;
> > @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
> >       build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
> >       build_vrr_infopacket_data(vrr, infopacket);
> >
> > -     if (app_tf != NULL)
> > -             build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> > +     build_vrr_infopacket_fs2_data(app_tf, infopacket);
> >
> >       build_vrr_infopacket_checksum(&payload_size, infopacket);
> >
> > @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> >               const struct dc_stream_state *stream,
> >               const struct mod_vrr_params *vrr,
> >               enum vrr_packet_type packet_type,
> > -             const enum color_transfer_func *app_tf,
> > +             enum color_transfer_func app_tf,
> >               struct dc_info_packet *infopacket)
> >  {
> >       /* SPD info packet for FreeSync */
> > diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > index 949a8b62aa98..063af6258fd9 100644
> > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> >               const struct dc_stream_state *stream,
> >               const struct mod_vrr_params *vrr,
> >               enum vrr_packet_type packet_type,
> > -             const enum color_transfer_func *app_tf,
> > +             enum color_transfer_func app_tf,
> >               struct dc_info_packet *infopacket);
> >
> >  void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
> > --
> > 2.20.0
> >
>
> Gentle ping on this patch, it would be nice to get this fixed and into
> 5.1!
>
> Thanks,
> Nathan
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
