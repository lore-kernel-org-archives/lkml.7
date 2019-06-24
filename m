Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5421B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="UyY7S25f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfFXPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:31:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35213 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfFXPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:31:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id f15so4509616wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=3k/9ttyeiY3kX//P+0wekSb9hiL/xE651wpr0JfFC/M=;
        b=UyY7S25fhFb+VwULBIg6JgRkIvlUUhsjfmfdW43kOQhPnnc9Lyv+YGBxqQr+yyFoBz
         ibGNHrYvRiulDYf2htawwmvND3s5ecnEQmVEqowIxL4U8dzOw0xVy79xq26m9+9PUvKw
         UOC7fiKyKOEqqpDAR540FXcSwBGIgY/TMY8Tpdd2YfZ60kQdGhsg8C03U4gjHm5MnWlo
         R/LN7IXF8hZh42WgGF0giV5C9eHeY4+D3Pf4Dw4/gn8DzWRv7zCIJNFXF5tIM/guMlXr
         xSEPMUGcRSO+ATaghJKzUymTPdDZy/0SveupqrzE4/djZWccMd9PY4q/rZeyQEPsdGtn
         gaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=3k/9ttyeiY3kX//P+0wekSb9hiL/xE651wpr0JfFC/M=;
        b=n1iCMJ7giV+AfjNlXDyjps7zezoko2v7UfJA+3tv+Phxlh6UbVzA532e312sVSigL7
         1a/36KRxN/lcQFcYjmDaObcStO/VExVtTqChla0+z0uzmPS38TfrwZ5tv5GTMRaZbF1e
         RXHEA4AyUnW4QOH/RoY67w5pf0zkG0INKQbb1w8VOprsgAu5aalLuKimFL84RJQfztdj
         DBWtgJVxATOnAH2nR4KIXILlKW1MRIz6j6ansjJmtzy0g28tdDNwBMJmjtK86NDaOjsN
         p20gFR1Aa/t8do9r/1HJiqb9oLfVDnhL4xC3wuCNAw5qTvJc8Nfcg5Co/XJoGkBP90YG
         vPCw==
X-Gm-Message-State: APjAAAUJDACWfRH17R5A8755l0sXGjBxxMSoouVuhHD5Gg6Ai+eWAxo+
        Sj5TbgD1GWvBYwzpzg96dwZk2Q==
X-Google-Smtp-Source: APXvYqzhxmyhWbdnrB79OPRD0CD8HMDU/P1Rc6QGjpDtHZYCH1mRhKbZwlWK1tsW0uNfRHz9Wvf6eQ==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr50335666wrs.289.1561390282132;
        Mon, 24 Jun 2019 08:31:22 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id w185sm15283238wma.39.2019.06.24.08.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:31:21 -0700 (PDT)
Message-ID: <5d10ecc9.1c69fb81.5c062.2d66@mx.google.com>
Date:   Mon, 24 Jun 2019 08:31:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.129-52-g57f3c9aebc30
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/51] 4.14.130-stable review
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

stable-rc/linux-4.14.y boot: 116 boots: 0 failed, 109 passed with 7 offline=
 (v4.14.129-52-g57f3c9aebc30)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.129-52-g57f3c9aebc30/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.129-52-g57f3c9aebc30/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.129-52-g57f3c9aebc30
Git Commit: 57f3c9aebc308dc826ec1191e750fc853e79fb3a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 62 unique boards, 23 SoC families, 14 builds out of 201

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
