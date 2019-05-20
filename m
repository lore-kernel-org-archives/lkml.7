Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B97C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D49720851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="eeQIySQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfETT2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:28:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35877 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfETT2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:28:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so492909wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=1w+fH/v8RBSWF87o1Wwaj3X+JwCU/nfmU+CgH+VdYgw=;
        b=eeQIySQgLbMrJSxJsZ6JOx3D+Ejh4BCO3Y4Qdnke/T2NRm38tXjoFDz/d46/Cp7k2C
         T0Vm/Q0GIA8yDkRmORwFqdq39y8VjKE8BNOgPnopRc41662JICup+Ilf3qIjsUwdXbv2
         5uQ8+wXgnJQsSLHm5IUX3nCE5XD5JS+xl+KmXeOGKf3EDa2dY4s/01kFqPj+4YKFyV6d
         CXM2r3vLWYRqu357RIcE73alx8nrHlxqJ/W8z3bmONPkVbp51zJesKTg5E4MizdlYMcT
         Yk1T1XNlN4vKJq1uHqW1WMm0sVKULdehIcG/5/dpWXL4kw0L+OD4tJzvkZLamF2i2ve7
         bzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=1w+fH/v8RBSWF87o1Wwaj3X+JwCU/nfmU+CgH+VdYgw=;
        b=fNXIiP2G2YFYKiqgh0hwynVHIr9H/fwTFSKx2K8w50itr1UR4KH8czqRGqwUKCBsq9
         YKK5g9vdD3CNsjm/CO9oeBasfkoVvW9RyDC+TFTqj8uUe6SW1qCg7s3zduqdXjpVUfp/
         JzZkrNA0bOueo1FqemwHKZ58RTZnNsP6TqU3UuDlC4GR99zU3DyFgUXw+ppcU/AAnDTa
         1h6AzMaSc00TdQXu5ZK4sRURv8/7CUpTALoxx4Fz2uFKH1FmXPsGz6/5GVutLLticIMb
         gUEHFZ2E/5Rr48ZqH5sEamO5HpRVg0vteVf8jhBGK8LMQuytlBvintdz6zCYR1DfpexT
         99gw==
X-Gm-Message-State: APjAAAU6KR789N93PqxrlVbR3opBk4WMQ2gQu6Ozo+3+/h2Nm3TnS5jB
        HGEBN5GwGw6851WRAlG4doQtW93NNuyfsw==
X-Google-Smtp-Source: APXvYqxeci9/TiZ7dSAkbs+57L8vtptqQMe2a7YDH/o2FHva9o7HtVHYQTOg5CIhlxZe0WQ8/WQgAg==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr481983wmc.129.1558380496475;
        Mon, 20 May 2019 12:28:16 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h14sm17334290wrt.11.2019.05.20.12.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:28:15 -0700 (PDT)
Message-ID: <5ce2ffcf.1c69fb81.2ec6f.f3a5@mx.google.com>
Date:   Mon, 20 May 2019 12:28:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.177-45-g1a569b62b013
In-Reply-To: <20190520115230.720347034@linuxfoundation.org>
References: <20190520115230.720347034@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/44] 4.9.178-stable review
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

stable-rc/linux-4.9.y boot: 94 boots: 1 failed, 91 passed with 1 offline, 1=
 conflict (v4.9.177-45-g1a569b62b013)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.177-45-g1a569b62b013/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.177-45-g1a569b62b013/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.177-45-g1a569b62b013
Git Commit: 1a569b62b013b75248598605647b0c077a399c5c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 47 unique boards, 22 SoC families, 15 builds out of 197

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v4.9.177)

    qcom_defconfig:
        gcc-8:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: new failure (last pass: v4.9.177)

Boot Failure Detected:

arm:
    qcom_defconfig:
        gcc-8:
            qcom-apq8064-cm-qs600: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
