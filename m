Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A55C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B64920645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="go8yCIhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfFXPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:11:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38269 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbfFXPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:11:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so13747901wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=5PTa33ogTni5Gg4Vr/ihQKZAkZXaPg7xdd3sdJLvL2w=;
        b=go8yCIhiT+F8iYHO99S9JLvCn555tSVkVtsqsbRIo1Smo4HKt+l2pfdIv7KLRWV/9N
         KZUEbe8hYzeE97E7uM7r80npmN6wVbSlXePnb9pT55qd2mQmqaN8fyd+8cwn9JlvRyYq
         MF6o6WUDzsv88wFDWtNolKPolCmhzlvofHa7Cyekvr86KAHcgmOZwmeyduY1eVaPQJHu
         lotN7+LmfGyG/9JUzcB1SU91p0PmugeYlEOaCSSbvce2fofpLnuNzKoOABAvZL8tpedw
         6w3MO45oncGBii8TVwcFtToKzWKlb1T6wBKnI/s8V8UTsbpKbskcHenOoK87S9bJiohQ
         svGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=5PTa33ogTni5Gg4Vr/ihQKZAkZXaPg7xdd3sdJLvL2w=;
        b=PB5HxJ28D6rGtJckQRlLI9pRVl7Ecup6q7FLlHPi89zZ4UEBPs7h6G7qVPeNlVeydq
         ZDkYWJy3OBaY+t5uSmnQIeKY9DGBmOcfWWFrjduPcXyYfVtwaLjusvZT4gjFvCdGTo92
         0TsmgPL6yBZazbxO6pD/H1/Zsx7pjMA93Be2azy/C7cXzi6DsMZzocCp0bXcYMJLHY/7
         eyDV8tzipMP5Pb/wz/pQhb2Uf8abi7EubZMIOSh17OVhXMKCLTxs0xWU30tFVTP5q/33
         3QDekiXFrSURYPPeK6gUo1WTDuxP7zU10n4nWDkY/+WKoOrfW655mAkT19J2LKD5V6ri
         fRww==
X-Gm-Message-State: APjAAAVuWTjWLaVeL05EeQL1/bLr1bUdT3M8XbHBkTijVpL0U12C+3dl
        hKLsqmLLYZ9VUt3143Gl5CejeA==
X-Google-Smtp-Source: APXvYqxWH1u9dYR8WkExwLUHrK/JnHBW17hhIDnlg99V0BwnQUHz+BncoLXRYWYLKTn2enOO+ZBs6Q==
X-Received: by 2002:a1c:9c4d:: with SMTP id f74mr16216529wme.156.1561389081671;
        Mon, 24 Jun 2019 08:11:21 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u18sm8301486wmd.19.2019.06.24.08.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:11:21 -0700 (PDT)
Message-ID: <5d10e819.1c69fb81.27d2e.c262@mx.google.com>
Date:   Mon, 24 Jun 2019 08:11:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.55-91-gc491b02eb03a
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/90] 4.19.56-stable review
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

stable-rc/linux-4.19.y boot: 120 boots: 0 failed, 113 passed with 7 offline=
 (v4.19.55-91-gc491b02eb03a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.55-91-gc491b02eb03a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.55-91-gc491b02eb03a/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.55-91-gc491b02eb03a
Git Commit: c491b02eb03a59e32d78bb8d4ee00c154a694267
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 67 unique boards, 24 SoC families, 15 builds out of 205

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
