Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99EFC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19202173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="evyqKc46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfGRHdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:33:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfGRHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:33:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so24514974wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=1FvNEKtS8XUFhNrzpNnVepQzKVjJRHhKmZb07KcMWQ4=;
        b=evyqKc46e0e27fwP/OBf22xktDIrfkJhYz3mIxqdQ3oeMkQrERXln2AkExwJ1qAT6N
         OB9qkBiX6wJqfrRcw85JuLcluUw04YO1g5cS0odf1pN8cZjAVK3P/SimLNj5MaCu4TUq
         +e6yYxwx0rWFzjsU+7UWlgSP0wWV6Xp5yzryFf+VPLHIlkgctSA932x+5KEw4ArCz+HB
         E5KQiJYEHftWXGFb+1ZwxUIptQwk3e4JkHLkRz2IOpSN1ZcxbQ7E7XkA9jwYVPi1BmxN
         9vCm1mgZonKgekcIy0iM5xYgRfnysTeRJhUu5QadwwffX7ZHWZMSlqHiwrS5Xlz1uczf
         cc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=1FvNEKtS8XUFhNrzpNnVepQzKVjJRHhKmZb07KcMWQ4=;
        b=hbuSznJXfbXoc40zZ+TFEHVRtK+l0DYXq6vj4z2A6xYevsX7mxcdnyPI/j2vsah6cG
         5lmZTQpqLmy4NHYHUxpdgIs35a3VSQBuQu2nxNfTTBHxps0Ecr6s+vyYtbvsedUGhr7p
         42YILJ0YkrskHPxoooHYr1V1k1Fve8BpC9twVAiw+TxmOgNEVasuekJMxNyericNWr8g
         eOzdYDhQJ3HNhN2moVcFYvGqw0LiZjyddrpAXlZiWInf8p4RkGowxob/q1Up1BsyKmXG
         gZxHsJpAbA/MFhBGXxxfYK8ZxSc6gvcp2+Wm09r3zxhqdmlMm10uAEhvNu2GUvzGWSux
         fEbw==
X-Gm-Message-State: APjAAAWhSiueWdzyWlT629Vz84rDbeS57a+/ljgHb0PlAPPCxdjz3TAi
        +4Cl9rqf07qV6uLK3z3EAac=
X-Google-Smtp-Source: APXvYqx8ZTbgTOcgcyF2LRPrV7Qrhotc/vxtv3JH5VVV/Vaix7qtZmMjXtf1ZWB8FF9DXYv/IFYdQw==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr40349946wmf.115.1563435215103;
        Thu, 18 Jul 2019 00:33:35 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id w67sm30063251wma.24.2019.07.18.00.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 00:33:34 -0700 (PDT)
Message-ID: <5d3020ce.1c69fb81.8d330.add5@mx.google.com>
Date:   Thu, 18 Jul 2019 00:33:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.185-41-g15ef347732a9
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/40] 4.4.186-stable review
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

stable-rc/linux-4.4.y boot: 98 boots: 2 failed, 96 passed (v4.4.185-41-g15e=
f347732a9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.185-41-g15ef347732a9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.185-41-g15ef347732a9/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.185-41-g15ef347732a9
Git Commit: 15ef347732a9cb126d0626155a1b1fc1dc15545e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 45 unique boards, 20 SoC families, 14 builds out of 190

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            stih410-b2120: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

---
For more info write to <info@kernelci.org>
