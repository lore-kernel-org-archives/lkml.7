Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB22921855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="AXONP414"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfGXXOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:14:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:14:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so33678590wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=UfZy49/B9rbS8h7ed+p9jIYgC2BxNXVvPg17QcKxhKw=;
        b=AXONP414SzQTyKZdrYqjb0wZ/8hyJbFUEYVuxzsUf/qfV8/5CelNXtt976kSZJggsl
         iu9NOBBEwy8DRFWdgmBtqxuyQOpS+i4JvWhRI2hIYsm7+4OI89M+fTsI677oFmWkACm+
         NQDfCFRo1SyATYZ7SJr3c2DAz+v2HKfdt+fZ4+2SaEcVH1lOObBOFC7OD76c8bdGhGyG
         9knzIYg0Q9s414HsRX3Npy57aPbHBx2q8VFWVug6bx9pB8QA5Fgf3iYjWE13Bd0kYrNV
         vZR7qw6il7c81u9+fy70gNIdgOUv1+xhx+5nPSrITsDXPHL4+mCnALg83L4Yh+qrDnvV
         oEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=UfZy49/B9rbS8h7ed+p9jIYgC2BxNXVvPg17QcKxhKw=;
        b=U7VztDYY42JG8XkIRDDeO3EGsERTy0EbmxhTH1V4/f8ssSELs6OXcR3dwCj053plm/
         VMDUoA9Qzd5xp/1TD5CSdUCbGek7E3AZWDURlqxR0Uo4R7yTP/RXWXOwB8herJnm0atl
         xF8UgCE4Z78Kf8fFPpeumkAdA4BqCjuMwt23T//VhbB8svyK1UTbILdYKooRksYtNbap
         da6KtRX+qPJnq5l6n6kGh91OXVKTg+eZHRdn60nwa7EumMHghwJWutvD/ZeJO+8u/t4s
         gO9uc0fcn/AG+hDT578aokdMCMPm/cPK66XzTkhImG8WFv8eDUsRirNvQERR570uR7Q3
         K6+w==
X-Gm-Message-State: APjAAAULyLAWncPmNxsNEpHJZQZRVC6QGfPNi8sOm2nvVzFTrk2DnNXZ
        oXnapoqyxofzWxgQU3x9jCY=
X-Google-Smtp-Source: APXvYqwgBaNx4efwTA5LqgKWCGthCQ0HQtQFeDZRvJTEacIJ7Jgw1p2DZE7vTaxRMtQN+HTcZKjriw==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr15050019wrn.11.1564010051906;
        Wed, 24 Jul 2019 16:14:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o7sm40705283wmf.43.2019.07.24.16.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 16:14:11 -0700 (PDT)
Message-ID: <5d38e643.1c69fb81.dd59c.1f01@mx.google.com>
Date:   Wed, 24 Jul 2019 16:14:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.2-414-ga4059e390eb8
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
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

stable-rc/linux-5.2.y boot: 139 boots: 1 failed, 136 passed with 1 offline,=
 1 untried/unknown (v5.2.2-414-ga4059e390eb8)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.2-414-ga4059e390eb8/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.2-414-ga4059e390eb8/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.2-414-ga4059e390eb8
Git Commit: a4059e390eb842ee95dcb0b856eee5cc422a815b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 81 unique boards, 28 SoC families, 17 builds out of 209

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-nexbox-a95x: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
