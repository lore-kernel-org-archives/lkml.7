Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFEC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2394D21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm7Eryix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKLU3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:29:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40062 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:29:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id j26so6868962lfh.7;
        Tue, 12 Nov 2019 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIggQvsLjw5/GKJs2QizxH1e6sO5J4u5NXBkTQlNHx4=;
        b=Pm7EryixgzSrwpEIlecvGLtcvGoL6KyiCIV4cvPb/ScMz+vfz+wY8dfG9mRNImLsGW
         Xi37PUrOa/ApG44a8SFr9XPQYettDQOw69RRdsBp5sOdjY5qKwYQg89T3iEwULPVVzl3
         AHMbSPok76A2afzdhxxmZC+4kJiVN6549bvzvojrBsz+DcYTwqcFULGMno41vxmCBoJz
         c+m+yKjQxYt5NCDRbrxIGNiDpReG1EH73Q3z7RO8sSeAvvcByGenB+AGQvTNyQViNSLN
         CUieQHax4hhjAPnncmyUCSnZ9UguOMRiGCT3/T65L24PWAVg6ygRNkWfrqaMn9hGKmAA
         bDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIggQvsLjw5/GKJs2QizxH1e6sO5J4u5NXBkTQlNHx4=;
        b=qIwrK4LFaUa8rp5NShCiYJvXjJbhQxkF+AJdKuTbYFPwuOvKhCcWvbUFQ8+t0n07lA
         TAyV/oxqeaYvg9jhYUhUqfM3iri9pV/HkI5BCxEHEqqsoncQo24WMrrMDu8rnXTYQaPy
         9VJb+fXeG5qDcdCUe7L8Msi7qsy3RQOk+S7NLh/jpMgq26/XY5t0pc+voqgZcT+/VPge
         iBwfqGm1QvrkkIKX/4x7x5O99o1e2e8ckO20rt8S2fCJumgg7hcUhwSbxC2GYHz1bcET
         E+midtBpww7co/qJef/oCCoW/I1nNN75HHfITfEFDzcuYeuRWQyEqo4KCMTxstNmqAmH
         Z4Dw==
X-Gm-Message-State: APjAAAUJT7oUa5FnBLeVrs8LTiLgSqiADxwHM7p6AcUYTFFQh2I7eLL8
        BL4oVa5nXTRtzIOE7VO2RKuXkIqkKkDYnD+PUOE=
X-Google-Smtp-Source: APXvYqzNLkwu0NxW/0pt4F6VhlKtlGUv/Q0HSQly3OQKZMNA6b8Jik4th1y4GDw72oNgE62F3BJ3p7HMbyUYq0GtrFM=
X-Received: by 2002:ac2:484a:: with SMTP id 10mr3190310lfy.80.1573590562691;
 Tue, 12 Nov 2019 12:29:22 -0800 (PST)
MIME-Version: 1.0
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com> <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Nov 2019 17:29:12 -0300
Message-ID: <CAOMZO5Dwt6yJ45gE91opUf3nNx24AG00Lk1KPLJ_7Z4F0os7zA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: arm64: fsl: Add Variscite i.MX6UL compatibles
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver

On Tue, Nov 12, 2019 at 4:22 PM Oliver Graute <oliver.graute@gmail.com> wrote:
>
> Add the compatibles for Variscite i.MX6UL compatibles

You missed your Signed-off-by tag.

Also, you should remove arm64 from the Subject line as this is a 32-bit SoC :-)
