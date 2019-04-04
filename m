Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2184C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814A720674
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="AkEPeeMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfDDQoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:44:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54280 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDDQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:44:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so3813134wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=YpLOPOua607JN6G8G6zJ43r6p8dyzZncJOJL0tXdjpw=;
        b=AkEPeeMeUddK122Rg870xtwkmjE/BFnUc70FFti913rlgbM8ioILuHsredFVuVSQJA
         iFwAx3lqGvdNrWoYDBo4jMWlwY3ap+aigBFMlvSIqPV45P9IhyTH35E6+yrkYfBk8QkT
         Xq02qvU4cnWIiibmuUsiRYIIyin129lKaFpIK/s+G+Is4O2gSeNwoc37VC28YUAaBeoq
         0EJQ+oTpkTT42l3m+1Nj4XOck9enk9nlbztNRdOEhZ/3JT/6Kx8QOM6jxdzRolESMFFV
         JzEp8+CkO6b67MAcgIX78mKYuUqmNdZJCzHh4eW5N6YMGmt3FCI7bgHL7RQKxR/Og1FC
         LNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=YpLOPOua607JN6G8G6zJ43r6p8dyzZncJOJL0tXdjpw=;
        b=S20kTD8n/vDNbXsoO7XSoI8BpuRrGyE1Q5MyfQL01hB4bzTbiLCPtQprs235wH05jw
         xbrj9GjHf2J0SgLhn1RuEjxQxBEbDKyHB/3+co1NB4wGvd7OIMqwVAfTCdV0q/LLEG4/
         eXzYo3waz6Z655f8uJWYKoyenHdWV/CObpm5nKZroTaChkk1SU8yRJVpf3nrgiDHEiRn
         Gq/qGUwTY9UtFeVpaSbEG0fuE7tu92BXoMLdWZ+gjvpF6hkge/9cUK1XP2fADLiLRFVD
         xUg9K+Spx32pTAPaP9Ud36jzKmM+ovgJoD1UgEcafHElW4lPtgrJ/RFOUcZBQwzk9EA5
         8EKQ==
X-Gm-Message-State: APjAAAWpE7R3inpQDrKZuMCke+/uDoWQOSJx1l+deBTlsL8NvAqSPsoT
        UtDxiXXQaeALd3k+SQHAcvbNKg==
X-Google-Smtp-Source: APXvYqwvCFnhOiDC0Q+hmy3qB8lD+3bf/jJokUM0PfmQfaGNWAVyl/uaxwRwDFLBVezK7DIu0u63Kg==
X-Received: by 2002:a1c:6c17:: with SMTP id h23mr5106123wmc.122.1554396263098;
        Thu, 04 Apr 2019 09:44:23 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d4sm17155238wrv.42.2019.04.04.09.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 09:44:22 -0700 (PDT)
Message-ID: <5ca63466.1c69fb81.9b5de.2bde@mx.google.com>
Date:   Thu, 04 Apr 2019 09:44:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.167-92-gea283005c82d
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/91] 4.9.168-stable review
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

stable-rc/linux-4.9.y boot: 101 boots: 0 failed, 82 passed with 18 offline,=
 1 untried/unknown (v4.9.167-92-gea283005c82d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.167-92-gea283005c82d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.167-92-gea283005c82d/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.167-92-gea283005c82d
Git Commit: ea283005c82dc0416d18a004588a21ee706cfabd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 50 unique boards, 22 SoC families, 15 builds out of 197

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

    socfpga_defconfig:
        gcc-7
            socfpga_cyclone5_de0_sockit: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4_xplained: 1 offline lab

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab

---
For more info write to <info@kernelci.org>
