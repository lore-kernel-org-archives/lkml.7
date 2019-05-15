Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C459CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E0F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="rtvw+piJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfEOPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:07:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35460 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfEOPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:07:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so3108298wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=gHYB+5pDwnOyiAAZ8gR6hokFzxBIAqvius/f3TazRDo=;
        b=rtvw+piJgBZ+VQce8TUgJcs9ILayFb7DEerxYEdFboU3Q4SCYeX62hHUNsww7wV22y
         60OB4mR4rcvcbDSmQpumN1o/3pFm3R0ugCbTHShMn0fKWcpXByGYZQkDYzfF54Fwkt6y
         B1DPYOUOQ9EHxABZL/3r3JnHJnMPc6RhG5E3vIugiEfeiJ5Co5kKVqsTEaiZEhgqCqRC
         xp9P33zNGPxoggxwK/I11ueXVaX8fkpSDhbjgJqeT3/zV/s5nymkNBzfqpTfti2BpLTr
         jSDuc+6zIaqX0eFzBCH3LsYRGeIRJVRC0OHZJxBharhIU6nv4Q1da/XWj6dADdiahb5m
         QjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=gHYB+5pDwnOyiAAZ8gR6hokFzxBIAqvius/f3TazRDo=;
        b=SFuJxtNZ1O/ltMoummcyr2wHORS/tPussc7OUrwuXjGfUmGoQw5VQm0dP/RxUCahh2
         OAy2xV+hHmn6pV5j7YRaEcYi3RHME687SBcDjoOoDxU5RiqroOgjbesOlZ6zVb/Ai3ag
         wQebRR4jSauT2lapvvHpQBeHYTAlMB4KeKmuBsnKjgvO82Yod8E8jH8HpePlksp3biqq
         t8Vp3XDukYwxSdCc2uF6k/CJwdXE8SK6zXSZoBOfcfSUAqY6F++1vBIElzGOXVGlv4WN
         D9YTED1Jg/QNbV/7Mk4iNmSELM1F7DI1cMVevtkwJ9kt5hRuDeVfHWHPjCFk1/5ypAd3
         lhSA==
X-Gm-Message-State: APjAAAWRAWGiexqpzibed9NCpPfAqCWvj6DoD3aNZP5jZMZImED8A5T1
        0TTUhRwoRuX9KgAf3edSb5yKXQ==
X-Google-Smtp-Source: APXvYqytro1vMKf0qcBOWJwc/JgLJx28fV2ruZABGu/ErmvIofUDUh/ubLjlc0JbHJ/lIKyJ3x9qlA==
X-Received: by 2002:adf:e404:: with SMTP id g4mr25616164wrm.161.1557932866428;
        Wed, 15 May 2019 08:07:46 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g2sm3115050wru.37.2019.05.15.08.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 08:07:46 -0700 (PDT)
Message-ID: <5cdc2b42.1c69fb81.5639.2219@mx.google.com>
Date:   Wed, 15 May 2019 08:07:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.43-114-gb5001f5eab58
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/113] 4.19.44-stable review
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

stable-rc/linux-4.19.y boot: 131 boots: 0 failed, 129 passed with 1 offline=
, 1 conflict (v4.19.43-114-gb5001f5eab58)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.43-114-gb5001f5eab58/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.43-114-gb5001f5eab58/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.43-114-gb5001f5eab58
Git Commit: b5001f5eab58fc1a2a3d5dfc90fa9bb513c73d8a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 68 unique boards, 23 SoC families, 14 builds out of 206

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: failing since 1 day (last pass: v4.19.43 - firs=
t fail: v4.19.43-87-gc209b8bd5e5e)

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    multi_v7_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
