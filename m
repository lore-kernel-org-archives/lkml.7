Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF7FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A313214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="emTDyMBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407797AbfJQEmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:42:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407777AbfJQEmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 00:42:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so678135wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=IJlnbnyY5cuX1Hnkfu7X6odyaf/nXbeywPLfKyjn1qM=;
        b=emTDyMBcY7lv/zsUQKHKUYVj2Upyj+63oi6HeQ0WcAcRxiN0/wQjiPY1jkwKbz/Nt9
         edTl9RpSDVglsXx+JMWFuES1xsHslfc+fbTacFhHGIK19yFEM5KNf3PNJh80cyjI7eCB
         zVWzcMfEMzj8vWVwnAktt+138ytzp+1lUtX0d7RXv8hFBJcDP0fdPwymqBsARAouTES8
         v/rfLxGQUdeXQw/azT56SNlT0pZiZEHFBqcyh79eozC09TPV8qSUc1C9tqeG2m3Rej86
         3gupOOFDNFI/9PAUH4qokzAVrNjTQgQkv4g/PCU4Bh8dlhHa8VFnbA2li0UGIj7Tr6fF
         AqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=IJlnbnyY5cuX1Hnkfu7X6odyaf/nXbeywPLfKyjn1qM=;
        b=njal5fpqPHqYJ9eKhzaKUEoY1zeR7WtcOah5lSH7UdIiCTdZNlYYmorCGJRMXxf04T
         A1LhLXDgREgXCuk1Tz09ypMxkEUPoVT0NDyUOgp6buPHVjn+63twmczEoaDCt5RHxiIR
         cusURO2ilrc92G57EcX5LtEUwk5Vxd5bWHnvmmInmJxWsdVZKmo7d0awIpCWf/BDLEBw
         7UMfIyutydKATAbQnOLkHTxxtHBZJUH/j11Z4/1N9RzNUDM8SG6EvXMS1YU5TsX/mPX6
         HeEGOThq+3vVoUX+yABEDrUKYwDiUq9LuyYUG5ulW8SCZbvZaC5xMzNK100xZMzH1Vws
         f2PQ==
X-Gm-Message-State: APjAAAW66ZXcB3/vLJDGs5n5c4h4f42DZkX7AF2cBVVDexIzsRKt9fjZ
        TqZXZr7eg4CdwLEH4u1BbspTfw==
X-Google-Smtp-Source: APXvYqzzyGjZ2T00KOXjU9A57EDR7cl3i+BjV3HxdjzZLZcsUmmF2MCVUPRNYxYWd64UFMbO936gSA==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr1157436wrn.199.1571287331742;
        Wed, 16 Oct 2019 21:42:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t83sm1570936wmt.18.2019.10.16.21.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 21:42:10 -0700 (PDT)
Message-ID: <5da7f122.1c69fb81.430a9.6b76@mx.google.com>
Date:   Wed, 16 Oct 2019 21:42:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.79-82-g99661e9ccf92
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/81] 4.19.80-stable review
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

stable-rc/linux-4.19.y boot: 106 boots: 0 failed, 99 passed with 7 offline =
(v4.19.79-82-g99661e9ccf92)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.79-82-g99661e9ccf92/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.79-82-g99661e9ccf92/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.79-82-g99661e9ccf92
Git Commit: 99661e9ccf9206876ca8f509555b7b0d3e45cc13
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 69 unique boards, 23 SoC families, 15 builds out of 206

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>
