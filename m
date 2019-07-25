Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0579C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E4F2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfGYOpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:45:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46955 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfGYOpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:45:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so49257247qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s58lJV1QkfWsNI9KTGkJmeyYTCi2hAqk7cXt5LhcdQ4=;
        b=bqrp+/48qZUpw1QhzRzb8vhnnMjgcDfABQcZ5cEdd41J53nmsWCkj7wgFERDhynegk
         th0Q7boA3XhXqQ88FpARYDA+d3GhOMB5qsTaksUegVHfBb0BV2+ljkKMKmK48owdw8Ye
         Ao/ppidJVaU4fqrAI0xR7CAROIx9Ojd0zoFXW7huMV+n23qlH+70BLN/rVoRdt807FkL
         +FtUD5IHVvwTLNdGwlTmbdzNeJC6StwKiEdix16r9eY/zx/uGSm3XhWtocf0Bhv2XuP1
         Qcr0DiKHMmC7T7ngvb0dDhSGoj7+n1WLyKtL6fHIKgZDSC5a+ntOXP11aJBpN5Ol5G5O
         Waww==
X-Gm-Message-State: APjAAAUBa+IH8l5uVFb6kAR49gIQTPpIyEeW/58BAh1bAgM0EZebyq4n
        QCXONVbZBkj0lXgrgbFin+fZ+T8+lgShA8H7Xow=
X-Google-Smtp-Source: APXvYqzopbEH7l8AXdfxl91N/j9wg/J7FxiwQcwJHq3kHZYrLTO2Q9mjcvkt9bV3lwwWwLcc60dj/ru9WPRReNC2VqE=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr63523651qve.45.1564065921146;
 Thu, 25 Jul 2019 07:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190725131257.6142-1-brgl@bgdev.pl> <20190725131257.6142-2-brgl@bgdev.pl>
In-Reply-To: <20190725131257.6142-2-brgl@bgdev.pl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Jul 2019 16:45:05 +0200
Message-ID: <CAK8P3a32tvPkYEiZMWxg+7weoAmZFPF31t2jw132f963ZeB_gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] staging: media/davinci_vpfe: fix pinmux setup compilation
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This fixes the following build error in davinci_vpfe.
>
> /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c: In function 'vpfe_isif_init':
> /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:2031:2: error: implicit declaration of function 'davinci_cfg_reg'; did you mean 'omap_cfg_reg'? [-Werror=implicit-function-declaration]
>   davinci_cfg_reg(DM365_VIN_CAM_WEN);
>   ^~~~~~~~~~~~~~~
>   omap_cfg_reg
> /git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:2031:18: error: 'DM365_VIN_CAM_WEN' undeclared (first use in this function); did you mean 'DM365_ISIF_MAX_CLDC'?
>   davinci_cfg_reg(DM365_VIN_CAM_WEN);
>                   ^~~~~~~~~~~~~~~~~
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/staging/media/davinci_vpfe/Makefile     | 5 -----
>  drivers/staging/media/davinci_vpfe/dm365_isif.c | 8 +++-----
>  drivers/staging/media/davinci_vpfe/dm365_isif.h | 2 --
>  drivers/staging/media/davinci_vpfe/vpfe.h       | 2 ++
>  4 files changed, 5 insertions(+), 12 deletions(-)

The driver has just been removed, so you can drop the patch now.

        Arnd
