Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1999AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F54206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="giQ4xvUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDAVXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:23:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36655 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:23:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so1050290wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=onBlkldmh7BALnXZJWf1VdyvfDChS+z84IMN5JixKi8=;
        b=giQ4xvUw607njPy9xRDn10DS5tp/bQZjD0R6j6d/qUJIT02yior3+rVnNFDZhdmh0g
         cyDBxiH7DY2O+XlnEJYfTAlJ3KvUpPuPg7cXVBpjui/NeTEZ+KeiHOzHwlGr0fpasxzT
         qXBGi6+jhshgtl7UtYhNAYkQFKi6aKoAOPRuB8XNZA5nQ3rAnwWztkqj5FPMyyYAa6zn
         dnOtAPdNGYfiIlJZZ/Uulr+IHUd4xt6jJ6N5jZnNA/lROBpHWhTxwDfANf8nPCWRpZyf
         B7idevYpPw2FghrWeghNTHUhMor3LNGLLACLGP8iRRx3hnuJ/eSvxpjUxRWBNdPKzlYe
         7fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=onBlkldmh7BALnXZJWf1VdyvfDChS+z84IMN5JixKi8=;
        b=tFsaABfW1eypLI0GWiFjFVjvcSk678hu5MQ/VFSOg385AhJtrBypPUKdT0DD7YijXs
         CRyCdNzt6abteWGyTOXQBx4hr039uTCSoZav5pn4Qv7AmCmY9x6A7oMVJ1g4D1th2OAS
         M1i4jqt2Tyax9kLVdn1C8oABfYyFYAnbs/GVe6Q5d0IiwPHJMWM190HaEcOm8fc3vYje
         IaTeYMsGMGY6vRCXZSmd6poJgRZnWRkraksbrUqIc6du2xVfgKeSWJvz8DiDxyGtw+U1
         DdxpVdcJTfEeovUD4r4Crsh0lsjSgfaW0J9gsoMM8QTs0+6GRzhhxn94ZR9H8SVv/g1Q
         cZIw==
X-Gm-Message-State: APjAAAUHBTAUqaWYat5BBDl6Np6H4JzRrnSfCxXBnT4tdPKt+WljqKLg
        oc81sGJVmRZ2RdxLstu+oQYuEQ==
X-Google-Smtp-Source: APXvYqwzhnGhSbRVNBoqyf+gB2R61ca53LArgMf76vAfjEuOke2uZ7k3Q9Lah4jxs58c5gBsaTzJeQ==
X-Received: by 2002:a1c:c186:: with SMTP id r128mr1044204wmf.100.1554153824697;
        Mon, 01 Apr 2019 14:23:44 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c10sm13336138wrt.65.2019.04.01.14.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:23:43 -0700 (PDT)
Message-ID: <5ca2815f.1c69fb81.77d46.4388@mx.google.com>
Date:   Mon, 01 Apr 2019 14:23:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v3.18.137-50-gf4aa2d82bdca
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/50] 3.18.138-stable review
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

stable-rc/linux-3.18.y boot: 53 boots: 1 failed, 46 passed with 6 offline (=
v3.18.137-50-gf4aa2d82bdca)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.137-50-gf4aa2d82bdca/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.137-50-gf4aa2d82bdca/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.137-50-gf4aa2d82bdca
Git Commit: f4aa2d82bdca82159575d7f668480a1b4f83f284
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 23 unique boards, 12 SoC families, 13 builds out of 189

Boot Failure Detected:

x86_64:

    x86_64_defconfig:
        gcc-7:
            minnowboard-turbot-E3826: 1 failed lab

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4ek: 1 offline lab

---
For more info write to <info@kernelci.org>
