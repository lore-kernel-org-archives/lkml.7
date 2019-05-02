Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532CBC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176F02063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556833309;
	bh=g3HRs+xm2OgzM5MYqIh3qU8/bD2JCzjgYhaXdIJGy4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S9j9yo3aCduBOOSNKvUEYUcecvUBlhu5Slnj+yy/MYWZ3Wa2UTxAOjLRhJgYbyWLS
	 5yUtqlf6GKCL4PXC9gVfotU4EnQOgEYn4YFJrbT29pOOI0xihMtCrUFfnRjMDItS3L
	 nUu8b70BHph58JAez3f5CeHEM5eWhjFkq+wVjk1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEBVlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBVlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:41:47 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1ECA2085A;
        Thu,  2 May 2019 21:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556833306;
        bh=g3HRs+xm2OgzM5MYqIh3qU8/bD2JCzjgYhaXdIJGy4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wR+FyPTjFpW5bakoGpctUlsdn/Qx4DI6FeJ/BkOoDW/TJfRHohSWtI8UrkfatIn1P
         pk5m54szAMi8wvaimcU7NjkoHJL++8S8Lot1SAPvWNfbmg9sMJXgjxaaOJcwoEDUxH
         8tL+XhFaOYrhu1Z7/talzrwu7JjMfwjD74Cx3R8A=
Received: by mail-qt1-f182.google.com with SMTP id d13so4525159qth.5;
        Thu, 02 May 2019 14:41:46 -0700 (PDT)
X-Gm-Message-State: APjAAAW6feFo4qOPGDEn9i+ed62YbM5TIOkA9wJqEJBh9AYnQFm62qgb
        0lfYLT+Sfpsl9uIuRBz0AAi3iXhq5Ojlvcdlvw==
X-Google-Smtp-Source: APXvYqwmKfEV36/v/C4TthiZUXAC8Za91tnWBCnMJHN6j1k3sbszWc+PiGDNXHdM0kQ4cxgAFZyip3t93MAslu3XVKc=
X-Received: by 2002:ac8:610f:: with SMTP id a15mr5162151qtm.257.1556833306023;
 Thu, 02 May 2019 14:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190502124535.6292-1-geert+renesas@glider.be>
In-Reply-To: <20190502124535.6292-1-geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 May 2019 16:41:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKrjmE9_huT-ViKhCo1mFbHka6reVKzo9Z1qJL0u3x2-g@mail.gmail.com>
Message-ID: <CAL_JsqKrjmE9_huT-ViKhCo1mFbHka6reVKzo9Z1qJL0u3x2-g@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: Remove error printing on OOM
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 7:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There is no need to print a backtrace or other error message if
> kzalloc(), kmemdup(), or devm_kzalloc() fails, as the memory allocation
> core already takes care of that.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/unittest.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Applied both patches.

Rob
