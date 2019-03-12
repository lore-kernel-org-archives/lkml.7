Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E1DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19E8214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="oguUHGt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfCLWmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:42:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfCLWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:42:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so4492707wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=OorSSPKo6oG5q1Mx2RadQlHZhet7eHb/IKfVKUxR+T0=;
        b=oguUHGt5qt79C69xSgI6v5clYgBSLCSQsV/ASze5QypQGsuDdIQ4imKAwpLL26ggTJ
         LeY+y2QGtScHgfyRYgvQwIjG5zrtKGe41gA7yngAi9iFrIyXkoRMdaw5KNTPEWHMlFU+
         inbcxmK6ebQcW3pekj2WMARfvg4NpWM5he8rCbd+k+fm00Q19+QE0pVwk5FzS4K/hN5s
         8dwenQ9xH79+Cbkt3D2Aw9LflvIfNR/HSf8EvYUT0xkHMDinHYo7XAYIT2kkdoWed/Dg
         jJj1UWOFFmO50Rq4Yn1zNkS/Dhlwsp8zhqelbxDfZSPkiaLfedn7x/n4Nc+7sltmufVc
         cMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=OorSSPKo6oG5q1Mx2RadQlHZhet7eHb/IKfVKUxR+T0=;
        b=pmMDHdekCrlTJDkaO65dH+h2Nfbs86MewhxUJWNAfy5zBJ2LYlPoRK7+Tly6CY7AQd
         IRAZw4N/z+njxQqmwqqBh01qagYalA77Ux3a9PJVv4fSbkNV7GsTtEHMinZKgel0WY/a
         lil7TXfZ64lZ/hYnU/mlgAHZXGfDBPRxRrlW9VJuCGEmx90gH9k9zPuef1aoDRZWuSn7
         Mp4uaPfPyxOqStb1IQo/uVoqjWFW3hlc+Dg2H8wAC3mi7DIpwTYf1gBP3JT27Z+x0Dk9
         hNQB5VYtnEqWznp3wcQUHTH2UfMwL+zQMJSF4mH2rPdi0wQP73keDTsO0b7Lc8r8xvhb
         nEXA==
X-Gm-Message-State: APjAAAXBdBcvnvhYIwPIlRBkuIYqCFuOLg6kyf0nLNOkZuGm6n/n+ETf
        qAk1eATy8tgd9YWsNCfwDsS5SQ==
X-Google-Smtp-Source: APXvYqw03lEhN5OQAkOnEAimcn9OnMO5nJcDRDCgbMsLmHT8boFZIrTIakjHGgjaINn3vJbjBjJfzA==
X-Received: by 2002:adf:f584:: with SMTP id f4mr10179951wro.264.1552430531546;
        Tue, 12 Mar 2019 15:42:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f13sm37821wmj.29.2019.03.12.15.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 15:42:10 -0700 (PDT)
Message-ID: <5c8835c2.1c69fb81.b48a1.0315@mx.google.com>
Date:   Tue, 12 Mar 2019 15:42:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.105-136-gf881675936ef
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/135] 4.14.106-stable review
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

stable-rc/linux-4.14.y boot: 105 boots: 1 failed, 103 passed with 1 untried=
/unknown (v4.14.105-136-gf881675936ef)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.105-136-gf881675936ef/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.105-136-gf881675936ef/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.105-136-gf881675936ef
Git Commit: f881675936ef263f178eab5a5cf95bc86089cf20
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 58 unique boards, 23 SoC families, 12 builds out of 197

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            rk3399-firefly: 1 failed lab

---
For more info write to <info@kernelci.org>
