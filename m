Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC01C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E182021655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7Qen9Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfI0VLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:11:36 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44658 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0VLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:11:36 -0400
Received: by mail-ot1-f51.google.com with SMTP id 21so3444415otj.11;
        Fri, 27 Sep 2019 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdrnlXF7ll9nhKDDCSUT7rto1+XDC1kH4OvzeUF8jTs=;
        b=t7Qen9PedVNhaDwldOy8u5nlalsssPS2bZgQgmMmjIn4oRLdvSvlaNommHqsQWvFqj
         vgAYuLnXs36Fe2i10PsqAk7ePg5RtaCozxKDTzqJlpM6GfQAQ4x/cQF5wTWJyIn4aZeU
         RrS0f6mQo5U8ibRMn1Di+OPC/BMxc3oucSP0ipdP96mdMWDf499aIorjpN06/x/GWe6v
         CcdN194au1sIDNRport+QTQp+RZDJBvIK2JGLbh4LpI39VsBch0u2hW1UC6tkJyex3Wy
         AbAJAjDJ1H3XwQIy1QKpOGh6eNksXt2xmfBIFxkYWIMp5Xtc/X3xEssxuwlZXNKT10Y1
         onXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdrnlXF7ll9nhKDDCSUT7rto1+XDC1kH4OvzeUF8jTs=;
        b=s5sAofFHUK47uALFTBVrzMDGTeV6qFFsluGEOqVSUa/cBrNQ9kscwrdOihHXiU/iw/
         bPrRTV3Mg5b/sPmwCreIcnF/Vgyn2Ex7zubjCFgb2Q7ldO7Adk1osHqaetusIZn2Y997
         6ffNbMYJ/P4giZE1tIKyX2KF+BhLgnhfV5H065Fztn8cr8VglAdqQPVsDphvcJyocNGL
         hCQ/6C06Ua69khjfBemsjhUl1fs22GZknndSTVDc0xISysMEk8WsuKQ7n6h92oinLQrH
         3R1IHYpDAVgJrh+1d84DzDex2txSe3s5yFFUoSWlQp8KzZJkFyENlW6fqby5jjDG8Aa+
         ZijQ==
X-Gm-Message-State: APjAAAW4IU275uCnbfXCKPZSHkDK5kowDlVS+Z/Ad1xFBwvpaUm9rBvE
        hOzDypKQjxnmpGzb+Sm4rqFZ+e2k07OF4xQQJ3k=
X-Google-Smtp-Source: APXvYqyl/IlPX3yrWAEVaBCeSNI1h/ZVb+mels+W83OPsNfbzYGmCwGfdE+aXOmQzGGkhPscUlrm3P6M0oFPKbxL+2c=
X-Received: by 2002:a9d:7a48:: with SMTP id z8mr4928395otm.274.1569618693794;
 Fri, 27 Sep 2019 14:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190927184722.31989-1-bparrot@ti.com> <20190927184722.31989-9-bparrot@ti.com>
In-Reply-To: <20190927184722.31989-9-bparrot@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 27 Sep 2019 22:11:07 +0100
Message-ID: <CA+V-a8v0nqLaYUTMVYpacBEKNaxaZFyivVwdaRZ4M-HEBYJ4zg@mail.gmail.com>
Subject: Re: [Patch v4 8/8] media: i2c: ov2659: Switch to SPDX Licensing
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 7:46 PM Benoit Parrot <bparrot@ti.com> wrote:
>
> Switch to SPDX licensing and drop the redundant GPL text.
>
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  drivers/media/i2c/ov2659.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad

> diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
> index 720310e0725d..e6da23d3a555 100644
> --- a/drivers/media/i2c/ov2659.c
> +++ b/drivers/media/i2c/ov2659.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Omnivision OV2659 CMOS Image Sensor driver
>   *
> @@ -5,19 +6,6 @@
>   *
>   * Benoit Parrot <bparrot@ti.com>
>   * Lad, Prabhakar <prabhakar.csengg@gmail.com>
> - *
> - * This program is free software; you may redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; version 2 of the License.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
>   */
>
>  #include <linux/clk.h>
> --
> 2.17.1
>
