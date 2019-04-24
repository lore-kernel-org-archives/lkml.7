Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560EEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E7421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZGt7Z5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfDXM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:26:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37456 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDXM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:26:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so10679953qkk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=shO5EWIaGQE9ySOldQKtzNfSKKSvl2kegAtmzbG5KWI=;
        b=YZGt7Z5fXvH+kNeFJHV97NbYg7TF7XrWvZlGjxPbWM3MEGCeTPTWfJjOfCaBe/+lVM
         CF372M90IkgKlr6L4gESCeKtRofeTfG3rUnYGyQgPLIK9ppg/YxHb+fLom9XpBvGtNT3
         O8ysDFToGZ6gz8vFjuTHqnST5BgFXoXqdoXZgAUl8RNI5KIv59DzhHalZinNip8kNwFM
         fQ6UMPg0V/HBBhOAn1lWfC7T1Hvm8SG2rW5lk/MpSdx1UiS5nmARO9j+h5yJK2jywaVZ
         CaF1OFQP8aToTxMu0O0NlqozdEBXv0aks72jNT9HAgNZ3TSvX7pGuaREiPRxKezTeiBw
         YN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=shO5EWIaGQE9ySOldQKtzNfSKKSvl2kegAtmzbG5KWI=;
        b=AjDQ4oA8EJ47/BkJMIx3wairt/IK83pS6RfHlIa4npDPTIDHa0MKNbhaNHwGOAwxyp
         Dpen0D001+8zvWPARCjwR93lYWQhyC6pT0w+ePIGBXNonClfY3oc1fxJOJls+8ja7Lp2
         Br7AdBkKosxM/6+BKh/0l3xzxA76nP4OgZ7jcjlaVIT56apR+arHYF87q9aB8wUaUYHh
         uChxbvfXkO8t3Ki710OD4aqNB3d3XSYzofNJHts7st0s8PAjCaS7kFkHUb6P5mh0VQ0M
         PA6oJhgldjviyPTMO/w1Zu7Z5iGfatyNMiqDdN/YZq8ZSyN4EF2Kyo3/ntKd5oTh7+fU
         UcxA==
X-Gm-Message-State: APjAAAXIN6g7O/TjIHjOcsffnSkTJKKavf6L40GXb+zd/4bNOKlGkLyQ
        LHOY3NRrGfIfn29tLu12DyFCxh2hZDSiJkQDyw9KoQ==
X-Google-Smtp-Source: APXvYqwPfrRIQAHNl7xt59wRX38flwb128N85TgSsZ80HFn0kHxSMXvI3lV4ukXhabc1dMCWcEya7OYbOi/HTAARtKg=
X-Received: by 2002:a37:8843:: with SMTP id k64mr24133797qkd.8.1556108807662;
 Wed, 24 Apr 2019 05:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <1553874620-31468-1-git-send-email-yannick.fertre@st.com>
 <98a9609b-138b-fc5b-c2b2-46f465c88bab@codeaurora.org> <aeb9a5b0-0ad7-7bd1-eaf3-d037c2fb39cf@st.com>
In-Reply-To: <aeb9a5b0-0ad7-7bd1-eaf3-d037c2fb39cf@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:26:36 +0200
Message-ID: <CA+M3ks4wYvutkSbYu_xo=xwvr=ObqMPS7Zv0oaLL3MZzBbRBFw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: fix data enable polarity
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 1 avr. 2019 =C3=A0 11:18, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
>
>
> On 3/29/19 10:32 PM, Mukesh Ojha wrote:
> >
> > On 3/29/2019 9:20 PM, Yannick Fertr=C3=A9 wrote:
> >> Wrong DISPLAY_FLAGS used to set the data enable polarity.
> > Used or checked?
> > Can you also explain how it is wrong to check against this FLAG in comm=
it?
>
> Dear Yannick,
> Many thanks for your patch,
>
> Dear Mukesh,
> Many thanks for your comment,
>
> Looking deeper in the stm32 LTDC Ref man chapter, we can read:
>
> Bit 30 VSPOL: vertical synchronization polarity
> This bit is set and cleared by software.
> 0: vertical synchronization is active low.
> 1: vertical synchronization is active high.
>
> Bit 29 DEPOL: not data enable polarity
> This bit is set and cleared by software.
> 0: not data enable polarity is active low.
> 1: not data enable polarity is active high.
>
> So I suggest the following commit message:
> "According to the STM32 LTDC documentation, GCR_DEPOL bit need to be set
> with DISPLAY_FLAGS_DE_LOW but not with DISPLAY_FLAGS_DE_HIGH."
>
> With that or something similar
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>

Applied on drm-misc-next,
Thanks,
Benjamin

> Philippe :-)
>
>
> >>
> >> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> >> ---
> >>    drivers/gpu/drm/stm/ltdc.c | 2 +-
> >>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> >> index b1741a9..6ba326a 100644
> >> --- a/drivers/gpu/drm/stm/ltdc.c
> >> +++ b/drivers/gpu/drm/stm/ltdc.c
> >> @@ -555,7 +555,7 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crt=
c *crtc)
> >>      if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
> >>              val |=3D GCR_VSPOL;
> >>
> >> -    if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> >> +    if (vm.flags & DISPLAY_FLAGS_DE_LOW)
> >>              val |=3D GCR_DEPOL;
> >>
> >>      if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
