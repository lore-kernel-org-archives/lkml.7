Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F47C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0659214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="vR1vjiSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfH1Bhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:37:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfH1Bhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:37:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so692292wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=q1/Ofde3eheBbpcLir1coN0/ebDNsE0zXOWBvpHEjoc=;
        b=vR1vjiSpPZW3JK12HEFirAYTniqoi1mK2LGqy1PpfTvduc+Kkzvqyh0isFzQXQOXvo
         M4+RlXD0or/R9nA6bwnjVW9ASbO9VLA7kMyEf+POqo2mlAG1sdz8sXuyQYU+CqJ9p5Y/
         muDGCrbgEbOstsBLOwlUyYC3mBbQHbbJQ3zqIXEGrYeFVxfYzs6MDQ5NTLbBG9FK/VXo
         CU3bEnBrxXhaIejcNDuHNCgkqrBLzWNkEpOY8RNGZzkHxCEqep6Of4IlxtjFn2QQrts+
         1TffnfOTqHF11BXPlRLIcXCaS1i6vNmuUSfn3Z2Q26rynFegtE/hW81g7LhY6FjUhAAl
         TTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=q1/Ofde3eheBbpcLir1coN0/ebDNsE0zXOWBvpHEjoc=;
        b=gtgRWqS7gbdpEU7Xc/R8eDS7HsvNnG5/n5i5Txmq4DJcfET7vgoXBK//Lh8fGZFpvY
         VygCHpi72myjNTWu8vc83uKBarOTevrAYLyrMPgcDW8ahGY6G8IjmS3tF/PkAZWVGRAW
         2AYbZ1pqe/oGHDR/xVyKzwiYU43KrDKJ3s5r8LoKi7XCv4gETLFBIV7+N2jLkHX70xIj
         LX/oCqWybv5rcbYIbi07OswF5JU5if+1S0SKJwAZOSQWT/OcET+G4u/nGoNUVopfrVxC
         4fYC5K+ANMNVCaOD+w9sYOLt32A8yftxGJost+FsTNL73R3JQ9W/Yiv/kVO4hZn9r1GA
         FwTA==
X-Gm-Message-State: APjAAAVe3qmgSiGo0kVeTwI3LieFMYv4yBjx0bBViDYE3xKINg+9SA3w
        lM2CtotLcKjy/p+Rr8Ja0mrGww==
X-Google-Smtp-Source: APXvYqzOcrkTop8niK2BOhZlj58NIXhE/aazQQJ0kmq+Yu7VCSQCGE5B2qpAF5K5+PPUrOnSA3vUgQ==
X-Received: by 2002:adf:f54a:: with SMTP id j10mr1049430wrp.220.1566956250672;
        Tue, 27 Aug 2019 18:37:30 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c21sm648819wml.48.2019.08.27.18.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 18:37:30 -0700 (PDT)
Message-ID: <5d65dada.1c69fb81.3bc78.3732@mx.google.com>
Date:   Tue, 27 Aug 2019 18:37:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.68-99-ge944704d5a79
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/98] 4.19.69-stable review
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

stable-rc/linux-4.19.y boot: 133 boots: 2 failed, 122 passed with 9 offline=
 (v4.19.68-99-ge944704d5a79)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.68-99-ge944704d5a79/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.68-99-ge944704d5a79/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.68-99-ge944704d5a79
Git Commit: e944704d5a79f6d6506a872edebd16e2b93cb349
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 73 unique boards, 25 SoC families, 15 builds out of 206

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-nexbox-a95x: 1 failed lab

arm:
    sama5_defconfig:
        gcc-8:
            at91-sama5d4_xplained: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

---
For more info write to <info@kernelci.org>
