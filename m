Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33054C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F000120854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="mLmEiLrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfD3W0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:26:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfD3W0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:26:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so5432436wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=VXYwZpX1d+wknY0tSOqvdnHG027bEu0WR2/eqUIGUnc=;
        b=mLmEiLrOszkjvWQmhv5Y63FqOFF5a7VybPmAa8ZnM6eUIVod5BYlQyeE4QfvwlR5NJ
         wzvoF48WoPU7qIGUp01G+0HFz7snAUq8DOLqBcsar19IkvH+GojvzrkGAA03Zo56VW0v
         PeXpaWaR2OSno0xfwaUj5pMMB3XCU71uDvHHSMpmBa9qe/7x9v61mz2f6QYnNyXTHfa8
         c0F2jYdO9/w4Ccn1Xo+2esy1tp/85RInpkJVxvbd7whmyAaW0bpWRi3NLtypypYE7XV+
         T5bifWMRFfSAcA5JiAAkZXpKubwl0FT/6bD/aCwkv3rl2xoG2VDjoEz9em+uC0JZZiJ5
         /n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=VXYwZpX1d+wknY0tSOqvdnHG027bEu0WR2/eqUIGUnc=;
        b=A1JauNnwq+nwuOIeg0K4JFBfwK1WqkKu/Xiqkx+vujRQbKhLRDfd4oc6a+XxEUdmC5
         dIX0lpmsxZgdfdKDVynqMJBzbnPdF/4F3P83byJZdAck1XXB3MqHU2iF8V86C3Cfriog
         MVoM4SDA9OKqbHLT+j3weBfOJVHZvuTb8L7+CqopUK2p5hHig3MlWisOHyUy/r6kZM9V
         8J2mZGJQzjGj3CYrAj54YnhgiKLeziMNRHMHjeKgpZG85W1DxRvV6rwua/oINHja3aGu
         4uNkTcRtXrG/2SUt3sgUFGzFKnxFxWykCEcD9yfKimgbCn+3/nX7KurI2od6TJWoEJ+3
         Pq9A==
X-Gm-Message-State: APjAAAW6f5aYOx5dEyR/U1IpOuFY5Gsossw+5WdiLr612SucYs3LKf8a
        dvRBhT00/1LEJx6cDTEoqHyxRw==
X-Google-Smtp-Source: APXvYqymoEF3vOsE3u+wAezZJxUo2QTFYbZ5Uz20HoxFagG5+NUSGvI2+6lB9uATQsmHDxyQRKuODw==
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr3686065wmc.95.1556663180349;
        Tue, 30 Apr 2019 15:26:20 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t24sm15073738wra.58.2019.04.30.15.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:26:19 -0700 (PDT)
Message-ID: <5cc8cb8b.1c69fb81.1f94.04ed@mx.google.com>
Date:   Tue, 30 Apr 2019 15:26:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.171-42-ga707069e56d0
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190430113524.451237916@linuxfoundation.org>
References: <20190430113524.451237916@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/41] 4.9.172-stable review
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

stable-rc/linux-4.9.y boot: 99 boots: 0 failed, 96 passed with 3 offline (v=
4.9.171-42-ga707069e56d0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.171-42-ga707069e56d0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.171-42-ga707069e56d0/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.171-42-ga707069e56d0
Git Commit: a707069e56d0b0365daa528a05c6388b41cfe4fa
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 52 unique boards, 22 SoC families, 15 builds out of 197

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-7
            stih410-b2120: 1 offline lab
            tegra20-iris-512: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

---
For more info write to <info@kernelci.org>
