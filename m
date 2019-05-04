Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC0C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1F206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="yWHI46OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEDSqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:46:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:46:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id a9so11924704wrp.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=KPACyaSmM7SH7Z/mR6C52rw+ki7LFPR7iQQVajdcVW4=;
        b=yWHI46OT1kwRnI4WAy+/jjFu1FxtQdf8bMQjbVOKwlTGqXeMyuL6069vsuA87ThNsk
         wmh5ORb8WoKhnRQ0u/wj4HAZ+RSqcqoGuu1zmfslTR6NJ78x76a9/FYQ+Vsngo93wtgZ
         DM7hK47ElTjmSWDJfZuhk/h/apShTNQTLTUn8zqz3zjHWBayOySy02Q9O0cMa1VYgfGC
         DFW1qrQnxw0PhAG2O+XvGFnCAz+/kj9UycGL8v9gVcpNj3Hqp9ptEBqV1KsUPTGN8C7w
         2nbbtItzObh4MkK0lB5JQLsuLGqPOEFXS8mAITHPrPnZ1E+chkDqKXYSzw4I6+FGX/Ml
         pJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=KPACyaSmM7SH7Z/mR6C52rw+ki7LFPR7iQQVajdcVW4=;
        b=NDrurXZMIeg9xiC8FaURZ8zC4Hp2m0VvkU75+e4duBVqTupUqM5olU/ABz2ootTCqI
         vRo58DIVt74TKRICnGupJc98Ji4MmiUkXW3baQoH9Yzz7QlFY9SdmaS24HyrEWlOo3UA
         0plWjePZsCdx+UD6Re/j6mbKOXF7jLzvkDr3hTpQElRkKzf20A4j1uF8YAcQW/dgHdUZ
         xzQ4mRZgs6RmIs/DwYWUYM+9MDkVWteJK/Nx+B5cLv7d43oo4oZvEIfiLP887Y+xbSrV
         OFft6ksFTlUXCSppr/PH+AzL1ex4EhTk+ApQsjTwiVfF4FbDRinH4EIGk2HoylIVGexT
         +hMQ==
X-Gm-Message-State: APjAAAXspdHsQ8o36DeZgmoNPpSN07eclvqseYOZeY3WQFSyLF1zliDF
        LoRpkqKhLh6Gq1aJsfyGj6EmyImqqEw=
X-Google-Smtp-Source: APXvYqzGD991jjuijsE+yDY3NLCeLH8x2fimp3tghKTxdYpnpUZrjzRmSW9yq3PwDbHanga5nBG3aw==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr3563090wrw.311.1556995601156;
        Sat, 04 May 2019 11:46:41 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d3sm10344624wmf.46.2019.05.04.11.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:46:40 -0700 (PDT)
Message-ID: <5ccdde10.1c69fb81.7061b.99ef@mx.google.com>
Date:   Sat, 04 May 2019 11:46:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.39-24-gb0d6421bd855
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190504102451.512405835@linuxfoundation.org>
References: <20190504102451.512405835@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/23] 4.19.40-stable review
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

stable-rc/linux-4.19.y boot: 128 boots: 0 failed, 123 passed with 4 offline=
, 1 untried/unknown (v4.19.39-24-gb0d6421bd855)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.39-24-gb0d6421bd855/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.39-24-gb0d6421bd855/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.39-24-gb0d6421bd855
Git Commit: b0d6421bd85515e878edcf33121a818666df7749
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 70 unique boards, 24 SoC families, 14 builds out of 206

Offline Platforms:

arm:

    davinci_all_defconfig:
        gcc-7
            dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab
            stih410-b2120: 1 offline lab

---
For more info write to <info@kernelci.org>
