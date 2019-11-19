Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC95C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9664222B6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArmFHtCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfKSRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:31:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44750 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfKSRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:31:20 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so13093001ioo.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKXb08mLw7/gYPbvXLPbBkWtw4UGYUMyffgZIZI+HT0=;
        b=ArmFHtCFR79K59IBtCbRQ9YtpK4dcS1SQ2DILybT8VpuW5oSI+0/OjIkU1lxFXj90/
         g67wwarVmSXF/YEiLI36TyOFoIjfqE27lCCfVjunx2J7PwQuhJWt3gDvFtjUCpYKxgh9
         oVBJkz7zllCUtHe+zYEkA35bMlpX/+bt76IY68FDbH/jA6+he9MBGIXzPgjDy2onhxbt
         MmWvCZG+IUqmlnJ/v5MdvtENnsgyvXm6+Q+U4kXbHucQ25VneEvlZXYpMb/i6Pwua1OF
         iBgGyPJ+pmIvLIBTRt8nvMFDyfyP6H8g7fFrfjUeeOMyL36jz0L55jJ7g10/Y6oDX1NK
         nTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKXb08mLw7/gYPbvXLPbBkWtw4UGYUMyffgZIZI+HT0=;
        b=e/xRls++CWG83MJDMU/A04NY2Zo0VqT1WxM4GdZ7XsOxwS6rJ9kpg9zZeW2A09NTv0
         YYvK552vKJu/nbNC7oRgHmmwWPOvnDHGFvgrJ3zbB3cIYhevPZdf0Fs1e0xlgoaNw6lu
         IXPmVPLmFshzJ6sJ7aaYwW0Fhr3VIe3WUq420jsYoq307Ho23vQuE3fzLOs1MbqVNoq7
         lvxL+c3T3z6CA43o8LPHIRtJd2V45HqL7BkiMYz1XYEr68ZIXPGad1KC/l15jMIfVDUB
         n6b7967Z10TAUVIeIN068Nn93iG5avHlT6NOIOOvZalh6qwA39QhUqulZ7rfR6YmbZSB
         vwMw==
X-Gm-Message-State: APjAAAUX5T8hJz1bd0JjJ+HlBO+ZLmr7VKGZ1khn0jOBdRKIBNIrdHG4
        hmRCiDU0/afscqvwP0l7i5wRvdcma1p+PxjGyJ1vlw==
X-Google-Smtp-Source: APXvYqxuSx88S96OihGrrKgtsaBcR+slNCHyQEu+C35JJbv7CvdH9n0vVrz2XW8a5TUK1UWZLn2OBnY3pHUXCiSjiq8=
X-Received: by 2002:a6b:14ca:: with SMTP id 193mr19398156iou.140.1574184677951;
 Tue, 19 Nov 2019 09:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20191119141645.19777-1-t-kristo@ti.com>
In-Reply-To: <20191119141645.19777-1-t-kristo@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 19 Nov 2019 10:31:06 -0700
Message-ID: <CANLsYkwyLMHzKkm-6X+OgQ+khRYJshMJsxdst7+c7n+hX4nLpQ@mail.gmail.com>
Subject: Re: [PATCHv2 00/15] Remoteproc: updates for OMAP remoteproc support
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 at 07:17, Tero Kristo <t-kristo@ti.com> wrote:
>
> Hi,
>
> This is v2 of the series [1], addressing comments from Bjorn and Rob.
> Bindings patch is funnily v2.5, as I posted v2 already and wanted to
> keep this somehow in sync. Individual patches contain comments about the
> changes, or Reviewed-by tags provided if there are no changes.
>
> I also dropped the conversion patch to SPDX licensing until I can
> confirm the license we want to use. Lets just keep the existing in place
> until that.
>
> This series still depends on the reset + clock patches posted earlier,
> but both of those dependencies are in linux-next now.

I tried to apply your set to today's linux-next (next-20191119) but it
fails at patch 13.

Mathieu

>
> -Tero
>
> [1] https://patchwork.kernel.org/cover/11215421/
>
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
