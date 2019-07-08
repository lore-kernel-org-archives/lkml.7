Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D3C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488DE216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="JQ1dItqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391152AbfGHTMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:12:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54646 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfGHTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:12:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so601074wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=K91t+FtsfBSUcSDS3x3jNNU8zFh5v/uXYLs4sWDTadg=;
        b=JQ1dItqNHVtvJ3YcIF4UShPyQ5LAqp4n/nsKRJQCM2pkOwKj72l6twA+nroOhRwRST
         RR3jHx+WQxM4rL+ygMsWSqlzfiUk4hjHW1Fit7t8+9PQzB9+E+9mf0EHI5cjx2Ogd2Ou
         wQ88bPOzy1VaAv9b2lDcyUYXOPv+u6fdUt0a37HibTbu1bBYxoSMiaDG63NLDJWq/5vE
         XGjR+3jhgH3WleyLhL4wHIAehCmYmvQ5YK48BDuyp4XAhjz2u1jsqqudrknK0FG/axzl
         4ZVKDFNTlj7sc74PSIxlXc9qnJowPgRcehUZfhjvi79lJWiByxtELbAqVn2WZlh+6nqj
         frpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=K91t+FtsfBSUcSDS3x3jNNU8zFh5v/uXYLs4sWDTadg=;
        b=cbenvC2TwoTMx8yWrrMNuwv45f2zk7zo6i+oXd2J0VbVH9mOj/2OfpqJsFkquJf6yg
         uOWmAZT/r86BqziB8beUNNRO8Q9fvTBWokWQNH7p5DbFU364F9gfDyBn3wS8y6MOZTg8
         quSyV51VgyzWFC1H8UGCsO1NFgo59n56UyxY5idI8TGG+lmdUbKHJatpmsGUt8v8/QZP
         F2L6ELoF5WzAOwiHqAFDel+uDITWi6MgIi+pmhoktdfpRZPu6Y+7aWCZTtV1nqajUosq
         /o/7O9eYCo4QQu3DlEKwBDD2Q6Qt+L7WuQ6F29jRj4dpAv1HSKAQ8r0D3Ti7wuE24L1z
         W0uw==
X-Gm-Message-State: APjAAAW3uMVIGjbWrWZLRLJCu4xIsQBDpr05yaNxtYYW87jEhDMtwahw
        Tfj8UUk3G0yd9TiPYW54vgUbxQ==
X-Google-Smtp-Source: APXvYqze2ejGTZU+LIj/GN7jDGL5U4KMBJsrIA0HOLHCTbE/A6UpepKmCzUp4TCuRFyDOgqXwg51bQ==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr18206495wma.46.1562613161948;
        Mon, 08 Jul 2019 12:12:41 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u186sm771409wmu.26.2019.07.08.12.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:12:41 -0700 (PDT)
Message-ID: <5d2395a9.1c69fb81.41685.4bf6@mx.google.com>
Date:   Mon, 08 Jul 2019 12:12:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.184-102-gf075c4e9d730
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/102] 4.9.185-stable review
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

stable-rc/linux-4.9.y boot: 94 boots: 2 failed, 92 passed (v4.9.184-102-gf0=
75c4e9d730)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.184-102-gf075c4e9d730/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.184-102-gf075c4e9d730/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.184-102-gf075c4e9d730
Git Commit: f075c4e9d7301b229ebc16b6ae51dd5094802c48
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 21 SoC families, 15 builds out of 197

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

---
For more info write to <info@kernelci.org>
