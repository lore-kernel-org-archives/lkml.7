Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0936C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AAA222C9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY+6Jifa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbfJCQGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:06:10 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45461 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbfJCQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:06:07 -0400
Received: by mail-yw1-f65.google.com with SMTP id x65so1199157ywf.12;
        Thu, 03 Oct 2019 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLNNT4AIEjIBRo/lVJ/0ZBtdA9h4araJ69Seis53dWQ=;
        b=fY+6Jifakv49XRBxdyt+s4Vqj6XBQnOPNAStPbm49uy988veIOvPI/V3Sy04K+Lp/i
         9nJMoST/5wPj1ojvMgOqAGpE0625jxeungZAmysfm4alrJTMc+KrEESKo1VMk8MNvR9Y
         397V54nnMVK9X2+83ZrM0pca0/8NA1xxnWZvFIl26VyMAvUfAiV8j8nngj9H7oBgR5WZ
         fMgbjqJtswkD43Bglr5/Ylnf4KckUv6e6Fan0AKN5wGjZqDkMhlnfPJu75vQMXJ5VI+G
         jIEwjD0k7i0K2UQRruAfmK01a+T/dNrKVfp9uVYsKbChcspbGXWWG19eGGgGVPltNt+7
         VisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLNNT4AIEjIBRo/lVJ/0ZBtdA9h4araJ69Seis53dWQ=;
        b=JXRmc7oA6PhvzdXmvwWIrbKC8NeqVNj8GCshEpk2TiPoszd7GxcTwz7XwV+ihIqzcp
         hTiEyF/0z/ysj6NmGoVx64Gc3CWkHg3ytaiC36kyQRGi41AwRT6eyoXJwGqNrPmlBxyS
         dhdv4IgSR7+2tSkBA7o06IYWiakPhD7CkZBinHChDX1El9RbY4FNQmPbMw4n2pZFTX+M
         vTnl38kl1PBmnD3qJiKHeOJmSZargEJOArhuUvAh4yuaSY1XY7+qYUq4qd9usJveGwit
         hOLMCAEGPzdC634HdoUgyJxMRuk/+Av7LV7BXfwXBnAIyXFOD4yl10sEvZZW4QRVGdmk
         Q8lw==
X-Gm-Message-State: APjAAAVrDQxy/mQ8uyNRN1XRWKuAEQ0iwUAG0lai3dcgVqp8okmd/Da5
        WH/uLHU+qOSauhHuJtdh7WbfCs0Yy6vFXTm4m/U=
X-Google-Smtp-Source: APXvYqzDJqamusQ0BB8tClY58QAeDkzR4fFBm6KrwPRGlb9RxSwrwAJCXBteDfm4gLKsevMcJoAhgKIlUl2aL15Bozg=
X-Received: by 2002:a81:a401:: with SMTP id b1mr6798539ywh.280.1570118765879;
 Thu, 03 Oct 2019 09:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191003082232.4136-1-colin.king@canonical.com> <125634cd-b636-c4dc-4e05-bc5c543b7230@amd.com>
In-Reply-To: <125634cd-b636-c4dc-4e05-bc5c543b7230@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 3 Oct 2019 12:05:52 -0400
Message-ID: <CADnq5_OAoct7q-CQQ=aLoUXpGcJa8qf=P7V1g=FS9Z6wiPhGog@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/display: fix spelling mistake
 AUTHENICATED -> AUTHENTICATED
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.or" <dri-devel@lists.freedesktop.or>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 9:27 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-10-03 4:22 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in the macros H1_A45_AUTHENICATED and
> > D1_A4_AUTHENICATED, fix these by adding the missing T.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h      |  4 ++--
> >  .../drm/amd/display/modules/hdcp/hdcp1_execution.c   |  4 ++--
> >  .../drm/amd/display/modules/hdcp/hdcp1_transition.c  | 12 ++++++------
> >  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c  |  8 ++++----
> >  4 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> > index 402bb7999093..5664bc0b5bd0 100644
> > --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> > +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> > @@ -176,7 +176,7 @@ enum mod_hdcp_hdcp1_state_id {
> >       H1_A0_WAIT_FOR_ACTIVE_RX,
> >       H1_A1_EXCHANGE_KSVS,
> >       H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER,
> > -     H1_A45_AUTHENICATED,
> > +     H1_A45_AUTHENTICATED,
> >       H1_A8_WAIT_FOR_READY,
> >       H1_A9_READ_KSV_LIST,
> >       HDCP1_STATE_END = H1_A9_READ_KSV_LIST
> > @@ -188,7 +188,7 @@ enum mod_hdcp_hdcp1_dp_state_id {
> >       D1_A1_EXCHANGE_KSVS,
> >       D1_A23_WAIT_FOR_R0_PRIME,
> >       D1_A2_COMPUTATIONS_A3_VALIDATE_RX_A5_TEST_FOR_REPEATER,
> > -     D1_A4_AUTHENICATED,
> > +     D1_A4_AUTHENTICATED,
> >       D1_A6_WAIT_FOR_READY,
> >       D1_A7_READ_KSV_LIST,
> >       HDCP1_DP_STATE_END = D1_A7_READ_KSV_LIST,
> > diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> > index 9e7302eac299..3db4a7da414f 100644
> > --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> > +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> > @@ -476,7 +476,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
> >               status = computations_validate_rx_test_for_repeater(hdcp,
> >                               event_ctx, input);
> >               break;
> > -     case H1_A45_AUTHENICATED:
> > +     case H1_A45_AUTHENTICATED:
> >               status = authenticated(hdcp, event_ctx, input);
> >               break;
> >       case H1_A8_WAIT_FOR_READY:
> > @@ -513,7 +513,7 @@ extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
> >               status = computations_validate_rx_test_for_repeater(
> >                               hdcp, event_ctx, input);
> >               break;
> > -     case D1_A4_AUTHENICATED:
> > +     case D1_A4_AUTHENTICATED:
> >               status = authenticated_dp(hdcp, event_ctx, input);
> >               break;
> >       case D1_A6_WAIT_FOR_READY:
> > diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
> > index 1d187809b709..136b8011ff3f 100644
> > --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
> > +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
> > @@ -81,11 +81,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
> >                       set_state_id(hdcp, output, H1_A8_WAIT_FOR_READY);
> >               } else {
> >                       callback_in_ms(0, output);
> > -                     set_state_id(hdcp, output, H1_A45_AUTHENICATED);
> > +                     set_state_id(hdcp, output, H1_A45_AUTHENTICATED);
> >                       HDCP_FULL_DDC_TRACE(hdcp);
> >               }
> >               break;
> > -     case H1_A45_AUTHENICATED:
> > +     case H1_A45_AUTHENTICATED:
> >               if (input->link_maintenance != PASS) {
> >                       /* 1A-07: consider invalid ri' a failure */
> >                       /* 1A-07a: consider read ri' not returned a failure */
> > @@ -129,7 +129,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
> >                       break;
> >               }
> >               callback_in_ms(0, output);
> > -             set_state_id(hdcp, output, H1_A45_AUTHENICATED);
> > +             set_state_id(hdcp, output, H1_A45_AUTHENTICATED);
> >               HDCP_FULL_DDC_TRACE(hdcp);
> >               break;
> >       default:
> > @@ -224,11 +224,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
> >                       set_watchdog_in_ms(hdcp, 5000, output);
> >                       set_state_id(hdcp, output, D1_A6_WAIT_FOR_READY);
> >               } else {
> > -                     set_state_id(hdcp, output, D1_A4_AUTHENICATED);
> > +                     set_state_id(hdcp, output, D1_A4_AUTHENTICATED);
> >                       HDCP_FULL_DDC_TRACE(hdcp);
> >               }
> >               break;
> > -     case D1_A4_AUTHENICATED:
> > +     case D1_A4_AUTHENTICATED:
> >               if (input->link_integiry_check != PASS ||
> >                               input->reauth_request_check != PASS) {
> >                       /* 1A-07: restart hdcp on a link integrity failure */
> > @@ -295,7 +295,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
> >                       fail_and_restart_in_ms(0, &status, output);
> >                       break;
> >               }
> > -             set_state_id(hdcp, output, D1_A4_AUTHENICATED);
> > +             set_state_id(hdcp, output, D1_A4_AUTHENTICATED);
> >               HDCP_FULL_DDC_TRACE(hdcp);
> >               break;
> >       default:
> > diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> > index d868f556d180..3982ced5f969 100644
> > --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> > +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> > @@ -136,8 +136,8 @@ char *mod_hdcp_state_id_to_str(int32_t id)
> >               return "H1_A1_EXCHANGE_KSVS";
> >       case H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER:
> >               return "H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER";
> > -     case H1_A45_AUTHENICATED:
> > -             return "H1_A45_AUTHENICATED";
> > +     case H1_A45_AUTHENTICATED:
> > +             return "H1_A45_AUTHENTICATED";
> >       case H1_A8_WAIT_FOR_READY:
> >               return "H1_A8_WAIT_FOR_READY";
> >       case H1_A9_READ_KSV_LIST:
> > @@ -150,8 +150,8 @@ char *mod_hdcp_state_id_to_str(int32_t id)
> >               return "D1_A23_WAIT_FOR_R0_PRIME";
> >       case D1_A2_COMPUTATIONS_A3_VALIDATE_RX_A5_TEST_FOR_REPEATER:
> >               return "D1_A2_COMPUTATIONS_A3_VALIDATE_RX_A5_TEST_FOR_REPEATER";
> > -     case D1_A4_AUTHENICATED:
> > -             return "D1_A4_AUTHENICATED";
> > +     case D1_A4_AUTHENTICATED:
> > +             return "D1_A4_AUTHENTICATED";
> >       case D1_A6_WAIT_FOR_READY:
> >               return "D1_A6_WAIT_FOR_READY";
> >       case D1_A7_READ_KSV_LIST:
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
