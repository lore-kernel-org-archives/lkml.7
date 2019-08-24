Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E7AC41514
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7EE21726
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7QNvw9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfHXKxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 06:53:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45947 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfHXKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:53:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so10432376qki.12;
        Sat, 24 Aug 2019 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbxzA8gVsCSK3z+t0mDil0in4W6ri8b3PO8br9bfWts=;
        b=M7QNvw9jRmfvcOSyb8HQd6yZAix34IZXdI4XbQzYW3owMZbo9a/T2Ng1Qj9wJ2PEti
         3AxQXMAz009wgw9nzXSga/VvSi7rYe/2vkvL0DkR03hl7moxNFipctcLoeqlOQiYmToS
         6qmDQyTltS6HgbLmT916vnpxBlT4m8BVju6Mq1zxFEYefIhn+dL+ySm8a6mLuHtzTTIa
         6gCzrx0+WmzJlOsrq2Tti/H5BDyKY85gKW/0JevFRJLUiXXZCK8QDCTQsiwddk4XP7Bt
         JB2NePG+bqMftxT00mWG+RSE9bK/IvmFzrRlwW5uXjJ/PAfJqu3TDytWmb4cJs7vVCeG
         R4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbxzA8gVsCSK3z+t0mDil0in4W6ri8b3PO8br9bfWts=;
        b=sdoLEtDVSwWVASWerexwmWm8MHAAMQzAB9QKiErmV2MZV/NYBdlhJsqDO305+zivWt
         XhM0/WGSCO7TWVJLwXE+YzOd9c8PZuw+fUZ//xazi2zUQKhEgI03KzeAVb1nIZZrcCOT
         mVReffdjgHz5JcrFKK1UQ+qJrTMLuwuzPprs6ct9l3EkIUsEN4D1XqwbzlTIHe2QQ9Gi
         2zk6JDkTTXc/ES4DNMzy3CmQHgEmgP2cU9+REdgkKffA+2aYfqpEdX5cGFsN6pQY9wZh
         OAnG7UHshQwI3LXEykGj6caTD5irD4rxfOI4xZvdJfrSVeGu5udmTTewpCgSEWPZAdwY
         Jm4w==
X-Gm-Message-State: APjAAAWZmB0O7kE5+IyFRQgXAFnGsCnWg+S6J73T+BjV+M/CD5NYUB8X
        +BJtzu2QQVKTQMjo0pggQkHZHGiZD6uGVpLCJd4=
X-Google-Smtp-Source: APXvYqxkG4NMxhycjdYiSIFcFIz9H1LlGWXbJH1IPkZl7HlwlKbsxAsC0YE39DrKJayiIL7rFQNCSgF5GI8IfuMEraY=
X-Received: by 2002:a05:620a:16c3:: with SMTP id a3mr7827421qkn.315.1566644026718;
 Sat, 24 Aug 2019 03:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190823215255.7631-1-hdegoede@redhat.com>
In-Reply-To: <20190823215255.7631-1-hdegoede@redhat.com>
From:   Ian W MORRISON <ianwmorrison@gmail.com>
Date:   Sat, 24 Aug 2019 20:53:35 +1000
Message-ID: <CAFXWsS9q5-Ny_Lz4H51+UU0eRv5DJgRHy5XFi4_hxNCFTMb=dg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot
 option and blacklist
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 at 07:53, Hans de Goede <hdegoede@redhat.com> wrote:
>
> To avoid problems like this, this commit adds a new
> gpiolib_acpi_run_edge_events_on_boot kernel commandline option which
> can be "on", "off", or "auto" (default).
>
> In auto mode the default is on and a DMI based blacklist is used,
> the initial version of this blacklist contains the Minix Neo Z83-4
> fixing the HDMI being broken on this device.
>

Many thanks Hans. I've tested the patch including the command line
option with both v5.3-rc5 and linux-next on a Minix Neo Z83-4 and it
works fine.

Best regards,
Ian
