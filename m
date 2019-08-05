Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B969C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FED20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="hthEXQoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfHESfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:35:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36845 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHESfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:35:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so69862680wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=zonXc3/aq46YHRaoY/iCK1+k43XKTgCzmG0UQJgG+z8=;
        b=hthEXQoYYgY0fhTSkH9Vx7nvNA+llRLzD3MI+F6sx1jO3yWhb4QIbJ6b1Xy4q8uDlK
         QOHE46t5saknXTiu0fP5G+gDVyXwapBG0t0lPXY/FR0YeguEmP31ykEERyRaNvFUQ8Mv
         T6/Gi6gXw4R6+N2Xo1rdjZhK10vO5rVD9Kvc5Y28C3OE2/XE/EGNADw5iDL88iEP9s/p
         Hvwtd7KsP6+rZxkmMvVHMS/KUhPCgg86ExfyINSR+8ZURNw+zLSbou9dok6I0aA7OInZ
         b6TfNOowwBWEFq8BlzBjhHM4ZoW51WfIgWIsee1kmOy7QGNnsauUwhZJKmdFmIXm7zBA
         UmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=zonXc3/aq46YHRaoY/iCK1+k43XKTgCzmG0UQJgG+z8=;
        b=P8hVs1DGwEQXs/dsU0LuThvSE23B9RBkixSEy/VGechXydvXWApVMojzeeo5WO66nF
         NYcy0UHg895AHOHIItcbnRhusXaNFxPSWZHv4oFha5ZL/rd6OlrNc4mXJP+emDpcO5+u
         DNe8py9josM8DjggEwjNMR7t4bSRyydAuA/dWwyCefJzcFL3OtKZ3vZXGv8fznOmm76h
         2pBJZSSwLT494G9dKfm4/RzJlzKsL9enjLKqtLGut5U9aUQYzEV6LqXmA4BZOiroqbLp
         g/A+0Na5NiUQHjoKaah/VEoTo8a3jbbRikRsUp9iycNoP/wvHHo2Ch07tnB7k/BLxsDe
         RCsQ==
X-Gm-Message-State: APjAAAV2mXllL0fWfyFgapahs4ofKIaA4VyYvqyDfuiacQnVC94UQysb
        uhofwcxYTKZYxxwou5ih3Qc=
X-Google-Smtp-Source: APXvYqzY7OsNmwIWSX5CYlp0IZgujoGvomN+1R7UBPB67LukyzF6bYH9pKxjYThhPzxOh6dW8/uSSw==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr18768406wme.99.1565030120160;
        Mon, 05 Aug 2019 11:35:20 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v65sm100331874wme.31.2019.08.05.11.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:35:18 -0700 (PDT)
Message-ID: <5d4876e6.1c69fb81.24541.29fa@mx.google.com>
Date:   Mon, 05 Aug 2019 11:35:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.64-75-g27e5d9acda64
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/74] 4.19.65-stable review
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

stable-rc/linux-4.19.y boot: 65 boots: 1 failed, 64 passed (v4.19.64-75-g27=
e5d9acda64)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.64-75-g27e5d9acda64/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.64-75-g27e5d9acda64/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.64-75-g27e5d9acda64
Git Commit: 27e5d9acda64f19f64a7db74e3bff765c11248bf
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 34 unique boards, 17 SoC families, 12 builds out of 206

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          exynos5250-snow:
              lab-collabora: new failure (last pass: v4.19.64)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            exynos5250-snow: 1 failed lab

---
For more info write to <info@kernelci.org>
