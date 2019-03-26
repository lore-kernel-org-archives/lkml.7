Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D41C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ED32084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfCZHzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:55:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35668 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:55:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so13497246qte.2;
        Tue, 26 Mar 2019 00:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipY8HI+p5IEzr9bTLpaAZTUX2nDc1oaysVydJZoboj8=;
        b=iAWnmf2UGk9rkuWWcYWHuVfev2aR6ywLv7wkEhnnQTQT4hUmVvF9duL37vH7Lpdl6V
         28j7aoN8YjJtx5cPHv415KIPpJ2Y8vFQQrR+uLtcSph+rwFk3LuGXEL4QxybFFakNa6v
         HAWms38FbgXKRVyCwenKHXZT1O5jA13ozDAJHcq1ZFK1r2WgcoYTsd839URWeI8suGSt
         uIAB62ohxYfAgfcl8OiC5OIoCb+Yvm/GZA6LzB+8obiPoZ3ZuHsOa55jm8Nc3MUxgPjN
         vElh7/QB8Ijo13Rg+Wiywr3EU3gbq4ClqUU8YkWA7hg11DZwk81SQtM857p1yWYROhkJ
         l81A==
X-Gm-Message-State: APjAAAXpTh6NcHO2APpDwPxLaS1yyrTTbvBnYmbXbst3D1XwnB1/kUmQ
        ykTgWtCKInqUNl21aIVJxQpG17GoD5d6bMxtbgc=
X-Google-Smtp-Source: APXvYqzXFXU3bEAcMV4JavinQvu2zZhs4Ycb3sWtw7DvuHRS7Xg+TIsB97rckkIprXd9CroR8/t7GpjxL3u3lEA3DFE=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr23542773qvj.180.1553586930898;
 Tue, 26 Mar 2019 00:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-3-arnd@arndb.de>
 <20190326010911.GB29420@kroah.com>
In-Reply-To: <20190326010911.GB29420@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 08:55:14 +0100
Message-ID: <CAK8P3a22Mp9yR49CEe2bq240SuSpbvy1XBDa2sSvWYMt=AZM3Q@mail.gmail.com>
Subject: Re: [BACKPORT 4.4.y 02/25] ALSA: compress: add support for 32bit
 calls in a 64bit kernel
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 22, 2019 at 04:43:53PM +0100, Arnd Bergmann wrote:
> > From: Ravindra Lokhande <rlokhande@nvidia.com>
> >
> > Compress offload does not support ioctl calls from a 32bit userspace
> > in a 64 bit kernel. This patch adds support for ioctls from a 32bit
> > userspace in a 64bit kernel
> >
> > Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > (cherry picked from commit c10368897e104c008c610915a218f0fe5fa4ec96)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  sound/core/compress_offload.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
>
> How is this not a "new feature"?  What bug does this fix?  Has this ever
> worked in the past?

It has never worked in the past, but I consider it a bug for the compat layer
to behave differently from native code. In this case, any 32-bit application
using the SNDRV_COMPRESS_* ioctls will just fail to do anything on
a 64-bit kernel at all without the trivial fix that should have been there when
the driver was originally merged.

     Arnd
