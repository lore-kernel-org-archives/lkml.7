Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09838C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ABA21851
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="wvwSNP7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfGXXeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:34:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38701 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbfGXXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:34:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so48704575wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=gJesdbZbbF3sI0aCILTJoTvpe7qNeUt3yyP5yfvb9A8=;
        b=wvwSNP7N1qONlRZmeQLBdvc6hHpKfdFRTRbDuKX/tLt5MZyQP+UArDZZAbhBrm5hi/
         g6pPi6uMS8njINXsko9cPIQ0CqQX17nN7okDCUFCBLVo7kCsJl4Go4E0UPkD5TuYUfm7
         ZHjDyRJEm51mTDJHgu9DImQL1+P3u8KlXxZ50+jozZLaAh9lYrH8Rfw/Y4fEuY6C/Fya
         A2N32VO8ojHo5tQswIPwaFQkj9CgfaemSBFHxuTJMUViaNP8zUu2GwFEU28JP7q748+z
         eFJpofCGFCLy5dy5d3gXoKoTOTEVEHNlNyJyuqlX5GI1Nb1KPfaX96ugaoanSvST2Ez1
         setQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=gJesdbZbbF3sI0aCILTJoTvpe7qNeUt3yyP5yfvb9A8=;
        b=g8zombaxsOaruMBdWg/OP7XzNez9f2NphXWYq3puzOyKzpva4iFdUm0UUTwNGWUWAa
         Xs5/c9ODUpuckYqqKsNJrLpJNMAcWsLyqw1I2bG7tZWPPsR2D+dTXpVin7F36RJ3+Bqu
         4/MEhKPKopGMleSfludTd53Zhbe2nV+7RWPUx/Ta4lm5vbYe1m4wYx+SDSIIbQ/0EULC
         DVhxuqUIqzunkdd9SCxUShVRaPacye5NqItemEl1+CW/LEal02jCtAzm0y8Ee8Iv17uq
         Cmfl0KImL23irDa7ukc0mgu/31C3yzy2j4N9Cxw9CMSmpqSyD00YXYH6Te5x4r3n7bKU
         /MqQ==
X-Gm-Message-State: APjAAAXcB8ai+KgzZAUZVYSqNsI9/G2lo2WmITWo+jpy38XRk3fGEMWA
        9GI4vM5MKdAA0sOhyP55l7E=
X-Google-Smtp-Source: APXvYqwbu/1onZwQ2Smw+4QpNUT8HGel/X/7kSj1fzh1T6toHjGecjxKxhAC8wreUB59uHJiXbT28Q==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr49218393wrn.269.1564011251851;
        Wed, 24 Jul 2019 16:34:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t140sm43179218wmt.0.2019.07.24.16.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 16:34:11 -0700 (PDT)
Message-ID: <5d38eaf3.1c69fb81.f02b8.079f@mx.google.com>
Date:   Wed, 24 Jul 2019 16:34:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.1.19-372-g7da17d99564d
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.1.y
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
Subject: Re: [PATCH 5.1 000/371] 5.1.20-stable review
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

stable-rc/linux-5.1.y boot: 137 boots: 2 failed, 134 passed with 1 offline =
(v5.1.19-372-g7da17d99564d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.19-372-g7da17d99564d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.19-372-g7da17d99564d/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.19-372-g7da17d99564d
Git Commit: 7da17d99564d84f797e66a578ec5fb34f43fa58f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 79 unique boards, 27 SoC families, 17 builds out of 209

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-nexbox-a95x: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
