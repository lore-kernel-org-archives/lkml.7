Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF6C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57AE20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ZZShjwaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfGHTco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:32:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41386 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732184AbfGHTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:32:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so18380346wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=bSvLMIBH1Y48taxCRuzAlDFjKHedGJ0Sa5daCvwKPv4=;
        b=ZZShjwawqNcOFaRonOmRRLizGBPfmqAkwYAHP4tPYFEa5dYzmTQv5Lhf2wm3h9cRJr
         kyW93jrFbamkOfXYcR8IjfCLhgxDfQA5K+n40zzXlcBaEa7/4OL5ldfan0l6Yll9Rr9N
         jpkIUeQ2wTHQGGV1oAW6kqVbMEsnVf5UZYZ0C+qqSZ+ZwyAkP3KpRnU6lGD5WL61ju76
         4QAM9neVhyeAnMg9eW1yiQjgnQRnBwZsVE10aRQNB2S2iVbotKTWq2giwW9V4aYPybRq
         snJx0B+ejRmi2pMVIJMQz5gxRAr1gkA1fmf0Bwbu9S6o7a8FLyWAFZX4wkoW/OLY9rN+
         laAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=bSvLMIBH1Y48taxCRuzAlDFjKHedGJ0Sa5daCvwKPv4=;
        b=aeuN6J55vLbi8KpMlvIFsnYeDCNbxr+62N1RNRx037dYrFSfqcJN7Ry4NDe76Nrm7u
         x4zB0bkKO/Gctfr+UAxgHDcu5LMbbfDgxbSWpSG/So1Myn8h/wSTjHFtLyDZZT5Jevj4
         3szut7QwGxvMh8ywG7Kh5+HX1EPDEyjn2EnvcmV6C8rASlt1FSx79g/7BDk0O0O51m1K
         dEQ6hrhnPyXF5VsrSpOqw7O2S8EGQBNjwJc1MTFnRJa8aVfkj/5g4ucvbxXeqqElDECC
         Zw3X/vWa+Gn6+WaXeK4mlE8u0lrztn6nhSXXRQj04PvtoOvp/S+iw262YRr1JnKb1ZsC
         bZZA==
X-Gm-Message-State: APjAAAVLZVAbolgsBtvLojYge7uIfGs/KMpnYfBTY1Lplgz9L0fLeh5N
        BHLglF2CxGszxltpgVZavNIR/g==
X-Google-Smtp-Source: APXvYqwobqcDil536iNWNeDGRiLAKMqFH8KKTphU0ql69Kq7ZH5Ojs4VGy58/q5E45HCaO9K2ntM0Q==
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr503900wrw.354.1562614362238;
        Mon, 08 Jul 2019 12:32:42 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id n3sm9778959wrt.31.2019.07.08.12.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:32:41 -0700 (PDT)
Message-ID: <5d239a59.1c69fb81.cf265.76e7@mx.google.com>
Date:   Mon, 08 Jul 2019 12:32:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.132-57-gb33dcbc2d8e5
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
References: <20190708150514.376317156@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/56] 4.14.133-stable review
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

stable-rc/linux-4.14.y boot: 105 boots: 3 failed, 101 passed with 1 untried=
/unknown (v4.14.132-57-gb33dcbc2d8e5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.132-57-gb33dcbc2d8e5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.132-57-gb33dcbc2d8e5/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.132-57-gb33dcbc2d8e5
Git Commit: b33dcbc2d8e56734ead69d9d6808090159b19dab
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 61 unique boards, 24 SoC families, 15 builds out of 201

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            rk3399-firefly: 1 failed lab

---
For more info write to <info@kernelci.org>
