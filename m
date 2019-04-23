Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C92C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE747204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnNuoWAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfDWLVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:21:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39696 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWLVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:21:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id d12so11445176lfk.6;
        Tue, 23 Apr 2019 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TomhzLYdxJAmgBKbyFa13n2y6TbQP1ekz4AvvmoMxrw=;
        b=gnNuoWAPXfjMQqMNFj7h1ZdUiLekrnL7iXNE6cSHXsg3gtTWV3HPFxJoteeNUz4y1X
         b+xSnQ02Ivtg3R/osTpasjJzs/EtFe0OBX08V8rYYbx1JInukLjUfPXIQVQNltV4v7VU
         cjmo29gH+vFboWc9m3dpdZZW3GYMaqRJhwm3/38TbE/8cm8IN5jcKNwVEVaIiSpdkGv+
         WQejMOhPDROHjY3+Q5zz8jyU1P26LTeNz5Z//Kw1m7/97+bPgD7YJmAk5JW5Vh1G5sm4
         y5wx0TUEkbHHg9WyboISrJGXeF/J9w/dkrAYL8IHcIthTGhJS3WW1SJXLiYSkoGPTL91
         Te8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TomhzLYdxJAmgBKbyFa13n2y6TbQP1ekz4AvvmoMxrw=;
        b=szsOmZTByzN9RgVMG4Y1ZWboUlu8KQOMJ529pBBg9ILWwQlpq52JbkqT6UhjsRKV72
         nIgREwwuUXW8tGteCCXaAHXOJQgxSEW4s/s9nHtMc/gW99RS7W6eB+LYtT+1aaZtd4Ky
         KeRK9g4gI1MW+SZkG8fKvolOTYj/xaNdXz67n/BM3KazVDE/IMX+mLEShXyJYpUNWL+O
         Jx/XpV+c2x2/dUSJZSdnXK/oT36Lud9ERLNxgctouk3W+GBWvlmLkVLe44wXyyQ8OGbH
         h0sxg46NwMXdR/9Y6OsQuLR++PMONdQVJCdqByAV6M3ZslwxBE6aNcHYGEtBE8f7InLh
         VFdA==
X-Gm-Message-State: APjAAAXevJEwFzphbFROE6FEOBvJh7wQxxvJTwfp436Q2EuWHegXwodk
        RYeLKKKdJh7Kxko5S0MsDN4ZWob408J+/jiwumE=
X-Google-Smtp-Source: APXvYqw/1L5XXY8TY5qnDHgC/WUxcxxzsR7kaFP0RiqAh9tKMIGKRSrLBaYCpx/H9+vyN1A5akzNH63RzelBn4rA+rM=
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr13484586lfn.145.1556018496845;
 Tue, 23 Apr 2019 04:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190423104649.24483-1-xiaoning.wang@nxp.com> <20190423104649.24483-3-xiaoning.wang@nxp.com>
In-Reply-To: <20190423104649.24483-3-xiaoning.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Apr 2019 08:21:34 -0300
Message-ID: <CAOMZO5CQ04UiYPoVjT6L3MuK6cCLu01Ba=-uui_Lf7t58n1tqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: lpspi: add multi SS support in PIO mode
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:48 AM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Add "fsl,spi-num-chipselects" check to support multi SS function in PIO
> mode.

This custom property does not seem to be needed as the number of chip
selects can be parsed from the devicetree file directly.

We got rid of "fsl,spi-num-chipselects" property in the spi-imx driver
in this commit:

commit b36581df7e788b674a4efbb8da7fe4a00c207e8b
Author: Alexander Shiyan <shc_work@mail.ru>
Date:   Wed Jun 8 20:02:06 2016 +0300

    spi: imx: Using existing properties for chipselects

    Patch reuse existing "chip_select" and "cs_gpio(s)" fields from SPI core.

    Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
    Signed-off-by: Mark Brown <broonie@kernel.org>

and we should try to also avoid such property in spi-fsl-lpspi as well.
