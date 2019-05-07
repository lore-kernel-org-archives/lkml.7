Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9794C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA7320675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ahJR6LhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEGT1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:27:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44947 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfEGT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:27:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so23854830wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Snv7TyoiGAcKNv0tuFYq8gStYoAzEsMX1pXAbixEywg=;
        b=ahJR6LhOZaw/AKX3XQShai5q5fKGZgezH1HRW7PZg3qTUvHODj7PancgoKDpf4eYPB
         8D+Uk08/K8w+BrDtXi6T4G9b09r8Kbu9s8wTJj7MIAxUlmRL1EBFpjHqsd5JNvRfafOz
         kHsorRt2Xb8o/9e3re4j+yL86uYXjqwuzOrloBvDdpS43qYZ4RKQBhoCnqOH8Qzf8Jc+
         fndMpElNwdLnxC/P69a+zezMCKhmIhVhsyn82/kBAQ9juGgU9CImIvSJSRkmEPEoVc/q
         rPe0w9yF6gSoj5g5W0sc1z4UeOiWTzVADhhK4NDDjn/AZaEsh4rYXWW6vx8lBy2Nc9ED
         xMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Snv7TyoiGAcKNv0tuFYq8gStYoAzEsMX1pXAbixEywg=;
        b=HoU28wOphygesys8ZdKj1edhIlny2jfXxx9pSRAqvY8q/OHpJgJYDUIOrr2gX4FIfm
         QYs/ksh+hld0ZdCMyxI1ix6GqBYNnDw7VpxjHE5LYs9gRYHAkbwFxHNYhKfeF5IBu6oh
         YICdTNGFkurpkRgP3MSb6qh2N+JwWGHjN6q8bsebN9TYhmu37z6V8jU/jOqfbpKJ5h1x
         xcppG/cZ+DjuPMbY7h5/hVV52OFmf2VaGios9soH5KFbwomo06kuVIC/Q+NesjVy7Kis
         wS2PwlzvxzNc6Ii2kUXPoJ3OvSA5j8QK6rMArL5HNe+QLZpV7JLsrgIwXpX0gDQLW93q
         JwjA==
X-Gm-Message-State: APjAAAVfUu/OMqcxS2C5rVdJxPpvFxU7T5JyJQzJXV4BKuYv9RIkCI0N
        pY5q3rmOIKjV5Habr2VZ8gcJ2g==
X-Google-Smtp-Source: APXvYqwZvey4kdE6QfjZ1FMDGUpTasFbSeF/gxEF+fQQVuag6wSWUDqY0OMwS8/kJ0hMrFB3Ovu46g==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr23305782wrx.314.1557257221363;
        Tue, 07 May 2019 12:27:01 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m25sm14465583wmi.45.2019.05.07.12.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:27:00 -0700 (PDT)
Message-ID: <5cd1dc04.1c69fb81.7a4ca.ab0f@mx.google.com>
Date:   Tue, 07 May 2019 12:27:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.40-100-gf897c76a347c
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/99] 4.19.41-stable review
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

stable-rc/linux-4.19.y boot: 54 boots: 0 failed, 53 passed with 1 untried/u=
nknown (v4.19.40-100-gf897c76a347c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.40-100-gf897c76a347c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.40-100-gf897c76a347c/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.40-100-gf897c76a347c
Git Commit: f897c76a347c330cca7fc03afaa64164eda545f7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 24 unique boards, 11 SoC families, 10 builds out of 206

---
For more info write to <info@kernelci.org>
