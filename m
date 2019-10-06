Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42E7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9678220862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="QebelLM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfJFXlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:41:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfJFXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:41:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so13078007wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2AVVZuP6kRpkgBFdGu0/PBs/Zxs8/JTnpS/uTskY5hQ=;
        b=QebelLM9RylRDZILcVIWQAh0EB9YgifEJHF77MAFIOUdlj9DYWJwPFdb9roKho7EvM
         pjEhGDM4LyWtto6tAUnGOaybDU5mg29yhZSt0vN9TDEKN1kD1AmFxN4SLaxRFACZEbgM
         FF2YC07tNWOAJPYuPLzbCzIDCib5ra7vv0Rkm2YKedKhdFGw8sSqO1kbwBwau+kHGgrO
         Et7ZwTUH+OAJ3nGNTJ72HprgLTBmDCcNkIpCpn6ie4K69efkonO+BReBqmVLQSWJFqjF
         KjatAarFbtCrXx7lJM9Wao9KzhBuPfFbJ/LlboVVCJRVW7thku10JNU7/nAYAwYd1b4T
         cylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2AVVZuP6kRpkgBFdGu0/PBs/Zxs8/JTnpS/uTskY5hQ=;
        b=iwg2kTfMz50kJ9e2A9eloc8Ty7SITl7QYxT6CPjLeNt8OwLOniZ3n4fMtEboun6dgh
         vEQWzQzFdEK6HXZoMrFFoxfFF/RCuTaybPme9oTi65bktEi2OUk4ID61d6r+ZjvTtzBm
         vn/8VV/o2+b2a9xb2rr7tiH2LWyVNWjUHZIzJwV9gaQ+706yXiWrhy/94PJqAocJfOod
         PbaEFXPrvGE0WfL6RBcUsn6gIiWBlWXU2iwK4TXFwqrWHJm4YQD4+NjmCCWUHAFt+PCz
         18vN3Oy516R6tV1S53g721QeKHw23wV5TSfohpljDIyo+HLpB3gySclqSJ/nNdAQlzw/
         uoBA==
X-Gm-Message-State: APjAAAVY5pFhFK1jsWetfiA4x4PV6UVYmN1fuH3LWV1fCkNSQfZxQ0nx
        8d2/MZ4tkA7rPrpjxU92dtOI/Q==
X-Google-Smtp-Source: APXvYqy+X4wqx7pdNVuZNr7q908rq+zyXvBqoT+8W33XSHhrytfbFPFh1G/Obr4oJ1A1mFCEd3BLtw==
X-Received: by 2002:a05:6000:128e:: with SMTP id f14mr19273644wrx.73.1570405277325;
        Sun, 06 Oct 2019 16:41:17 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z9sm14341532wrp.26.2019.10.06.16.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 16:41:16 -0700 (PDT)
Message-ID: <5d9a7b9c.1c69fb81.14b6f.089f@mx.google.com>
Date:   Sun, 06 Oct 2019 16:41:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.2.19-138-gc7a8121be8ef
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/137] 5.2.20-stable review
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

stable-rc/linux-5.2.y boot: 62 boots: 0 failed, 61 passed with 1 untried/un=
known (v5.2.19-138-gc7a8121be8ef)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.19-138-gc7a8121be8ef/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.19-138-gc7a8121be8ef/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.19-138-gc7a8121be8ef
Git Commit: c7a8121be8ef67066e07c79b2204dea12511b17b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 43 unique boards, 16 SoC families, 12 builds out of 209

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s805x-p241:
              lab-baylibre: new failure (last pass: v5.2.19-133-ga4c5f9f597=
86)

---
For more info write to <info@kernelci.org>
