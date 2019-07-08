Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B21C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C551216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Sg2Isfy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbfGHTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:12:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32853 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbfGHTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:12:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so18382957wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=RDRGTN8x919ptUJcgdMpXaqUnSA3Nby8GPaC88Pdh/U=;
        b=Sg2Isfy1hv15iggO33sYxOcwXs6PmseiDANYxruUcg2O/wvklzYEHPhvKXfln0Gayw
         ZbNd4sJ3ZwNYadfoWYPzPI2N2xakAONONQGMuZgOTawXH8j9kAZ7ayn+mdEjM6pZOjMq
         hWMJJAF1mK01dqyy+NGewiWCPTwQfr06vC9sxKiildLgl0CsydxPxsuG3HHkoW6JzBKg
         FzDVIEyqMChGRB1ziA1ezDfFoPIBFpTtLqRJ21KlW5Dnoqjc86Z2mCxEh0U14IvQBVAh
         vEOGpLjY5wVN+u1nkzKLn4ghOIM0shjq/KyxrwyvP2FmIm3nOUzycpVAzedDtaRzBnPc
         eyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=RDRGTN8x919ptUJcgdMpXaqUnSA3Nby8GPaC88Pdh/U=;
        b=kxN8liHqysMS0ROU3KmZJaWB/YqM8Il01T1NTadDE31lMgTmvxcflZmwNLELCzO0yW
         Zy/zz6KTjroXxl6jKMTOYg/AHDsIpYbvzokCU8WUQjRwtdfbuPAeRXC7t+FH8SmEgHpN
         7vg/79AhAbZi0JTMkXRAn8Jbfqy1PxxeZzet0ignPNHITfWlA7HPZ4xY2gsWL2Qd884O
         +7FOJgF0PTLUnKrWsCy9t2Wvi8qY5lq37iZF+7pRnEosxYafWAKM6U2izBhiTkUUOW3X
         ciJZ/WD9nasAlMlIvvSkNt2uqFU5rBakYd+75jgd9qbxbGLFJaZzW/0ApgdAlftxqAvP
         tTkg==
X-Gm-Message-State: APjAAAVV6nAOmLkSPKfiIPR4rUCPCPyvK/CbzpKMPdCVG7WceuUMeYow
        mFN0dKKOlD4mFaPNgAePNvZ+Hw==
X-Google-Smtp-Source: APXvYqyH9knR104jag6LxdCTMdYd0zBHt0+kcHYiweHGOkpP8q2RPmHnaRYDHv8WYlbuo799tINJUQ==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr17700363wrp.145.1562613162740;
        Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g8sm355988wme.20.2019.07.08.12.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
Message-ID: <5d2395aa.1c69fb81.39844.207b@mx.google.com>
Date:   Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.1.16-96-gadc3bfb5810c
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
Subject: Re: [PATCH 5.1 00/96] 5.1.17-stable review
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

stable-rc/linux-5.1.y boot: 108 boots: 3 failed, 105 passed (v5.1.16-96-gad=
c3bfb5810c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.16-96-gadc3bfb5810c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.16-96-gadc3bfb5810c/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.16-96-gadc3bfb5810c
Git Commit: adc3bfb5810c7d89758b29f1736fc927757ea64f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 24 SoC families, 15 builds out of 209

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab
            sun7i-a20-bananapi: 1 failed lab

---
For more info write to <info@kernelci.org>
