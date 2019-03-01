Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF62E20854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5E0/huI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbfCAOen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:34:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40680 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388610AbfCAOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:34:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so12380486lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBapgXqkl4L1Kp5k3gMreZSqISZL1TQmMdeWE1ORKa4=;
        b=j5E0/huIa/W0dzMeMjpnXH7v/2YP9ugqSIwpGCTl2kRlsVfd830ziOSM+tEGAjen1f
         lrmFZIf2ME7R9jfuFJMLvSW8V5M6fOHMEaOwE155Hxbo9nfks40+1ybuUrSc2qbNu6vW
         DT4q0f2WXWkSTbxXszKyVfYf3omHXVXzCjZUfwQOSkMYfaQuNATqfQxJs9/PEx2mSjjF
         /St6yh11eRzlH3rqPns7DHREtqGNu4+5Yho3ivjey7FazvMMCUvQFzBe+89KrHk8uHxh
         vhyUGQNuN/DvA8qL9TfCzQ01oP7VcuOgf/bEbQpN4bP534tqfT6zFu99qhxO/iuUpoWj
         MPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBapgXqkl4L1Kp5k3gMreZSqISZL1TQmMdeWE1ORKa4=;
        b=iCIOAV17Y4h4v3B9bLYvyXIOl2JXe/IEHNN8vxTONRZi/5n0Nc/nDpdbznsWnQaUxN
         lJeR+PlvyM+R1qqbOaqIq7CHH1v3z+latW2WH0O6+BSoX5ToO6biSvwGdStSC46vpLQa
         1VHHzVhLtM1LifscF0WippGFXND8TDkUzp63pyaF8gX4GOVJoPOduEcDx9DfQKC0ZfZa
         Lo3QtC6cvlEcVTvkBYBxxatLRq9sasXS6ScxhxM84iu2MGfu4iTWu8d9p0kwlkVzDltb
         c/3Db7baAqWH2kicCrh+ZKARL2/4N5/0BXBoUWEU1iueF3PPnte+sGD8Nx2xo7fGjDww
         fa5g==
X-Gm-Message-State: APjAAAW5jDVC26XbcP2HA5gBTFDqBEXqIjFyP+siEUo7VOpTB7A8fUsP
        EVFEAEn/Qf09HZkoOlJktdh5b8X6rBdxGTaSj+4lMg==
X-Google-Smtp-Source: APXvYqxnG3LWV6GEtylHjCvETKPwlLvaWtlPQP0A5n1QUVPV+F0ZOcUKlnuANnvO/u3jrydNaGmyU0t4B4QXMc+PGOY=
X-Received: by 2002:a19:5611:: with SMTP id k17mr3090530lfb.168.1551450878177;
 Fri, 01 Mar 2019 06:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20190301035852.26780-1-marek.behun@nic.cz> <20190301035852.26780-4-marek.behun@nic.cz>
In-Reply-To: <20190301035852.26780-4-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Mar 2019 15:34:26 +0100
Message-ID: <CACRpkdam_CYGtph16McpQQ_WwohpZr+Rzi1B=re4UrGxXmSEqg@mail.gmail.com>
Subject: Re: [PATCH v3 bus+gpio 3/5] bus: moxtet: Add sysfs documentation
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:59 AM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> Add sysfs ABI documentation for the attribute files module_id,
> module_name, input_value and output_value of Moxtet devices.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

(...)
> +++ b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
> @@ -0,0 +1,25 @@
> +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_id
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> +Description:   (R) Moxtet module ID. Format: %x
> +
> +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_name
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> +Description:   (R) Moxtet module name. Format: string

These look good.

> +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/input_value
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> +Description:   (R) Read input value from module at this Moxtet address.
> +               Format: %x
> +
> +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/output_value
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> +Description:   (RW) Read last written value or write value to the module=
 on
> +               this Moxtet address. Format: %x

What is the usecase for these?

If this is for debugging it should be in debugfs rather than in sysfs.

If it is here for random userspace drivers, we need some good explanation
as to why they can't just be kernel drivers.

Yours,
Linus Walleij
