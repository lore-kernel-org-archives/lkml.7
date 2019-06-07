Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D122208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="s5AxgnMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfFGT35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:29:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38077 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfFGT3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:29:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so486936wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Ap2p4K3FsBhUMMLvzSSv6qGy6XWuBL+FfMivSOfqOJ8=;
        b=s5AxgnMWDpn6CtYOzZSF9hjBWFmPBtZaEZn0wUfZIB7ELojrTR2LQUSgfegfbL9hWK
         Dyu9kPxMVZdWzl0DYg0V0CGOqtDpDT2twfBZY6ZzcMt3RxybrsXK7JkmS99AwXFyW3vh
         N1gycoyii5hZ5NUKE+8fJMrVPAQ3L/lyx+ycwDCrCL1SggRk2tI5Rd9ynSFe+KipGN2F
         S//K6f2VOJiBAT94rAHPOPDGyr3m3nJwnZUN5EU69AuDqoG8bZtqIiswvsOMEXQOOyA6
         0Pyax0QZsW777YthmhXgjXo0tsgQQQ9Gs8sbL09h2tWwi/9Lk9XVkVT6Pl4Xcl2LSRNj
         d14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Ap2p4K3FsBhUMMLvzSSv6qGy6XWuBL+FfMivSOfqOJ8=;
        b=qevEPR/mtB7cfy0Yl9XcoqeuONcsweDxQu7zrsddheWf7xr+6nv+SuLoht8ElH5z3b
         Dnqg/hpKC+6eFXzKe8ONoGpCH1dWUbf8bYifjz9GLiT7j9XY96O6FTz93rRFK3HTHNO1
         28ilYnIF6BCNh19JaYeV26lEUESFjzrodZ40+vQQg9mDVn44xGW1mkO2CyT2nxnsyfYK
         I3oAqs4y/3oYg3GgCTphzCMj5OUKNUOYBT6AH45ZH2dbPPMp4VRAtuIsaBT/JtkYs218
         RnVCmIyy+SPynUdscCockA59r2SKQ/Og4dPo7QhWb61IyoDGUK1Y39GmTHvsqxamukTj
         tpxw==
X-Gm-Message-State: APjAAAWbtGdTxRCREpkkwcKhPpD/of7sa/KFWqJwCBk03LCfOOrwGYXc
        6aU7OY7jWMJTTxVpT/vrCgrcUQ==
X-Google-Smtp-Source: APXvYqzg8rN4XO2cEWlxa8W8vpTbdCYD+U6tzRJD13uX0yolhaXKgzY6lmmpxqR+wy8yGJR9WOBlcA==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr4626066wmc.91.1559935791212;
        Fri, 07 Jun 2019 12:29:51 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 128sm2810695wme.12.2019.06.07.12.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 12:29:49 -0700 (PDT)
Message-ID: <5cfabb2d.1c69fb81.8cb0f.1984@mx.google.com>
Date:   Fri, 07 Jun 2019 12:29:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.48-73-gbcc090cdcd34
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/73] 4.19.49-stable review
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

stable-rc/linux-4.19.y boot: 123 boots: 0 failed, 112 passed with 10 offlin=
e, 1 conflict (v4.19.48-73-gbcc090cdcd34)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.48-73-gbcc090cdcd34/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.48-73-gbcc090cdcd34/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.48-73-gbcc090cdcd34
Git Commit: bcc090cdcd3453e60d078bbce0f28dc4ebb8d79d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 68 unique boards, 23 SoC families, 14 builds out of 206

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s905x-khadas-vim:
              lab-baylibre-seattle: new failure (last pass: v4.19.48)

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        gcc-8
            at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:
    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre-seattle: FAIL (gcc-8)
            lab-baylibre: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
