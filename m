Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1585C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760DD2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="fx8SHCFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFTWLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:11:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34930 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:11:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so4593580wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=mbYFTh6bazxqWo9R2yJjJ1/62LryVwqMQHAl8inkfY8=;
        b=fx8SHCFYj8+ekg/5IL+B4cIMRixAzUC2mMLglXUFG8a0a4DrqVNCDYr4DQ0ztR+15g
         0IX2NUPnNWhxcS0iqJ4+VupcDWFGo7zHbmByixSI1nacq0LI5hKCZ//vZ/KPwnyHSCpO
         4As59nXUwzDuUQvslAPEe+5LkaKL/a6zjFBGwIDlbZlz+OcyPAQCBdyAyahFwljWQ5Xo
         j5QOlOX42Jd5boBQA7P1Ervd7WIsetrKt3CUc0rzBMKdDjm+nFJxGOMqOx/LMuxLkP7M
         zIixdThhX7X9CicKNcK+rQX7D9DdyPIGSWDjb3DkfUEoNUWAyFBirRkS++yTCUZ2IjL5
         dwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=mbYFTh6bazxqWo9R2yJjJ1/62LryVwqMQHAl8inkfY8=;
        b=sZgY1zknueqFZG+T+PkvWoqwsy6Me67Ju+2YLYdWyjKJlGj0EWOq+6/xlKdzuwIK6c
         jbLWSfZK/q5WPEAzlrxcCDNJFP1j0Bwni7fIZOwxp1bqmV64W2BzVaTS61UD9EmIKVaw
         NlUTSfWQaAXULQnmKeRvT7FPftYu9tL6a0jmfl+A77POoZXK5QE2QdkY8dt06MQfhaFz
         85bkPqAY5YrdwEaCFWUOhXgZkPXwwgsLH79n2hz0wqaJGIDxf25HBTflPbSstzcNNG2a
         BmlNCcGkny69lombOpZF2CVdOLwLXb4XCqlbtj2a7iPTR7B2Kp5rSMj9Ox8gjRJ/W4oo
         DcoA==
X-Gm-Message-State: APjAAAXb8eqs3Xmq6L9bEWpN2+7ql8Mxij8Ec35EK9ol67shWSXOZTWM
        yNc5x3yWza21lxWYgHq2r07syw==
X-Google-Smtp-Source: APXvYqwco75N024LNpbRiHjtMlzSwUitTMmkymBba2UxnLOWOikFVoDkvcDMvidvTsjDzTpVCn9ItA==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr76614756wrm.218.1561068662643;
        Thu, 20 Jun 2019 15:11:02 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o20sm1824598wrh.8.2019.06.20.15.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 15:11:02 -0700 (PDT)
Message-ID: <5d0c0476.1c69fb81.cef30.b578@mx.google.com>
Date:   Thu, 20 Jun 2019 15:11:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.182-85-g847c345985fd
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/84] 4.4.183-stable review
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

stable-rc/linux-4.4.y boot: 90 boots: 2 failed, 86 passed with 1 offline, 1=
 conflict (v4.4.182-85-g847c345985fd)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.182-85-g847c345985fd/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.182-85-g847c345985fd/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.182-85-g847c345985fd
Git Commit: 847c345985fd296caa81af3820e8185f0d716159
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 20 SoC families, 14 builds out of 190

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          omap3-beagle-xm:
              lab-baylibre: new failure (last pass: v4.4.182)

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu:
              lab-baylibre: new failure (last pass: v4.4.182)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            omap3-beagle-xm: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu:
            lab-drue: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)
            lab-collabora: PASS (gcc-8)
            lab-linaro-lkft: PASS (gcc-8)
            lab-mhart: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
