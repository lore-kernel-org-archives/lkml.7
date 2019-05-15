Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E5C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E8F20644
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="kItYuY4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfEOOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:47:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40494 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfEOOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:47:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so306104wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=K/lUybpYvYg1JgyXxJbdS2Ey0Btfjlwmmf2j+lr+5xs=;
        b=kItYuY4KYpdAUJ9KU9PTGPNItWp8h2JCcCJduGZTmd8xWrDEyjLHOzNnaskNWxlbAR
         fGKRNqzWxgE0sHdBG7FUi7XEdL4x6RUOhxc0Bg417JbrG+zh9r76bgai38CodMbcjk8M
         uUwYFwpRn/iGCzsv29/FUQwNt3Lzh5gljsvvgnU+xRPw8mBMtoPMBvYNmr3595vLYZoO
         mHWOnBnofgTYGuro7LTLpF+Tx11jE4DglNwxhJGsngr8+HxAq+ULU5z8LQwxG7YtRnhs
         JGz6KLsBLgW7GINDmy3y9NfFBEiS7RL5HpR/nAqkfRrmk0dHSw+DCn9n8hu5JST9j7ER
         35LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=K/lUybpYvYg1JgyXxJbdS2Ey0Btfjlwmmf2j+lr+5xs=;
        b=RUwksiORZQrsCaJCqyEDRiliRy9HhjeehamQ6C+WFI63g/JIdoXDX5D89FXcyq1gSJ
         owFulVZPyxsq04s3ul0iUqwwspMG/Ai9y0ww2WwDzkoouGkG8fqiIpHFI9USzQbrByEc
         eH5b+kgERF+5+eof6cw4OVBgcRDncdG+kdcHXQAOofYrVVkyhwExPcTffj7xLN6xppKL
         H8zot7UIP/FZ+r7EzV9v0TxKKXIsllg0Uw9AlHwjl4uxLZ7KYh47LoqvJW12cUGlbPEp
         Nn3FkDAsuBdutHm58iTK5pd1mlo57m+iTqfqPhg5ChfZK+FmqATGex8IgeF2UY7SUXSw
         vthw==
X-Gm-Message-State: APjAAAXdtlqkCkFZShO8XqtcQweiwMOgsOXTGiKLUyNv1CO09i8fyhx0
        lAGKCdXUgf1qAhNDWJphGuVSTQ==
X-Google-Smtp-Source: APXvYqz/GmzhqJjq4NFmN4t08RmEb8CtzQrU7XJ4p6ebUHGGNKp53IYmMuULRKC+KLEPOLh37EfXMw==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr15027332wml.7.1557931665901;
        Wed, 15 May 2019 07:47:45 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y132sm4073253wmd.35.2019.05.15.07.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 07:47:45 -0700 (PDT)
Message-ID: <5cdc2691.1c69fb81.bd8d8.7247@mx.google.com>
Date:   Wed, 15 May 2019 07:47:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.179-267-gbe756dada5b7
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/266] 4.4.180-stable review
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

stable-rc/linux-4.4.y boot: 98 boots: 1 failed, 92 passed with 3 offline, 1=
 untried/unknown, 1 conflict (v4.4.179-267-gbe756dada5b7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.179-267-gbe756dada5b7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.179-267-gbe756dada5b7/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.179-267-gbe756dada5b7
Git Commit: be756dada5b771fe51be37a77ad0bdfba543fdae
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 21 SoC families, 14 builds out of 190

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v4.4.179-254-gce69be0d4=
52a)

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab
            tegra20-iris-512: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
