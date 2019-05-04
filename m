Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D64C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA4D206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="syvmT+8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfEDS0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:26:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53240 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfEDS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:26:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id v189so1954377wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=6rNsj0ZT+uN2F+lI52cSsaVO+r8mdkB1QltZ73Xyud0=;
        b=syvmT+8IOIHV4w2ndD/mky7Wt9m7bzjiwYPiPxe/e6aH4/a8ksaQjsD4FaYITltiPv
         HevEQ5iZbI13YO831W3WorsJ4BJjqvx3xTdTdwWcIVAgdq8EGF6E0VsVIqnFmUxMzfOr
         i1PkTJLrhiS0xic2Vp4FpNeK77rM269XanPbcjLnmiZWqYgx0nZhnfidsLCKyqrR9/ZD
         aS+YywTlBfMRM5ugCe+4cvA0xw7IRn2P8EY/q8KzLFYSYxueIR9m+5+k0uWffghQQsn7
         M5+0DB8M0xCGyrxSH6ZASJ6gRDtoTbG1egm55/w5ur8WQ1CYj66bJNOio0OwhJrrnTPf
         SGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=6rNsj0ZT+uN2F+lI52cSsaVO+r8mdkB1QltZ73Xyud0=;
        b=sQasQzOIq8rn838RA9HlNFgNYq1LYAEkKv/H12heNGMDW1IpqvJnAUpuLhkccvWUeW
         tIW4cYky6P0SfA10GnXmKjX7FDpFFF7CoX2wUAZC4QyLX80c7wVaMErFODEP8mAPC0YB
         ezDSEt0lF8pec5tvcMMyA9d5SHhbCQz1HSas5hUvUJkudCoekyNfDw7mWhwqwcPf4beE
         sATB4pAy8V7IXqqLQsEcIbichjsSLFGY08NRrCSj+snp+7C71gNBSi7B3fuVqSk6KpKZ
         TmhlcMoM/g7YaEg1lovNhVjDTtTZKOfrLhp0+eW3TkrcMJ+AxV4/ZIPg01mujnBHWuPM
         L11Q==
X-Gm-Message-State: APjAAAWrxNmjqjZhGUEJucAmf7w8llPHbhUmlz0frE3zSb5S6Exa6wtf
        eMcI3dbc6b0BJJSk4P5z1kNXnw==
X-Google-Smtp-Source: APXvYqwjY1p7llMSh39AQCydYzzc2pQ4gwAIycqwnYmUeHArXcsz62WSMIS3jWtnGCKbfgRhAPMfBw==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr11046668wmh.90.1556994405333;
        Sat, 04 May 2019 11:26:45 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a22sm3972114wmb.47.2019.05.04.11.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:26:44 -0700 (PDT)
Message-ID: <5ccdd964.1c69fb81.47209.4cc9@mx.google.com>
Date:   Sat, 04 May 2019 11:26:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.0.12-33-gc6bd3efdcefd
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
References: <20190504102452.523724210@linuxfoundation.org>
Subject: Re: [PATCH 5.0 00/32] 5.0.13-stable review
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

stable-rc/linux-5.0.y boot: 136 boots: 0 failed, 130 passed with 4 offline,=
 2 untried/unknown (v5.0.12-33-gc6bd3efdcefd)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.12-33-gc6bd3efdcefd/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.12-33-gc6bd3efdcefd/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.12-33-gc6bd3efdcefd
Git Commit: c6bd3efdcefd68cc590853c50594a9fc971d93cd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 24 SoC families, 14 builds out of 207

Offline Platforms:

arm:

    davinci_all_defconfig:
        gcc-7
            dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab
            stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
