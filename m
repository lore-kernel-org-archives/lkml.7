Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E96C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE902173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="pRCoCqYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbfGRINi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:13:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGRINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:13:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so12613915wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=m6v76uLNAhe76m2yoyYYvuAgJjHyuB/rHa+1oEoNBb0=;
        b=pRCoCqYGnIQwmZu4xVl7CEXyBEFk/9L0iLXjR7aGAB2vp7+gw67o20do9fAeksGocd
         XbbBYw/u0o0JqIqJnv/pPRlIkWaw165VoRkDSjS5Fm7jAdP72ByfEM1tlwyL2VVre1Dp
         4k4WdY2WjNeC+2ifTAHxlY0nxKhPBLfkqY7xlEzcGivTGSYcaLhLW8TN+ebz0T/pjRyw
         X0uWiUCSKqapLajTWydLgUvK927yObzfQYhBqWTj2mf//7Hn7MFdesuPwcbSzytvldor
         S5qcAXtf1LATqgmz/0pyeSGQDtTTqrM5XcnSAaPJhh+kG4NfFjFw77t7ELcl07xE9v4J
         9nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=m6v76uLNAhe76m2yoyYYvuAgJjHyuB/rHa+1oEoNBb0=;
        b=DGxqIxDaYhz3xlsNAliPe7hKkpwljqcjJefzM6lUVYCnhk6cM5chE9aVz8SGci5L82
         HGKhg2P1BRz6Uc8WDJUllDpYebGaiC+HNLv9jz+Vsh5JI5LmELAZgVcfa5T3ecu6N4dQ
         XZGiI4fScaDbSgehV/yZcAADHX077+FBZMupYPENkASR4O2IL4SP4hcmM/5IsJJltP1/
         tVX/62/QypzEeV1eMLI7CJ1DQqu32jdhRWhyh+tqcq3p8jyUiAqM72tfwdphubClHGFx
         72k29X2+Qfu1jLdCKVjeA0azLashfxv7Mc0JBn0knuYAoNvjS9/gytH532gZ2xkVYjK0
         xFEA==
X-Gm-Message-State: APjAAAUg4fR0SbZ8PimiDfKCrnDYZQJ7rc6KFcoRqGku7atGY3W0lQQb
        Ux3/dwqwywSNWOZPR5P+K/s=
X-Google-Smtp-Source: APXvYqzcyeCwvwpGtTktRsBdDdXx3d36SaER6ay6RWE/VnDIbQzRaUsqvGTHkb/TyzNnkKTK5xdCwA==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr48994744wrt.84.1563437614808;
        Thu, 18 Jul 2019 01:13:34 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v12sm24741416wrr.87.2019.07.18.01.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:13:34 -0700 (PDT)
Message-ID: <5d302a2e.1c69fb81.c9c31.a2fe@mx.google.com>
Date:   Thu, 18 Jul 2019 01:13:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.59-48-gaa9b0c7579ba
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/47] 4.19.60-stable review
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

stable-rc/linux-4.19.y boot: 127 boots: 1 failed, 124 passed with 1 offline=
, 1 untried/unknown (v4.19.59-48-gaa9b0c7579ba)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.59-48-gaa9b0c7579ba/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.59-48-gaa9b0c7579ba/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.59-48-gaa9b0c7579ba
Git Commit: aa9b0c7579bacf570e7e430fa563e52b6b4ab15f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 71 unique boards, 27 SoC families, 17 builds out of 206

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          sun50i-h5-libretech-all-h3-cc:
              lab-baylibre: new failure (last pass: v4.19.59)

Boot Failure Detected:

arc:
    hsdk_defconfig:
        gcc-8:
            hsdk: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
