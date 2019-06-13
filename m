Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1B6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CA920449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="uCQaZyzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbfFMPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:13:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35721 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbfFMNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:30:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so10171602wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=fG7zTrGYhrTn2R8dicpGyyCWK8SjK6usqkrzLPnkewQ=;
        b=uCQaZyzX5/SinctvqDo8dFQ4w2Na8NlIkQzusQo9dViadlKq9VIwX02tHVDXpjt4UR
         fYujjVWR+GnxCIFsUXKKCUYndPnCBEjxUIs2osCBcFFPiDFaGFkiVwLpQL8MRUx0mQVG
         fky6mP+/FcwwBHuHGg0OugYptaDJ6jxyDi4FJ9ezUVV45icwJMINKGmeL3bpq2QzWf+w
         JE8RGTmqYYAYoSuQxa77CxEyRBZYjTbAyubo+2xxZDptGnS9RUsilnhteU+tnRrcZWBH
         Af8codS/S6Of1r9oDANWmAu8EYIfLzPbSj8PuC7XApzPdWOUsUkaC4qOQeRqd1PueFKj
         kZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=fG7zTrGYhrTn2R8dicpGyyCWK8SjK6usqkrzLPnkewQ=;
        b=lR3HNv61A9FiEl/Sjb8Y//uUMwgvG92aTa47APTMqr/eFRXXUwivi4LLdpuIbz3Nzb
         ceitA22sbVQTQDXXmzg3LPhMBjD/LyJcufpB12cfzQSxP6v6mr5RYewf1qzr6jnmU/gf
         1Ez4qH9iFZQeG5MWcOVIr2LvMYyjmSzh9JHBcaO/7QaKcU3HhAhl4m5Q3h8kvV4+bLFI
         00evmIgttXAARaj7y1hYYJnQA4b9IF6oQ9lPTPhYe8zGkIcFXDD3r7FUEjjPqSM4qvea
         1oba6sEiYzVRj8xTAxq128hxADIm6Nkzc0TfloMGIzaxItHpjXG1CqwAfua/YI2A7OWc
         /TUg==
X-Gm-Message-State: APjAAAVmZwmPqi1/kdDxziqTKXPygwolqptRqj/9UFrZp22JXU6hSyWV
        Kfr9m3JUGRqHn6WNAnCT/3f23w==
X-Google-Smtp-Source: APXvYqwwjn735ZcJh4RCTzzb2yvw+vbpmotjGHKxj/HsIfwbG5bEALE3PPpaQAxEGGSxu1SyzuhDOA==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr3844073wmj.103.1560432624540;
        Thu, 13 Jun 2019 06:30:24 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j189sm4337413wmb.48.2019.06.13.06.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:30:24 -0700 (PDT)
Message-ID: <5d024ff0.1c69fb81.749d7.81a6@mx.google.com>
Date:   Thu, 13 Jun 2019 06:30:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.50-119-g94ea812871ce
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/118] 4.19.51-stable review
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

stable-rc/linux-4.19.y boot: 123 boots: 0 failed, 122 passed with 1 untried=
/unknown (v4.19.50-119-g94ea812871ce)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.50-119-g94ea812871ce/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.50-119-g94ea812871ce/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.50-119-g94ea812871ce
Git Commit: 94ea812871ceac0a190ded80c3272a779dfb101e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 69 unique boards, 24 SoC families, 15 builds out of 206

---
For more info write to <info@kernelci.org>
