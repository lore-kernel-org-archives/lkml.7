Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD8ECE58B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DD42080F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="r0nUxAOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfJGAVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 20:21:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfJGAVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:21:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so13133470wrs.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 17:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2L6tu62CQLvhfmYfpH+nP8vU0QMy44jNC1xZXtr0hog=;
        b=r0nUxAOogHi0K5RbeGeNkQvDNyfaa7Y1fXWmCTBqVaIqUUK2xZjIu8F6BaGkzIKXSd
         htqZ+zV0Qpoyi9Tpm0+kuhHQp0ckk8Y6e5nRq3/9VsG8MDkdE2nMf651PfsgcUaR9xwI
         CESYJdqjYRAQitMm+TqiP8FK2DD1xBxzYyb5XFsxy2/DQYE5PMXjvNy5MeN8fL83Ln4Z
         TS5VccVrNhMTHa0ilzoli/Ou5Mk6d/OaRvADQYkgd5V6P4pITFebZnWXwo0jKD4M7/fm
         ZE60Ck7VEAhBKE+Gm0iGjMr5O2sKgomHeYS8qBzSs9+XiFEKBcP/nBtFWc2bzH7WOAFw
         JrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2L6tu62CQLvhfmYfpH+nP8vU0QMy44jNC1xZXtr0hog=;
        b=En7REEl2E/dT2d5SrGhuzzYD3NKhGMrAvv68VWBxR8TYYNjTEZE+56q02VwRrrXtKV
         Lx0kO8dIS80J83v9iElKrlV9ZJlLt2PAA16SxnDWP3u8nHTl/9k2Pv19pbzHGWlp0t/m
         UWJ7U6d0cnS1/xvnTeDFmjskIkeOmUBlI+mI/fAOptz8Qi8P0YIHDs4FR+UXpSbsDv3d
         olJIzzi6VwoDrBJwJD1yYRfuwGlPcO1uCuNJ2eZ8GLV6GO5je4jWGimjL+0iaD26IsJT
         VeqwBxMaFNreRqb3Ie9eem8tRGsb46vxfyB4Ta/kD6mVFobSAaOtymWusayGduWFHzCf
         oBiw==
X-Gm-Message-State: APjAAAW1UwGqEJUfu+uX54TA/u0hFmnfLaqHdDORoSOFYEqvppRZLuCX
        VwnH5nfRC4OsLIAu4MuaAbM+XH0Ad+I=
X-Google-Smtp-Source: APXvYqzobeOhXZz6qRzrdBqfmKicz3f6C/SVsZ/O5kkiWfjRXYozDbjsMj3haLtGpZ7xQfYH3q3rRw==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr15583243wrp.191.1570407677361;
        Sun, 06 Oct 2019 17:21:17 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b12sm12479191wrt.21.2019.10.06.17.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 17:21:16 -0700 (PDT)
Message-ID: <5d9a84fc.1c69fb81.7ba56.664a@mx.google.com>
Date:   Sun, 06 Oct 2019 17:21:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.3.4-167-ga2703e78c28a
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.3.y
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
Subject: Re: [PATCH 5.3 000/166] 5.3.5-stable review
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

stable-rc/linux-5.3.y boot: 62 boots: 1 failed, 60 passed with 1 untried/un=
known (v5.3.4-167-ga2703e78c28a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.3.y/kernel/v5.3.4-167-ga2703e78c28a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.3.y=
/kernel/v5.3.4-167-ga2703e78c28a/

Tree: stable-rc
Branch: linux-5.3.y
Git Describe: v5.3.4-167-ga2703e78c28a
Git Commit: a2703e78c28a6166f8796b4733620c6d0b8f479a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 17 SoC families, 12 builds out of 208

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s805x-p241:
              lab-baylibre: new failure (last pass: v5.3.4-162-gde3c43ffab5=
3)

i386:

    i386_defconfig:
        gcc-8:
          qemu_i386:
              lab-baylibre: new failure (last pass: v5.3.4-162-gde3c43ffab5=
3)

Boot Failure Detected:

i386:
    i386_defconfig:
        gcc-8:
            qemu_i386: 1 failed lab

---
For more info write to <info@kernelci.org>
