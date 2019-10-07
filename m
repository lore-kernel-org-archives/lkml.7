Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B64C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FF62084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="WaZ49LUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfJGABV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 20:01:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33672 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:01:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so13110712wrs.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=8A/b/buLvgq885sAoN7Nr0i+KAjyO9HJlZWwmpkzPBM=;
        b=WaZ49LUblvFIfMvFw/zQrha2Gu/0bUasotvpoLH54PdQvaMX/AQvQJVxby8EgF8dPA
         51DU9Ote9sOvhs4/jic85DXGz3anNOfxGyjkgbeSVVoNRMnSdd4kcsS5sThQmwUnUGl7
         4ieJL/UUJcyUEH/fplSBvI1UkJ9x0bb63Wv2o4xsx73OxOfG3NNAtbwWwKvtQgv+jwK0
         rN/RcVwZMD8YKit9FDMYntFrFq64TyExgRiOefxXJuhB6VGcR92nuJdJ9KrxFvMUKQws
         gzHp5En3AXRq3c6r81BM+xp85LwQxnGtCovaEHFL0moUb/ROyj72Ict6En/aN9s0od1f
         A6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=8A/b/buLvgq885sAoN7Nr0i+KAjyO9HJlZWwmpkzPBM=;
        b=U7UhEUZ0++kP9FqDyySk0XkDHcadpDGRTs9bLe20OzSKBmS+ymsK0G46auaOXXATBl
         C8F4bhMn17ecZOZhDKbm+5eIs/npAh6H3WRBJ5vZFxYeJVniXCixh1422o25khYmopjk
         ps8OC7BC2u99v+v1OMGvVdHwy1eP6T2YITE4QTqz0Do2KTQ1B1IfebXHMuqKYzsgeoj5
         ed1muaCVb7VLU1BPWTsxmXmnXFxmmE+JJl494MtGz7LoKSOAznkwMpyma1E8fN1OVDHr
         Q3zi9kqm+4uUsTO7TkvTO1mXULizcEURaIsfg2aRWcLctTmjQ4sX8KSNpXhfHJDgm4J9
         oOjw==
X-Gm-Message-State: APjAAAVmcmd6aMa4/tLqopsepQo1YanfmSZqL+egWgV8+w0GNgtpZpfN
        3AZgAaD/Ade+VD3ac8H+zcUo6A==
X-Google-Smtp-Source: APXvYqyT+osXHm4zxc/ZrBzht6GDZ1DzEJEIwzpu3A3usSFzEHJfzlJBvMXFUdidEn07lEqvd/mYIw==
X-Received: by 2002:adf:cd86:: with SMTP id q6mr11221308wrj.153.1570406478717;
        Sun, 06 Oct 2019 17:01:18 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o4sm25830666wre.91.2019.10.06.17.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 17:01:18 -0700 (PDT)
Message-ID: <5d9a804e.1c69fb81.cf4b6.33e6@mx.google.com>
Date:   Sun, 06 Oct 2019 17:01:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.77-107-g61e72e79b84d
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/106] 4.19.78-stable review
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

stable-rc/linux-4.19.y boot: 56 boots: 0 failed, 56 passed (v4.19.77-107-g6=
1e72e79b84d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.77-107-g61e72e79b84d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.77-107-g61e72e79b84d/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.77-107-g61e72e79b84d
Git Commit: 61e72e79b84d3a2519ad88c10964d7e4fa11ef1d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 39 unique boards, 16 SoC families, 12 builds out of 206

---
For more info write to <info@kernelci.org>
