Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497EDC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2110621A4C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="PkbTo/6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbfJDGlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:41:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55285 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbfJDGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:41:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so4502022wmp.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=rKDZNQHbI3yhJDQcPVxUjNjc9rSkeH/oY75z6ZC22no=;
        b=PkbTo/6UtBJ7pn8rWMyMPfAXT9NrdSo94XhKMlUPDeVS9VV2hcu2Aa86XP3rj5/+Cb
         b4gW66RasjK953AN3MQcZj9kfWoOaQlcXGLQZt13zN5M5QJIc92zq+n7yIfbLdX2V2AD
         dCwhujbMwyb3kJY+uc5LVGfmZogaui0qas0XyYgM+EYVHsYkfxKd0hu0HcEbe6n2iF9v
         zb0CANi2inhWoUufzxJJ7i6r9hPW0ICQEooiHG94VxqjAF9V43HnpuzTLVk016+aW26C
         psKxix5dXydliPrC5i3nDKT1KEEEhmKCxDBt8sQBxU3IrCHwkcSFJLOtmxwZJBUGfp7y
         kmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=rKDZNQHbI3yhJDQcPVxUjNjc9rSkeH/oY75z6ZC22no=;
        b=HgGmksDyVRlrGYxikPe1jhPKgVBZvDmS7iceb3Um2kbPNsY9HDQ72oGxBAIumdP0EF
         DrCdku6JywnFL+jP4yDVicHRRax7NVsGqsgSrXlSOeJ/NjAhD6XnARY3/lfVeJu/ZmR5
         yt/NkAfffcAse6XydnedEpmMG2b9JOi8nIzTQKY2LJvaxkB7/GZq4A379jSOWlPFgDHO
         czVKWzNQLFj5bVdOVQAq6mtadbzOQ7b035+h8+TcXS6MTWbOwjyGIKQqIe3QS2j32N0b
         aAFvAPfBwq2kv7EjE7rHKeTh1WsWy4+qfvGkCS14VRXLMZVVm7BZA6itUMe1wFHhKs7h
         cOYQ==
X-Gm-Message-State: APjAAAW4L0Kz/8mG0HAT9uP0EvVnxJPCODmJvyb7p4TNULJahXkNqiLA
        DU5akaQGnhh1mTRsde7b1+dNtCId4J/MGQ==
X-Google-Smtp-Source: APXvYqy5hABhQ/36xrN7snaT5BUf2z8IqZUnEezNbkuPG2887a8BXxj4Y+W3d1Yu9tw62LQZ/qIbzA==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr9226505wma.43.1570171261257;
        Thu, 03 Oct 2019 23:41:01 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 143sm5259045wmb.33.2019.10.03.23.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 23:41:00 -0700 (PDT)
Message-ID: <5d96e97c.1c69fb81.c1579.7521@mx.google.com>
Date:   Thu, 03 Oct 2019 23:41:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.194-100-g9a8d8139a7e5
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/99] 4.4.195-stable review
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

stable-rc/linux-4.4.y boot: 90 boots: 1 failed, 80 passed with 8 offline, 1=
 untried/unknown (v4.4.194-100-g9a8d8139a7e5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.194-100-g9a8d8139a7e5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.194-100-g9a8d8139a7e5/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.194-100-g9a8d8139a7e5
Git Commit: 9a8d8139a7e557ce81c19f467a2a873371e3deba
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 45 unique boards, 17 SoC families, 12 builds out of 190

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

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
