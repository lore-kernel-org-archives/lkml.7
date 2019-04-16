Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE505C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735E020830
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="n9trMxwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfDPApB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:45:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:45:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so24383916wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=nwqWdKDazLS00hggTRRpuRQ6y3jGgHUjt5ipPuCA8p4=;
        b=n9trMxwjUNneqTKhbdZWSwpO/DCL0Souj4jIJrPt2IS8Sn251+tP5Dhed+XqoFaJrx
         8n7MJ5szvypmntd4qzRBPE+7xunnkti0xI+4j81KbW2GJw3cnjWCYurvwZxrahT/zjXu
         r2flA/iCwz8VrPrfaRIIJ3Xr/IWSt0Y/M3qkb5D6CGcm3NrgUjOUnUrz2zwepmw7e/6v
         GYI5oMY4sbDN8Uypptf0OLhmIyHZAuME9N98H8ool3Po7vfjJ6f0a7JNQPM1ALc8nts1
         KCxLAef6sguboyDPK/+vIUWEC/MzUqc/aA2Bwi4UhSpxrT5vSFvYEzqKdrvvAfQooUNH
         kiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=nwqWdKDazLS00hggTRRpuRQ6y3jGgHUjt5ipPuCA8p4=;
        b=hT+Tp+apY7yAVsa0tYCed7+Oltwkc4MpHOEexMgKz0oAYfdbSCzNOl3zUUMm3UIfHB
         OzWzjEwMZeZj+XHJxrDUxg6ciHyxts4bW6rmgcGlOHc6fPpOHlfChPZfk7/zyWdSYwuy
         MYM+oK02lKcDS/hV1gB8GmQJPP7BaIoNuZWiE62QTyi2oJPK6QVKsPbTS42LKn76+xkk
         aap09DtXmi1xQXT6KQwPDcN1gkB4tA2p9RW9iqwLQHdQFGTrJJqw8q1gi7wg3Nhl+gbf
         +9QXPXcDqgU3Zo2dmnnknmDZ5uvFakHrhNn2RD7k+OEtL1pZh23cUmRqYGqLojWiddsX
         XIfA==
X-Gm-Message-State: APjAAAXZRIWJydSOwM2LauI5Q15fAi4lmeDGlKHH1DcrWjl1T/6fOaKi
        s/vpNvX21TJrtDOTBJPgAxOvMA==
X-Google-Smtp-Source: APXvYqxgDVbSPGR+vJZgTgx6Rf2p4M7KtbUWmHyAMMjS6a8ZOWNOdHXyLcZ3KorRG3Vi2t4vIJv61g==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr44026772wro.2.1555375499173;
        Mon, 15 Apr 2019 17:44:59 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z7sm51307696wrt.10.2019.04.15.17.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 17:44:58 -0700 (PDT)
Message-ID: <5cb5258a.1c69fb81.81057.69b4@mx.google.com>
Date:   Mon, 15 Apr 2019 17:44:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.168-77-ga5905936a4b8
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
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

stable-rc/linux-4.9.y boot: 92 boots: 0 failed, 83 passed with 9 offline (v=
4.9.168-77-ga5905936a4b8)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.168-77-ga5905936a4b8/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.168-77-ga5905936a4b8/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.168-77-ga5905936a4b8
Git Commit: a5905936a4b81c2c035f5abf34914d802573b0e3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 22 SoC families, 15 builds out of 197

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra20-iris-512: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
