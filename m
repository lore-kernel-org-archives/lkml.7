Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C96C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989D52086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="miFo+VU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfJCWlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 18:41:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55311 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfJCWlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:41:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so3643150wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=uOVd3X/wZgzEB6V0Fr+tNeKdOcBOeAY72FFGJ1MiF4Y=;
        b=miFo+VU06QptyI4rqV6HRgzo8qhNbjtt3w1wdJpypaw72rZHGNGN5xbRbWP0WnVDK2
         m5/OlacpBkE4cZLHtmmYSnP3Rz8QsTFmJxNHMufHMmHkShOS7bpEPwxZ6FkggAydKiyp
         cfHRlg+KXP/v1DXhQryS+6L5odYaCVN6E0APfRzNxr7DNUP79pIiCeu7QfbQIBODDsgR
         Aokw80zgJ7g6rr/UNJ1rBqLT5w3cajm1vP2Jze4vW3OIB2+HZiHwL4sv06QqGOgmZa18
         24cxI0UQjecr1PzeQBPofF41AWfHc8XcDd+nfStc9ZJRpd6Vt4Q7ghbCFkeGBSkKpZ4P
         KEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=uOVd3X/wZgzEB6V0Fr+tNeKdOcBOeAY72FFGJ1MiF4Y=;
        b=kH3cJxx686oKf7vaeQ7m+Dsi38TLBMNKI1YNHyZJdRCX/Q2ExnNkIrnPRV03xquSNF
         iZY+b6uqsu9a2tMWeA4IM460egHEoYdbXhHcD3/8ceoy6WE8+qfYgXOanTCI+0N9otB6
         mf2Y5UUxFFVkw9ZpUoSJYN95JUmlwEltUSE6/z6O5gmp++us4BjLts9UDYtX3YWCCNet
         dvBx9BGzClHuCQoxOXrZrAc92+F4l8ndbIEmZxM+oRlP4W+BzTaLUAvxlP1nQ3BLIt2p
         J5BaRgopYDe+dpuONyx4yvjFIvO15O27qplOssbJ10bXtjd7CO3/Y0q74wlt0e4qwRCe
         1lVA==
X-Gm-Message-State: APjAAAVedsi4rrFBltjV4vDcTrIMOgbR51NjcUW2F9v8XDDn4bSK7sVw
        LtfCUXT6vq16HQXfqd9FhnXrsRjnBzLWOw==
X-Google-Smtp-Source: APXvYqyuJkmfu0KDfIG92lUKyRQZ/+be4GBXFc3rX0H85L9SpU3eg379pZCpZHPrMz/oGNZvjlcpSA==
X-Received: by 2002:a1c:454:: with SMTP id 81mr8233401wme.119.1570142458337;
        Thu, 03 Oct 2019 15:40:58 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 94sm7428514wrk.92.2019.10.03.15.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 15:40:57 -0700 (PDT)
Message-ID: <5d9678f9.1c69fb81.af96f.47ab@mx.google.com>
Date:   Thu, 03 Oct 2019 15:40:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.76-212-g319532606385
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/211] 4.19.77-stable review
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

stable-rc/linux-4.19.y boot: 124 boots: 0 failed, 115 passed with 9 offline=
 (v4.19.76-212-g319532606385)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.76-212-g319532606385/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.76-212-g319532606385/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.76-212-g319532606385
Git Commit: 319532606385c7221dfbfba6f857bd03e97e20d0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 71 unique boards, 24 SoC families, 14 builds out of 206

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
