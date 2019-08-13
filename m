Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43777C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190C220840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaRWVR3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfHMUM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:12:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33344 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHMUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:12:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so80783508qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lqf1BvRkrT0zFoMbdtExl8EI7GsnY3Mh1uu1vtSvfE=;
        b=PaRWVR3er7psEDVsOhRlEoF2QZxAWb5s5r09Y9Y2D3p6C5+NPwM/XkzbD90RUEphLI
         +Syn0GpMuCP0e0TN8DzZF3M0qmT10UKIkF7EBPHpVoZSNw4Cc0zogjYfN25CuTyeL3Jw
         AClxM8m+Ygb0KlbUKWQtvAvKT/uEZAqndaE7aMuVXuKQ/tH9StsaN5Yn/ssDTkHPDwni
         ne0yGHx8Wtp4S+FiahuEd09kqdMqWt2SS5umyL5a3BEYTp7KhrR7JFHdgVkYCerJdOvU
         DRmdFGNJPTW+6eJmRO21zU8ONhPl1PEKDesxLD779RIybT9NkvjLlK5DXv2S//RbgyYJ
         ylBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lqf1BvRkrT0zFoMbdtExl8EI7GsnY3Mh1uu1vtSvfE=;
        b=iA7i90TGZiYQvl+yjyfmxGbLUODGA/jXO6/uQDQ9TAhegbHkPHBjVGLBzMuB3srvPH
         vRLJdjJGcN7TN9gbFSpz/Xbp1xzCxh71aRtx9qUQ+B7A+bN9qSyOWHSl1/L5yh4hW2hU
         +KAy+9QWKdjbTmDrGw6VOzMnIPX95JVxSdtuXyH1pEk1LYllBdQCkhxIPOVfLiJjGWOW
         Qjhmtodhetu2uhV+cjydeFH2DfZmBrSUT8/nU6Zko9xO6CmvR3LHnltTzHfBoHV6cRG4
         qNywNiIukF3ju3VVOCVvSuTXog3pPrIRS5Q8cWuDRh/hWl/V0PJgXmp6SqJyEKKNotQF
         VoIQ==
X-Gm-Message-State: APjAAAWRBQmXNdy3kc54h5fdEGfijytrNQjRpWz7PnjIwnapnSy34ePt
        gNfCqG+/p4uRI9o4vhQa2dV4S5YdNZuL69efFBBggA==
X-Google-Smtp-Source: APXvYqyV/U0/+1MmPT+TGcVVYBP8Z8kW3m0SU/rhcx34vlDtB4WZg+oKZevkLnpngK5MGs7yUagnSRz+9Q5MEL08rU8=
X-Received: by 2002:ae9:ec06:: with SMTP id h6mr12020396qkg.221.1565727174451;
 Tue, 13 Aug 2019 13:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190613211228.34092-1-nhuck@google.com> <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
In-Reply-To: <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 13 Aug 2019 13:12:43 -0700
Message-ID: <CAJkfWY6U3RF=2X4geFsUhFADf9x0GO8s28KQmR7TvnVgo_WTig@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix Wshift-negative-value
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not familiar enough with the code to rewrite these parts of the
driver. Silencing the warnings while maintaining the same
functionality was the goal of this patch.

On Fri, Jun 14, 2019 at 3:52 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Nathan,
>
> On 13/06/2019 23:12, Nathan Huckleberry wrote:
> > Clang produces the following warning
> >
> > vers/thermal/rcar_gen3_thermal.c:147:33: warning: shifting a negative
> > signed value is undefined [-Wshift-negative-value] / (ptat[0] - ptat[2]=
)) +
> > FIXPT_INT(TJ_3); ^~~~~~~~~~~~~~~ drivers/thermal/rcar_gen3_thermal.c:12=
6:29
> > note: expanded from macro 'FIXPT_INT' #define FIXPT_INT(_x) ((_x) <<
> > FIXPT_SHIFT) ~~~~ ^ drivers/thermal/rcar_gen3_thermal.c:150:18: warning=
:
> > shifting a negative signed value is undefined [-Wshift-negative-value]
> > tsc->tj_t - FIXPT_INT(TJ_3)); ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> >
> > Upon further investigating it looks like there is no real reason for
> > TJ_3 to be -41. Usages subtract -41, code would be cleaner to just add.
>
> All the code seems broken regarding the negative value shifting as the
> macros pass an integer:
>
> eg.
>         tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
>                                  tsc->tj_t - FIXPT_INT(ths_tj_1));
>
> thcode[1] is always < than thcode[0],
>
> thcode[1] - thcode[0] < 0
>
> FIXPT_INT(thcode[1] - thcode[0]) is undefined
>
>
> Is it done on purpose FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]) ?
>
> Try developing the macro with the coef.a2 computation ...
>
> The code quality of this driver could be better, it deserves a rework
> IMHO ...
>
> I suggest to revert:
>
> 4eb39f79ef443fa566d36bd43f1f578d5c140305
> bdc4480a669d476814061b4da6bb006f7048c8e5
> 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144
>
> Rework the coefficient computation and re-introduce what was reverted in
> a nicer way.
>
>
> > Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of Tj_1"=
)
> > Cc: clang-built-linux@googlegroups.com
> > Link: https://github.com/ClangBuiltLinux/linux/issues/531
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar=
_gen3_thermal.c
> > index a56463308694..f4b4558c08e9 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -131,7 +131,7 @@ static inline void rcar_gen3_thermal_write(struct r=
car_gen3_thermal_tsc *tsc,
> >  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
> >
> >  /* no idea where these constants come from */
> > -#define TJ_3 -41
> > +#define TJ_3 41
> >
> >  static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc =
*tsc,
> >                                        int *ptat, const int *thcode,
> > @@ -144,11 +144,11 @@ static void rcar_gen3_thermal_calc_coefs(struct r=
car_gen3_thermal_tsc *tsc,
> >        * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
> >        */
> >       tsc->tj_t =3D (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> > -                  / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> > +                  / (ptat[0] - ptat[2])) - FIXPT_INT(TJ_3);
> >
> >       tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> > -                              tsc->tj_t - FIXPT_INT(TJ_3));
> > -     tsc->coef.b1 =3D FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
> > +                              tsc->tj_t + FIXPT_INT(TJ_3));
> > +     tsc->coef.b1 =3D FIXPT_INT(thcode[2]) + tsc->coef.a1 * TJ_3;
> >
> >       tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> >                                tsc->tj_t - FIXPT_INT(ths_tj_1));
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
