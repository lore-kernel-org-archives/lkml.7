Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0FECA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 23:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D1D20656
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 23:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYP79ta3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfKCXXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 18:23:00 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46951 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfKCXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 18:22:59 -0500
Received: by mail-lj1-f180.google.com with SMTP id e9so2282882ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A7f7kc4Or8nejtGZcNFcOsvUo0Y1VRFgoBZiZOLsbLc=;
        b=XYP79ta34j0pD2uxWxo5iJSMjy2VPx0GMlmhNO+XFSGajwFAYduTtQ3wNBK8ewpXmK
         kjMv+IOmgj5jdZ4ztwnoBddz7XKGJmfjVbVULzW67g3CFzVrhOuq9jQp/kdLWuW6+Lm6
         apTp4FVP6zZZAYj49XMYj90Hwn4sFj6uCDSm9t6ylMlvunivFUQhbM9rA/OZFMVA654A
         InYuxme44Ws7d29EX5tDJ89/2r8hQv/qe+eH081HHXBvnAexGYtEEWmQhI7jgSJEbsgP
         gwlsGhyIZ1TNnkxxp7t+RGO0UlrUjMoTJ/zS2xSgZ2I7jJzVMQRjYCc1gvZ67D5tnyAa
         A2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A7f7kc4Or8nejtGZcNFcOsvUo0Y1VRFgoBZiZOLsbLc=;
        b=n4tw5q5t91JkI3KdV8Eu/SJFhF0QKPHUp2AH9Rg/mqSked08V/AQit5Lzr/Hot+R8c
         77UuHpOsU87GATSZo8EkBgihwJ9Dy5WembaqwT+5QSLo79/YM/dLWL4hgs/Bpap5dc9Y
         jCt0tZP/UnTN1vDKkyZkL8312uXm1ww5u6lFhricO0UocYf40x2q/5jcQGdl7PkYFmkO
         UzxgNv8DuZHr03sNBmMjSCoTC9nrRngYMhjeFE4y589dy5Gich1872G5enR1QK85RDBT
         UVT0+hCHcfnEKQcuHvVrN2UnIYIqAvgZP0wmsjSRVxk/co6yfPr4NWQi6BDR4P5k+cD+
         r+wQ==
X-Gm-Message-State: APjAAAWE7PLka6gdxHVSjCYx8B0H5psr4Jed65qijvAVhpzp0A2dLH7d
        ySobyewOECJOpGPrg13oVatQ9Mca3lCuFdODdTupWA==
X-Google-Smtp-Source: APXvYqwX6VK4SW8IcAEXtL4RSvaL1lf1vcXSiHNSDs8/E3XSjpO1za9Mwf5F70cn9ZAtvWejPgwT2Elwgqlb82FKVN0=
X-Received: by 2002:a2e:814b:: with SMTP id t11mr16972488ljg.20.1572823376318;
 Sun, 03 Nov 2019 15:22:56 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Nov 2019 04:52:45 +0530
Message-ID: <CA+G9fYtoODTuayzXdsv=bFuRPvw1-+dmZxHqQePy6LX8ixOG5A@mail.gmail.com>
Subject: stable-rc-4.19: cpufeature.c:909:21: error: 'MIDR_HISI_TSV110' undeclared
To:     Hanjun Guo <hanjun.guo@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux- stable <stable@vger.kernel.org>, john.garry@huawei.com,
        zhangshaokun@hisilicon.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, andrew.murray@arm.com,
        Dave P Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable rc 4.19  branch build broken for arm64 with the below error log,

Build error log,
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
arch/arm64/kernel/cpufeature.c:909:3: note: in expansion of macro
'MIDR_ALL_VERSIONS'
  MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
  ^~~~~~~~~~~~~~~~~
arch/arm64/kernel/cpufeature.c:909:21: note: each undeclared
identifier is reported only once for each function it appears in
  MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
                    ^
arch/arm64/include/asm/cputype.h:141:12: note: in definition of macro
'MIDR_RANGE'
  .model = m,     \
           ^
arch/arm64/kernel/cpufeature.c:909:3: note: in expansion of macro
'MIDR_ALL_VERSIONS'
  MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
  ^~~~~~~~~~~~~~~~~
 CC      arch/arm64/kvm/inject_fault.o
scripts/Makefile.build:303: recipe for target
'arch/arm64/kernel/cpufeature.o' failed
 make[3]: *** [arch/arm64/kernel/cpufeature.o]

Build log link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/331/consoleText


Best regards
Naresh Kamboju
