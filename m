Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3605EC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B4220825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="T5uTiFkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEGQ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:27:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEGQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:27:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so23183655wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=+52L+u62TNY6YACkEbpqwAKBYstdSnWBCEy5H39fP9o=;
        b=T5uTiFkzwuZSXQ02GknS7agw9Ku/tQEoGwLeFinH5mNT1fMvJDMVLkzT8O+CgKhwoC
         3WtRaCG5dFDw/DsRA2wYElIOQpNdRteMRAdcjmlg5Kx0oqzO3AjtY1x7CEBbDI8+NtRS
         BC75bFRU0DDJ6jc+ijZvIEMhB/jEabEdEufZ0dzER+7fK4A/Yre5hBWrMKOBNLuNT3Cs
         8ksgArUeilUyIwFvKpCpfSD+ccghy8pmynk54I6FMHtIfUCztd8i1aO/vmoGWxdugFM2
         9psx2iCxH2tXK2IV/ixDhfN1XUkuPTskpKYioe1D9tuRe7IgKFcjYCkGRxvRxcA2h7wI
         ZAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=+52L+u62TNY6YACkEbpqwAKBYstdSnWBCEy5H39fP9o=;
        b=KY5s9+matx6MEvGos9oy6jUjWS3yJ7yeWcnDztVWRmJfKXSqcf372okJFHKf5E2KaF
         VlyJgi4lchT2ZhvrTGMDojSQAGID30X8tlW/bqtS0lbKMuvyvs8zJTQkvylZgUBzPHtF
         NYLHYNRZO1PE74GIgRNPSXcaiLYEZdb3+77S4zyzX3zKV828E4qzXcM6y6ORkaywGrBs
         bdWwCpZ+YSLdYtfOX7TJG48tWlhZeRuSCy4nbhiFAGnoOfHFgCdKQq1bWuINb3t28PmI
         LQ0DwD1uOwcFn3reeqRMrb8P3Dz0Ta7f/IjqBqRgK2OQ8C1YXH1Jjg6EKjmI3qfpH4bW
         ZLvg==
X-Gm-Message-State: APjAAAUQkSsoojdgW6kjDDHbWfv3dlUe8A99zLZBps4um6AQ05Y/J5Ui
        rmDJ1ESrSAk5iZoAGOFX6z/TmQ==
X-Google-Smtp-Source: APXvYqywW2jCRYjL716MqhbCVN/FuKaYokKrqE12i9/pioB1hY60FONsczBqbn6v4W/1x/U92Fk7kw==
X-Received: by 2002:a5d:4711:: with SMTP id y17mr24826288wrq.122.1557246421070;
        Tue, 07 May 2019 09:27:01 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v189sm23678819wma.3.2019.05.07.09.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 09:27:00 -0700 (PDT)
Message-ID: <5cd1b1d4.1c69fb81.5d408.0a4f@mx.google.com>
Date:   Tue, 07 May 2019 09:27:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Kernel: v5.0.13-123-g5b4a1a11a18c
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
Subject: Re: [PATCH 5.0 000/122] 5.0.14-stable review
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

stable-rc/linux-5.0.y boot: 56 boots: 0 failed, 56 passed (v5.0.13-123-g5b4=
a1a11a18c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.13-123-g5b4a1a11a18c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.13-123-g5b4a1a11a18c/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.13-123-g5b4a1a11a18c
Git Commit: 5b4a1a11a18cf15168a00c41c55384b2558cdee0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 25 unique boards, 11 SoC families, 10 builds out of 208

---
For more info write to <info@kernelci.org>
