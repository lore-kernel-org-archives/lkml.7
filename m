Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D332086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cOXL9rj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFZVFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:05:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34543 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:05:16 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so5039264iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRBmhGMcbQ4hALpmq1oAoDfVUyAe/BHGvMizr8MXf+c=;
        b=cOXL9rj7l3pbqbCoFjpGe9MIbEROS5HHtDQRmVmQEPdEXzTsUP2BvSROCfT2EMhBhR
         RgMATFCrT0RzmwXTd6xDBVKkO9juHSGFZ/NekvzXzdsrhyDEtAof1EVtHzUweX1v+ttI
         Y/+2lhob+k9r2UYiUECT1+fBwYeJPYq8BgTgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRBmhGMcbQ4hALpmq1oAoDfVUyAe/BHGvMizr8MXf+c=;
        b=mjzwKHb/MjSAVE8/Q+bAL+YRvarg3l+FJ3RkjeAeFnqi3lDNghg/Aj7GRO98Pv3Uig
         wLz6taf7L3VXVR8l1MMQysRCkkOxHNL0hWUau4TIu57FNpFKIhM+gh/KXfHXfHJom0lV
         XtFYgn6nsoHnjOk9+W4nC8tacXq2waw9v0II58BN4JTjs9OI5Aj2CWqmA5EC71T+LnVE
         K5mdBqfA7MSYKxXEatbZetK9Spbr94/tXfegtOAMzMpHHz2eAj0ckoA2ghnbkH+qNgyC
         sMis1/AI9SeuYN+q2ci/mEYLP9kdgyVMZNmqT7lVfU6j56NyCzNG76EAJ2qZdOcWTzN0
         0P0A==
X-Gm-Message-State: APjAAAWzUJaqf0eiAbAWoHhijyQ2AM3CGDQsSR/QLU8qf1V7Dux9Tt4M
        RYqFgwH3KOZsJZso1fH3lbnkh6jG254=
X-Google-Smtp-Source: APXvYqyin4KAkaHvWQUoBHLpMDdrV5DDNZa0mkbBNT/zFK1oxYRt+ro+Bb9ff0Wa97F04XabdsL8lw==
X-Received: by 2002:a6b:b987:: with SMTP id j129mr303739iof.166.1561583115730;
        Wed, 26 Jun 2019 14:05:15 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id c11sm75858ioi.72.2019.06.26.14.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 14:05:15 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id u13so7838381iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:05:15 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr228073iol.269.1561583114838;
 Wed, 26 Jun 2019 14:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190624225312.131745-1-gwendal@chromium.org> <20190624225312.131745-3-gwendal@chromium.org>
In-Reply-To: <20190624225312.131745-3-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Jun 2019 14:05:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYg8d8ZHqcH7LWsSXx5-9kNP+nC+eS84=XNdaZi_7_-w@mail.gmail.com>
Message-ID: <CAD=FV=WYg8d8ZHqcH7LWsSXx5-9kNP+nC+eS84=XNdaZi_7_-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: cros_ec: Extend legacy support to ARM device
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 24, 2019 at 3:53 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> -static int read_ec_accel_data(struct cros_ec_accel_legacy_state *st,
> -                             unsigned long scan_mask, s16 *data)
> +int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> +                                 unsigned long scan_mask, s16 *data)

As found by 0day (see https://crrev.com/c/1678822), the
cros_ec_accel_legacy_read_cmd() should have been static.

I presume this will cause less confusion if a maintainer just fixes
this up when landing the patch so Gwendal shouldn't send out a new
version to fix it.  ...but if this is not the case then yell!  :-)

-Doug
