Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA7C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B51208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zCTM3bLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfFGT3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:29:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32962 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfFGT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:29:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so3262817wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=sJ5T+Z5HRLuJZN0gt3pR40uH2qtZesjRQTuawwndF/M=;
        b=zCTM3bLb49tLuFDID+q7Aq5ml379wign8HtBm5CULMa/8I9B3ZuhuiW1vkDXn1CMqW
         db7H7jeN5QgYcg2ga6MJVcJPZQkhtYErSPWTTJX1GLCGH4xqEnjb+6ZBSwcyYtmqc6k0
         wpOtEegNWB+uQP1Kz4OqIyMcPdkC4y2LMefVyGwcBSGkrRSJASAlzLirxFUJ4wP3Uehc
         PFYzG1H6WqjXQnHLVPeMjkCFz41+zUNiP/pzL0xI5oQHfmchHTVmFcpf5sAnbmELB3Bl
         nQmz02pUl/jemtBFE+TjrHKuUwx0uMlggWUOV9v8WFhDs7PdQk3EUTafF9UyNMOUQKCx
         Wi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=sJ5T+Z5HRLuJZN0gt3pR40uH2qtZesjRQTuawwndF/M=;
        b=gVqZ7kK78MD4ILwqdNkxp7ItiyvziKEPtnAGRoaOLHLygCfbuoUJ6uR5k6Ql2dQUSE
         8ZB6Z70LlelTMnVnXLENSh2Zoq59HhY6XE0AY4VuFRopchH9ybZXyIqPfxNKVUXLaalm
         PrG0jybyM71UHn6v6Gc41J1iP1NU8lAZ+n+j3uwP9XIDjHNgSnw4/d6AtwWw3fNsGDw7
         M0RgefpvrP714Lcqh7V66AUiVjBl5W2xvcqvw6lnq440gmfY6q5p5gvnqLUtxW+7/NhG
         CRZ/33bBYgFNQE1OznuDeMjgeJdbUjbYosiLmmeKN95QbmiqJVwBXz7KIcmv2MJ/Ap0i
         3vqg==
X-Gm-Message-State: APjAAAXbg2Fe1+TVAlvbIT3up5lbo9tmtjogbB9EskWQ9ve4Qxhl6fT8
        aw55JuJ3Mw/yxs2cs+qoSsvw7A==
X-Google-Smtp-Source: APXvYqwRUoQ7RSKk3VIfPGOjS4thqVpAybZDzwWNvjshWmv3BhZTyi0fdUvKd1A6UNTzP9WQsoZg8Q==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr6678142wrt.96.1559935789901;
        Fri, 07 Jun 2019 12:29:49 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o14sm3100647wrp.77.2019.06.07.12.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 12:29:49 -0700 (PDT)
Message-ID: <5cfabb2d.1c69fb81.105bd.34f4@mx.google.com>
Date:   Fri, 07 Jun 2019 12:29:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.123-69-gcc46c1204f89
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
References: <20190607153848.271562617@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/69] 4.14.124-stable review
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

stable-rc/linux-4.14.y boot: 118 boots: 0 failed, 108 passed with 10 offlin=
e (v4.14.123-69-gcc46c1204f89)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.123-69-gcc46c1204f89/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.123-69-gcc46c1204f89/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.123-69-gcc46c1204f89
Git Commit: cc46c1204f89505a33f1fb42e719ae0c8586cb68
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 63 unique boards, 23 SoC families, 14 builds out of 201

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

---
For more info write to <info@kernelci.org>
