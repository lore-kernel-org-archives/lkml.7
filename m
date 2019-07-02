Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2630C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BD220836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="b1h+VHvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGBMcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:32:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfGBMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:32:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so805704wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=e+9jO3EwOEXl25neut37mAgd7vjkxK0lA1LxJ9WXw+Y=;
        b=b1h+VHvQ886TGEE3gxTei91RlQDf6uDPdc2QQ8sEBOswMPiAEny8Cb1pfNT55/2qbr
         JfWzKyP8eg2X+A3THQNjbf70tDKG4baiVKxptDacqyXHg57RmmGQUv2FzghQp+U2Mi5I
         nkNhVXAVSd/DplaJ3ifReQplgl2atQVYAPPlwv+KUvMx6uGAxRdSpDKVhcdNtwDjMObK
         33M46/HoT/Md9nJchWwFwBZTLJGmR76irHCIA/DKZrT/ynWa+b1FE0s3cGnhkfpqSCbT
         k847NZfkTKxVC+Yk9MtVfYCFpMcUhaMROyiV6/a4JGmsOYLE4bUBNsLJ90pSX/EaFz1M
         Noxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=e+9jO3EwOEXl25neut37mAgd7vjkxK0lA1LxJ9WXw+Y=;
        b=APKzbl818QfRE8Leljc8wEulKashoaJ+jlsqgXrT3VAruIHJNFs14DP0fJp7HWmVJY
         YQfHBE/AE2vfxGY8R3garOwm8K7eW2KEXLbabhOYsd1YqIVfYHK1+Gx47tnRB2pzYJ07
         FquJ2UXJowZ9sFdI4GCsO6sh9gPseftjr09BFR9SJ6+Fk2uP53eUuI5i3RKPljCLyepA
         IlFqmlx6FtuMUj+Mh4OC8XXp47EpSZiS9O0lPJBptdrqYcGQP1IEx4FZa0wJOvJ5Bfvy
         BxOxXA+xUv82djeTZGJBtEYh+VqXeJxv/3JpFsqhr/ha5XB/hKO+px8whtNVOg51zXTG
         aVlw==
X-Gm-Message-State: APjAAAWRPo7991qOr75Bw1momdUj9VVIT9YdE3XGeDCI73lpbz0TDT/y
        OELmFt0///Z7ZqkboZNVEJtRwA==
X-Google-Smtp-Source: APXvYqywUk8zBii4OiiT3yG3VzwJVaWRex6r6j4iXnW3YR6AdgtVeKBWMX0PtFROaZeISnuqkL8mFA==
X-Received: by 2002:a1c:f519:: with SMTP id t25mr3470326wmh.58.1562070727961;
        Tue, 02 Jul 2019 05:32:07 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v18sm13671226wrs.80.2019.07.02.05.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 05:32:07 -0700 (PDT)
Message-ID: <5d1b4ec7.1c69fb81.790c0.191b@mx.google.com>
Date:   Tue, 02 Jul 2019 05:32:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.56-72-g828a73287676
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/72] 4.19.57-stable review
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

stable-rc/linux-4.19.y boot: 131 boots: 2 failed, 128 passed with 1 offline=
 (v4.19.56-72-g828a73287676)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.56-72-g828a73287676/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.56-72-g828a73287676/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.56-72-g828a73287676
Git Commit: 828a732876760accbd58e1c3ce70be8b6ae0c03f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 73 unique boards, 26 SoC families, 16 builds out of 206

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
