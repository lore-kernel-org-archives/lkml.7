Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE4C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105112173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="yx9okcxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbfGRINj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:13:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53288 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfGRINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:13:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so24612418wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=nThpdK5yO2OfCE8SuE9Qiy+7h9LlRqpG8oEJp9t7qAA=;
        b=yx9okcxfEfopABERJdTBJBxvDVVkqSqCNVLbxs6ftK0mWnDtLlAL3cnQSrKIrqZQB6
         Myk598P7HPwm+4Ih1c8U6VhZSaljnFzbLzQyojI9ZotTicPt+KI9A/67chBOElMGXBNx
         YqFQHneklE2yZ6P6ftQpQ0H01SUxSUjzViXBVAiyT1eKfm1eUZWjTdjPrU6KFuL/xlFj
         SqE5DenSFXx91R8pllYTzPa0vuN6FDUKjf2ziQMfQlJ2G0RbBanqSUulMAqtzkyQYKIP
         K1kphWNTxlum/hUN6mTk7J1/SyNx1bxflLWHOZjX+x2rLLjb9G03AVxN2ezAib8/6ZMs
         kxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=nThpdK5yO2OfCE8SuE9Qiy+7h9LlRqpG8oEJp9t7qAA=;
        b=JUCGVqwNBigoREQiNizGatZ9rhK28pSkhaO4WZ1imhI/GXZxluL0IBm3xiaysTvCHu
         ruYNLb07aKzI8HjAqstvrPTlDY0NnRN1D6Bn/eWg8jWjQZvgRbGoqUsJpRzHeOe59dpY
         T6nnjQNbdPyoE3qsq7U88LZIBbxNKmvoRUDjktUTM+XOBg9HwOLZJdfDVlowdHmtPeXQ
         Rqs+GtkMGyx6dFLsCvcj+d1nt1WX14Pc61sbBSv/FfsFjK9evxtJCLBtOjXhvHG5w46W
         aFjUSHzrUoQx17rrUxNQDIevQFa2AzaKN6gIhsyJhjhliW5/RFjZx/avqC9ge7tEgpaB
         Zy9Q==
X-Gm-Message-State: APjAAAWigWqBmxi9oJPjDHAMfZV8kZploIkilL+h1ex/Boip6+wTZB6O
        7lt+nY6+eLthtiRDtBacZx0=
X-Google-Smtp-Source: APXvYqyiKE+ZNi3kj4Soc3BnxSsuO5dLIlqnXPQl+JfrF7CA85nJaFOHlXKrYsQUD4QnyB2i9EC0Bg==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr42236985wmg.63.1563437615136;
        Thu, 18 Jul 2019 01:13:35 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d10sm31770837wro.18.2019.07.18.01.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:13:34 -0700 (PDT)
Message-ID: <5d302a2e.1c69fb81.6850c.314f@mx.google.com>
Date:   Thu, 18 Jul 2019 01:13:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.1.18-54-ga80425902cdb
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.1.y
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
References: <20190718030053.287374640@linuxfoundation.org>
Subject: Re: [PATCH 5.1 00/54] 5.1.19-stable review
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

stable-rc/linux-5.1.y boot: 135 boots: 1 failed, 133 passed with 1 offline =
(v5.1.18-54-ga80425902cdb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.18-54-ga80425902cdb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.18-54-ga80425902cdb/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.18-54-ga80425902cdb
Git Commit: a80425902cdbd5ab05f9f9af4e992fee397a1d47
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 27 SoC families, 17 builds out of 209

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
