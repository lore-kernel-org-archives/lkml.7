Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADABC17442
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFED214DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="L57qdSK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfKIBRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:17:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53470 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKIBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:17:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so286575wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 17:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0dI0N760IiNitHImF/wM9ggQoHbHXE7osrTopRR5tok=;
        b=L57qdSK5Tc25FxZVZKn1/T8GqpUVe5PrVDVj3yPg7NHYtmO1K78G+eYr9RFV2vfxJ3
         TJk+ujhTpN7iH4+NEW+DoSwWHPYeLhmZh5SWfgSl9LMnyu/sHcvJgCi5b58MMdoCQ+s6
         ELAWoLGUYq5QLt32vShNooiV2DPSe24yPj7c5kRyDHuuy6TsGWW4JDZsBtPJ25++UczN
         /uAIuiwo610PqvryhiueO1jRnf2xZ1AQ503aB8sqBmfCoCjDShgYfr8f2mZ8CJPEBByO
         4SgqPEMVIFfmiEzycYnWP/eYHos3f0pCZk0dFh9rxVjFjr3EkbhLsuqdwq3XuLanMdQ5
         7XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0dI0N760IiNitHImF/wM9ggQoHbHXE7osrTopRR5tok=;
        b=o6CDoWj2fs+rLWGWuxCyfOJj/oT7ZYBdNhCDLQd9JSlQjQGCeYyK9i198OORUFcZd5
         dMTbLRfnz+fJrKFKbVXDD7JT7DWSI+pam9AKbS+lTeFjouR9sYcMP6xUx0aKW9nGcBhd
         G/hPdJLwt6HKnyc0h0HnYuR2xtTfLsUhrYfhLMHn4fLfGq7GxpzsSVcxXmNNkB53UHIr
         83AoZEmm0pusvvxXshrVWzcsbV9R5YeVFi0x9mUKQROJMnn0K0qGVUpi8cNDFalAdBIm
         THrbDcvM6L5kMEIGt4XyuxVVgwAgOhxeaPZmUfiLHsjkWusGCtos60FuMYi8RMVifA3o
         uz1Q==
X-Gm-Message-State: APjAAAV7pr1Y/SjqgMW5UXZNzjwOX4de/+DF+jXsl/Cpw0yIxHiprnz+
        1tOmxwwvkJ56tzb7xD9L0Ajnwg==
X-Google-Smtp-Source: APXvYqyqyksRnfuFIWQpVjzLXeApBDBSj1AFX3eKJISQGQYgDsUqXxzpJI/FAmPo8JTQwrkYCYBsCQ==
X-Received: by 2002:a7b:cd0b:: with SMTP id f11mr11253854wmj.26.1573262272354;
        Fri, 08 Nov 2019 17:17:52 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b3sm8382432wmh.17.2019.11.08.17.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 17:17:51 -0800 (PST)
Message-ID: <5dc613bf.1c69fb81.29693.c3bd@mx.google.com>
Date:   Fri, 08 Nov 2019 17:17:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.199-76-g6afbf4832d8a
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/75] 4.4.200-stable review
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

stable-rc/linux-4.4.y boot: 80 boots: 0 failed, 72 passed with 7 offline, 1=
 conflict (v4.4.199-76-g6afbf4832d8a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.199-76-g6afbf4832d8a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.199-76-g6afbf4832d8a/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.199-76-g6afbf4832d8a
Git Commit: 6afbf4832d8a30149fdb36136e222f795f2e9ec9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 41 unique boards, 17 SoC families, 13 builds out of 190

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
