Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04140CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C193A20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdAUuouV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJ3OEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:04:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43750 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJ3OEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:04:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1so2427408wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aCQjH8ptc0xQjGtBTJNWD3Vb7W7u0ebnKJvX0R/Yz4=;
        b=XdAUuouVCrplOq6HWCf2b9xX2ZwmWfDbyhUCgrd/FYSzwGrnllKA/tpcdkNyGCIV7k
         GmNRt7MxtDT8ym5pKXg5BaCjcPvnVgdZHd36rhqONQKzOdj7It6vGKB9S7gRmUWNbs9O
         J0621I7hdteKGK7OJRe27c06BCqwEK765uWJeKrz2XOISNsuyy/Qa0coCBXVnBzXGP8y
         Z6ECdvxOO49Mjx9kTRjFdJ990o7QQlL7+WI5UznJYZSvtkGfp4a252vBGvquUSPt9UuF
         nc6liJhOF9MBOTRFwwqYDfrQgPn5ND72V6yj1npv1WtvCsUucK3XteGKqEz3Y3Y/664Q
         prlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aCQjH8ptc0xQjGtBTJNWD3Vb7W7u0ebnKJvX0R/Yz4=;
        b=I0DRqHy0WgDAE0HUisXBb9cV32VYy2PJjXKR1G2f2epWyjNGwjB8tvQr9J5k6xsxMe
         /TVmz8AhPflELYce/XfVY40HVFmvFkVox+SHQHF1H3g5zXUZKgPODGXcbzn3zav3a9/G
         cVw3FTxll5EggQUXbKd2RCFQd9IZE3jn7iPPFR6yNDAyOQaCIRCfTK2nGTZhAiOslBLJ
         oK7fQ+hPHzXN8SkDgkCIglCKHoG2g0f9YZLg2d8y0gsMf0L7JoGUT+Bs1zomgVkXORmT
         4tRRcRZ9nRlG2rGEDG8eL3urq7iCanawRD1Lx4V28bMvssyXbCN7MZKGR/dm6JD2I5/r
         Rmsg==
X-Gm-Message-State: APjAAAWy5N3Z/74gD2IORkVJQWR/t1jQo77G6Wurw5Wb1QFBuH6BdmRe
        NkxKJfiMtAiQKt0cJgF7NIIQQbbjNZ1HKsNqqes=
X-Google-Smtp-Source: APXvYqwTAy8oRD3wSDNrCPJ71Mb+mys6TqLa+zDd6xNTeXh8ujQwAqSutbrzGp+AzHWyrKeCWOhqo/8jo1XSYriwAf4=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr72834wrr.50.1572444250709;
 Wed, 30 Oct 2019 07:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191030060411.21168-1-natechancellor@gmail.com> <b8a9f49e-b788-82b8-ead3-0ae6fba7e8fa@amd.com>
In-Reply-To: <b8a9f49e-b788-82b8-ead3-0ae6fba7e8fa@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 30 Oct 2019 10:03:59 -0400
Message-ID: <CADnq5_Na9Lyb_9z7DY27o8SWkPQNi6pNbU1qXd0R7W6_Qa9Xtg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Add a conversion function for
 transmitter and phy_id enums
To:     "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Li, Roman" <Roman.Li@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 8:33 AM Kazlauskas, Nicholas
<Nicholas.Kazlauskas@amd.com> wrote:
>
> On 2019-10-30 2:04 a.m., Nathan Chancellor wrote:
> > Clang warns:
> >
> > ../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2520:42:
> > error: implicit conversion from enumeration type 'enum transmitter' to
> > different enumeration type 'enum physical_phy_id'
> > [-Werror,-Wenum-conversion]
> >          psr_context->smuPhyId = link->link_enc->transmitter;
> >                                ~ ~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > 1 error generated.
> >
> > As the comment above this assignment states, this is intentional. To
> > match previous warnings of this nature, add a conversion function that
> > explicitly converts between the enums and warns when there is a
> > mismatch.
> >
> > See commit 828cfa29093f ("drm/amdgpu: Fix amdgpu ras to ta enums
> > conversion") and commit d9ec5cfd5a2e ("drm/amd/display: Use switch table
> > for dc_to_smu_clock_type") for previous examples of this.
> >
> > Fixes: e0d08a40a63b ("drm/amd/display: Add debugfs entry for reading psr state")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/758
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> With the small nitpick that maybe the default case should be
> PHYLD_UNKNOWN, but well get the warning if that happens anyway.
>

Applied with that change.

Thanks!

Alex

> Nicholas Kazlauskas
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 38 ++++++++++++++++++-
> >   1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index 7b18087be585..38dfe460e13b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -2447,6 +2447,41 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
> >       return true;
> >   }
> >
> > +static inline enum physical_phy_id
> > +transmitter_to_phy_id(enum transmitter transmitter_value)
> > +{
> > +     switch (transmitter_value) {
> > +     case TRANSMITTER_UNIPHY_A:
> > +             return PHYLD_0;
> > +     case TRANSMITTER_UNIPHY_B:
> > +             return PHYLD_1;
> > +     case TRANSMITTER_UNIPHY_C:
> > +             return PHYLD_2;
> > +     case TRANSMITTER_UNIPHY_D:
> > +             return PHYLD_3;
> > +     case TRANSMITTER_UNIPHY_E:
> > +             return PHYLD_4;
> > +     case TRANSMITTER_UNIPHY_F:
> > +             return PHYLD_5;
> > +     case TRANSMITTER_NUTMEG_CRT:
> > +             return PHYLD_6;
> > +     case TRANSMITTER_TRAVIS_CRT:
> > +             return PHYLD_7;
> > +     case TRANSMITTER_TRAVIS_LCD:
> > +             return PHYLD_8;
> > +     case TRANSMITTER_UNIPHY_G:
> > +             return PHYLD_9;
> > +     case TRANSMITTER_COUNT:
> > +             return PHYLD_COUNT;
> > +     case TRANSMITTER_UNKNOWN:
> > +             return PHYLD_UNKNOWN;
> > +     default:
> > +             WARN_ONCE(1, "Unknown transmitter value %d\n",
> > +                       transmitter_value);
> > +             return PHYLD_0;
> > +     }
> > +}
> > +
> >   bool dc_link_setup_psr(struct dc_link *link,
> >               const struct dc_stream_state *stream, struct psr_config *psr_config,
> >               struct psr_context *psr_context)
> > @@ -2517,7 +2552,8 @@ bool dc_link_setup_psr(struct dc_link *link,
> >       /* Hardcoded for now.  Can be Pcie or Uniphy (or Unknown)*/
> >       psr_context->phyType = PHY_TYPE_UNIPHY;
> >       /*PhyId is associated with the transmitter id*/
> > -     psr_context->smuPhyId = link->link_enc->transmitter;
> > +     psr_context->smuPhyId =
> > +             transmitter_to_phy_id(link->link_enc->transmitter);
> >
> >       psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
> >       psr_context->vsyncRateHz = div64_u64(div64_u64((stream->
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
