Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E0CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC69212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epxnDKo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFGMtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:49:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40896 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:49:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so2035202qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wfc0ONRiE7if96re9IgwhqZxlxJKyUTTfg/JtYHw6Xs=;
        b=epxnDKo4vb2qpmp6p0AVIYMa9cl9iKK1LLOl5bMlGKR0AY6TJWtGjVXLspm3fDzjpk
         08cqKA5rMFu7QLp1C6F8FdK9n7Q8dw8tZF0E8uRQpfst5CtV3OhRFRVt5SAbGgrFB7Ob
         No+5OQktEuAF0RZ9GvgbPA/OhYIEY9Wt8KaKNtguH25pGRm8L2WXIG962zD3Ohs3cfw1
         OZEYVyHjjWDPBuFSYoDhDQinBJoIMk32aYaCF0k590G0ZnhK09Jm0om6LtTETvTKL5ub
         aK1wbChp7D+i9mX1eTTbaUVO+sWS7XQJTCL3hsuASYEWuhpWN5OzC1X9GGn0tyskeF25
         3T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wfc0ONRiE7if96re9IgwhqZxlxJKyUTTfg/JtYHw6Xs=;
        b=OL7R4nEXYcqe1CNsGiv0RTPWLlZ0oDsdXxiXAb4a+jt/32Uya68EIrV6TzsIoX0d3O
         iOjSDc6LxJOlb4Kt8gDr7NZmxAvPSe5eGgJdceBqHp5pFt0wCo8GtdmdfQ4Ng92Dtgs7
         gLg+2/b9EgBS6a+VpKCSb5VFqVLvhgRNSCcWBqxiqeq7tXRc0Mi0JdRnUhi9cFfqGyW8
         MNLloL+qLgsH2v1SNeAxx4a/lmKLb4/2YBEcrm6eEMXQR4vOlmtA/1ZrPJo1qmct8qfl
         M2giAMNslqkHfxkJkgrCQPBLCgoZ5K+pkrKnAxrEmyKh+Vsp8Y2oBMmujEHB9gKmPXJk
         kdqw==
X-Gm-Message-State: APjAAAX+iHnrodytnns28xQl8VuUAQwhnHpSHuLgnFWx+OcwlOGfJk8L
        mSdqVewKTfcEmqBsMr3CAWIxYoxuNtXkYuEJawS9iQ==
X-Google-Smtp-Source: APXvYqxikxR4bWp/IUM1Vo5wMutzlbB13crxKTadcYTVL5fEBAhSxYAflS6HqhnaINjHAyc+TYR4oIJwdCMD1i+/IoM=
X-Received: by 2002:ac8:395b:: with SMTP id t27mr46770308qtb.115.1559911763243;
 Fri, 07 Jun 2019 05:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <1559550694-14042-1-git-send-email-yannick.fertre@st.com> <ca5d4bcf-6020-e924-5577-d7cf9134958b@st.com>
In-Reply-To: <ca5d4bcf-6020-e924-5577-d7cf9134958b@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 7 Jun 2019 14:49:12 +0200
Message-ID: <CA+M3ks6uUXVCHvzAW90GWMgOpkpQUwFhTo_MWdLwur4ZGmsMXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: No message if probe
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
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

Le ven. 7 juin 2019 =C3=A0 10:51, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Hi Yannick,
>
> Thank you for your patch
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next

Thanks,
Benjamin

> Philippe :-)
>
> On 6/3/19 10:31 AM, Yannick Fertr=C3=A9 wrote:
> > Print display controller hardware version in debug mode only.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index a40870b..2fe6c4a 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1229,7 +1229,7 @@ int ltdc_load(struct drm_device *ddev)
> >               goto err;
> >       }
> >
> > -     DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_versio=
n);
> > +     DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_versio=
n);
> >
> >       /* Add endpoints panels or bridges if any */
> >       for (i =3D 0; i < MAX_ENDPOINTS; i++) {
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
