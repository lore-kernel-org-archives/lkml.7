Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE5C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2E520825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MOXKNuRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEGWrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:47:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEGWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:47:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so11420259wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=9KmZcvbM51Ahdr1a8pXzpoTQRpVZOoeydHZiJZ+kMlg=;
        b=MOXKNuRq6G1Cab3TGfzPz4NbGfvhNpLU88y5ZOW5Te+AH0kwjRSNyHHZEzkkuNnZ6/
         YuB86zdivMVacZQP/8IxTQiZlyLYBPW3FVP6/tluXjHMXo7O0hTCBW2Kx4zmDB4GJvBS
         H+aEqkhJk/JqUsu23xQdhI0TKNY5tgGDqtmTKGi3a3QLnmjy6axqCP4WUxqPqdVJMuk5
         V8CwDqImiJ1IbdQOEAy7Evv+jGR5P+g48nUyu1kc/syvD5pcOkCYSDaxdHHniQdq2Vjm
         oAsNM1wf4daUks7iunqls+++luohTyjiyN+vJgN2cwh3AE30Ts+bzAxs2F1SzJm4L+v0
         g6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=9KmZcvbM51Ahdr1a8pXzpoTQRpVZOoeydHZiJZ+kMlg=;
        b=HKDV4EgsmaejEWNTvSrKR7vVZ+0B3nzNUjC0MI0KbFziPCkKvd+uP9yfdnF/0Dv8mA
         jgTa6RDJuORzzEI+ERQJRqgbPfzx5Ub6+Iyhp5MIHhw35sY8q+6GPl8BmaMg4sqnxA68
         js/p10pNdvttG5iLtAxEN2MMgDiI4Mqd5rqHpMzqSs8kGc3KG6IMBxG3Gas4rZtimze6
         avti+Y6Wj9yxz1i1lCpuxdRNguOJnPEivguZnV7kANo87m4I9Ac4NG9oNFUks08m6dsE
         Jc7to7Befvuk2R4oTMVJilkWFcUHOieslMZlvOo4aPuh8ZvmM2j56lkY8riDA+u6gmQu
         Y/hw==
X-Gm-Message-State: APjAAAUewK3Qc+0qQhvpV7+4+X1YurvS3q950WFFOjicNUI9tSDdB5cX
        /HNNQlLDcNCn8ZAbBpOQmSLbFA==
X-Google-Smtp-Source: APXvYqwRoaj/hHFJl0RN2ppt7xelUHTljhJJzr+5KeC3rV8d9qUmGOi31ZkwaoRwnza8C+/Dy5wqzw==
X-Received: by 2002:adf:9c87:: with SMTP id d7mr18660680wre.68.1557269222219;
        Tue, 07 May 2019 15:47:02 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 91sm25815586wrs.43.2019.05.07.15.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:47:01 -0700 (PDT)
Message-ID: <5cd20ae5.1c69fb81.b91f5.9074@mx.google.com>
Date:   Tue, 07 May 2019 15:47:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.116-76-g2e004f6acb80
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/75] 4.14.117-stable review
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

stable-rc/linux-4.14.y boot: 64 boots: 0 failed, 64 passed (v4.14.116-76-g2=
e004f6acb80)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.116-76-g2e004f6acb80/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.116-76-g2e004f6acb80/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.116-76-g2e004f6acb80
Git Commit: 2e004f6acb8062e310cf8e50c91d562d91dcdb73
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 31 unique boards, 15 SoC families, 10 builds out of 201

---
For more info write to <info@kernelci.org>
