Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="aTSzrj9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLCjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:39:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38544 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLCjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:39:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so1309735wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0NbmoJXn0tF3SxS5c0t7ZlOoPipHZmqzqZunLWgBPiE=;
        b=aTSzrj9E3HNv5IONj6eYdXv+gLDpN5bmKxl/zramH0L0AWOMw2sX+iSQzjsV+DF8Uo
         FvP3/jDTNA1wlczELdevUs1MD9YRfMqWbH+aewxhKqqRU+q9Zd/GHUFgkq/tZXhaUkip
         MOjPukp1BjHmdiGFHnrWuRnWfKNgqCQmODmCVpWSEHxEH6Dh5C0Adt2MovHVQGPG9VeS
         psyqxQf102jiVffa25VfBwWJs4/3JM5Xb9B+FSJ5vL0tmf00UZcb/kBnGUwsIoZ16zAZ
         Y0EvsxWZcgFkQ9HuVjcp6QsEerq0lOJATTlDj80egFkScJIRLeCQJZZjFX1piJvHrgVV
         2gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0NbmoJXn0tF3SxS5c0t7ZlOoPipHZmqzqZunLWgBPiE=;
        b=t0ZugXKACz8mnvxX8U1+e6OjSQrjjZhhAheJ52tK2IodBmUKdmBy+pWbT1PSkzyDld
         UH+mq04nJCLyZ2ynbzv5YYulbT6LIieQMG6k0EzNmi2WiR2nxtEM+72w6sHorsXVV6Bl
         YZhncR990i0C/qtqZnL5LuvWWMGXW0mCrEer155hKFRlzGROVObWDUXVeJRBppvSksaC
         n785dgsmscvmkFImcr65hkQu6qLvCsdtQfcLNT+tuuFjYYuOjAILhP40dMSsJnyt8SMJ
         iT9oczaTn0+p7/SXnU7R2ixKi7i//x9PyN+D4g5IEfSITb9i62lKwnXiJ1u7pz4lxE1O
         LETA==
X-Gm-Message-State: APjAAAXop5/MvXHj1N0c2m5mme9KKB9pSbf2f4xtQdu0fjPu8fmy52O+
        6VmSswt2giTJzeVByLrZkeoaiA==
X-Google-Smtp-Source: APXvYqzO00eLBVNuUxnqcBbXEFojPxbLnSEnoxlxP/A9ciPVECSljWdTXDcagO8k1A5QdTVN88tcZw==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr1653677wmc.157.1573526356994;
        Mon, 11 Nov 2019 18:39:16 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s11sm691958wrr.43.2019.11.11.18.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:39:16 -0800 (PST)
Message-ID: <5dca1b54.1c69fb81.478a6.273e@mx.google.com>
Date:   Mon, 11 Nov 2019 18:39:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.3.10-194-gfeeefcbdbfc1
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
Subject: Re: [PATCH 5.3 000/193] 5.3.11-stable review
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

stable-rc/linux-5.3.y boot: 130 boots: 0 failed, 122 passed with 7 offline,=
 1 conflict (v5.3.10-194-gfeeefcbdbfc1)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.3.y/kernel/v5.3.10-194-gfeeefcbdbfc1/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.3.y=
/kernel/v5.3.10-194-gfeeefcbdbfc1/

Tree: stable-rc
Branch: linux-5.3.y
Git Describe: v5.3.10-194-gfeeefcbdbfc1
Git Commit: feeefcbdbfc1362972ef26970aed0aafe90cc1ae
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 24 SoC families, 16 builds out of 207

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

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

i386:
    i386_defconfig:
        qemu_i386:
            lab-collabora: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
