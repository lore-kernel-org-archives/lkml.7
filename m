Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF25C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8747A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Gv9YgH9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfFXPLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:11:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35400 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfFXPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:11:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so13805302wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=FIItinavA9eIiwybMWsRJobHMmdz/PIEXj8oD2br1+Y=;
        b=Gv9YgH9Ze00ejmWRA5NYNU7cOzZCaVgj+72WLSbLgKDzDgUdcHP71fNdm8n5I+AvzE
         y1U6qHnPIDh2quFbci1F2zfpfcHDSofki9Zui5mFYdgVe+lueO7yUxDsd8CwBotUDGZH
         fxxPGeIt9qsS1bSv/JWfZyum/UPq/uWsIWIBF7AevLrUZBxrs32Np6LWt1TeN7O0KWLg
         ARZh1niZNH5/LkqNatTA5TTReDs/qH+RmZiy2VquzHDfooXl5yclUD0US6ZyKwvggo7d
         n1qDicH3QC+ZpqAZ8Cg7WrOILcRHd58dA5QLYBh/nHHA/9kelZFNAeDVG8jX6GYibiIU
         LUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=FIItinavA9eIiwybMWsRJobHMmdz/PIEXj8oD2br1+Y=;
        b=Y+AlNNfVRkKI9RaK25mY50OdmxCDnxwrCEt6rjBOflaxRGHTt0eyB0t/C5aLWS9Wye
         FfRzTUAE5dOLX6nNZAKd2lnpYia4Yekre/agd6WtEVAJOKhJtzfx1KKczwd8/MlX2wME
         tV5n6ZyfsQeMl5HPFeFByfGmfTiyyaODg6p4SDZQFl3YJ0W0nSlD7G6b9R+eS/HwLuhB
         g7h984n4hbFsZKxzxFPKSPz7v18aeKLKSknS9BfADLH+olBJdI15E+qqEnlRs9t5kWto
         SNrabc8AM2b/bm/69oD/WYE74FewHmGgIZIeaaWGJIq4ANaAVAjpBn2LdfaXoY8Csbft
         pbWQ==
X-Gm-Message-State: APjAAAXDhagqgTXnTwn3h9az3lmS8nUSsT1wd5GZDv2IX6l6kc7XucnW
        T9eC1W1/VLbXIHgXa8NQEbNGdQ==
X-Google-Smtp-Source: APXvYqz6aj4ckQRZGXdhP5/dMj83pFM/u5b4lS4bPrD1NR7n2NreHUlkJGeLeUJq3wKO7p3XSwj6gA==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr11467264wme.93.1561389081132;
        Mon, 24 Jun 2019 08:11:21 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m9sm8657360wrn.92.2019.06.24.08.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:11:20 -0700 (PDT)
Message-ID: <5d10e818.1c69fb81.bcba7.da52@mx.google.com>
Date:   Mon, 24 Jun 2019 08:11:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.1.14-122-gd74a88068af9
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
Subject: Re: [PATCH 5.1 000/121] 5.1.15-stable review
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

stable-rc/linux-5.1.y boot: 128 boots: 3 failed, 118 passed with 7 offline =
(v5.1.14-122-gd74a88068af9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.14-122-gd74a88068af9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.14-122-gd74a88068af9/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.14-122-gd74a88068af9
Git Commit: d74a88068af93d3fb0042f1af40244e76cb49dc4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 73 unique boards, 24 SoC families, 15 builds out of 209

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s905x-khadas-vim:
              lab-baylibre: failing since 1 day (last pass: v5.1.14-13-gb82=
58e6be3bb - first fail: v5.1.14-13-g5c276064ec4a)
          rk3399-firefly:
              lab-baylibre-seattle: new failure (last pass: v5.1.14-13-g5c2=
76064ec4a)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-khadas-vim: 1 failed lab
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
