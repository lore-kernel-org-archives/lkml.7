Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F347C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5F20692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="1eBnZE/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfIMT7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:59:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbfIMT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:59:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so3075776wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=TdseWFi9nNeS6hr9vU8WMp7sk4P8F8KbbFD+cmn/ufY=;
        b=1eBnZE/+gh9aEOaSP2pMP908RRNY9uy1w9hH+H0Z1cp6geaVgU3mChga6jyRi/7Tbt
         veg53Xkay91ImDnDnwh46ECDoWdDd5JAbdZhWcHyDVes/zAZqLIpz5LhDMvLABZiylbN
         NM2ELn1myjOeYVxitL8VbegAnzlbdd3VkaBwiouoKkQJ9awUUSoJs9j9TqNo8eXTNDQ4
         S10k2IsVmnfLRk0b+rXWvaRG0XlCNvrDCg2gjnSulx9QngV9fPfKa2ONJoombcVZ8k9y
         pVQnWDBe5CJhpYpa0FMfGFEgRIelvwiu30tIw3s/BEAQ+N712lPldxcJaP0kHqe4ympa
         bubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=TdseWFi9nNeS6hr9vU8WMp7sk4P8F8KbbFD+cmn/ufY=;
        b=JbT6zZpUX8zszPuqB9eLl0YePAq1cwIImlq/UsSk1KuXF6znzjRVwPLPFAS+yLms3H
         P4Ll0/ZMd8+8IXnTbAzdN6Rd0Ed+efQ9U2XvgHeooZL9+tK2qBX6SEF8uebTqfztCwwH
         pFb12QKnK2KnEqKghlFqicRxuehp2grxcosi4TvBzR7ZQZVhDY5MyWhcFdhOyI8Quwmf
         4APNFupWZMIzqG7HKUvVD3DIMSHDV9YOrM16mE0OioOJyQr2eWR5MNu+EIhGzICOtScB
         jXbnOJiCqayzxhL9xvKMf4WSoEM8qRaPp3eJQYGjYF0t8cnJKzJI2FKtR6n4nwpJ19aH
         /rhA==
X-Gm-Message-State: APjAAAWNQROqSx080Z2fStoq9CrM5DrZEAKQPOAkVF0T4SakUOfUsgjW
        YRAuRqQJ+Karo74XKQPkrBheWQ==
X-Google-Smtp-Source: APXvYqysffBDWYB0LA8vb7HG7aQb8HEmcDPvGh1FA8r902eVXah1k2TXA8e6ZdsELApCXCfgSYVvOA==
X-Received: by 2002:a05:6000:1632:: with SMTP id v18mr22256824wrb.233.1568404746082;
        Fri, 13 Sep 2019 12:59:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d12sm3153871wme.33.2019.09.13.12.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 12:59:05 -0700 (PDT)
Message-ID: <5d7bf509.1c69fb81.25a99.f298@mx.google.com>
Date:   Fri, 13 Sep 2019 12:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.143-22-g6073f0ee406c
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190913130501.285837292@linuxfoundation.org>
References: <20190913130501.285837292@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/21] 4.14.144-stable review
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

stable-rc/linux-4.14.y boot: 130 boots: 0 failed, 122 passed with 8 offline=
 (v4.14.143-22-g6073f0ee406c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.143-22-g6073f0ee406c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.143-22-g6073f0ee406c/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.143-22-g6073f0ee406c
Git Commit: 6073f0ee406c52baaf3625e28c631a33b20efef5
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 23 SoC families, 13 builds out of 201

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

---
For more info write to <info@kernelci.org>
