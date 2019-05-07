Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2067C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E7820C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjALlnw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfEGKyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44813 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfEGKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id c6so8460734lji.11;
        Tue, 07 May 2019 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GCAhg11SRp6Hew9zFemJx8a1BnYPfIc90dC9LSkimJg=;
        b=TjALlnw4nsc9u8UJAhsZ1uBY5MpOfYYFHDH9mn1SZIL22WxRUXNdnNDBKfloMxs27a
         zkktcwu/Sx6rAtgYRy+jjbrFEiebWtpPakYRhHYSNwUjqg7hkjBxrywE0qdj+bs5mwqT
         mAGORk3CLwMloH9BP4lzzaQuXR9JlzO+Kj8q69ccRd2MiUz3z35BBRqAAtUo4zi4smZI
         MabzDOCr9zz3P4SlWcmyucv0ihFJpbiG3KUU5uh85AnttvSQVcs4Nu1Ynf9ze8oNrxGs
         bmUy+Q8EEcR0F1vtMfz5/KTQoCKVgobaHPF78FJw1bkxm28K/RTEI8P+B2dIY2YPQEXE
         KveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GCAhg11SRp6Hew9zFemJx8a1BnYPfIc90dC9LSkimJg=;
        b=UjTfRNP0bSxwd16ykzvWUM2gDEVu7Bd/P9qKzPynxqq3UPWFMZpIJjcN3Iai58yiej
         QFgUFqSW6jWBuYx3MqghrLHhwJkd4p9oMcW22gyyAtl1MpyIbGCR3IjZOEQLdVmXU/xL
         5TEYC831cpjyZKTa655CRMvCAQ0DhYwTmoNs7KzKWtBPeGD8l4/Ls+ZGcOAgFblUiUB4
         jG8qT9SkRGd7O8RSafKB6YstykzbXncj2c0CKEDhf39v+QIjK4Zgl/h/tjaOGa5WGaoi
         HEG8grlTQO6V63YdmBe/bh8F9PdFGvyxukZivCvetXLPEGtjWrQWEhgff/CB0l3XveHP
         4feA==
X-Gm-Message-State: APjAAAWZq9PSDd++ImkaYk8IE83xSq3b/76GXIFFpiF7JO5kl2puCg1B
        br/0nnVrKr6/ay7eucC/g40PCvYP2+jz5U+0/pM=
X-Google-Smtp-Source: APXvYqzra4CeE9doUIEh8YRPLjXBNgdVF2kc5zUdswNRrUeYL/COm0wsOIKOaERd5W+viBb0m/EIk30lew/cjlBl89s=
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr16824476ljj.192.1557226462187;
 Tue, 07 May 2019 03:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557215047.git.agx@sigxcpu.org> <5817853945e1c707f641ae22458a0f27aa25949e.1557215047.git.agx@sigxcpu.org>
In-Reply-To: <5817853945e1c707f641ae22458a0f27aa25949e.1557215047.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 May 2019 07:54:27 -0300
Message-ID: <CAOMZO5Dn7yHC-NEBd0egHtXu8R4Zg=GNrvXR-RoHH6t9pqq_rA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: phy: Add documentation for mixel dphy
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 4:47 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Add support for the MIXEL DPHY IP as found on NXP's i.MX8MQ SoCs.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
