Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643CFC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315742075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zfqjuz4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfD3RGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:06:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfD3RGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:06:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so4616880wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Mn4S8rnxAWXrqwzwzVKs0U8dS7gV9+cUXMTKHHNHoTQ=;
        b=zfqjuz4fKkLrqCpLZ50XHs/0LyZaEvKKCViqeCyBd0Mlrjv7lsISpUNTpsasuBkHDL
         vDoLwhdMaFWfcp/ooj2Bc6wurv7iPOMqljK4RukgZ3i7JRX9FqjUUlGcU/EU6NDD6bTv
         hM9az4gLyslH7iGba3+wyc7MbP3FxqOzMSEfh0oNWAs7CP7TBgogBFJziUEtjlnLhOm5
         g1bviBvNrXF5MrgBDMQHny/TK3Be5Fqb8/X4WIS3q4yqrQa3ulpjrpKmqVdc4kmZLFBw
         1hK0m5TWiiYxJfGcLT0k9vj1YOVaEXZbMDBBdMeba7X+mTlJR15eSh8pIh0/fUgtsQ5H
         oZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Mn4S8rnxAWXrqwzwzVKs0U8dS7gV9+cUXMTKHHNHoTQ=;
        b=rQuI5dWq7ZGR70E/0A6a0j5Ux6ajD+B88CrE2i2WXTjoKHQKa22E/yOHgFedN+7sU4
         t+eEWiEc1QniUjTnYf/BXXwajN9CTzrXkBw4xwZIaDHIfGJDmugXT4Wa2VWTaoP4+A4f
         S5sPIDUklq1ra2brXCjrbX6/00XgBIwyu9zMhPD0yHQQ9k4RtFd+hjoa5+5oI4InNZJw
         GR6os3GH0JSoNFZ9DcQDDFXTR5iEguSDQTqlbKabBANEtBrVm/uR91/+9wjJ5PVWA19S
         Ka+NVTJhdWvOGLyfhvHt6oZpK40XegxpjJKez7DU1hWQkecsQ+xWrE/RxiV1KpWaJeqp
         MTOw==
X-Gm-Message-State: APjAAAVjr7BPT8D4DZ0LOesN44KFhn7vDWzL9EhAR9b6zQdEk3qVmSl/
        iJcKMT7dNdAXDEgCGP9SXxrLwA==
X-Google-Smtp-Source: APXvYqx4NQ+1Y/BmlSvop8HPxb/zWLn3py6MzO23lYnevkdGmoa1z2r1RGcsiM6rqqbwkXPyQGUlfQ==
X-Received: by 2002:a1c:c142:: with SMTP id r63mr3993541wmf.97.1556643979107;
        Tue, 30 Apr 2019 10:06:19 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c204sm4738454wmd.0.2019.04.30.10.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 10:06:18 -0700 (PDT)
Message-ID: <5cc8808a.1c69fb81.d69ab.b13f@mx.google.com>
Date:   Tue, 30 Apr 2019 10:06:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.0.10-90-g852cce372723
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
Subject: Re: [PATCH 5.0 00/89] 5.0.11-stable review
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

stable-rc/linux-5.0.y boot: 128 boots: 6 failed, 118 passed with 2 offline,=
 1 untried/unknown, 1 conflict (v5.0.10-90-g852cce372723)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.10-90-g852cce372723/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.10-90-g852cce372723/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.10-90-g852cce372723
Git Commit: 852cce372723872dc1e9f40fef3bcfd2b3215420
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 75 unique boards, 24 SoC families, 14 builds out of 208

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-7:
          hip07-d05:
              lab-collabora: new failure (last pass: v5.0.10-72-g49e23c831c=
03)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-7:
            bcm4708-smartrg-sr400ac: 1 failed lab
            bcm72521-bcm97252sffe: 1 failed lab
            bcm7445-bcm97445c: 1 failed lab
            sun4i-a10-cubieboard: 1 failed lab
            sun7i-a20-cubietruck: 1 failed lab

arm64:
    defconfig:
        gcc-7:
            hip07-d05: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-7
            stih410-b2120: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    multi_v7_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: FAIL (gcc-7)
            lab-collabora: PASS (gcc-7)

---
For more info write to <info@kernelci.org>
