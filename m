Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EFC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E05218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="GhcthsIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCVVmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:42:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:42:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id w2so3834690wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=qt6YwDWafSWqqrp6VhotGv5EkViY02TvN4wQuiGS6zI=;
        b=GhcthsIROUq196GT9L+g7mssyESjnvXwxg5qjAUhecEPB4hmJpr0doHlh5pStYnOY+
         Vow5GoLgG7wZfUao6IDq5K5pFZM/XTVuBAUHnt00IlmiMN4BiyYunZWZfhIg94eEglbr
         WYCs3/NjyvDdwD6eRmTJAFlvTZWZQVH2u71dxHLt+22dM7GPrVfkuP1G3Rtz3S1Olymp
         CEcSbSScZiN1lGRgo0M41T0KXNPVE3RHYVhEvy7CeQfeAYUfA8ckIa+pWwrfoznZn9aG
         Qh0xWOLpMV5xdIh6G9XwhdylcxQa4GdF0XsoGkeATHix/Hzt1/XkeAWIIXxubhW/Efpu
         5SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=qt6YwDWafSWqqrp6VhotGv5EkViY02TvN4wQuiGS6zI=;
        b=tuJ3V7V6xgPgfrGfVG0+Maz/ivR5gj0XEFK4jj0kcFGJf6a5YxQt2lPrpHPCYu+Fow
         lgScG8ALw9SJ0qm95pe9xJDE0U7Ra9/BR7gskbvFvERI9+AdPxvD8J8zyi0Xg8WNw6C5
         OoJfV320gmT0fdZaYnRvkNZlqDtuxdji7EQv3t4aV2yBgeBL2yn+dieZsAntih8Ip9tQ
         vIYlPQ9ppRqHuWtgqvlBMiIkfgqOnHqTlxrSowEpANlBLrfGeACv7GrCFhCWFeEQnvG8
         HD7KEyyh4BdACDU9CcxznlP631rSjkDbJ9CESdK1U6zuCD3yjtRVWnc7HEgaVE3e0Da2
         if9Q==
X-Gm-Message-State: APjAAAVawHABJeF0ChxJSe5DovMAHef1U8dk743USoAFIcZrgQ2p3RYh
        n3iHLtr9vzK8oyczD3xz9xCjKbqXN1hp+g==
X-Google-Smtp-Source: APXvYqxp2QDAhtvJGk67TnGhWMrEdss/5ZwdG2Q/0sWHZ6NnOog2d10EeHdSvpTB6DnQBqLlfvueNQ==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr7422465wru.104.1553290972886;
        Fri, 22 Mar 2019 14:42:52 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u19sm11071394wmc.7.2019.03.22.14.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 14:42:52 -0700 (PDT)
Message-ID: <5c9556dc.1c69fb81.c10d8.5cba@mx.google.com>
Date:   Fri, 22 Mar 2019 14:42:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.0.3-239-g6a3b25ca9720
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.0.y
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
Subject: Re: [PATCH 5.0 000/238] 5.0.4-stable review
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

stable-rc/linux-5.0.y boot: 55 boots: 1 failed, 54 passed (v5.0.3-239-g6a3b=
25ca9720)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.3-239-g6a3b25ca9720/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.3-239-g6a3b25ca9720/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.3-239-g6a3b25ca9720
Git Commit: 6a3b25ca97204a3891527d88b6691b362fee82c8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 32 unique boards, 16 SoC families, 10 builds out of 208

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            meson-gxbb-p200: 1 failed lab

---
For more info write to <info@kernelci.org>
