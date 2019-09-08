Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F274FC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC726218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="STnPZu4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfIHQ6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:58:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44116 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfIHQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:58:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id 30so11268160wrk.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=5cxYzNBRMBcx8NZ7jDdRQwdLkktnjDO1pmwjV4xyOFQ=;
        b=STnPZu4MJUDFo/H+AJzT2c6FxgejdhLawW5ESpKrzsBb3R6JNR0tj0BvJoXQSusIVz
         BwjCBGGx5hlYWlPGlE+J1ctY3KPoa4BIV0LBw+YPW8PvxR58CFjmpS3KoBfeX6+ADayf
         NFfWET5/z5XgQl+qsaFuOr5SWMRA4HqqTfq4+BFFcjxUU+K/XhRZOCsh9P4GbUBXWJUp
         OgPc6Gdx2GBREitlujPOlQiOONqif8OuBnn5oSpZL7JHiA9J747p3lhgs+niVIzX2YtE
         k5ZwDQv5jEcZvjLP79Q3JZiQjP3JwYuFyU2d0MLGbXiFVG1aCKwsTie8ulm2uq40iSn/
         Mb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=5cxYzNBRMBcx8NZ7jDdRQwdLkktnjDO1pmwjV4xyOFQ=;
        b=sCAazGrb8DAt7h6tl888aIjHD5gxCrdL8g1AB5Z7gNclf3TnUuS9s9T3DQjO1m9JZw
         WS+qPNuDl8X+QYeBmw3yWJ89VtgDd68MHnSSHjDtapJQJDv3ml/I5t1mZqpABdBcmFuW
         nhkdyAlO7zkw7SHFUSXbDMX9vBFjB5Xnz0zGF7rFRcY+4u/D6UT1AG5NfuAoDyvuhgta
         25E7DqxppBp/M0vpjpoynKq2rEe/37BdiBEe+guMCQzmnMxHebQECjEq/uZ5RYsvxJVZ
         MWx29Wt8742KNhCof/6+Lza/3VsLYyI/qbBfibYUQTijLYTCFftUhxFKmMlLs69RzRmb
         vXLQ==
X-Gm-Message-State: APjAAAXazsgGp5QEBXNdDa7nb4FhYvVklZ1ZIOBi8rhEm/dfPqsBFx/p
        IeqkomDSFY2Idwd2JNvVt7zLdXJAhsc=
X-Google-Smtp-Source: APXvYqznobkFxLMFKQk/FPWI7sBsvopZv9PbJBAvA9I8T261yuDZObDj9/eNeeq6eOpfuhSGRTPgSQ==
X-Received: by 2002:adf:ead2:: with SMTP id o18mr15108845wrn.107.1567961915054;
        Sun, 08 Sep 2019 09:58:35 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t203sm15346562wmf.42.2019.09.08.09.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 09:58:34 -0700 (PDT)
Message-ID: <5d75333a.1c69fb81.94c91.883e@mx.google.com>
Date:   Sun, 08 Sep 2019 09:58:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.142-40-g6b6c4e3151f3
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190908121114.260662089@linuxfoundation.org>
References: <20190908121114.260662089@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/40] 4.14.143-stable review
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

stable-rc/linux-4.14.y boot: 80 boots: 0 failed, 80 passed (v4.14.142-40-g6=
b6c4e3151f3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.142-40-g6b6c4e3151f3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.142-40-g6b6c4e3151f3/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.142-40-g6b6c4e3151f3
Git Commit: 6b6c4e3151f31a94bec9c9c14906b1fd3cef2d87
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 37 unique boards, 16 SoC families, 10 builds out of 201

---
For more info write to <info@kernelci.org>
