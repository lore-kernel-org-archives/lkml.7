Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8424DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B672082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8bIRrbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfFTROe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:14:34 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34926 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:14:33 -0400
Received: by mail-ua1-f65.google.com with SMTP id j21so1958400uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GR6x4on2th+OpGEr++2MdtxVD5WfNFN9wx4DvQ5w7Rc=;
        b=V8bIRrbAwIjB8y/e3VK5hdGQiO8fdK96fE89vK+8xM34pSYwtIAitElGMyEc8eEZ8Y
         JNN2Dm3GQX4EuHrYdTR03KQM7saTG0dG9xx5zg8ZkNjOfIr6ls5jeWmDIaheAotE/Yfs
         HELQdZl4/gheu42t/o9XX2Hh2YkYYtpBtob1vLOLhf9cgFBMV0rKwK8fnXV2suKtO/C4
         XaCv7FZXM2vP1vPi93jU4r/GnJzEFBq/C2BcDaw/yl5TkAlj+EOjsIQ+vkSq6f4v28Z8
         W3CDYr6Ag4umJu04mO2GC/WVWTh8HbyridbYuXZEfCtzeI4aRTnbJLsQ1DmiR9jSu4Ai
         gbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GR6x4on2th+OpGEr++2MdtxVD5WfNFN9wx4DvQ5w7Rc=;
        b=dm9GfbBecMfCLuEA8zbBZqlnLnb5Saq94ub290r+AHM+xKtOJwWf5NiSFbftEwaphR
         b672Ccv6EMwz0uAjTBpqxpuEnoBp3zhtTpVPYAKl2shZO22Sy/c2IIFcFqo1dmi0kyvW
         BCjOgAfvDxGsNBIsUEp1zSdG5YgyuYtBYCPOIOnN+/WE2ZP5oEkL9W/2kqMADeRXuek/
         q7WxVgeni37KcxluGB60uGmUh8en3/vyoWtYAZ0RK4biJhxRhWM8GNbrYMW5yRAwf4hn
         3bV8MhFMXh+YG+kjSplYuxL2Nfy7IiqAfZgo/A2PkA+tbqjIsG+JZs7I2VYelAWTqdjN
         GBXw==
X-Gm-Message-State: APjAAAU6OItrsgBMozvKpi+3EQ93i0ECHFjYCJpgTfS6wJ2TJS3faNZV
        YiSPVN6OshF+34vRPOA5sFtPgn3p12d9bNKcBVS/zQOG
X-Google-Smtp-Source: APXvYqy13gguR6NEUfCLLKpXnDy4AttZXqs4ykBs0SX9Cxiei5TfjAP35fuOn0fKJ5MLZcb+jT6s0DLzf4BvjOV0F9U=
X-Received: by 2002:ab0:2556:: with SMTP id l22mr9364887uan.46.1561050872751;
 Thu, 20 Jun 2019 10:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <1560755897-5002-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1560755897-5002-1-git-send-email-yannick.fertre@st.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 20 Jun 2019 18:12:16 +0100
Message-ID: <CACvgo50vSNCTTTKp9D_07tazOE9YkU-zKAsDywvWe6h0NgcEmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/stm: drv: fix suspend/resume
To:     =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick,

On Mon, 17 Jun 2019 at 08:18, Yannick Fertr=C3=A9 <yannick.fertre@st.com> w=
rote:

> @@ -155,15 +154,17 @@ static __maybe_unused int drv_resume(struct device =
*dev)
>         struct ltdc_device *ldev =3D ddev->dev_private;
>         int ret;
>
> +       if (WARN_ON(!ldev->suspend_state))
> +               return -ENOENT;
> +
>         pm_runtime_force_resume(dev);
>         ret =3D drm_atomic_helper_resume(ddev, ldev->suspend_state);
> -       if (ret) {
> +       if (ret)
Hmm the msm driver uses !ret here. Suspecting that you want the same,
although I haven't checked in detail.

HTH
-Emil
