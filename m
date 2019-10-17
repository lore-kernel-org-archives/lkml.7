Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761E8FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49769218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="sdeKXKb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395269AbfJQBma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:42:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53368 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393064AbfJQBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so721490wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=4PlnNJoSqbgZGjpswnpRSIhWXTeapV7BXOO12k9Vq4w=;
        b=sdeKXKb/aDjWkIigJ9vE1zn046iDrva8JV2kXVrA9iFxHRaCEMkHyjQA8glmjRn4hE
         xO4ZK1LdvP1wYTyc4loyqyt+y5z16YIft820VIgbWfjIIAaefvzQUa0xk/4tc9QrEdNO
         kW5ai3XSLidpetEqENYU8VL4rhxHd2Ydyq+6CtAQf+4gBahBTSiatGG2xQEaOHkuSp40
         MCCtSIqkVmpnwivOephy99Jp5L2Dv/bJ5uECFNCJYxEGqPspLOivnDVI1b2tHhlsU6ge
         jWOkdR+PUQZhcFqIj0J28LLWcYOsIdpZGHJTzpmEvlZOK7/mMAWsQ1Vh0n+ekOqlH5zT
         2z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=4PlnNJoSqbgZGjpswnpRSIhWXTeapV7BXOO12k9Vq4w=;
        b=Yl1RtCKnx0jtNWVxc9RZTpKiBidiu3XFVo48snuLGvFfuzJg3rW2Kfuy9g1KYjN8B/
         K5iS5SZ3aakIj/IApoeAmA8FCGXxtyOg9LwxF6rvfIlBYJ0HogNX9Lr/wru4DlBYLQ8L
         Z68knycpB+wXw/kE1e1qaDdPPUd/udQsTrFOeW/9VLnaHhp0To1uU57V/SemeCo+FsbT
         ExoNU+u1aORFwSRsWso7w6ZfwcbPYjenDqAQ/b1Rn8SAaRDc+dyj9WPEbNzZUOVEGp5Q
         xUI8FO10BJ2GqTDm3+z7mvSu8Hytkzqd8gnpyvVrDB8xmhQ8cbAjI0P2ceMbioK8l/ME
         yrYg==
X-Gm-Message-State: APjAAAX3gMd4kSoQQTR2jRwt5368bmsoCfre6wgCRZTmzqEGJ86pah54
        DLn2p4iJMOG57Zzuo2Cw7UKRHQ==
X-Google-Smtp-Source: APXvYqwwMXcl73QU1lCZCQOLa/BZ7ghVY1xQRnaXRqyFMV80OaoSpkIQSNBSRUKDBNdQS7YUznNeyw==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr500379wmc.128.1571276531039;
        Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x129sm964400wmg.8.2019.10.16.18.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
Message-ID: <5da7c6f2.1c69fb81.20afa.4518@mx.google.com>
Date:   Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.196-93-g8811b6f62880
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/92] 4.9.197-stable review
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

stable-rc/linux-4.9.y boot: 42 boots: 0 failed, 39 passed with 3 offline (v=
4.9.196-93-g8811b6f62880)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.196-93-g8811b6f62880/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.196-93-g8811b6f62880/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.196-93-g8811b6f62880
Git Commit: 8811b6f62880b7a4b6d43be23d9837491ce18ea0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 36 unique boards, 12 SoC families, 13 builds out of 197

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>
