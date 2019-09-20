Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB563C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E71F214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="TULAlVgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406992AbfITDjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:39:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33353 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403998AbfITDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:39:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so5261337wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=JxSuNDRTNY122iXEX/hS5NZ0dE0XPc1tRWWP3rVxMFQ=;
        b=TULAlVgOkMBZa6p6ebSb9bn9970VoYjSKiMpsaa9psHxV1gQYpAuRDw70Bf/vdFRTy
         dj2vkAdKVgB2/NQCHEHGv+6PpuBufmbhfyezXaOOjDYoWaLyEZiTciNLveA9f6oBtMQm
         BbGwNzz5R92Z13ZvjJT03AphD/jtCMrykwR4Uz8NrZvONOqYHpSHbq+VEPgBmRH9paAc
         Fic1Gl3fw2C5GRdFnjf+eRve/AWJd9D4u+Vu6Wg352bs0miON+M2N6Ag/LxAcadjziJ2
         NI1jB55e/Z9UJTIN/NUw4Db/ToDwGouLvryZrtusXRpINi8G+bmBJWeH4G6zletWBEJD
         E70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=JxSuNDRTNY122iXEX/hS5NZ0dE0XPc1tRWWP3rVxMFQ=;
        b=GeVG9uugc6aQrLyz7yscelD/D45qdX80+67F+YX7Njbsml/fdFczXvdh6zlfUKA8Rt
         15VjD4874IL6GBSMLYdB1xoO2qk3aV9ws00r515rz1gwm2v1HX2MIelF31MBDJq+Qhb7
         kxKvJH4ioU63/CoXFjpYu4aqZtcU8wX9gfLBW63wI0YpedFsIl7/WOJwUocYNmo5Sf74
         80dd18f4uUHZycgAmFIpTnBtLCUNCiS0Zd6j5ybEbsKKSOzOJZuufWOVTiJJOtbkqk56
         6UpZATQKMkTH0X9VjOX4CSzQEWNPo8RZlUndPw/73mRhUN7KIMnp3l+9AL4tFMDJ11U3
         UkgA==
X-Gm-Message-State: APjAAAWo3JPo/XLR8A8dIWtlsWBdjRploT26zhdQGtRqDeELF+hETgVB
        BJDABmM6bHNHWCO28fuC3IU8Eg==
X-Google-Smtp-Source: APXvYqx3EVaK3oUApeuL4FbXfrEbDggdlBAH5Ts5904WnBKQZYM+r0Yc7JEfJ5SDiynvuuUb71dbjQ==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr10070148wrs.179.1568950781058;
        Thu, 19 Sep 2019 20:39:41 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y19sm521634wmi.13.2019.09.19.20.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 20:39:40 -0700 (PDT)
Message-ID: <5d8449fc.1c69fb81.6658a.1dd2@mx.google.com>
Date:   Thu, 19 Sep 2019 20:39:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.74-80-g42a609acc1b2
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/79] 4.19.75-stable review
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

stable-rc/linux-4.19.y boot: 68 boots: 0 failed, 68 passed (v4.19.74-80-g42=
a609acc1b2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.74-80-g42a609acc1b2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.74-80-g42a609acc1b2/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.74-80-g42a609acc1b2
Git Commit: 42a609acc1b2b5a744dd9ad3d3eb6a71906e4bcc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 38 unique boards, 16 SoC families, 12 builds out of 206

---
For more info write to <info@kernelci.org>
