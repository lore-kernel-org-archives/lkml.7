Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365A0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0759A2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1fMEwmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfEQWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:48:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35395 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfEQWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:48:59 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so14548574ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWLIDy2co5Vn50CtpXbdQSItadAnwXRU6oL36I+LMbU=;
        b=j1fMEwmFBzpq5dKJ/MaU3D+drIuI0ARLCKClUL2DUep1n6kX4Fj3FE+3y2BpqzVZcg
         cEeqDwknBjsY/k8bhbZb9ooIqb2AicXfoG+WcGFLfDGOXOwGm39gXALlBPzi1fE7dZkl
         Gy0hqJ4vSeb3tcYqh9HvuEQUYmtA/7AZnr2/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWLIDy2co5Vn50CtpXbdQSItadAnwXRU6oL36I+LMbU=;
        b=q0B6mFUXnDRKQkGem9UMMUj5aUFfj4k5R9h/3uRunxTRncIW1ePnhjQKRfbUyygmQ/
         RIvo9m8TvpeEVzW2t9aVbBpgWmHqnAiCZ4B90eyxjhVjJyGPtIkAo3qZbaHClsv+3WwR
         xICyhzS0oDMitK2E6At1YUFtZ9PCa4tG79h5jVbLNlMTJVFJapThWSYT9JfUFuns62yr
         hDsaB7P+WubZcRhjiM2P5Eo5rf81ZrucPszLGnb2rkGX2m1SF0caP4ytkL1lqCBp/1pF
         UsVbdBDJUSo7nJ8ebOya0t4RteInTa5Ec9LAtA+tISgjZODz3Xk004jLcWv9XnojZLvo
         Kbzw==
X-Gm-Message-State: APjAAAWYAaC9Bs45Z8F9M0Vm6z8vI+AmKe1dv7+552KRgSrivR3RqCfx
        XlVQVV4WDa8l6/IPZrH8Z7vzUHHqMm+CkGq1YFgTjA==
X-Google-Smtp-Source: APXvYqyYg5NJJ7Eb1Cf1sch9W6PqiIZNmQkePH7xL+iwmKaY8JvrKHQXzNzcY6+FGrg1OB6xJE1HilF2iy1ns9vW/Ag=
X-Received: by 2002:a02:1142:: with SMTP id 63mr37714962jaf.19.1558133338638;
 Fri, 17 May 2019 15:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190509211353.213194-1-gwendal@chromium.org>
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 17 May 2019 15:48:47 -0700
Message-ID: <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee,

I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
used on chromebook using a squashed version of these patches.
(crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
respectively)
Please let me know if you have any questions.

Thanks,

Gwendal.

On Thu, May 9, 2019 at 2:14 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
>
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>
> That include file is converted to remove ACPI and Embedded only code.
>
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
>
> Fell free to squash the commits below.
>
> Changes in v3:
> - Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
> - Add Acked-by: Benson Leung <bleung@chromium.org>
>
> Changes in v2:
> - Move I2S changes at the end of the patchset, squashed with change in
>   sound/soc/codecs/cros_ec_codec.c to match new interface.
> - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Gwendal Grignou (30):
>   mfd: cros_ec: Update license term
>   mfd: cros_ec: Zero BUILD_ macro
>   mfd: cros_ec: set comments properly
>   mfd: cros_ec: add ec_align macros
>   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>   mfd: cros_ec: use BIT macro
>   mfd: cros_ec: Update ACPI interface definition
>   mfd: cros_ec: move HDMI CEC API definition
>   mfd: cros_ec: Remove zero-size structs
>   mfd: cros_ec: Add Flash V2 commands API
>   mfd: cros_ec: Add PWM_SET_DUTY API
>   mfd: cros_ec: Add lightbar v2 API
>   mfd: cros_ec: Expand hash API
>   mfd: cros_ec: Add EC transport protocol v4
>   mfd: cros_ec: Complete MEMS sensor API
>   mfd: cros_ec: Fix event processing API
>   mfd: cros_ec: Add fingerprint API
>   mfd: cros_ec: Fix temperature API
>   mfd: cros_ec: Complete Power and USB PD API
>   mfd: cros_ec: Add API for keyboard testing
>   mfd: cros_ec: Add Hibernate API
>   mfd: cros_ec: Add Smart Battery Firmware update API
>   mfd: cros_ec: Add I2C passthru protection API
>   mfd: cros_ec: Add API for EC-EC communication
>   mfd: cros_ec: Add API for Touchpad support
>   mfd: cros_ec: Add API for Fingerprint support
>   mfd: cros_ec: Add API for rwsig
>   mfd: cros_ec: Add SKU ID and Secure storage API
>   mfd: cros_ec: Add Management API entry points
>   mfd: cros_ec: Update I2S API
>
>  include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
