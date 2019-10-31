Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD4CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDC32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sILgo0Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfJaRJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:09:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33004 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfJaRJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:09:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id k1so4608585vsm.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbJu3UVGxb/D3O3Jaajy2yYceop1LdG6jIZpC2UGdME=;
        b=sILgo0ExuXrqJv9wUbE2Tumq0ELe9CBQDKkU77dnmj/RuVa26/zmecu0GpbeZGTHBM
         ePVf1uFkrSYmYYbtLs705cqb8LfV8HUlHunhiFQbAbOik3oQEtW7EJPpasqgTvjQ2TM0
         LIrREjmrFrRvjpBgBmRubuP6d0oRUxDI8Hc32Y4qIlmCaBj2B/JSC+PHwtXGcKgLiWus
         DEKo5bKI89SVAivdVDnQ+wCLFKmAm9oWYDSxKRXcB3/y3uZeqC/7CvcgrGjxfvkSWxoG
         TG6wKMt7wZHp7DAHNEHqrk4ygoaC3HxA8z/wUcmHdZrBvMtS821UR9VsV2r3le3tgedY
         vrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbJu3UVGxb/D3O3Jaajy2yYceop1LdG6jIZpC2UGdME=;
        b=h6tnDywcAEsw02RsIB+L9TO3xAisu/tWaBxwy+bz2T3UeJWiCVbTJXhU8obC59aU+f
         XO0YT8fk4ctctlKmY3f+9pQ2gVzFGTQ559Kw6dtxnuARkTVARtKYk9cQ665fIrL3CaHR
         9Gs95ouakhgbNWugL14JgJ7CQnpH/25XnEXz5o8lJ+BrbP0Bc5L458maTy/JpLrhE5QY
         XEwZ9KUQBAxnAA500aWdy+PTzOZVWyIwcnRtz3doIk5ii//jMk/hDoDpAqz+Vo5L973/
         ohOmplWan4TYSFdirsnnXejt518dj0aQDBuRgTvHOTQ4qPOHKHiz/cYS8sYL/bwIOtj/
         JKpA==
X-Gm-Message-State: APjAAAV7su0o3dvl87mtzDCANg+xL9mE9aqhNn0hOCWn7pE/iSy9Z2AB
        PyQyJo73Mk6VAulLBJEgmpkzsBa8pt/t5h4HbCM=
X-Google-Smtp-Source: APXvYqyLkkWgJ7ICTVfMGBOcq4S2OAn5nYpk6VJZW0O94lgZM/BCKp35+LK16Ms8/t5Z7RoL2Vj7T2VyJxX2Oc575EY=
X-Received: by 2002:a67:77d4:: with SMTP id s203mr3435400vsc.118.1572541771757;
 Thu, 31 Oct 2019 10:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191031142633.12460-1-adrian.ratiu@collabora.com>
In-Reply-To: <20191031142633.12460-1-adrian.ratiu@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 31 Oct 2019 17:07:36 +0000
Message-ID: <CACvgo50NmofJrCvADOTxJqJqKEWDsy8qD-1B6R356vFMcmdbWA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Genericize DW MIPI DSI bridge and add i.MX 6 driver
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, 31 Oct 2019 at 14:26, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> Having a generic Synopsis DesignWare MIPI-DSI host controller bridge
> driver is a very good idea, however the current implementation has
> hardcoded quite a lot of the register layouts used by the two supported
> SoC vendors, STM and Rockchip, which use IP cores v1.30 and v1.31.
>
> This makes it hard to support other SoC vendors like the FSL/NXP i.MX 6
> which use older v1.01 cores or future versions because, based on history,
> layout changes should also be expected in new DSI versions / SoCs.
>
> This patch series converts the bridge and platform drivers to access
> registers via generic regmap APIs and allows each platform driver to
> configure its register layout via struct reg_fields, then adds support
> for the host controller found on i.MX 6.
>
Have you considered keeping the difference internal to the dw-mipi-dsi driver?
Say having the iMX6 module "request" the v1.01 regmap from the bridge
driver, while rockchip/others doing the equivalent.

>  .../bindings/display/imx/mipi-dsi.txt         |  56 ++
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 518 +++++++++---------
>  drivers/gpu/drm/imx/Kconfig                   |   7 +
>  drivers/gpu/drm/imx/Makefile                  |   1 +
>  drivers/gpu/drm/imx/dw_mipi_dsi-imx.c         | 502 +++++++++++++++++
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 154 +++++-
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         | 160 +++++-
>  include/drm/bridge/dw_mipi_dsi.h              |  60 +-
>  8 files changed, 1185 insertions(+), 273 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/mipi-dsi.txt
>  create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx.c
>

This should make the delta a lot smaller, avoiding the unnecessary
copy of register fields and regmap.
Plus plugging future users will be dead trivial.

-Emil
