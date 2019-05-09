Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0421C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 23:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAFC217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 23:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="KZXV+Zme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEIX1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 19:27:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53501 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEIX1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 19:27:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so5239006wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=RnvY7geH+A4N8B10Z1RbPFf3s1ZPigUFVWpv/Xpazjs=;
        b=KZXV+ZmebZiHyksi89Co3Ncpgpll079vA+GPTDcX0c3sNhE7P/fo4EdX4iO1u0r0mZ
         COOreq3YGTcJLoYVnHX/+3Xvs7DTecqEiFLlFMaY7yEKZIyzuSAyvs5K7i6EE4gH01uV
         91H5X2EdBsyu5VtMNtV/YFwARMQ2cqT6CCKNQ9uJF3pXIwS9U9Wwp7JUEcC7vUJKXjx8
         DJGfxDLwnLy3krjt0OtCkXQjTudjHgYu0+rFwPcdGGjxmknBOkYH5WlQC+K/eg0wdlkK
         Scx4Nsm9ATFL0UUBB4FxUQW+qPRPW5ZrN+J/aj2IFQK8R3u5FLkqXNxWqPNEvFu2zskn
         aljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=RnvY7geH+A4N8B10Z1RbPFf3s1ZPigUFVWpv/Xpazjs=;
        b=sTM+XsrA8QxjcmVU27Te7OpQ+dX0RmUxK/ba4UTN7a+AJnqFBlbQ6d6TaqCMe1dYPW
         Ze37JmZLTghNQ/P5sOVyqOqmlGeWUCR4p78CPOsc6ZbvEQ1RMYYXqH37wIUvBPAAjgXO
         AjXNpPhm5G51OnEAYFoWTC/8it8TpDKkkT+ElEGwks4JL7cssLmYhrOlalnN8UgMzsE7
         igxgtUqumLwLiRvBrHvyv9muiukOQyRy9hyTtPnd+hlpqwsxfexfVG2BYBMCvpQTvFZY
         bO5vPB8PRJ/svoNEV8ERD8S9Hhf+GNQvXEqBG218RSZozKFkntbRLEDrRValcSRzWu25
         pB4A==
X-Gm-Message-State: APjAAAV9+9MJprlVI+w5EWYux5aZklDv2hPWc9APseadX/AyjJyCT/Qp
        HyjuSHR39xXnhfSMyLaN+zu/FA==
X-Google-Smtp-Source: APXvYqxLLfrFCfz3i3u9lf6pJBwCTjAtwmx1g16ijs4SqlmlwcGtWHQfTSP6cXuPpLXD8ZRGHn/UEw==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr4581605wme.126.1557444433385;
        Thu, 09 May 2019 16:27:13 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f7sm2215872wmb.28.2019.05.09.16.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 16:27:12 -0700 (PDT)
Message-ID: <5cd4b750.1c69fb81.c7a5d.a8bc@mx.google.com>
Date:   Thu, 09 May 2019 16:27:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.117-43-gfd7dbc6d8090
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/42] 4.14.118-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.117-43-gfd7dbc6d8090/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.117-43-gfd7dbc6d8090/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.117-43-gfd7dbc6d8090
Git Commit: fd7dbc6d8090b210573e19d5a50f7772ec4b1977
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 64 unique boards, 25 SoC families, 15 builds out of 201

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            stih410-b2120: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            rk3399-firefly: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    davinci_all_defconfig:
        da850-lcdk:
            lab-baylibre: PASS (gcc-8)
            lab-baylibre-seattle: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
