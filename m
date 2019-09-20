Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B89C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF374218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="LdF1Spbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfITEAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 00:00:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfITEAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 00:00:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so732992wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=F9l8I5TdxL6PCQcPL+1DndsT7qoplt01uSl1H39UVpo=;
        b=LdF1SpbqaISG7VH07rUDXDoxP7Hz5tYK5t3+iQPrIMSvHiHnAhGm1dnEkxHhZ41CY3
         vcTnIq0TmLYSv/Vx9zGoSOMw3wvPodVcHMfGVMI5wEFJSzPkHSeSYodjUA4F8HO2HYAD
         Tct5qX0wWD2IQ6a1F5FNpnN4Xj+iBNk2snAAEZO/PEqZisYTC2Nc+8+gxqz8lbACNikJ
         ciw0zV7AAQzy4OOjaJPR+5/OBQbD8zSafuOn2sabgBxaFHWQ6hGnWGCgvt0iCptz4Foc
         +TkEjvGrPc5qKpfPOnck7lyUu6szbzx3OpjnkGQ8u3xYitnx3FBBOpx+Zx1LybK9wwEI
         K3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=F9l8I5TdxL6PCQcPL+1DndsT7qoplt01uSl1H39UVpo=;
        b=OWF1WGIAHlH0G6mWiuR1vhLd4nl7aJr3ChIagHZTVimd9QCoZfBLv+TzHKb3O8rwvS
         332PDPFQ8wfZmuoZTYasKeV1ymgJnrx5fVztzkIg0uH/cCgzRoDu3wfixYcUh/LcTAAK
         gIjmVcb5xpr7AFaJeDnW+eKj/Ljfy+p7VthaOqUkIaPV6bQMoqhK1b2mghU3chYgtYhj
         m+SkvKAHjBj34nBY0T696dzO92a18ep4YGUyCuf1e8N8hssQblkPAG5x/t24UdU9lPOu
         jyuv10w2dCK0kTD/9NtXOZJgZqXty7BBbmLu0UZN5lygZ9EwW1CswbCSM3p5vyav1RQE
         VvCQ==
X-Gm-Message-State: APjAAAU5Qh1BCpGLwy/nZKipqFcqa3W5SJqS2Y5OQqOo5NnSG7Wu6tj+
        gegBvip/qXdWpaVzFS9QDOWlHQ==
X-Google-Smtp-Source: APXvYqyVJ7rNOXZjqj/s7P93tAHrFU/KpzzDUgMgeTGzWkJgswwWyoZZVxcIHxE5Mb9UVUvixqX43w==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr1410685wmc.124.1568952002885;
        Thu, 19 Sep 2019 21:00:02 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d193sm706821wmd.0.2019.09.19.21.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 21:00:02 -0700 (PDT)
Message-ID: <5d844ec2.1c69fb81.d3c01.26c3@mx.google.com>
Date:   Thu, 19 Sep 2019 21:00:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.193-57-g7b679e1a966b
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/56] 4.4.194-stable review
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

stable-rc/linux-4.4.y boot: 47 boots: 1 failed, 46 passed (v4.4.193-57-g7b6=
79e1a966b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.193-57-g7b679e1a966b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.193-57-g7b679e1a966b/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.193-57-g7b679e1a966b
Git Commit: 7b679e1a966bc6ac22d75cae76b97a9fded9367d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 19 unique boards, 10 SoC families, 8 builds out of 190

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

---
For more info write to <info@kernelci.org>
