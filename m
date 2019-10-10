Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B46BECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132482196E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="nK5FjrP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJJOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:41:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:41:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so8190407wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Fh9Hx1P0eMv8gyvLKexMkSz9TuiAbke7YyXoM+kWNOg=;
        b=nK5FjrP59K3ng3P4YgO4vwC29jLdqnTV9mf3lSlsePV+NVlvd8YucDdl801ZoFZQTE
         fAOupa/LOixBAsraAohUxD/QStkkAORLlpB4o30gxyctPMaEPeQDS0fxGufxqyI+44gW
         6xAGaB+cbylH3VD8cRUQwmjtGpdgL6irg3mbK7hb3TKJowYTCwT9ZkIwJ3uqG29f/EEo
         zznElOF/ieoTWJCdp54ab1JU2FtaAavHW9O2Yx52A/XYgYcoiaE57qp7/t2dnoXSI4R8
         OCAkssVyDYSt+llB04JQ4IqfSGchRNNYpSQn+zOfRNMmdc3/g9YT3Iq2L6xsCMYH76mW
         U3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Fh9Hx1P0eMv8gyvLKexMkSz9TuiAbke7YyXoM+kWNOg=;
        b=eIIwpEcZg1cfa6iyC0VNHPfugoD2X8AO9gpC16FWRDNo6yG2ypUAxEiVm8iGMvjYov
         wurUv41DniYV9Bj5ZkBfz+Qx/Vqbg3urnf0lOTY5VqLTp87Gl1YkXseahCUXr7zAXIxV
         U8Txs4Ug5ZYmJV0VE45AjRXA6WSIA8ene9ETW0D3YX+bvAxkcMjvKeV/OnP+55O6RFP2
         EH2ArmqC6ou086H3pSFYbcosSEqd9VS+2Kx7bKybyv2BpYi3oCUdRFmGIpEYsGdb9PI3
         69wLWlsMJjD1R8bFzHfTyI8/5MzdrfU0xWvGCMYkF0HNAA9KcqXn5T+RKVdenscGAK3s
         Hhgw==
X-Gm-Message-State: APjAAAW9Tn3t8r7Ta09js6PmaJDQOIeWVAQSoWThDzm64ciZRM8xcXEJ
        I1OD2dnlIX9P/5JGFwE16Qg4aA==
X-Google-Smtp-Source: APXvYqywYXNqUtCUh1tqSRXS8kHXQuLkQpAdFExNwTdpQwA7rofQc7epbkiz4NVdCOPT2aWJQj7FVQ==
X-Received: by 2002:adf:f452:: with SMTP id f18mr8619268wrp.187.1570718496848;
        Thu, 10 Oct 2019 07:41:36 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c17sm7118509wrc.60.2019.10.10.07.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:41:36 -0700 (PDT)
Message-ID: <5d9f4320.1c69fb81.f0ef.24cf@mx.google.com>
Date:   Thu, 10 Oct 2019 07:41:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.3.5-149-ge863f125e178
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.3.y
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
Subject: Re: [PATCH 5.3 000/148] 5.3.6-stable review
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

stable-rc/linux-5.3.y boot: 130 boots: 4 failed, 116 passed with 10 offline=
 (v5.3.5-149-ge863f125e178)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.3.y/kernel/v5.3.5-149-ge863f125e178/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.3.y=
/kernel/v5.3.5-149-ge863f125e178/

Tree: stable-rc
Branch: linux-5.3.y
Git Describe: v5.3.5-149-ge863f125e178
Git Commit: e863f125e178f8d2edf7a3a03e7fc144d3af82c2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 80 unique boards, 24 SoC families, 18 builds out of 208

Boot Failures Detected:

arm:
    imx_v6_v7_defconfig:
        gcc-8:
            imx53-qsrb: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            imx53-qsrb: 1 failed lab

i386:
    i386_defconfig:
        gcc-8:
            qemu_i386: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s805x-libretech-ac: 1 failed lab

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
