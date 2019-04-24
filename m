Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376320811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ysIVUGqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfDXVpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:45:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45499 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbfDXVpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:45:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so27130329wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=YXfb7/x46GwVe34W3JSpQn/ItDTlnSQexlC8/AGXnEM=;
        b=ysIVUGqbq6R4R6oYQ51AUsWYMYYPCxtZ5kZwTanvTSWFj17wdzUc5wD8DPRd+I9P1h
         iRsqmuZmXqoE/r/l1UukCJAHd6aGOF4T/sFsu19l0VM3yOhBLjO/oMmOYVkVDoNPw4RX
         TDZrqb/Z+/8igr92fgvITb4hnyO+ZcTb5FMN8K5pwK2+sBDVbSqCW4LttFweEwOHFvSZ
         d98sHHPvJi4v2Y3QioGwjmTZs7H+sgUm27YsOYboii8DP8/QHKJfjOxwo1o5jkeQg7dW
         mIj4UPpwFRYJc/luoA8dEUKIM3PU58tPKJPBowpHhhaxyqM2eyq2cAfGu59GlkWM4my/
         q5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=YXfb7/x46GwVe34W3JSpQn/ItDTlnSQexlC8/AGXnEM=;
        b=QZ8cboYIq81CcNrHvWkBN+T45PTkS7cjLlyJUuteZSJjNwnFn3nDVlSU1TiGi3NoEv
         S7t9i388fN2Wtk6j3oEz94mUV1/ed+n/S/Y1Yb6Qy+IfgfaEKBw4KIUojrR5SqgOFBLp
         ogiWJY+vyxPSOk/2nh1iK8V35QIq4wIYI6wPBQmQaOHdLbCfMhTe7K4mTOuT8hCKgUpW
         16dTQpuTNgz9CaYPuazhtj0WOvSSPsLr4mSWnYehEJZbMM/q8ztLI0z7LilnauN+J5n5
         7bPtgtrDJZGny0DivWtJXfeV231fkOrqxiGOyfRx6c+wTXMGLZTInl5sxexeJGQlwb+B
         Rd4g==
X-Gm-Message-State: APjAAAXyf8vYKk5wic5b72qXkEFnTIO5/cLaFXcRsusexIk1U/Frrt/d
        mUBOZ6gGw59gMl9oqdF1qemBtQ==
X-Google-Smtp-Source: APXvYqxNoK2eEf6CzgQZLG4E0DrDCpVHmL3FIff5zepdff5c823IHWTLE0mvb1hkdufzeOMH+E8FFQ==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr4076712wrx.314.1556142349326;
        Wed, 24 Apr 2019 14:45:49 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id q202sm5464346wme.9.2019.04.24.14.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:45:48 -0700 (PDT)
Message-ID: <5cc0d90c.1c69fb81.e38ee.fe07@mx.google.com>
Date:   Wed, 24 Apr 2019 14:45:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v3.18.138-105-g84a721a30d55
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
Subject: Re: [PATCH 3.18 000/104] 3.18.139-stable review
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

stable-rc/linux-3.18.y boot: 47 boots: 1 failed, 44 passed with 2 offline (=
v3.18.138-105-g84a721a30d55)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.138-105-g84a721a30d55/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.138-105-g84a721a30d55/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.138-105-g84a721a30d55
Git Commit: 84a721a30d5546bc805cdbd24c4065a20d883de8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 22 unique boards, 12 SoC families, 13 builds out of 189

Boot Failure Detected:

x86_64:

    x86_64_defconfig:
        gcc-7:
            minnowboard-turbot-E3826: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

---
For more info write to <info@kernelci.org>
