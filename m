Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EB6C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F5121848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MC1VMYh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEJA1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:27:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33220 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfEJA1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:27:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so5441596wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=yAAyy3BHNM/31FkJFRTkcNx30RMpdg86sV/KQ+dR8UU=;
        b=MC1VMYh/rizm4a41+EsnpnBAlqZGhsP0RklmlfREZYU/JT7jWJ1q2PvFNqFW9ytrkc
         O3ImL9X428DgBNaSfxUPUOhA2Tixd0mcVYDZF+BE+24zuvIsIreDEghgaSMrtKvv4LGW
         t+ghAOXnd45PAg6+jar4eByS3AQnw4tpmlGdv3pck/EB0S+RR0I+KbvorYyl/RywK9Bg
         tevrrHQQZTOlFzVtFSLuPW/mlLa9oQZYhM+b5mDJNn/M2vdswbhNBEM58uNHtvHB1PmT
         jNrJIE2UfyKFZQgBfHfVZ7zpBqJdMOYk9xfQltsXde2wR/aUaQkmj/dO0vGqj2PnjUFx
         V0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=yAAyy3BHNM/31FkJFRTkcNx30RMpdg86sV/KQ+dR8UU=;
        b=QkPJulXUk7KSmEek0a0IWiBHYz1nY3OoBCF11sAhYK9JprnI12tJjZ6WaiqeLvInEA
         iWK9OyDLlhWCUXxEVUkYbscXvGfGiVzkaw8LFKqFUChvLh5hpzmPk/wI3ZOwpKb5WRmr
         jd+rACalu8i5mq81ei0NqdVTXmSBolIDOn6eD5Xz22bmsru3BnM4Wc31BxUUFdR75umt
         v8Mja3lF/F3WbTnxVBUYzpifioq9avsHSQw6tHtbwiU63Qvg090hUcTno9f8M4++dAkP
         c0VmDiTIBoR2gl/vDp4lg8Tf9J/m0kFfrht6Gq2uQAC3mUtx4GufYKcdEas8wL1AIj2d
         s3tw==
X-Gm-Message-State: APjAAAWCGBnv/KnazcytRrgI9RCEAUqlYjcYENrGl4t0JVYYx9ehExe9
        ZVudKH40L9FziCjzgUConthZdQ==
X-Google-Smtp-Source: APXvYqyY/HwMu9+Kps9zzh6CuB0NRqAMs2vSMIz6L+iKWb/4LHH4IiEXeM8bf5yzXj/pK5WpBWnevg==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr5445877wre.72.1557448033689;
        Thu, 09 May 2019 17:27:13 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a125sm6286229wmc.47.2019.05.09.17.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 17:27:13 -0700 (PDT)
Message-ID: <5cd4c561.1c69fb81.ca185.0137@mx.google.com>
Date:   Thu, 09 May 2019 17:27:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Kernel: v5.0.14-96-gdf1376651d49
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
Subject: Re: [PATCH 5.0 00/95] 5.0.15-stable review
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

stable-rc/linux-5.0.y boot: 143 boots: 1 failed, 141 passed with 1 untried/=
unknown (v5.0.14-96-gdf1376651d49)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.14-96-gdf1376651d49/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.14-96-gdf1376651d49/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.14-96-gdf1376651d49
Git Commit: df1376651d496484d341d374c3d2566a089b1969
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 25 SoC families, 15 builds out of 208

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            stih410-b2120: 1 failed lab

---
For more info write to <info@kernelci.org>
