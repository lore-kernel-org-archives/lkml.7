Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MJqEOi1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfH0S5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:57:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45543 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0S5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:57:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so19828295wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=tJ6JT4mbjmxDTtYCcCKRvbFj/AkxPciRIoJmoc0g31o=;
        b=MJqEOi1NoCd2mhJx7tOLWZaAjI+lCk6fg1tcgwfApTvtHFq/4zZtjuW8lyfZevogDL
         H6na8WULWU5JkLg3hyOUuFqtwlYKbbIyzIhwkttN4EIr4KlIrDO6ht30pGIpWWLYbttk
         bZbBqZzOHRLPWOMbAIWu7v7LG0mLraGJLnGHVCHu41V79Jz9V6l4Wxdf7NtlbFKuKtWL
         lJYYkj6EJcoR+QJMRmBR3ITPmvFEvLltE/zg2rIScof0B//bgHLvu8Xbb+XW7XB2qFoh
         1MMYKQI85NSPjvXf0RoBtsDoW0KwRFeVvaptsEV1K2IaWkeHB1TNGUDbZINKzhBDnzIZ
         Twsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=tJ6JT4mbjmxDTtYCcCKRvbFj/AkxPciRIoJmoc0g31o=;
        b=ADB8Ub0G8+IzX4kENXB7P6kdVLjCJ4D3BmF9XhdhfyjhOrD7ohstwjhTd0mRFMkbtT
         2wObxW0nrGq8rzgOrf9z6UR2j2JyjPZ+yxfNEix/T1e9s0nsz9GdFa412n3E+aMfmTwi
         7IG9zP4YmDQswWxHp+dYwtr0w53hzn+hZJQz3vd+aqBgZUGqDtMwocCz09hPVfrJvVnU
         A54j1Gy5tErRa3+SI9jPzrFh0pLPYYMiuuNUN16B71Jqe44OyvFbdpaaI70D2v4OyJa4
         ftdHBWyxNUFQ9ejE2dUMTPRvOKkzzWnwTz/14x6kWgELrtpqiKHwOaLOQ/kKmgtahZtK
         4j5A==
X-Gm-Message-State: APjAAAWfFa8OqfJ3lUJPa5+RprfIieQuncR4yCKn3WDZcguZeSSQdHIi
        wpQUqHSrVAhJ9gkokSMKpRFn9w==
X-Google-Smtp-Source: APXvYqzEcEEoekfXHv3LhSxYPlOoKLqWjAz+ESX9lss5oqdxBTsOVRcbN5+F3Pl+wt4+vK2Slj0UoA==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr5838644wrt.34.1566932248116;
        Tue, 27 Aug 2019 11:57:28 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f17sm11316wmj.27.2019.08.27.11.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 11:57:27 -0700 (PDT)
Message-ID: <5d657d17.1c69fb81.7742d.00d6@mx.google.com>
Date:   Tue, 27 Aug 2019 11:57:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.10-163-g9f631715ffe6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/162] 5.2.11-stable review
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

stable-rc/linux-5.2.y boot: 149 boots: 2 failed, 137 passed with 8 offline,=
 2 untried/unknown (v5.2.10-163-g9f631715ffe6)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.10-163-g9f631715ffe6/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.10-163-g9f631715ffe6/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.10-163-g9f631715ffe6
Git Commit: 9f631715ffe68666bbe4c5f7ad0dfc1ed387e1a1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 83 unique boards, 26 SoC families, 15 builds out of 209

Boot Regressions Detected:

arm:

    qcom_defconfig:
        gcc-8:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: failing since 12 days (last pass: v5.2.=
8 - first fail: v5.2.8-145-g2440e485aeda)
          qcom-apq8064-ifc6410:
              lab-baylibre-seattle: failing since 12 days (last pass: v5.2.=
8 - first fail: v5.2.8-145-g2440e485aeda)

    sunxi_defconfig:
        gcc-8:
          sun8i-h2-plus-orangepi-r1:
              lab-baylibre: new failure (last pass: v5.2.9-135-gf5284fbdcd3=
4)

arm64:

    defconfig:
        gcc-8:
          meson-g12a-sei510:
              lab-baylibre: new failure (last pass: v5.2.9-135-gf5284fbdcd3=
4)

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            rk3399-firefly: 1 failed lab

arm:
    sama5_defconfig:
        gcc-8:
            at91-sama5d4_xplained: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

---
For more info write to <info@kernelci.org>
