Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773E8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639421670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="k/GibsdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfIDXiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:38:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:38:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so556515wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=+cQEKFH8HrxoD2GgI2D5PxiBEsa3yF83dOCqARH/zII=;
        b=k/GibsdIhhVJpYu8KrTOATmi0Y4MBefLjJhnp+PyeSOTaI8sUa8ZwKu/eWSvuKH+eb
         gXQJ2VX5pVEcMRWK5DgOp3HfiGh4yI4D5GlbbYb8WI5y+IBQEIqksBM/xrPxIAQ040aP
         pr7ky3onVMaT3h3Nymzk3MI62C/6duJaxpUDBFZa/sAIT9+57yriLQf23/0vl8Qk4lBA
         o2O2Oo6ORHBm8GDRo/TUeLcPBlK9d/TBOfeB8DdgDFAwYA4SmPJcWP/fZiQ9TDtgRNg+
         0AwsrmAz6KnVtXe4rJcQLW3840jj956Pk57U0JbtRlKLIgJAoPaYqegOwrVu0FccUphp
         OXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=+cQEKFH8HrxoD2GgI2D5PxiBEsa3yF83dOCqARH/zII=;
        b=av4QNg7ZTgBRBp383gq1lZ78yQvoeEF8DU2Q6AjEDmc+lPkKGkYq4bV6jlh6l+kAxC
         8cYqmOooIWma5GK8DWsfHSu2iQjRm2Voo7TW00UE9sd467Ntzmc08sWSzg5kw2eQoO/e
         Et3wKyHBHxGnsXaKWCOV8PZwndl3t9+Qdd/rkfOnTDR40OOWQm6lgbz6hLFC1SLsxieq
         nSlTOOTWXFQG9GflY44H16YZvZyGHjadAopkprwT+jzcrLGI5nXAfaM2XpYxvdTFAZ6g
         5WlpyR18L6+FRn3iRkTVPkqwmUDCFrmShZNTUQA5oqw3TPs2/19eWwh3LE39vvQgVR8/
         HZ2A==
X-Gm-Message-State: APjAAAWILTsCmqBO4x3rs6EO0/R8ozoWNEsuTEiVE+m9d4Eden+/LnWE
        YuLuImyeQzXWuhLqD3kL7HdTQg==
X-Google-Smtp-Source: APXvYqzxnRChZHDXLR6JASjqAO5XncEr7cP5/xJfBRHyUcGpoxINw1o6DY8aNCq7iSpFJKYOwB4IYw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr139898wrx.163.1567640293942;
        Wed, 04 Sep 2019 16:38:13 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 5sm424433wmg.42.2019.09.04.16.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 16:38:13 -0700 (PDT)
Message-ID: <5d704ae5.1c69fb81.821af.21a1@mx.google.com>
Date:   Wed, 04 Sep 2019 16:38:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.11-144-gb6eedcb8cf66
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/143] 5.2.12-stable review
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

stable-rc/linux-5.2.y boot: 157 boots: 4 failed, 145 passed with 8 offline =
(v5.2.11-144-gb6eedcb8cf66)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.11-144-gb6eedcb8cf66/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.11-144-gb6eedcb8cf66/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.11-144-gb6eedcb8cf66
Git Commit: b6eedcb8cf6670234e137d277a5ae1cdf5cd141c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 85 unique boards, 27 SoC families, 17 builds out of 209

Boot Failures Detected:

arm:
    vexpress_defconfig:
        gcc-8:
            qemu_arm-virt-gicv3: 4 failed labs

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
