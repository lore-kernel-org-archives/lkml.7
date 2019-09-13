Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E9C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174612081B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="QiTbP9vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbfIMTjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:39:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35784 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbfIMTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:39:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so3957162wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=pd40vG/uG/GzoenlJau3I2g3PG44k2MY+K/oA0okfbI=;
        b=QiTbP9vbxqR9iG4x0RDtHjGnRLDGXPgJH1o+4z9yT4hm8SoJ1Z7LnsO9UyXiF2EYLa
         M8+xvuAMJvNQr9sStTElsNef2TaF8DbHslRQ13HqIXUVgJI6SG7y5K1s3EVB0bBfQHK8
         qGorccgUONznrcRZM7kecOFphfnoEY5a6XXx98KJZilUHKt8ptirh2+oNwSzyxkwX6Mn
         GuYN7Kjw2SNG53chvt8TiUPuurCjipJy88+97jwxkUilRybQwl1/hiqnVyB952KlJqQx
         RnXJg8rThycSCxUwLoTMTkUlyztpRKAngPJXt+AxWorRM3sgwtONLKl6BU5WNnXVWozg
         kzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=pd40vG/uG/GzoenlJau3I2g3PG44k2MY+K/oA0okfbI=;
        b=FeAsE8ZpE1jqsD+lNpFpJftsHTyRNDffsp0wFbcDgghnOk8n3Mhseex5OlgP4qpgny
         ZAMMrmojKO+8Rek1xPRKC726D7eWmsq7jG6A8XOyqTuPydkXe13K+9DNclWqBM3uI2mQ
         DBowqfVfpHeOA3N67TB9Gfn9IwsIq93sAWTzRy70zW5OyHzm0rHDTrXWOW+HBsdI2Gfo
         R5nxpVR8BmZm9DJVq5yKxGRCOoDyGFHwPkTKl71pQgSzH5QNqH1dHWZrcl+Qf5O6WBXV
         AlGsYz7NqoGi8bflFRljBCEY27ck+9rtPNieLqsGnGtzSAMh5BUMVUh7d3kbo8GAvLDo
         5TLQ==
X-Gm-Message-State: APjAAAXkEhpTEttokbTrx0hagDDWSef+Qk35jmQ/j+G6i7my0XyPDXbV
        YPfa03KJ9ZNlK9RheXQkz/ibgw==
X-Google-Smtp-Source: APXvYqxwiQMX3VbuvfmrdsrgYP5GETL7nbmMEjQqq8qoVLOYT2fXSNMsVruqoBQxs4SP2pXeJrTtbA==
X-Received: by 2002:a1c:ef09:: with SMTP id n9mr4397015wmh.23.1568403545199;
        Fri, 13 Sep 2019 12:39:05 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o11sm3949126wmc.7.2019.09.13.12.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 12:39:04 -0700 (PDT)
Message-ID: <5d7bf058.1c69fb81.4ca9e.38dd@mx.google.com>
Date:   Fri, 13 Sep 2019 12:39:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.72-191-g490747a3f68a
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/190] 4.19.73-stable review
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

stable-rc/linux-4.19.y boot: 136 boots: 0 failed, 128 passed with 8 offline=
 (v4.19.72-191-g490747a3f68a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.72-191-g490747a3f68a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.72-191-g490747a3f68a/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.72-191-g490747a3f68a
Git Commit: 490747a3f68a8ef2bba5b0cb5f29b896c02885c6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 75 unique boards, 25 SoC families, 15 builds out of 206

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
