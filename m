Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84984C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9E20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lg4JgcZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKULao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:30:44 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37987 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKULam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:30:42 -0500
Received: by mail-vs1-f68.google.com with SMTP id u18so2008672vsg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzOo2JV6kkqnrwHkbUSJuC+75l0A5IKM+uRyHywuXgo=;
        b=lg4JgcZK7t2R0U9FLgUevhlhy7bVd0uQOQbZ4FU/lBtzXd/Oe0ED7vvfm1wvlaHer3
         swUXak8Mp79XDGOXu3i/EslwDffIo0voi3c3icVXgsFPaSVRwrKOttt42XJba2hionhC
         1Hk3DX9a3lazZ6iu4L60+jNWjOusc+WkPQBo+Le3GPYbUEMKz9yEKSh4RB7iTBvA/3Sy
         s9USQXzn4lNKgwvl7WR0/+JlRPv4ytRumvQ9cbf8UDEYbNrsNoDfC/A/GToOD7ELC/Z7
         A1pzL3o9mIogCGh2Vz4fbrJCXjZ+fnCMFyqKczspqNnwVhwbX/cdn7qQzxwqnJoL6YBn
         O40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzOo2JV6kkqnrwHkbUSJuC+75l0A5IKM+uRyHywuXgo=;
        b=rM22V04oDvRWQECp7t1P3a1br2hRzcqbzJp8Xwcc24Pf2UCNRzRepU8lhE58VWpCQ+
         eEr5Dz00v+M79WJSMZx3ALKdetPoq9zj7ld0f2SyZykx23OVspOHRvnYxGaf2XUoS1zw
         P9Z9Kj67IJ2PmBRs2BJQoRhbN/WlpVDZq/n4xUsbeLBQ6TvzawY1qU9BRQ1C1F5XuAUf
         +XZs0ihuw4gp5g0x/5667nBa8DAdqpn2Mr0McEpwjhfBzl94J+lXjDFpKqCRwZ426C1v
         +0kg9UIsl9iy5QhJmYmu+Ap+uvDVydmVk7mVg5g98lfBe/GlXaJsJSXNnY7C7IslHUD8
         Nhkw==
X-Gm-Message-State: APjAAAVAEQTu2DCEDHwFu1u30eM+cMGHhIFHTX6apuoTyZRcq5Ob+GRq
        SpCNJNiKbaa/chxN1jWTWIReyu58c9Hhyl/mfsOeGg==
X-Google-Smtp-Source: APXvYqyi/CNSLQC7kcZJtahFRlILYFYUIVR4PapSxddBUrS44erqpLciYYxGapgJhka0MHjM+RpzfqX/W4c1YbQcBh8=
X-Received: by 2002:a67:ef4e:: with SMTP id k14mr5559804vsr.165.1574335841550;
 Thu, 21 Nov 2019 03:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20191120134101.14738-1-krzk@kernel.org>
In-Reply-To: <20191120134101.14738-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Nov 2019 12:30:05 +0100
Message-ID: <CAPDyKFohHYuqu=a4PJMqPq6ydNGcVjVMotyiSniF=mhZQ-qa4Q@mail.gmail.com>
Subject: Re: [PATCH] memstick: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 14:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/core/Kconfig | 18 +++++++++---------
>  drivers/memstick/host/Kconfig |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
> index 516f454fde14..08192fd70eb4 100644
> --- a/drivers/memstick/core/Kconfig
> +++ b/drivers/memstick/core/Kconfig
> @@ -6,16 +6,16 @@
>  comment "MemoryStick drivers"
>
>  config MEMSTICK_UNSAFE_RESUME
> -        bool "Allow unsafe resume (DANGEROUS)"
> -        help
> -          If you say Y here, the MemoryStick layer will assume that all
> -          cards stayed in their respective slots during the suspend. The
> -          normal behaviour is to remove them at suspend and
> -          redetecting them at resume. Breaking this assumption will
> -          in most cases result in data corruption.
> +       bool "Allow unsafe resume (DANGEROUS)"
> +       help
> +         If you say Y here, the MemoryStick layer will assume that all
> +         cards stayed in their respective slots during the suspend. The
> +         normal behaviour is to remove them at suspend and
> +         redetecting them at resume. Breaking this assumption will
> +         in most cases result in data corruption.
>
> -          This option is usually just for embedded systems which use
> -          a MemoryStick card for rootfs. Most people should say N here.
> +         This option is usually just for embedded systems which use
> +         a MemoryStick card for rootfs. Most people should say N here.
>
>  config MSPRO_BLOCK
>         tristate "MemoryStick Pro block device driver"
> diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
> index 446c93ecef8f..4113343da056 100644
> --- a/drivers/memstick/host/Kconfig
> +++ b/drivers/memstick/host/Kconfig
> @@ -18,7 +18,7 @@ config MEMSTICK_TIFM_MS
>           'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
>           (TIFM_7XX1)'.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called tifm_ms.
>
>  config MEMSTICK_JMICRON_38X
> @@ -29,7 +29,7 @@ config MEMSTICK_JMICRON_38X
>           Say Y here if you want to be able to access MemoryStick cards with
>           the JMicron(R) JMB38X MemoryStick card reader.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called jmb38x_ms.
>
>  config MEMSTICK_R592
> --
> 2.17.1
>
