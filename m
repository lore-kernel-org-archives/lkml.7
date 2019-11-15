Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF25C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BC82073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MUMcguYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKOMAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:00:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46237 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:00:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so10674227wrs.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=xswx1TYcTCN/R8BEco33f7ioZ6ZLAVd47u0UZeI2jCk=;
        b=MUMcguYJF8ajnQ3y7i1PjDdTyM+BQ2KMNnYfE1qxTk2qXijwX+4CN6nCI8Cgsutns8
         Uzi+Zbxlm2231OvJMmIkO6dj8PkMI+acnr8gaPIh85xqikCPKOZ+NH1zvwPWxEAYrlkg
         dDi+5IwLYwFU6X7ODSHQ0MaTD/dw2Gzj/5CnutAqBXUkgLR4oxNao3Evtrj4fkXdgZZB
         vxpZzjUPqWn0D0TeY3FLRUM0T46rggV73MXPD0BbBUAwTwKe+UcVCVjtV5gRZB90B9lM
         wUhW54SVL/o1ZXfrL5y9sXoX4K/WqYlrCBZKkEHg74bvMEINce/LnOq1cFdKMNi+WHDa
         PY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=xswx1TYcTCN/R8BEco33f7ioZ6ZLAVd47u0UZeI2jCk=;
        b=Vb6pb32vyZXPIjxU1IbJNCtoQJrmf43dKy4EqBJ3zASDxfymZNCX9IX4u38+2PlTYs
         4tWDaeuk0chx0FW1stSG4gW89NPVN0kfH67sagT2yYN2XwMql9LIRoaCHhPexPm4D8IH
         RxZwON2Fm57qHZ/1HEx1Nzv5t4EhOsAZYT/t9znhB12aFcdn0x/hChK0XLsnW6iTl8Zu
         WC6xkdGCPrbBpY4A4RIazbQ122qcL7gTif0pRDf/ol6beTFkjfu85zo36ngmdBmkMLla
         yqRG61bFHEE3wmKHu+tNqqYGFQZu9btGR/Di5wBT6OX2bhdD0V+seFdjyniF4D6e0EHS
         9VqA==
X-Gm-Message-State: APjAAAW4hbcZkE4hCiJZY7PNzIzvjpLicSZT7G2evKg7f+HdJGp0wBtl
        bhdu2FXr54T2Hk3PuZGxeflh5A==
X-Google-Smtp-Source: APXvYqzzIgy/syrF3JnQEqeoEyHU6giJHzqN+5y+DMC43YNF5J1SmtmtN2HDN0/nAsrvn036HOXSWA==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr15426058wre.286.1573819203903;
        Fri, 15 Nov 2019 04:00:03 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g4sm10390750wru.75.2019.11.15.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:00:03 -0800 (PST)
Message-ID: <5dce9343.1c69fb81.322d4.273d@mx.google.com>
Date:   Fri, 15 Nov 2019 04:00:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.201-32-gd7f83e4f45e8
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/31] 4.9.202-stable review
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

stable-rc/linux-4.9.y boot: 93 boots: 0 failed, 89 passed with 3 offline, 1=
 conflict (v4.9.201-32-gd7f83e4f45e8)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.201-32-gd7f83e4f45e8/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.201-32-gd7f83e4f45e8/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.201-32-gd7f83e4f45e8
Git Commit: d7f83e4f45e886d919bc985bd225b8355ddd9284
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 19 SoC families, 14 builds out of 197

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            bcm4708-smartrg-sr400ac: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-collabora: FAIL (gcc-8)
            lab-baylibre: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
