Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB5C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A34920679
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Xv7G/IV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfFIWaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 18:30:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfFIWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 18:30:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so7229691wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=VbwrAx1UuhYUk33Eb6Nh7Ho50cD83TFR3BNTlq7pRds=;
        b=Xv7G/IV3EOLxpvGYFNodCktudkRopSI5EOZgt7FkFUy2H13fWaCDi7JZ4iBiSjdNdr
         Br+oQEBapIqJrTdR0in2ZsAZaSiwzG3FOB1Ecs8//ZBKm6vG9sjCi/4as5JyxcLFBoMx
         3RnNUDNvQwWRBy45VM5xDl9z8jgoYL0FaOZOnmTrgfBiKygKSkYNUrzgJH70Rsat8OiF
         SE5XF7dwHA1/3mh1qbOIDnqXrN8vl5wjO2KEXwPHJzIoOcWvGfBSZ4jkrGkV+75EZ1De
         BTB54sTiEgmrmRC6PEltVplR7pIfFOj0b3XrWkXypllPgfxCwiq0VFrAiou7wdV6xSEg
         13ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=VbwrAx1UuhYUk33Eb6Nh7Ho50cD83TFR3BNTlq7pRds=;
        b=AjlG7kT5aDK5o7HsRrcAtrYLAps6eTHrZ/15EWCcRSEw1mQHuoPF+Y6923R4ilfGMc
         JqeSM2aAF8y8PSNgLDF367MMl/+QIzpzi/i8WZQSiZxparkb4k9lu8TlPvbSaVqEeuC4
         ECv8mVeUU35isGjZxO5j7IefKC39dd60Z/U8NtzQViRuPCPsqo1bhIrS2x6E8CK0rZCR
         LktpFP8pIGdQLPoJT0y1/PD3y9+JoP3EEyWJZnJ10qouh+J3sZ4qeVXFnjQ+ey8+DR4y
         +viEovU5XizI3KQAXi23bl+43IDIE8o30C78fz6pZfkBhym/9EWmy8GF9oGfLSU09sJ1
         EQFA==
X-Gm-Message-State: APjAAAXX3IKShLCWZl+wrOFtrb6HQ5ilSCdpIT38MREmNaGaVhazcUK0
        xaHpV+uLr9Jol1cJMfsMNzhXYT3qrJo=
X-Google-Smtp-Source: APXvYqxnDohVWMWpdwiz6rnPyllv0BfV0QvQ5Es7z3p0OgxWoRq7LCubNLGPO52u5he+3Yqe6M45Mw==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr2968719wrx.182.1560119414287;
        Sun, 09 Jun 2019 15:30:14 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 32sm22129828wra.35.2019.06.09.15.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 15:30:13 -0700 (PDT)
Message-ID: <5cfd8875.1c69fb81.5cb9b.0f42@mx.google.com>
Date:   Sun, 09 Jun 2019 15:30:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.180-242-gc9c6a085b72e
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/241] 4.4.181-stable review
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

stable-rc/linux-4.4.y boot: 94 boots: 1 failed, 92 passed with 1 conflict (=
v4.4.180-242-gc9c6a085b72e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.180-242-gc9c6a085b72e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.180-242-gc9c6a085b72e/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.180-242-gc9c6a085b72e
Git Commit: c9c6a085b72ef62ce2cdcfbee79476ad2bdbd703
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 20 SoC families, 14 builds out of 190

Boot Regressions Detected:

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu:
              lab-baylibre: new failure (last pass: v4.4.180-230-g17950b5be=
27c)

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu:
            lab-drue: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)
            lab-collabora: PASS (gcc-8)
            lab-linaro-lkft: PASS (gcc-8)
            lab-mhart: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
