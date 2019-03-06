Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7479C20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKkf78JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfCFQ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:57:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40896 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCFQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:57:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so7195048qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r16xGN9L3Bl3lBmJjosg64UpvV5z9jAZUnJY3MNODjY=;
        b=FKkf78JNBpt4jfS/w/H/x+4li9HWHp0d4AupwBgeSekk+dOL9/snqDeTZWYS97OeoW
         m53QvewHwNrmI1yagefXElIO8PshYzB+jX2Ot9OpHr3TPd3fNROoeRzW0SewQPX3SZ1q
         OLTMd8fQKW+5j9qhsC5NRH7zLESSxPTDdm0m+HOzx56eUz3LiPE5zlEwWiCe+DARLYS7
         GP8hQD4tUp/m7rVTEoNKCWnJFVfc6g1PVfZoGyXisOdKfvvZmkhB4kLMlBlaLb2EaZSb
         5UFbxogpIFopmwKgMtjPalldfEnQVdFrRJm7lMO8VA8jAtikb7HHHy84CbqXkqZvj/AS
         ui2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r16xGN9L3Bl3lBmJjosg64UpvV5z9jAZUnJY3MNODjY=;
        b=dp21DxpbqOpGaxB1ij9NgzBI7bJVtXvc62WfmCEoUPJC7+L4wLlqlxBrJQQfL1o6eG
         zHWzYtqmGHeSbuGepD6h73Fk6W5Bmc3UCM4QueGmHBQjSzQHm1EZ2sqj9Nmu14aUoM8p
         e9ekQzTLOhfexiA39jMMJSX96U1uixCbrqYDNIQi+3d5rTWCVzTwShwahTxy3GyI4JUm
         mOkvP7D5bTf3hv0Q4GaDznvqSMPPaIQFePXd3ZlTM6btQbz+SXi3aAQdmiIVO3Qe4Qjo
         W1o0DaLBwg+4Okk07JjZMfCq4N125RzrvKBdT5i3GcLa0nYlEagNGgkGmvZrEwoDxJTf
         Um1Q==
X-Gm-Message-State: APjAAAUzz+RAr7Wg6/LKCA9oJH8Cx8EGT5/JJKM1c30kqd1HQ7dajpwO
        H0Dc6n6BW1sWDvak52GZNRIYZcYlL9BQmxlcXM7IgPn+
X-Google-Smtp-Source: APXvYqzZY4/ZmR9dCMofZX9+bl9tqGuaMJuKJYeVoIBt2KfhV5mwRYoJyCIVrZGBai0RANc9/Zk0+9r2S5VhX/Oz1LM=
X-Received: by 2002:a37:b12:: with SMTP id 18mr6341439qkl.125.1551891436008;
 Wed, 06 Mar 2019 08:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20190228002725.57444-1-gwendal@chromium.org>
In-Reply-To: <20190228002725.57444-1-gwendal@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 6 Mar 2019 17:57:04 +0100
Message-ID: <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Many thanks to send this upstream.

Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dj., 28 de
febr. 2019 a les 1:31:
>
> Chromebook Embedded Controller protocol is defined in the kernel at
> cros_ec_commands.h.
> The source of trust for the EC protocol is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>
> Only needed changes have been picked up from this file to the kernel
> include file leading to gaps between the upstream version and what the
> latest ECs can do.
>
> Fill the gaps to ease future integrations. Changes from the original
> files is header/footer for license and include files for alignment.
>
> Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 3627 +++++++++++++++++++++-----

I'm wondering if we should move this file to include/uapi at some
point as this file is also used as user-space API for some userspace
applications.

While we are here I'd suggest if we can also fix the few errors (3)
and warnings (5) spotted by checkpatch. With that it's an ack from my
side.

Being strict, though, on most cases the variables are going to be used
in code that can be seen by user-space programs so maybe we should
really need to switch to __u8/__u16/etc exportable data types instead
of the uint8_t/uint16_t/etc types (those are not aimed to be used
within the kernel). For those types that are internal we should use
in-kernel type (u8/u16/etc)

There is also the use of the BIT macro instead of the (1 << x), I know
that this is a maintainer preference.

[snip]

Thanks,
 Enric
