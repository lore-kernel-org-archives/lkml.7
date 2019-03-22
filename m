Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B81C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E620685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="nGJDRpDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCVXC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:02:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41754 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfCVXCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:02:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so3978335wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=LbXobM7UltE6TVAPW6lJZ/T4zq4wOJhJcrgrEqti7a0=;
        b=nGJDRpDwiqcAEe2MTvIAXfjHODLxC488t+MByi33K8BdvgO7if9LSXoo17C58nzaWl
         UIpJQmwd2FNaz1BjRHfvoRt4unyUIlGntSLZvIneNsxolPay3LyzDmpJelgRNg4J1ZBh
         jBrghk4snCFxFehZHEShDrSoG/D4oC2INE8WtebaGNCHFjN4YyORnxfG2zTHRuNyzpA7
         t9V84UWGrmkJApfRrC7s4T62jWrdd/1qjDBe53V4QGmJaCvWxVUDINISpRQ4OlwaF3sw
         +mMUHbY44p5XjstsUjTLdoyUIuDqAr4hNLnKFNgZU1CmnocQGxvyWGiLl81oeSiEjXz5
         p1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=LbXobM7UltE6TVAPW6lJZ/T4zq4wOJhJcrgrEqti7a0=;
        b=gfH8uBHkmnTSH/q/pKMnYDGuUeEd5l/vIg0J8QnXMoMmDV0xp1bY7MrMcKB5reYgKz
         +UqqsH4IFuZzt3OJFMx+BTdXZcBL4DMf/OGsNd3s0N9INAUcaQHaEoSUDr3uMl9qBgq0
         VSLO0U9xiK/60Se3AqvGT3FVKBr6ecD3XqrpAF0OFzSk2MJDlf9QF3uoF/ErjXViJAej
         mbXJw2bbCAOBTY3K+jzEPIQqCXJMnGnMTeVKaoG2m9DRYz8p7xCutfb5Wwmn7sHsB1YE
         vRL7qC6bPcJ0yEndMY+lGfzMvKKbscQK6eeFQ6xKfH0q+FprWhdjw9eDS421Slew96ip
         mKtw==
X-Gm-Message-State: APjAAAVz8gAI/nLD2Y40BMo7VypxSMQ8CWF/2e4+KNGQzdi+HZ+W9sha
        n/VpK4S2mCF8FTeD+/hwijaRGg==
X-Google-Smtp-Source: APXvYqy9pw7t5JrlXbzWMK1p/cB6LSqr/WAp6ttRqVucQnanwdAM/7oEz9B3IvTxEPz57TZTCDV0Mg==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr7725477wrp.268.1553295773864;
        Fri, 22 Mar 2019 16:02:53 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z198sm7240052wmc.10.2019.03.22.16.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:02:53 -0700 (PDT)
Message-ID: <5c95699d.1c69fb81.55e18.08df@mx.google.com>
Date:   Fri, 22 Mar 2019 16:02:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.164-119-g7d2ac480f8d7
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/118] 4.9.165-stable review
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

stable-rc/linux-4.9.y boot: 47 boots: 2 failed, 45 passed (v4.9.164-119-g7d=
2ac480f8d7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.164-119-g7d2ac480f8d7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.164-119-g7d2ac480f8d7/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.164-119-g7d2ac480f8d7
Git Commit: 7d2ac480f8d77207af9d191a51f9ae2036117da4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 24 unique boards, 13 SoC families, 9 builds out of 197

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
          tegra124-nyan-big:
              lab-collabora: failing since 24 days (last pass: v4.9.158 - f=
irst fail: v4.9.160-64-g0c0f9f653c9f)

    tegra_defconfig:
        gcc-7:
          tegra124-nyan-big:
              lab-collabora: failing since 24 days (last pass: v4.9.158 - f=
irst fail: v4.9.160-64-g0c0f9f653c9f)

Boot Failures Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
            tegra124-nyan-big: 1 failed lab

    tegra_defconfig:
        gcc-7:
            tegra124-nyan-big: 1 failed lab

---
For more info write to <info@kernelci.org>
