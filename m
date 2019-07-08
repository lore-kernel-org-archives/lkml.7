Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2CC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDAB216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="lNEjFWw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbfGHTMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:12:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43630 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfGHTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:12:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so18325178wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=LTYHuAcEiTADjXh81m7VrSjapv6hfDEK7BlZxV/EhG8=;
        b=lNEjFWw7RiFQpiRP7RdvDXvrjELwN/SwchYIfCIkS7cyx8/Dv8JDFvmALF3LO7d3ev
         uJwk8YpOqeE2KFfmN5Yn4lK5jp0ZHJ+s3gKo+IHzwVfTDkYt+8qXRF7eTdilViEQgx+r
         YhjGJYDV2G9W1GsI7ZfzIp8tu1NiZlu1Sl1E+Hh3ccqYf3QnjC2leGv8LD0CilHu/ltz
         63Uq5gztHnaWnaFX7kf29qppf1kDSvYuF4zTS/HcpWg/oMyeEUWJR6lGkhXv8NT3SR75
         hWd9diTYETZbs30J7jSGVulKg6NRp+jJvZesJjMK4GYtc+pc//QRriNviGDLbJGWismV
         YVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=LTYHuAcEiTADjXh81m7VrSjapv6hfDEK7BlZxV/EhG8=;
        b=WwdMf5pk3CZWUNPaz88WJcgGwuNHd5+8PDQZ6tOwNGyyhJDfhrbl+5mSdpEcS4Xf7z
         cpiuChN0E8GwkTviGy1vDKRctlMLBZS5lhKrZBcpyLvRfioIRuDt9uEeaIuXuNOEcGt4
         ot1g5epnRSnFaJl6weesxOyazO409unK2jYX7QctYzgoSNBb5zwuMWjyrrciyenG0cJX
         NC2yPr/9rIaPPLlnXYu0LDa4eygYYmQNHNw9bJt91PPEvKAndFHT1WZ1XmXqLidYNbfZ
         szt53KoGJwzkDa7c7tQUDPXwCw7XBdb6HYJaz7enQ1TgG2NgbukgQpvJ6VP8m6y7NzMW
         WSPw==
X-Gm-Message-State: APjAAAWu3CKQjWOf9dj+B3INtwBUNXiZRQZG6qe64Gtj+GTd85YzNX4v
        bdb+ru3mjoLwnm1k4Ifu5BGNdA==
X-Google-Smtp-Source: APXvYqwIErtox+EtBzu006KFQvcDop8wFxR1TDa7u/EFlLQncFEzRdfNQcWwtYnX/eUfTSoEklA08g==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr17700304wrp.145.1562613161554;
        Mon, 08 Jul 2019 12:12:41 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a8sm341004wma.31.2019.07.08.12.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:12:41 -0700 (PDT)
Message-ID: <5d2395a9.1c69fb81.2106a.2001@mx.google.com>
Date:   Mon, 08 Jul 2019 12:12:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.184-73-g71b130d46805
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/73] 4.4.185-stable review
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

stable-rc/linux-4.4.y boot: 100 boots: 4 failed, 95 passed with 1 conflict =
(v4.4.184-73-g71b130d46805)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.184-73-g71b130d46805/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.184-73-g71b130d46805/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.184-73-g71b130d46805
Git Commit: 71b130d468055291345db697052e5256d6e46397
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 46 unique boards, 20 SoC families, 14 builds out of 190

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            stih410-b2120: 1 failed lab
            sun7i-a20-bananapi: 1 failed lab

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
            lab-mhart: PASS (gcc-8)
            lab-collabora: PASS (gcc-8)
            lab-linaro-lkft: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
