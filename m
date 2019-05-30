Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB8C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F21125633
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="L3vsTD4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfE3JJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:09:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34842 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfE3JJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:09:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so405809wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=KwLKUN8slvjd04RjjPvWvOTD/dy+wDNN+lQ29SfJmq4=;
        b=L3vsTD4glvbgj+ev/qNkSGIHk38D/C0vapNjbxrqQqhWTtevSyBB7sezZi+YFslVPb
         Z+TdCTChr6AkL0LY0EE1YtcIdq9NqNwNTDRIPh3orJzdDhMhuELqabzftd8KndtwMtCR
         xtk78PyeTXV+gD4WhL/8qbrCfJzRxw+WKkSpA00yTX2Mc32dQf+PzXckLi02AsK1+i+7
         04cU2H5SMFUDIueO4cERLqRS0G07TnWunrUljpfoOaH09C8dtWEQ0UexORZzw5GxvNf0
         pqTfY9vcrL314KxOLBamiUl+008zAyBrUEmN6LPegxce0Rz7xwomjVyHK6KPY7MgcwH+
         /bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=KwLKUN8slvjd04RjjPvWvOTD/dy+wDNN+lQ29SfJmq4=;
        b=I0COesqEjPHmpnJiqG/VQe+678EtBwUtQ/S4g0espHCjPri5wA8iNXtnPhrMtl4Bc+
         nQERjiRsAsyE91bBkIZHgq/tjlzPJDU2pP245dQ8+Y0a3SwdYA94C4di2Ou2BCHLlQoc
         2HPrfdnAnMBPsLW1zq7B6307+f/nNFiC11qt1YrTLJEG2LGAOI+F2nYKX83TBGL+NFnf
         WRfpRw2ZQY96A5LY1AQLgH3kiLK9fY22urkag/C4Zu4kK7B6o6uWOI6TPQNOmFSFrHyt
         TCKJclp2CVaRpJJJPeUYty6wllZEL05UP7a1vvmdbMjbb7izsHl7aXX1QDcvSdDwRFjX
         zJxw==
X-Gm-Message-State: APjAAAWzpNla1+pfuigtiN6dvy5OCT3bllQRA7M8YeK0PMVQoRtkvoXc
        FqX7+H2mu4sD3odNyfRMPdgT+Q==
X-Google-Smtp-Source: APXvYqyvjde5WbkcI/hQFOanzLzO4AKbZ9BWC5gqEJdyP/xXB7rVQgkQzXOsdGOrF2ETwAW2uxXwRg==
X-Received: by 2002:a1c:6154:: with SMTP id v81mr1445550wmb.92.1559207346390;
        Thu, 30 May 2019 02:09:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h90sm6699497wrh.15.2019.05.30.02.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:09:05 -0700 (PDT)
Message-ID: <5cef9db1.1c69fb81.12cc6.0ca6@mx.google.com>
Date:   Thu, 30 May 2019 02:09:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.179-129-g545b59ea794c
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/128] 4.9.180-stable review
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

stable-rc/linux-4.9.y boot: 103 boots: 0 failed, 103 passed (v4.9.179-129-g=
545b59ea794c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.179-129-g545b59ea794c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.179-129-g545b59ea794c/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.179-129-g545b59ea794c
Git Commit: 545b59ea794cfbac3646ccfab4a34c9f7753621e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 21 SoC families, 15 builds out of 197

---
For more info write to <info@kernelci.org>
