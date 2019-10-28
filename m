Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1518920663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="L9kaD5OW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJ1Cfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:35:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36296 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfJ1Cfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:35:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so8231299wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=sCnueQboB7yjbqdY0v/k1fqToGKy0OAW4/Awe/F57nA=;
        b=L9kaD5OWOg/WgPujdLk8wzDYIhmlcsI4gg7jGMDnCi+bKcG8047kW3vHJIfot3EgBx
         HWB4KVt3kGtrZU1NfmzcUp9MpkXQodpZXvQwZfcHZKpk5K2RU8ihCd/kKIdT6/S1JSpb
         8wP1w1a0wKcP+UH0TGFcXuvonBvZNcJ0D7ntuFu6BmTjbmSMrJWfDW8EvV4JRGQwM+7z
         38iZ0nChGg6kyqKqwCTAcKJ6FQUcHpf2YKVTi+EnfZ1YqCJUD13iNUzdzl1piJnI9A9t
         bkp/Qowh4YbTP1JynmG0T2IKj0ysrARLH0X4tmO97k3uLdSitG4zSYubZ4accn579RTm
         WViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=sCnueQboB7yjbqdY0v/k1fqToGKy0OAW4/Awe/F57nA=;
        b=j1TDREg17FXeKpF0e31yqm84aoKggX9JKKz8U6Je+eY0SRBaBT8oZt5EHvgh+kUoWz
         7v7LpRLrxsG1YGD+1Gz2mojrH0+HdTaOSxAib6sBOLf6FW1jpR5P2bxE4zAljLhAxVAO
         X5bNadKW9h8kRcqYPDZBrJ2gS4AGzt94KerGAtbaxv2n8wwOTw64CZa1acx595MMh2qY
         UNYWY+z7uZJIX1qP57B+83tbIItJ/oOL5kBvDEvIuP5cMMvedLZtzEigNKwfJvz/Zl5h
         ZGMUL4XvQGhlnRep/DRDTyhOA/ZZhM8YfX5FOpiKSFf23A+QtcolchAuyxnAdYGdpHUt
         wCTQ==
X-Gm-Message-State: APjAAAXf5Y2zy8QjGktoP/9bWtQrHdtoicjQ+P9/+lThGP8Dav+CHSx2
        BOBI/33uGR5+9zAYVAM0GUzAiA==
X-Google-Smtp-Source: APXvYqygXmEm3sH5pm3LVCvjvkJ/LAQnPV6M9+KKIrTYiwuwKz7cwqkLi9EPCCLWypWeLQHm4nGSLA==
X-Received: by 2002:adf:9381:: with SMTP id 1mr12891363wrp.10.1572230139518;
        Sun, 27 Oct 2019 19:35:39 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b196sm12711847wmd.24.2019.10.27.19.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 19:35:38 -0700 (PDT)
Message-ID: <5db653fa.1c69fb81.5a707.f77d@mx.google.com>
Date:   Sun, 27 Oct 2019 19:35:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.150-120-gea1df089eebe
X-Kernelci-Report-Type: boot
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/119] 4.14.151-stable review
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

stable-rc/linux-4.14.y boot: 117 boots: 0 failed, 110 passed with 7 offline=
 (v4.14.150-120-gea1df089eebe)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.150-120-gea1df089eebe/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.150-120-gea1df089eebe/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.150-120-gea1df089eebe
Git Commit: ea1df089eebe2babf969ff53de3fefe3898c2362
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 63 unique boards, 21 SoC families, 13 builds out of 201

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>
