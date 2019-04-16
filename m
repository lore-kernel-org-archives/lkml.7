Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC75C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0D52084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="rvIpWcAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfDPAFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:05:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32988 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfDPAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:04:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so24299545wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=827ThroLSPIZ3DyumpSm0RPsWEU/JJ3q4FaUCYXsTAM=;
        b=rvIpWcAaitWS8tmxx3fneWngg9wP8mLX2Ae+IT2Y4084ZupCWb47YsS+r3el2WrZIY
         tkpYVm3hx1uRM4zmKtZJOJOebv/3JhHPpr9vJoVRj9xtI4Rp4KkRF7qjL/zuQQr5RbCq
         NbeLFeJN62xvSuCh7Co+AM+KZRmEKf0VYS+K1CKgTNGRq3s80nzWgaVUfDRgvv2/on9i
         Kl5R6nyFyyvmc0aogQj7ia9OLg2NlHk3VTZsNdoSwiWo+qLhqio1tyImdDUDvWRpcCyp
         u6u+oU6HRONzC2V/sJbj8g4pivN1tXuFlZwcP83qui2d4C9huTxVmK0gRNaDkZn0a7PG
         qacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=827ThroLSPIZ3DyumpSm0RPsWEU/JJ3q4FaUCYXsTAM=;
        b=AzIjuxuX0XvK72pesqMSRo9jzUYFKqW6lYY9itgVNsVcNAEGDOUVTvV1FMlxN2t2Ku
         rytOe2XlxUL9eGvt5v595Wvmow0OFZFclag9FfP5e+jklj+9ffRSUw+VlkAlxrhQsz8u
         DOpKnMU1FXO345FJpUemW/bR1Qa7nL4Gf7H6QE064h90qO3MSR1zKSHh8+6MRMX63uVS
         OCQwcF4Z7Sd6JsXZQ6bXbamrC+Bw6Odr2OWLJ0WojXyA3VP74HQEtf9MyoCpsPROvjBQ
         qvANcbQL0qMwCCw5UfBjeEdFJj4KAbpo0w9Cu1/8E0GPc8PU4uBJWvzQ2itZINXMFK2j
         TZPg==
X-Gm-Message-State: APjAAAW5U3M9a1iM4xVoTBpwMhZu7Pg7dKTL7C8tkijVS2ttsg6sGksY
        UZ8iOWMgetEJtOQf6hL6BBwTS0vznpQ=
X-Google-Smtp-Source: APXvYqx4k3ax8dwzxd+BLEOk6EOJsnvpv92mrvvsuYWuFE8GxbN7ockEAAUl3kr1NNdpCcVWCOX6kw==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr15911839wrw.167.1555373097922;
        Mon, 15 Apr 2019 17:04:57 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g84sm29504009wmf.25.2019.04.15.17.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 17:04:57 -0700 (PDT)
Message-ID: <5cb51c29.1c69fb81.8c38d.0d9b@mx.google.com>
Date:   Mon, 15 Apr 2019 17:04:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.111-70-g58023abef2c4
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/69] 4.14.112-stable review
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

stable-rc/linux-4.14.y boot: 107 boots: 1 failed, 96 passed with 9 offline,=
 1 untried/unknown (v4.14.111-70-g58023abef2c4)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.111-70-g58023abef2c4/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.111-70-g58023abef2c4/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.111-70-g58023abef2c4
Git Commit: 58023abef2c4691261db5b40563dc18cc95f3c37
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 62 unique boards, 24 SoC families, 14 builds out of 201

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra20-iris-512: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
