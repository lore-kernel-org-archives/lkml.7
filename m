Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FA9206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="uP2ingZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbfIMUTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:19:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38805 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:19:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so33221326wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=1EXHYqWuYUZbZDvA/e1+2lxe1TJHgdaE/HYVLCwEBwc=;
        b=uP2ingZw4+Nn8mHiZ1OS+P5vkQjApkaRTqfOmwPR7DqQ12RbM+ZWQJ5TGxmOYMwe4B
         jQDSwobodZ5P8dJdRs3a6cvxg0DjQG09yveBayjwna9TRvxfSIakuHNi7gpOC/yaNXFY
         EIcX95Uce1OAcjAAkgdQj5N72iE/nlaSetxRJ3dkD4y2R7RjMwCzfZkH9xyUM/rTCvuc
         vJnrMrS6g1qXyquYC9vO+zUhfwQWjk9Hq+ceGllNLo1irnhpZ9p/OJjhZAS9RB9YSvxd
         k2f+Jqw1ssVX9pP4sReDkSIORNwapU5K+dGHsGe4urMdhnFya95JhhOgB40dxK5qhkQx
         aKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=1EXHYqWuYUZbZDvA/e1+2lxe1TJHgdaE/HYVLCwEBwc=;
        b=GE8ZqEq9DJGs5wBLSxT2yw7qXNnZjIJQKrxQptwxUPYFxZnLLYr+Ykuqi5y/CFK26S
         AMSqU/cnfNADyuwkzeYgovqSWn4NwnKPzHpJLlTx3x9F46Nv6fBkwK8SHu7oocXeb/st
         bV7MnoFI9icPty60s92hjZJpyD/yhhD6hOEqHhZ6z/ZI21QWSnKFozo43fIXmjxtc1Vt
         Lxdi3WJeCL0uc7B+vrp0kin2Hxt+uyyFxRLvFI7vMAgRClaClj9nyfyscu6eElKhjjoE
         fziucqJtByONIS23mvFtojFY3vPRbaLKuYCRCyIzIgsSiGseDTUV2O028rh38haIv6A9
         pyQg==
X-Gm-Message-State: APjAAAVLKEac4iNDPXnlwCmFF/BArq6wM8Tl3u7wWFOy2ZIucLGiT3X4
        k1vEdnvJaTpeyQlyGoORTXm+mA==
X-Google-Smtp-Source: APXvYqwWcE2RLum3BzRhMB26Ykpq9P1ru36qoHUfErGfACNlntG5JKw9iQuA6TYG3zMJNZ+ejhyriQ==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr42751074wrq.305.1568405946772;
        Fri, 13 Sep 2019 13:19:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s12sm42231261wra.82.2019.09.13.13.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 13:19:05 -0700 (PDT)
Message-ID: <5d7bf9b9.1c69fb81.96e74.f21a@mx.google.com>
Date:   Fri, 13 Sep 2019 13:19:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.192-15-g8e25fc1750f0
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190913130440.264749443@linuxfoundation.org>
References: <20190913130440.264749443@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/14] 4.9.193-stable review
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

stable-rc/linux-4.9.y boot: 115 boots: 0 failed, 105 passed with 10 offline=
 (v4.9.192-15-g8e25fc1750f0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.192-15-g8e25fc1750f0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.192-15-g8e25fc1750f0/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.192-15-g8e25fc1750f0
Git Commit: 8e25fc1750f0dd9f378c153ecda509a578059b81
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 55 unique boards, 22 SoC families, 14 builds out of 196

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
