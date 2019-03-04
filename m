Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE9206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="jY5Cy7+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfCDOVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:21:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56211 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCDOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:21:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so4794782wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 06:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=6xQ3CIDNuGozn7mgedY6P/lhTBCwZ8di7eLnv9IvQDc=;
        b=jY5Cy7+pSTo3SWw9UwWf4DeMkqmSC6U7iH/PtqFXa6dXHeACk7J4YKV/leyOfsq1oj
         FFOEwN9X99bgAyr6+6mATq/49AouI+47dRHvWjqFXhZkru9Wqqbw/kz847toRldSNoJ0
         jv0Mi9Kyc4Gqya52uZBcn/3SkhBvPCAPFKXIMTccDR3/9Rdis/XUOJ6E69Gh+Yo+ysRz
         UO/gG0Yoj4Vye+BSahJhJDBvY0XBMbxj/1jJMbmYTqm9IDoJe6nZr84Nn9UGwj8OqJRj
         pVejMoR4oWJCIZsNNO0M4madF2KxWQEaM29ZNcfstqRDz/SFg6dryBIXqDWwA3VLmiY7
         xTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=6xQ3CIDNuGozn7mgedY6P/lhTBCwZ8di7eLnv9IvQDc=;
        b=mZasRw+60fOoVBxxE5CurwEvPIN++9oT6V1qcgpgqPhss9qZFXT4GQPprdH8bsb1Gh
         ri3dTnd40RHbXROckgMu7vKWxvJHSv72h2eYkRvlfsILstHtA19SayIWCZP82aT4/on8
         UssoJyU2OuLM9ZTrRzBZfpDxDp0GEf0Jdr215QEXbPJ5zkTbVmNuy4D5GbWESPQorso0
         IE3ZwnyW0UGD2c+l8NEQASjl+mNa0rq/RzmujJRlPqWDgOTL1+q7eUyYcnteKdcOUlvx
         pSQWMIRR/sFBAOIB9E3/3g4W+AHWROAxmlAi8qDplGLdX2CLoC/64dw88iKS9VaV0S8z
         IWqQ==
X-Gm-Message-State: APjAAAU8OPX8kcu8N2S4hiGC/xt13TKSwuWDeOjs+U9vy94znxyK3bac
        vbtScW4CTBKqVXGPUv2qIfIpwQ==
X-Google-Smtp-Source: APXvYqze8QenxJSJZ1xxJ/YhJpCBh4U0tAesGLmBbZxb2aDcGuwNmCtf1nXB1UZ6NCfhIeUUXC0sVA==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr9257255wmb.46.1551709261988;
        Mon, 04 Mar 2019 06:21:01 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d21sm22646998wrc.44.2019.03.04.06.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:21:01 -0800 (PST)
Message-ID: <5c7d344d.1c69fb81.21f06.c909@mx.google.com>
Date:   Mon, 04 Mar 2019 06:21:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.161-33-g95ebbd164ce2
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/32] 4.9.162-stable review
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

stable-rc/linux-4.9.y boot: 91 boots: 0 failed, 90 passed with 1 untried/un=
known (v4.9.161-33-g95ebbd164ce2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.161-33-g95ebbd164ce2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.161-33-g95ebbd164ce2/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.161-33-g95ebbd164ce2
Git Commit: 95ebbd164ce260ac8147ec92861b752e1416026c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 45 unique boards, 21 SoC families, 13 builds out of 193

---
For more info write to <info@kernelci.org>
