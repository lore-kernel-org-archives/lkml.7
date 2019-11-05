Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6902CCA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB6820659
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="f3DLqOFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfKEFQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:16:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54091 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKEFQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:16:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id x4so8138929wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 21:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=D60qdc1NRvgwenO+TXiB5E0z4E0k/lieVI8azX+EcZc=;
        b=f3DLqOFrjpgzmPUXH4bpPpGlH3o5Lc+NLEIH4yBsrQaPvqhZekoFfQAE4vpH5b2qy8
         SYd5UFhisDkT6mq7L3uR/s75is0+O5kWvsmIBVQ7P4aw44LQF8nFipkwM+aHcNTqmIeG
         Zhw4SyW80iAVMs2TTyAD26Q5+8rxwGpyKSVHrUkgVWgIJ4lAAxc4LoLe7WIaPozldyqL
         96KR3CXtDdxXQwhzGWGtqEhsA1O2xY3uOcHJAcY/9klI5SBXqWMJmHxoB5BxRE5MNJnZ
         a+yPMKKWwqeu6m91/DLUQDpQb0Ub1nDDfz8a84UGVEQr5DKvG/gS9uujVedrp6i5PluO
         HTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=D60qdc1NRvgwenO+TXiB5E0z4E0k/lieVI8azX+EcZc=;
        b=G03dPp22ai837fZNllruvVPiLGb+6SY7tk8XtsxO9SFGOOzGhfsL6S+4rYk6gOfLmt
         gk2mqztBhJDS62xTOqf5O1Q56NVfbJjkYK1GE1Rg/n8Cj3lXVIoz9vIIRhsFQ6yPRV+C
         bfHuuv9br8IJdhnNMlMX4UawuzFXCPJntBzYAIajQDgyyg1px8eFCLpQzBCZqqf2lAXj
         1AYGbL69xGiBwSP/GCfx/Zi0AMoSgFQ4lQIKuaU93FlLn6n5XAhV7oZBNyBVNIc/T0ja
         WCFoMbnlcb6GM4+i//MjJT6SBQVHLDFy0kz/JuKvI8/sT01ZJXPSO9vRqDOVB27UclGt
         5UUA==
X-Gm-Message-State: APjAAAW/2/j4WfUviiVgbge8YjWukqnysXUWir0o7kK9k/dPh8UtHscE
        k0NyPBXL1aAVPcpkkkergV2JKg==
X-Google-Smtp-Source: APXvYqzfzfdJb9tGDYwRo863AgM99Kaz6mN4+R1YpWqwU774e2cj27yCvcpXpS71io4NSQ2ZK8sWKg==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr2234172wmc.64.1572931002647;
        Mon, 04 Nov 2019 21:16:42 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p1sm760413wmc.30.2019.11.04.21.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 21:16:42 -0800 (PST)
Message-ID: <5dc105ba.1c69fb81.4d466.4f55@mx.google.com>
Date:   Mon, 04 Nov 2019 21:16:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.3.8-164-g75c9913bbf6e
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
Subject: Re: [PATCH 5.3 000/163] 5.3.9-stable review
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

stable-rc/linux-5.3.y boot: 128 boots: 1 failed, 120 passed with 7 offline =
(v5.3.8-164-g75c9913bbf6e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.3.y/kernel/v5.3.8-164-g75c9913bbf6e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.3.y=
/kernel/v5.3.8-164-g75c9913bbf6e/

Tree: stable-rc
Branch: linux-5.3.y
Git Describe: v5.3.8-164-g75c9913bbf6e
Git Commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 25 SoC families, 16 builds out of 208

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s805x-libretech-ac: 1 failed lab

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
