Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF0C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234FC2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="gWizblmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfGSRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:33:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43321 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfGSRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:33:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so32988048wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=HbloDMykWMJg5GWsUcNK25kqerTy7WxyP9EHxQarjPs=;
        b=gWizblmL23dyxIJrDU2S1luD8/q15UC2IJn/daoCe7PKjKWeGd+qZ3eNMs2VpZ9YRD
         3k70M2KsRar2E/031dA2DkYZjI/u7NZrjJIUn8cl0+ngMFaPwvCRM28rqqLp7Dyz6rpX
         uhsdEa7xtZbCtHt3c8m0amqze0KO/K5gwScZtu9r2s6EH4jC8OCQtQpzyEgYrYaxva2f
         FN0c9Hlot72MHWtvm4OBBCd6uYXVxKmktONctbZ6v6Ov6pn7AjIrITj6FowXJvc/8IxP
         DSJaRs+Knxx+JM2c4DoYypwz14OzzuIHB06bpOBU+Xz759to22l2CcwdvAN1vfRbj4aW
         UMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=HbloDMykWMJg5GWsUcNK25kqerTy7WxyP9EHxQarjPs=;
        b=lUXNz0RamI2/6O+12Yy+eklVwU5yjlPz5DAMEq2LiUuIlMlm6kcx7VGTc/e/TZBjB1
         f8jgC2QQXlpXabwF2bPa49N0AEZNG5Z+wDUiDMwYEfUHB01/k3AbnWXsmTODQ/bnXgMX
         Q8XCKjGfloWqXjE231Qf7mjfnPORjJ/0GZy5B/hCv0dliNIqIXprOgfvBwmVvh64+Ezq
         mQWBSuqDJ/CmT0OjqsbPj7g5LW02e5X/9Lf++0euGvKnI/uucAnHuzkwXZIx2NsOVAvb
         rjrAGoEj1ceimKutf03BgCLciJ0RU5AV3xLttMt3QAGmKQeGU2UzzEwosKZq9wBXhhPZ
         MsPA==
X-Gm-Message-State: APjAAAWsJd928RaMY3P8b16pjdFQQICETzV21nQr8AmmaWvXuMdyWl39
        dx2q8hthI5ru7Iy/ALTDUfU=
X-Google-Smtp-Source: APXvYqxoph5fTI1ze7NTeFMAAYg7yjt+hFgRrLUFwNaNqoIEGp+nr/9O2bd2g9W42Oz5ZRw93V9WNA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr14182061wrn.257.1563557627008;
        Fri, 19 Jul 2019 10:33:47 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id i66sm51673313wmi.11.2019.07.19.10.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:33:46 -0700 (PDT)
Message-ID: <5d31fefa.1c69fb81.a5d88.8efb@mx.google.com>
Date:   Fri, 19 Jul 2019 10:33:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.1-22-gcc78552c7d92
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190718030030.456918453@linuxfoundation.org>
References: <20190718030030.456918453@linuxfoundation.org>
Subject: Re: [PATCH 5.2 00/21] 5.2.2-stable review
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

stable-rc/linux-5.2.y boot: 135 boots: 0 failed, 134 passed with 1 offline =
(v5.2.1-22-gcc78552c7d92)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.1-22-gcc78552c7d92/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.1-22-gcc78552c7d92/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.1-22-gcc78552c7d92
Git Commit: cc78552c7d92a2d16d8fba672a91499028fca830
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 78 unique boards, 28 SoC families, 17 builds out of 209

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
