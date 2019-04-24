Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E208C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0A8218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg2pNjdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfDXM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:26:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38767 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfDXM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:26:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so19958803qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k/G53At6GpO9p20H7pGhrT8FvlHyaW2wBtqlzxG9UpA=;
        b=eg2pNjdcN3TTp0Zz+anyu2txkD2KAV89Qi6LLwLSVeAy3gZiIBVCqOc4Ghm8sFs+yv
         riM6B01w+KmJpFNJWCSxgoX6JNaLwnfmrpHRGgDPeH6wGzSceNeQ44Bgr5U3z1e8qnFL
         prFr9nw+Cv4vrTter875x1+2fL0FJGu0/t5fjkthVxu0t1g66eJm/cR/OrNCyg6BpLzY
         P8wktdg7gdWhIRCe5RLC0NPJB1vwjT5CNNt0Ejk6V8aQDBPODh/QEqBS9icMHMeLFS1l
         ch/jt/p3libNRcsJn4ilA5QqS/b/kN1fa4U/Rzo2PLBnd135cH4jflQQEVPKMPeujBNJ
         GxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k/G53At6GpO9p20H7pGhrT8FvlHyaW2wBtqlzxG9UpA=;
        b=WyN0rVhZootkP0cl6HKc9AaitO8kwP3B4ufEhmM0g1LkiKhm24+UHe03A3svv5SYm6
         wvC5epjykFCeriMf9G9b+BkZSPYpfJSgM/7WFskNOKSth8RIXmXGNuCP9jBUg1BLcmv/
         dw2HSmVkap3mWRcmX7vCxuuSUar/6id+UfVwDbX4FMMxS0ld75OOJzX4PSF3v1rQpZCR
         EDisgpr/2wNaxyYeN5qvzbEraZl16yBHgYLhLgtm8gf2o582/pLJtFxfChsih/Z6/xhB
         SJG3NthNdqyIoNt5DVcBrJBWweImPd5Mdr3F3heaGIpgDsBj5RFFqtS/fCpqyBHV8m/q
         JSIg==
X-Gm-Message-State: APjAAAUDgmCrOfKn4G2HEWIi1BQMiaJ7qtwKfF91feXHhrqsuKYpzKMy
        ShtXRgFDPJ9RrCDpyBdV2XqFrVxP5ZRlPd3+CsTKIw==
X-Google-Smtp-Source: APXvYqx57ALUlPRQ49wlbfJdiVS8H6Riwho98PXRJ3tNyuCbQIKmc3Jthjn7pTxcyjeVjbTyu2FFM7S0W3XeN9CZwQY=
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr1176233qvu.98.1556108774534;
 Wed, 24 Apr 2019 05:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <1553874548-31366-1-git-send-email-yannick.fertre@st.com> <ef8aa4e8-ebf9-ea01-d8db-fbf7740bc765@st.com>
In-Reply-To: <ef8aa4e8-ebf9-ea01-d8db-fbf7740bc765@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:26:03 +0200
Message-ID: <CA+M3ks6RZmXjCh_r5MBLGeNb4vY4g8nOCX=cSbCe8GW4rHc4gQ@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: use DRM_WARN for fifo & transfer error messages
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
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

Le lun. 1 avr. 2019 =C3=A0 11:20, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Dear Yannick,
> Fully agree with this approach,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>

Applied on drm-misc-next,
Thanks,
Benjamin

> Philippe :-)
>
> On 3/29/19 4:49 PM, Yannick Fertr=C3=A9 wrote:
> > From: Philippe Cornu <philippe.cornu@st.com>
> >
> > Use DRM_WARN() instead of DRM_DEBUG_DRIVER() to better
> > inform the user in case of fifo underruns or
> > transfer errors.
> >
> > Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index b1741a9..15d8a02 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -822,11 +822,11 @@ static void ltdc_plane_atomic_update(struct drm_p=
lane *plane,
> >
> >       mutex_lock(&ldev->err_lock);
> >       if (ldev->error_status & ISR_FUIF) {
> > -             DRM_DEBUG_DRIVER("Fifo underrun\n");
> > +             DRM_WARN("ltdc fifo underrun: please verify display mode\=
n");
> >               ldev->error_status &=3D ~ISR_FUIF;
> >       }
> >       if (ldev->error_status & ISR_TERRIF) {
> > -             DRM_DEBUG_DRIVER("Transfer error\n");
> > +             DRM_WARN("ltdc transfer error\n");
> >               ldev->error_status &=3D ~ISR_TERRIF;
> >       }
> >       mutex_unlock(&ldev->err_lock);
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
