Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4887FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81952084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="E3DsFqNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfLDPbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:31:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54622 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfLDPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:31:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so139731wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=ijoLCBnJ3pPexA/GR1FIE4d3lIT82dN/vPnRiftiEjE=;
        b=E3DsFqNYYoNk3wJ8krQcMebT9+rMBTieirdWX7fi/YE5D0FA1P8YnZ4k8ZZNAJObnb
         fwLjJ+H6rCS2tv9FYx6CjYeL8ThmCGHLTgz1oQ2HYmorHjwTAm/xeNKu04RpHTjQgQSG
         AGMUyh6S3BMEQ2BLImO5bJKMED3wiqljPM4VykXcD+mEnl571jShECGkL0tKNNGvDoji
         nfb8k2Z2q5tf+39Edjv03J1+IuyiwI+cL3VIBnhH/7Rb68MAKPpO7r9CJBczn9CI13DP
         V6MxlO0bM2m5y3GEm0o639CBJoTN6oHCbL6mrpT1tHVhxqbw3lA4dmRFoeoT9dGPwlCV
         RyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=ijoLCBnJ3pPexA/GR1FIE4d3lIT82dN/vPnRiftiEjE=;
        b=q+/9qEyZyaVr26CPDeCklTKgn8X9k62bua1NqiYKx4al1qiBj2p0huSJRzWz8eGr+s
         3eJcLeihWQxCtVhNwfZnKYDhhh8OaZrHjyQJQujxCDzIASONmdLDfXcVOD9Vc2Xjs8uC
         JvuWBQA//4HTuqW2wPm61J5sUw49Iws1fEPcV35mEa2XliP9SUmwovKb0BmESD6Fq0+o
         t5crfWJ06ZPjiOTRFEEDFNOz2Tj0fY18rV6jQe1RDolrdI9PhrovAK1qQxiVHdt9qIoA
         vK9hmA+R3vLvvgUvnEB7RomVnqw1tTquiBVxyfgMJrtYpwtdEBBrp2UB73PcI5PtMfzL
         sqIA==
X-Gm-Message-State: APjAAAXE+facVqFIeCGeMlsc7z3g5c+869VDMR1qBUbP4GyBniLyNGMj
        blMqubQXnUbUypPRcVjB15xtdQ==
X-Google-Smtp-Source: APXvYqxbr+RDuWTYR72YaOoOSelg81h69keK+nXeReh9jM343ocfrIvOsVlWJnN/+vq+YcyK7XaPRw==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr133439wme.125.1575473494478;
        Wed, 04 Dec 2019 07:31:34 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u10sm6971432wmd.1.2019.12.04.07.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:31:33 -0800 (PST)
Message-ID: <5de7d155.1c69fb81.c06f8.3583@mx.google.com>
Date:   Wed, 04 Dec 2019 07:31:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-9340-g16839329da69
X-Kernelci-Tree: ardb
X-Kernelci-Branch: for-kernelci
X-Kernelci-Lab-Name: lab-collabora
Subject: ardb/for-kernelci bisection: boot on rk3288-rock2-square
To:     Ard Biesheuvel <ardb@kernel.org>, mgalka@collabora.com,
        guillaume.tucker@collabora.com, broonie@kernel.org,
        enric.balletbo@collabora.com, tomeu.vizoso@collabora.com,
        khilman@baylibre.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

ardb/for-kernelci bisection: boot on rk3288-rock2-square

Summary:
  Start:      16839329da69 enable extra tests by default
  Details:    https://kernelci.org/boot/id/5de79104990bc03e5a960f0b
  Plain log:  https://storage.kernelci.org//ardb/for-kernelci/v5.4-9340-g16=
839329da69/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/=
lab-collabora/boot-rk3288-rock2-square.txt
  HTML log:   https://storage.kernelci.org//ardb/for-kernelci/v5.4-9340-g16=
839329da69/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/=
lab-collabora/boot-rk3288-rock2-square.html
  Result:     16839329da69 enable extra tests by default

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       ardb
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
  Branch:     for-kernelci
  Target:     rk3288-rock2-square
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 16839329da69263e7360f3819bae01bcf4b220ec
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Tue Dec 3 12:29:31 2019 +0000

    enable extra tests by default

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5575d48473bd..36af840aa820 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -140,7 +140,6 @@ if CRYPTO_MANAGER2
 =

 config CRYPTO_MANAGER_DISABLE_TESTS
 	bool "Disable run-time self tests"
-	default y
 	help
 	  Disable run-time self tests that normally take place at
 	  algorithm registration.
@@ -148,6 +147,7 @@ config CRYPTO_MANAGER_DISABLE_TESTS
 config CRYPTO_MANAGER_EXTRA_TESTS
 	bool "Enable extra run-time crypto self tests"
 	depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS
+	default y
 	help
 	  Enable extra run-time self tests of registered crypto algorithms,
 	  including randomized fuzz tests.
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 88f33c0efb23..5df87bcf6c4d 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -40,7 +40,7 @@ static bool notests;
 module_param(notests, bool, 0644);
 MODULE_PARM_DESC(notests, "disable crypto self-tests");
 =

-static bool panic_on_fail;
+static bool panic_on_fail =3D true;
 module_param(panic_on_fail, bool, 0444);
 =

 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [b94ae8ad9fe79da61231999f347f79645b909bda] Merge tag 'seccomp-v5.5-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good b94ae8ad9fe79da61231999f347f79645b909bda
# bad: [16839329da69263e7360f3819bae01bcf4b220ec] enable extra tests by def=
ault
git bisect bad 16839329da69263e7360f3819bae01bcf4b220ec
# good: [25cbf24a7eec7c3dee4113b2e98b572e128009b7] crypto: aead - move cryp=
to_aead_maxauthsize() to <crypto/aead.h>
git bisect good 25cbf24a7eec7c3dee4113b2e98b572e128009b7
# good: [7b19c7a82950ed034645fa92adce29cd6163ed3e] crypto: testmgr - check =
skcipher min_keysize
git bisect good 7b19c7a82950ed034645fa92adce29cd6163ed3e
# good: [062752a354aaf03b46b86cba5fdaa2fd5c932860] crypto: testmgr - create=
 struct aead_extra_tests_ctx
git bisect good 062752a354aaf03b46b86cba5fdaa2fd5c932860
# good: [2cd56a00fff8584e342164c65e6b55da61f79c4a] crypto: testmgr - genera=
te inauthentic AEAD test vectors
git bisect good 2cd56a00fff8584e342164c65e6b55da61f79c4a
# first bad commit: [16839329da69263e7360f3819bae01bcf4b220ec] enable extra=
 tests by default
---------------------------------------------------------------------------=
----
