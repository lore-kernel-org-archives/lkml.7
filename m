Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0551C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941B92339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oHQtK7cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394429AbfHVXYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:24:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41960 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391126AbfHVXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:24:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so4577145pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Xrv/K8dQ89ELPWp5GIeJvc/tKU1hE0fADZZT0Rp4xCw=;
        b=oHQtK7cWF4YNNlGFX4Lou7Tvf5M6/BkXy7GynBMfRPexYBZiYMeznIpW0OEEMlYOvO
         h9FRRAdhuHWA69cBYNVMLsSpA0lLfGO1Vme9nN+wiZwpWn0Bkdo6KZ/80U1+uSjgWWpu
         MhHBCysvmoJvK6dkijFMjPDvC/846PpdnyhE4AqP9XQlCBkGmUhoMLtg+90YXqGWpXKS
         B4XwVx8ERhHdNl4h7RyoXWP8YYGz5OFuh5Pm0s5n7qtQhnY7N9AkSOY1KGPpikrGf9xX
         axyZfS8wUK3VLfhWjIYpsq3n12IGgJJO/dv3dRVP8FqN0FvyhDGz+L4cBxZvz1LSDVAf
         U9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Xrv/K8dQ89ELPWp5GIeJvc/tKU1hE0fADZZT0Rp4xCw=;
        b=kqOsCmEERmI+gAdOoiF/3q4hBYHFuyyRmHnGxb8kfbDyOthCyiJUeu1/Of8uIYep7Y
         EzOJnsj7A+W7CwsWdNTm5RiDUy2p46VY6owLrkLJbFMka2KFulNT0doIt0+N/L+IIbef
         oqi2SolYdWNsKkXQSx3GnkkI4KD8kdxC/joRPgTrvHeR6kJJ8sfvPp0JURmEnOx5Ws3X
         hUOXhJ5y1AKgMXgIGS6+v/boA1QpMOlUP9CHSC+3RxlC0IXm8jegdRQtYWKgMo+YUM/F
         bZS1hHIb+VjOtCaqxCuMBMXSxR0NXNXy25gIQohKpxAG7a8U53cp8d7n57Zi/HJg6OC0
         nIYA==
X-Gm-Message-State: APjAAAVwh652y5fBdfR11pIqN+sKyQutRpK8DnZVkJRzMFiZVFLHp9Jt
        lHKHWdpbFnYaroYmNcLKTVEw4w==
X-Google-Smtp-Source: APXvYqwa+nxDVJoq0CNmukkf7aMafMYxPRJadiw+6g6zA2gNsoqH1hxioLg6agDSoWaVzexljZ8jNA==
X-Received: by 2002:a63:e148:: with SMTP id h8mr1392722pgk.275.1566516240065;
        Thu, 22 Aug 2019 16:24:00 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id s7sm474003pfb.138.2019.08.22.16.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 16:23:59 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/71] 4.14.140-stable review
In-Reply-To: <5d5f064d.1c69fb81.ab35c.8cfd@mx.google.com>
References: <20190822171726.131957995@linuxfoundation.org> <5d5f064d.1c69fb81.ab35c.8cfd@mx.google.com>
Date:   Thu, 22 Aug 2019 16:23:58 -0700
Message-ID: <7h8srk238x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> stable-rc/linux-4.14.y boot: 124 boots: 2 failed, 106 passed with 16 offline (v4.14.139-72-g6c641edcbe64)

TL;DR;  All is well.

> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.139-72-g6c641edcbe64/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.139-72-g6c641edcbe64/
>
> Tree: stable-rc
> Branch: linux-4.14.y
> Git Describe: v4.14.139-72-g6c641edcbe64
> Git Commit: 6c641edcbe649a2aa866356ffd24f595edb17bea
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 67 unique boards, 25 SoC families, 16 builds out of 201
>
> Boot Regressions Detected:
>
> arm:
>
>     bcm2835_defconfig:
>         gcc-8:
>           bcm2835-rpi-b:
>               lab-baylibre-seattle: new failure (last pass: v4.14.139-62-g3f2d1f5446a4)
>
>     qcom_defconfig:
>         gcc-8:
>           qcom-apq8064-cm-qs600:
>               lab-baylibre-seattle: failing since 6 days (last pass: v4.14.138 - first fail: v4.14.138-70-g736c2f07319a)
>           qcom-apq8064-ifc6410:
>               lab-baylibre-seattle: failing since 6 days (last pass: v4.14.138 - first fail: v4.14.138-70-g736c2f07319a)
>
>     sama5_defconfig:
>         gcc-8:
>           at91-sama5d4_xplained:
>               lab-baylibre-seattle: new failure (last pass: v4.14.139-62-g3f2d1f5446a4)

Again, regression detector failure...

> Boot Failures Detected:
>
> arc:
>     hsdk_defconfig:
>         gcc-8:
>             hsdk: 1 failed lab

This is known broken on v4.14, will blacklist.

> arm64:
>     defconfig:
>         gcc-8:
>             rk3399-firefly: 1 failed lab

Hmm, this appears to have never worked on v4.14 either.  Blacklisting
until someone else cares to debug why.

Kevin
