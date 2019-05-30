Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC341C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923EA249D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="O+nkNooX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfE3HJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:09:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33834 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfE3HJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:09:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id e19so5413902wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=JMEyUWmXaaJsTdIjDAGpIIBvFDGVzyT1a58p8wvMwLA=;
        b=O+nkNooXREb8oEHsMe4D0xQ021puf5mtSoYotiMf+FTdvgEydXDuFgFLsz8UZIclME
         0d5hPZNAhJC1NG4ommMzDuA60ZDO4/2s02aTCn+jOZceRVaD8YiYPSYAMxEMuo3HCz3N
         pmWVYk3bGOxAJAy3e/+faKszONH5KOVeK1QzkE1jrUo7P7uGaxW2c8J+v6mXYtif0rna
         x+/RoTQ0d5MOuYLMwBwyT1LlMaCM63NlMzmMgdK+j2vhjtjIhuuaUv6bCuNiSZtnE7AI
         R4JbV35U62km7E1cAvJV9CnGtfy0ECDIlFBosVdOATdJ17XKRKT1wq1bim595H6OyvUG
         nLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=JMEyUWmXaaJsTdIjDAGpIIBvFDGVzyT1a58p8wvMwLA=;
        b=BmL/Mq9FWqlvQknqwdGkFAmi6UEWz2hyFupScVD1A/9K26eYs1ulDD1rwYmnY8MDT6
         isA+XXKqxEtmOS3MOX2Ce/frNX2JcfaPtyfiG5dRi8LvMOOU3hjKhwdBdr7Q0tKSsLoM
         0Z8AVpgG4cc0o7Exoa6z5meM9P/fNR3WoxqjRPYmUOCG5etfzxJO6f/brnXN3WKTYPMi
         O2yovBkC+NPIWVGCPrvoNpflKLoPuBc9qzU7Qjz2GyVN8Kbcz7ggWmZRvIYnnkEKvwzq
         hdSVCwn7u3WDfs2z+DGv6M+ehdZHyrDMHW2jjjJW33WzbdtReEKgYcGrjgi4GLVg4BtZ
         JYNA==
X-Gm-Message-State: APjAAAX66QGZfBQ5K8+jkXrFcFokyh+X1xEHXp3Pu4YtHhw6Hb197Jur
        JBGkIXxShkdLgdsA6NbifazUpw==
X-Google-Smtp-Source: APXvYqyje7NIy69xSH10foyXe2FT8RiQoQNm5jxPmxP0XqGbJStZqZleNiblthw4qYhQuuRVNCsSBg==
X-Received: by 2002:a7b:c943:: with SMTP id i3mr1191110wml.128.1559200147022;
        Thu, 30 May 2019 00:09:07 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o12sm1603833wmh.12.2019.05.30.00.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 00:09:06 -0700 (PDT)
Message-ID: <5cef8192.1c69fb81.fdefc.7e69@mx.google.com>
Date:   Thu, 30 May 2019 00:09:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.46-277-g9c8c1a222a6b
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/276] 4.19.47-stable review
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

stable-rc/linux-4.19.y boot: 118 boots: 0 failed, 118 passed (v4.19.46-277-=
g9c8c1a222a6b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.46-277-g9c8c1a222a6b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.46-277-g9c8c1a222a6b/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.46-277-g9c8c1a222a6b
Git Commit: 9c8c1a222a6b10169a5d95dd02011515ff85f709
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 63 unique boards, 22 SoC families, 14 builds out of 206

---
For more info write to <info@kernelci.org>
