Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="tSKUMbGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfCRNW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:22:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43170 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCRNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:22:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so17012995wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=anDKkfkfgUjbCFW17LBVFkEpDX5SSum7g1bnWPoKEUQ=;
        b=tSKUMbGIV9ZwCxl3dvzjGmK0CSvR3tloAf3yCB+5XWILhJ3KVrL6nXRH2Ow+fLR8tw
         lqLxmM+g2SM30sOZp89wkCBPTqhlbzcXyeTJLkn3UI7vldE8a+r2rChL+xphqWpPXj37
         6xNXEcuQrU1/ZXE3A7oNIKT7PknVlRllCptQJ6RRR27K4mhLm7RPizx5fzE2Oc5ayAL4
         u7uX0ynKJX5tjEILSjbaRspg8vJ+kyOpM10q0cniNxLRWOetfhjqYyi1F600qP3iKBXh
         uDfzVEPWya5IOQrFfs9+ldmjBM+GjYmAJn14EgUrREt9O1flkxcME+f8zu0QJPo3+AI9
         tZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=anDKkfkfgUjbCFW17LBVFkEpDX5SSum7g1bnWPoKEUQ=;
        b=okY/doiq/33hsQqID/dfSHEtg6eeQAi7T9FpZrZgXV/90D/lQxxOXbnmWcsHiEc8hq
         +nUhjUI3t6tDQIfYYEwGrj5XxVONwVS62aGFvBL9tF2sTLwLD+gY7bj7keMbR/8ukaAw
         83R2qqft2lX6vpCqCilN+8Y+qrTJ1HYnewvxjyuEwqrHIIeGzchSWrR0fmwzazACEWEL
         mrGwLJqnnPmvS2DngisW3sHHyfbv7ViCpMnf+3+z6NFhdVd9mPgdm6IHuoYGAKDikV11
         yVOFrUscbz5Uita8dA7CDb28kmGkzssAod1mTdcqr12gF4RSTVPMMZQgqhhXhg7lsNiv
         nKZw==
X-Gm-Message-State: APjAAAXCnwWQQBTuBiDCiuhikHVrSF6/CWjE3i6M1RCPTzTrRVqsTSLo
        4yoc9hplO+cDS+dmJrbR0FXCHhWFWjtyug==
X-Google-Smtp-Source: APXvYqyXauMsFn3SlSvfcWq33BwglwLizvemnTLDarX6qEVWPh8legvjQFVMJeTr0hupP0vvK+pR5A==
X-Received: by 2002:a5d:6981:: with SMTP id g1mr9539495wru.326.1552915346318;
        Mon, 18 Mar 2019 06:22:26 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t202sm19580833wmt.0.2019.03.18.06.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 06:22:25 -0700 (PDT)
Message-ID: <5c8f9b91.1c69fb81.e9cdc.e1fb@mx.google.com>
Date:   Mon, 18 Mar 2019 06:22:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.106-35-g6fdcb56d3713
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/34] 4.14.107-stable review
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

stable-rc/linux-4.14.y boot: 103 boots: 1 failed, 101 passed with 1 untried=
/unknown (v4.14.106-35-g6fdcb56d3713)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.106-35-g6fdcb56d3713/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.106-35-g6fdcb56d3713/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.106-35-g6fdcb56d3713
Git Commit: 6fdcb56d3713e8abec18669625bc170613795f5d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 60 unique boards, 23 SoC families, 14 builds out of 201

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            rk3399-firefly: 1 failed lab

---
For more info write to <info@kernelci.org>
