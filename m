Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3CDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF5221D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5FY1/Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfKDNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:04:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35193 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfKDNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:04:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id r7so8820181ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhQ7HFlU2UjuPowmnwPGHmD+EdJPReNvJPv4o/73DLw=;
        b=B5FY1/XbL+HcLM8uSIu6+xWTIFQMhgGR0ZPc+1TqFaYNb1YQ36cPU6LCYvBlUYusqP
         avFe3K1dEA5OAwuz0iPyfvQUmKLIDhsKl0k4ZLnULf/uordbSoPvhYCHckvMW/hTlUSS
         yZI/RBp4yvR1rCdMD7t5ddJBuTgMn8WFIijWmaY8qSTlDu2WR+Sd8gkxHDkISxD5UEhj
         QJl9FclTkuIOpCIAag+MkYWG97kQcyZiHNoweOVHDhYSTSf7PnynXwYEDbUTTXGLXiGN
         qtP4vYFmNw0OHaTrGlgmMTjFc5DC8u70AsjW1rVABrOR9EUNFL8XRPd7z1Ch00QT6eo9
         EAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhQ7HFlU2UjuPowmnwPGHmD+EdJPReNvJPv4o/73DLw=;
        b=QuWMaDu7jKGdZ6OTlVF/D7XvF5Da8pum1b7S4M6A2ka3zcGxcu6s3gnbQyqGFlkL4M
         KH9a0/umYrTCbjunMjl7+Y0flwCtDHdf8u1ocYNcUDMl6+hXpc0y0ptuImdF4iTJ9Iff
         e03Q0fAvCxYE2RwRFxoCLKnsbf51HhDB1RSojkUxoOnT7BFDzJKEpn0wxrVYrlxP5Yct
         q0s/4xFbZAB3xoJA2aybYzXTOz9HH+Z/D1cdK9TH9ExBwDsQEKBfhxiM7EshNqBSf5ZX
         vdmP7H4GueR/C6vY+hDrcoPWiZNtq2lATFMJePQbfQ7AoitXLKTUNn2QX+dRUiGVFgAr
         ODmA==
X-Gm-Message-State: APjAAAXtizGeTttuV49dvtGKi2SLUXgrlULil/+09vu5aM3AfOqR0veV
        d2ncba3EP7JzQPqpf/Bp3+R4WE0PUVbKTl/A7N8jpQ==
X-Google-Smtp-Source: APXvYqz5yHtYXhLt1jqsbom3DmiNCD/Pl9JJmdKaVL59tf08VLPMTBtZfDVWp2YoogUmAUPkOXxwQTAYiXXb4t82d+U=
X-Received: by 2002:a2e:9a5a:: with SMTP id k26mr8959112ljj.46.1572872665261;
 Mon, 04 Nov 2019 05:04:25 -0800 (PST)
MIME-Version: 1.0
References: <0100016e3654527a-82a12a13-1ed1-448a-8c6d-58f7e85bc85c-000000@email.amazonses.com>
 <20191104122138.GA2127297@kroah.com>
In-Reply-To: <20191104122138.GA2127297@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Nov 2019 18:34:14 +0530
Message-ID: <CA+G9fYshX87tu3FWjVH3-hga4SdwbwcXeBFTgmBbH_6tHDdpXQ@mail.gmail.com>
Subject: stable-rc 4.19: net/ipv6/addrconf.c:6747:22: error:
 'blackhole_netdev' undeclared
To:     Greg KH <gregkh@linuxfoundation.org>,
        linux- stable <stable@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two reasons for build failure on arm64, arm, x86_64 and i386.

For arm64 we have identified missing patch,
Patch "efd00c7 arm64: Add MIDR encoding for HiSilicon Taishan CPUs" needs to
be bacported as well,

for arm, x86_64 and i386 build error log,
------------------------------------

net/ipv6/addrconf.c: In function 'addrconf_init':
net/ipv6/addrconf.c:6747:22: error: 'blackhole_netdev' undeclared
(first use in this function); did you mean 'alloc_netdev'?
  bdev = ipv6_add_dev(blackhole_netdev);
                      ^~~~~~~~~~~~~~~~
                      alloc_netdev
net/ipv6/addrconf.c:6747:22: note: each undeclared identifier is
reported only once for each function it appears in
net/ipv6/addrconf.c: In function 'addrconf_cleanup':
net/ipv6/addrconf.c:6839:18: error: 'blackhole_netdev' undeclared
(first use in this function); did you mean 'alloc_netdev'?
  addrconf_ifdown(blackhole_netdev, 2);
                  ^~~~~~~~~~~~~~~~
                  alloc_netdev


For arm64 build error log,
---------------------------------------
arch/arm64/kernel/cpufeature.c: In function 'unmap_kernel_at_el0':
arch/arm64/kernel/cpufeature.c:909:21: error: 'MIDR_HISI_TSV110'
undeclared (first use in this function); did you mean
'GICR_ISACTIVER0'?
   MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
                     ^
arch/arm64/include/asm/cputype.h:141:12: note: in definition of macro
'MIDR_RANGE'
   .model = m,     \
            ^


Meta data:
------------------------------------------------------------------------
kernel: 4.19.82-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 7d816e1d91b01911392b7f8f93a4a153b9af60d3
git describe: v4.19.81-145-g7d816e1d91b0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe-sanity/build/v4.19.81-145-g7d816e1d91b0


- Naresh
