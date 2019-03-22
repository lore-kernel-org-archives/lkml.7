Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E38218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Ol2i+HtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCVUWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:22:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56236 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:22:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so3343232wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=eoauUn5UHy2j2ei4Iho+45cdFIKf6YoffOa3j1GQALQ=;
        b=Ol2i+HtSZ0QDA+PfOzCiqzzVhmahXNHCXgX9+V8sUBfY3Y9EDd696OiBq5RpGeOsJc
         nAdih3RMoXSWyYuaAlRyy5ZPIRHb82e6YtyxSiVshWeXiyb/4wz2m9BNNjHE6nBnLsV6
         rJAzd5xoDBvumFJ9twdKg1ZN5BNJyP5RbFP1hRMl4tFRH/CLHwEKf/0M4z933JkjyniX
         v3WAMsDY0VmiTzXzRbFvGQLTfdgOiwBvxQFub2/bqjLWa5H4Vj1ZdwIy9KaLPpwtr0JO
         ErkBiD8U49mXTT6ePnL4dR2eaAPAZ5pEvneOfEKXJOUByuR8by2CK2H2rpxieSDfTfL5
         FwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=eoauUn5UHy2j2ei4Iho+45cdFIKf6YoffOa3j1GQALQ=;
        b=oC/td7jyhCG2yj59jRos0E7d02G8FXt90jUMC4RL0ZU4NJwpGKeGk+dDFa2oHiurSm
         ItsjK4lsUujjpdSaHG+F+zh1jU+LVgdU/x4jSTijnHq9Bmb42Q3IEOktt74Cta7jZXL0
         1CrAxGiXh5xxpknBWp4mojQ52DB4Zyl27FdE6slJiRz1JMtNB0r0qeYfSoaPTB6xClbh
         PDNJXkOQhWFm2QIwZpECoEmfhB2xQlobhCfpmsD9ohPONlOpCSQ4SAq9xdiBFlVVOLFb
         ytrsEM+tfV/HEt3bz/3WdAdOa9b0etCqNmawaVpiA+ygOf6ij+YipU1Ok7+cxg01mqLX
         jasQ==
X-Gm-Message-State: APjAAAWmwymFDf0gSiaYNkVnoSJSWf3/BrH09NTHzwRQiRoI2W2V1+fz
        +1/f6MDAztfr+cXVXT2wIV79p2gXNCqGRA==
X-Google-Smtp-Source: APXvYqx9cVYx5smQnW8HJQd7NfkzxyWZERkffdG/B3H4rNhkZtC86UnCJMflVCsKYu1xf9m4PKtivA==
X-Received: by 2002:a1c:f30b:: with SMTP id q11mr4294207wmq.118.1553286173343;
        Fri, 22 Mar 2019 13:22:53 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t15sm8469652wmt.2.2019.03.22.13.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:22:52 -0700 (PDT)
Message-ID: <5c95441c.1c69fb81.3ca57.b354@mx.google.com>
Date:   Fri, 22 Mar 2019 13:22:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v3.18.136-135-g0ec48545fd19
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
Subject: Re: [PATCH 3.18 000/134] 3.18.137-stable review
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

stable-rc/linux-3.18.y boot: 26 boots: 1 failed, 24 passed with 1 untried/u=
nknown (v3.18.136-135-g0ec48545fd19)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.136-135-g0ec48545fd19/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.136-135-g0ec48545fd19/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.136-135-g0ec48545fd19
Git Commit: 0ec48545fd19e7d77e038eae2475b73969f53a36
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 10 unique boards, 6 SoC families, 8 builds out of 189

Boot Failure Detected:

x86_64:

    x86_64_defconfig:
        gcc-7:
            minnowboard-turbot-E3826: 1 failed lab

---
For more info write to <info@kernelci.org>
