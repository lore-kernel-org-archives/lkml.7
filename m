Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50EBC17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84578214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="SyCVq7X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfKIA5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:57:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52173 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKIA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:57:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so7913206wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=HbWqXty6cqaMv/LTlNURbDS2LNWnKiEuBM4m7cwJBAg=;
        b=SyCVq7X9ieCdrPryVtlnFYXexpfacg+gw3W/PADRgLVOJrGIY4nCVsjTqE9QpkODhy
         NJHZXn0rc9WA/cgmsxxDVSsLfLTV7deM1iCLvCYmaF6CxPkOUb4KIPotXLe5sVlpifDl
         r2Nx1qYp7Yn2pkW6zC5Jcabgsg+j1kaJDE/G5ezZBxSqebVoAhQ3YhinSTcbVX13Zkac
         M3KOwEA5/Z77eui02usZuZ5B/CnAx2ArFTQ/3sl42YTCvlQtz+14I/PdFLOMEeY49tzJ
         MN1NMZW6rpa5ojvJr13dTWIebLY6ejmlVUMitW9N6c5TKYtrx5EatwV/4bmlgAGU5LPo
         4RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=HbWqXty6cqaMv/LTlNURbDS2LNWnKiEuBM4m7cwJBAg=;
        b=hsYT89LkBGITI5XqLCIEVs6BcH2xVpnEJ+vKXooTrWWR86u1qL2rfv/RV6wJUQddcB
         yxdHlIfwAbCfdpnhSieiG3+AgjoODU/TpD2CBVaz1n/3Mv1hUR7KhfsJ3u9STIOLrl3a
         dhl5xnYBXtzyuay3oJfp8+CH+cjAgFKujzrUZnZFffkcl0zcu9h5QK6SOK1Xyuus9AXf
         +fMQEyj+zASkkI/DUMNXVYeLqz9QTn0Da+YlBiZU5oiy6L2OxjE2NrG11PmH6AfmbUcN
         k6sWzxcg5j+9lSVnSuLMRSxRLnFz8fmsAEE2uFruCru5o4lZUzRcsBZ7AuLwaPn6x4Mz
         tZMQ==
X-Gm-Message-State: APjAAAVt8iRJS0ufdu++EhX0yWvQGFEahYygkmn4RpJMVbEFjEAG+IUj
        NZJhEAFNUSlNTavLC2o2eVnKIg==
X-Google-Smtp-Source: APXvYqz0n9giLMoXtTtDedUDpoufMk2XRurLwAdoFDhRH5zOSF8pIBLi4A3Vw32Hg6pi4yerB8y7fQ==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr9964280wmc.49.1573261071890;
        Fri, 08 Nov 2019 16:57:51 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a6sm89530wrh.69.2019.11.08.16.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:57:51 -0800 (PST)
Message-ID: <5dc60f0f.1c69fb81.58bde.04c0@mx.google.com>
Date:   Fri, 08 Nov 2019 16:57:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.199-35-ge0ad85ece397
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/34] 4.9.200-stable review
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

stable-rc/linux-4.9.y boot: 93 boots: 0 failed, 86 passed with 7 offline (v=
4.9.199-35-ge0ad85ece397)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.199-35-ge0ad85ece397/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.199-35-ge0ad85ece397/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.199-35-ge0ad85ece397
Git Commit: e0ad85ece3979aa8efb65ef7e22c924cd63dc859
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 20 SoC families, 14 builds out of 197

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>
