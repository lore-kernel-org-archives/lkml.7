Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C1C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E031220717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlyiU5dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLBM5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:57:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42432 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLBM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:57:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id e28so15804185ljo.9;
        Mon, 02 Dec 2019 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qlt+/dRlgH3WSZzFFBm5SD3CiWvxcdEsgMu4Ka1X8YE=;
        b=UlyiU5dpvNruuaxcXO7dvcG62On/kdUK4obQpYfELq3M040cPWbk92RXty5c7XyxHQ
         JlwoKbkid8aIAN5Tj/Q45F++QZmZ8BDp2fKC3o0KiEOLkPMVj/sP/GA1ijguRSSyroJY
         j071GRkprPF86nKLRiFrKQr1QfIg+WOcCTwil4xkDqnRcrbJgBj574XnFo9nVQx06eqV
         kcfwKnDmvmw0gf1VF5eHPJ4eSqHqCr0YzpPxG11lmnzUjX/43McgbFIBGFt2hl0/+GAb
         ebjqRxaO1ouiLadvFFlXedasMYGwWmhPw3n5mRho5odgoUIv9cuc0UPXktHrNHYG+Tma
         teyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qlt+/dRlgH3WSZzFFBm5SD3CiWvxcdEsgMu4Ka1X8YE=;
        b=t7NTKna6zMWUSxr1ze5Oe+GT5j3TyhA0q/XxXwiSe190O+uTDgxbEGR9rtzqQksJWF
         QKG+xlcPd6wXQL1C5q2i3GsoZWUQSZVrYsqyaCBTkCSt2pJgTAeGmA+3JsA8LjMHc4rX
         vx2jT2m7ZAnF2r/xN2PB4+LdYB0pwzEadNmuolgp0vM0tYWWK1DUQ2q8Hd2WD0Q998PH
         ngYZdQmAF9PC9vSvKyV/om+SzI5GdtAhPipsqnI6qBI7SAS/BXap6Ci2XLaAl16I0k7m
         RMQjQZPQjtfyGE6esEnP+dzQH+8cH+LQpDHgDtVlU3wrCiCfBIeHGVoTORcCm9i3f6z/
         pTgQ==
X-Gm-Message-State: APjAAAVziH83jLS/9RzGpKhMc/7EIwfFo9Ii7gH5sZEAH7g3lt7+mPhy
        yEVgd6j5aqPn06YdSxAJJFliHQv/T5ykbIvtgiQ=
X-Google-Smtp-Source: APXvYqxQdPHL3wwjh1XiiAR4BKUnI9ER2eZEatvhL25goi1fFQraJN0onktSvPLymKxIx9kQLcHq96wvcClwhZw058k=
X-Received: by 2002:a2e:241a:: with SMTP id k26mr2647022ljk.26.1575291417981;
 Mon, 02 Dec 2019 04:56:57 -0800 (PST)
MIME-Version: 1.0
References: <45ef9ee8c6265743a9c30d8e4d9dcbac1ee3aabe.1575286886.git.shengjiu.wang@nxp.com>
In-Reply-To: <45ef9ee8c6265743a9c30d8e4d9dcbac1ee3aabe.1575286886.git.shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Dec 2019 09:57:12 -0300
Message-ID: <CAOMZO5AXnw7QDdfKkZ+FBwuWWvr+t0rRsHQ4muW-T00he2f73Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: fsl_asrc: add compatible string
 for imx8qm & imx8qxp
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 8:56 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> -  - compatible         : Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> +  - compatible         : Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> +                         "fsl,imx8qm-asrc", "fsl,imx8qxp-asrc"

You missed the word "or" as in the original binding.
