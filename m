Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F42C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB9820656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="wMA3SnlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfETTIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:08:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43212 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfETTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:08:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so15788683wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=YzAXxaOC5xqVMd8/F/Ga0LPRdXuar3Jj9JxMXvVw7Sc=;
        b=wMA3SnlVfagrZY+IrVonNezodI0Y22lIHeDsGtG0cIyAG7bEDsCTOZDiS/SDfK+s+X
         FOQnnL8LEOD/F4ccOmfGbRb/UhW9oA+elSFuvK/uO98RHcYb7p6SUIH56U7e18HCLJlM
         4f3qLVe+Pn2MmVRbHqdyOuV3c8dVShpbc97fO4zYV9fVchps1iWOVOXV8XT+kCBXNgkD
         H27bA40hFdSdc6Fw0FmnzTr4t46VK/epVSq9DZej0fXNXDS2NM6+oAponHdlznIjU3vZ
         Rp+OcYk4i0WsfeKCsXv12+VbXIhWj6Yq3AK8oACTdwYNMPal2VKDxoH28IPpU1abx+Zd
         M8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=YzAXxaOC5xqVMd8/F/Ga0LPRdXuar3Jj9JxMXvVw7Sc=;
        b=dcsEFfK2wARIcoWCTKVQh3MCg68lassyKHHjHMJD0YFuMhrb+xcB8PgBO4Do6oqqKn
         ut3NfwRqVESgnlILCm0FCLlxfypBtzhmT3b3pjgEdwrSjheEyPOiDyQqeYmBciAH5TgE
         9KiVNt1seWWAV+9flmar6ututiyOi82XfvP0huw2PwCtxHDlNvHRU0aVSUSbqkll+vYH
         jLNV9p0+Z8Iz6TNZEPp//+k/PVQ+BXtPhrh7QnyyV9G6DQd3exLAed4L+ztZ9tf/r44h
         y5Phs7BbTm146c+x2Xj54XYWUrr6C1XB18sLK7x6ppQwkeF5BENKV4PK8iRMd7+VhA5X
         mRzw==
X-Gm-Message-State: APjAAAVOB2iD/UzPLsdn5YVeh7HVN8ZWSIjgmgKKsh3ixSFQXta/t2Yo
        giM2JP5Q/byl/iESK7B8AfwzhQ==
X-Google-Smtp-Source: APXvYqwCDZdnaTgUywPY4vGp0YZHmTdm6mZENFhdUN3APJbFm6JQra2C2IIQqq2x13Y19c+6AXbpQA==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr7260238wru.316.1558379295861;
        Mon, 20 May 2019 12:08:15 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m17sm756867wmc.6.2019.05.20.12.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:08:15 -0700 (PDT)
Message-ID: <5ce2fb1f.1c69fb81.b5d8f.3a76@mx.google.com>
Date:   Mon, 20 May 2019 12:08:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Kernel: v5.0.17-124-gbb2772791a81
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
Subject: Re: [PATCH 5.0 000/123] 5.0.18-stable review
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

stable-rc/linux-5.0.y boot: 126 boots: 0 failed, 120 passed with 5 offline,=
 1 conflict (v5.0.17-124-gbb2772791a81)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.17-124-gbb2772791a81/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.17-124-gbb2772791a81/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.17-124-gbb2772791a81
Git Commit: bb2772791a81b9bbda82fc5b02ac84b8b8b42628
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 72 unique boards, 24 SoC families, 14 builds out of 208

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v5.0.17-117-gc76436debf=
df)

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab

arm64:

    defconfig:
        gcc-8
            meson-axg-s400: 1 offline lab
            meson-g12a-u200: 1 offline lab
            meson-g12a-x96-max: 1 offline lab
            meson-gxl-s905x-libretech-cc: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
