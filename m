Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1686C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8C92339D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="n+ysQQ0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfIEDiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 23:38:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35543 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfIEDiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:38:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so1001711wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=wdCg0HhXFQYvWf13Dpr72Lu3ccPJEKe2R3YxRA7hBqY=;
        b=n+ysQQ0ql4O0chfy4kZk9Da6I0w7UoCSRGqcqyGWY8Myxm9MXkhkwnnyqzNSQYoeEQ
         yLaXwt1tCTXJonO1of007Ivz1EVjnrYAp6EBhEIJBFZRWTQ8DByE1s02U9vf17SHk/vS
         Hsf/qBpVkY7nw6/JURvnXF7JrcHT6YBk9ddET03EZJ3g/TcrEKBRjt0ZWIftXM/A2f84
         BTUAiMhmzpdC7IUq3jTKPUJZAeTWhZjGBEc69p8fGsz5Z/ymhM9ElE6MgG1zuv9kiET9
         J/u5LGc9X76jQxSOwUTVsjRUkrDegnRtFmIVIPjKD39UzT9yVnpKPPtXC8b56fyXQumQ
         mZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=wdCg0HhXFQYvWf13Dpr72Lu3ccPJEKe2R3YxRA7hBqY=;
        b=VIgHG0vyX4JapB7345+oQsDoQVtXT/cRywUl3hD7JpAOZj/6iern3zBw6Tn6EGNK1S
         lQ62oRsH3dHA2lmKDD1YkLKahpXXopSQr/9YeaPRjXiGe/9xiBrJ3M3aKycGgZvWFk/o
         slibmgfXnYn/YdDofIWtmpSHS65A9gckK9aGuX5xvoSLCXys0z8m25v6LcBJEsxyi9XM
         5e1NttY5DCDAeGjJ2XIGyArZ1nkpromvcxCKjCyQrbL4WAKJtM2ZqaD94OBOBFP+VJNk
         /141GZPtO7I7UOyqQCHkYFteaoUC/Di8xTyb5Aax1I5CZRgRT4ViiRge9O/bwH/MOmxp
         lcsg==
X-Gm-Message-State: APjAAAUXu44OWfh1El/w9C8aaPQq7t7H2U+tFNYglqJpPi1QDQeOG6ww
        IufZZpShU99ot8PXdrI4CAncKw==
X-Google-Smtp-Source: APXvYqzvwjsuvb2kXjaTeS6BH4MGGz2oMCftqg+t0boL0rswWC69btc2F35rouFLoAbn8bR2gQYbLg==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr1025395wmj.175.1567654694301;
        Wed, 04 Sep 2019 20:38:14 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u10sm870926wmm.43.2019.09.04.20.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 20:38:13 -0700 (PDT)
Message-ID: <5d708325.1c69fb81.61f62.3c3d@mx.google.com>
Date:   Wed, 04 Sep 2019 20:38:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.190-84-ga232f5b3e312
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/83] 4.9.191-stable review
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

stable-rc/linux-4.9.y boot: 129 boots: 6 failed, 114 passed with 8 offline,=
 1 untried/unknown (v4.9.190-84-ga232f5b3e312)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.190-84-ga232f5b3e312/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.190-84-ga232f5b3e312/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.190-84-ga232f5b3e312
Git Commit: a232f5b3e31224799f7506f9e9d4257d3d357d1b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 57 unique boards, 22 SoC families, 15 builds out of 197

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            stih410-b2120: 1 failed lab

    vexpress_defconfig:
        gcc-8:
            qemu_arm-virt-gicv3: 5 failed labs

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

---
For more info write to <info@kernelci.org>
