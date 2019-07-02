Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E055C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86FC21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="UDQaw2pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGBOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:32:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55305 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfGBOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:32:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so1066074wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=hghNClm75/4KZJdIxJf4/GmQX4sIhC6S5l42nPPIEdY=;
        b=UDQaw2pC9Yvpb5EmLZHdi4Vk9UmEj7TaX9z2sRU0D3m1XI+adn4AaE7othU/fr/irf
         pVb1uAbu17oRwmwQvn7vFmAoEDKS5CVLn93PyV1BtGJxzWuH4BIlLLLPjVmUjfUCfnfZ
         ktO1hNTF2M7xK137+EX4blHLUg9jG5UiEgpVBTqZZ8oGG/0A7e/KmtZcdNd0fDOpVbDK
         pGOvc0JN03N7vgOJVDqH/SFbkwUFlXQcOz5fZGZX6gfrZf39Pt5fBuXkfg3r2wBLPKAC
         +mFDEDXumr36cxumNtRUHZmi/dgRWRBx7fvGYuzN3ewsuW0cBRORx2pQdTNtI77lvEa6
         WNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=hghNClm75/4KZJdIxJf4/GmQX4sIhC6S5l42nPPIEdY=;
        b=Gd5Z1wHx1U0QEMjGJ+YHwBGl16mxK+06Emul2ZLOJJoNAZkUaT5uPZmulI3pxJbOWE
         7yniFQuvvQ7V6KtjWPJIw3Pag23176seZPWAOt135EXLaJWoqgVkpLyQnM3aIMHF842z
         SgMim05skgm2SzG7EuRxmExbKF30KUuCx/mWGQFNQbnxndMmbQCtXxhRigRJ5Uu0jAL7
         tGIDGg6ccyeJoInKJaA16t12lSnhoyIdPMbaW1iv6UXlDYFJxTHV6A6MjvAd7Bju0gIf
         cVOhK+b2jjUks4ioOSLIO5FV1XAKSj6pkhJLIAXtaHD0dX1QEVLLfbGDCm4BNfHm6XDB
         WkDA==
X-Gm-Message-State: APjAAAWdC18GL+oWqckJh0FGOPHdx9cSx2l+ph2zoWRlSCoQFje/Yn8k
        91xIhik0AGD9rfL0gC2+bW+3Pg==
X-Google-Smtp-Source: APXvYqxrmuHjs14f/iLRZFoH+LaZHidltMqWmA8xOe3Xd9IOraAZ13IzBAHkuCLhrTgEIZApovcEww==
X-Received: by 2002:a05:600c:303:: with SMTP id q3mr3801577wmd.130.1562077928722;
        Tue, 02 Jul 2019 07:32:08 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g131sm1779291wmf.37.2019.07.02.07.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:32:08 -0700 (PDT)
Message-ID: <5d1b6ae8.1c69fb81.7c837.a037@mx.google.com>
Date:   Tue, 02 Jul 2019 07:32:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.1.15-56-gbe6a5acaf4fb
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
Subject: Re: [PATCH 5.1 00/55] 5.1.16-stable review
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

stable-rc/linux-5.1.y boot: 135 boots: 4 failed, 131 passed (v5.1.15-56-gbe=
6a5acaf4fb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.15-56-gbe6a5acaf4fb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.15-56-gbe6a5acaf4fb/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.15-56-gbe6a5acaf4fb
Git Commit: be6a5acaf4fb84829cc456c77af78ef981fb6db2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 26 SoC families, 16 builds out of 209

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab
            stih410-b2120: 1 failed lab
            sun7i-a20-bananapi: 1 failed lab

---
For more info write to <info@kernelci.org>
