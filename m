Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69522133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qur21Nd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfDJO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:26:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbfDJO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:26:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so2310319ljq.7;
        Wed, 10 Apr 2019 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y2p16iLH2m+HtsDYjG0iV8Z/Xh7rWVUwWRMS6QiGYg=;
        b=qur21Nd3eXlCOCpoEFR24g1NyRtYtiWtwK+5j0rn/tP6R781DwDcKg4l9B1YnInwx6
         1R37Ajvmyh8Cq+ejttt6SXGT6fE7b4Hs08s8GED39xpyH5XskkDVSHAntZV8E3WlM5V+
         nThkoK8M2cbOWDifJnDn1bGmo2Q4EH7bclNsCujLMGK/SCONS+Misg5YRAej1Ah0QnPw
         6IhyH3NEsZYS2hD67M+O6QB8QYS2+BOqozSKOrWj+83WkPyise6Ekln+dx72ncQibzbZ
         Av01zUUGHpzq6mtUcBXoJuKdsWavf148j5N9hvgk4cle+EgJlQBak7aWzROJq5MpndzB
         zL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y2p16iLH2m+HtsDYjG0iV8Z/Xh7rWVUwWRMS6QiGYg=;
        b=KLIiuHOAKDVx7TIO/Hc/0qcyd/aMc6KqIxNEbgOnWtPFOHgo2qHrjQiDCqrzz0xWB8
         1uYCNGt59uk2YyIqJmiWCYJXqsW77jwbkq27I6aWLJBnIEP2ZWUM10HA4QRZa1b3fRou
         Du6kXO5YiN8T6gzVBfm+4e1Ip1YeQy6dUGr6+TjKFz0cuJB0cOvMltEMxIsRqH+K/OfF
         8EBH6vnlK7ZrN+sUyNCpmtGtyyLMAItO2NtBzOsia6KLPuir+8lY69zqH9mzkFoFd4ZK
         gBblhCJNvKp2i3xnYDj/zu3gozfqz6/dk2iR0awRxbjtrI9kW35Tz5jo8q8SS7oNaxIY
         oFsQ==
X-Gm-Message-State: APjAAAVb1nOVqX8cOEcCZFYD0o5Gw7LlNlWMZk7REUqlx1/ZIflNaqf1
        +Z9fdA8FIWXCDrPsjituiB0BKhuBiaJeUN1fohE=
X-Google-Smtp-Source: APXvYqziHI7r075gt/OuJfM9PFekJuDcOB9t2Jlm/nkuFEzgM9PwxHF6IQTGleEkMqqAnzytrssxspZXshP3JVGaKcY=
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr3223389ljj.63.1554906412051;
 Wed, 10 Apr 2019 07:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com> <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 10 Apr 2019 11:26:46 -0300
Message-ID: <CAOMZO5AM0OOTc0SKFMDGWnDpAWrM0-1cyeQjYb-7ZzX558hK=g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ASoC: imx-audmix: fix object reference leaks in probe
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:06 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Please provide a Fixes tag.
