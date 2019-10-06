Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F1C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE12077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="GqqTOVSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfJFXBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:01:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53406 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfJFXBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:01:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so10583529wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=5FhZ36jnVtPYp2moexL6x7c0xT4VPQ85lGFj06T19kk=;
        b=GqqTOVSZIr3FtNHbKEemaBipI0ksciIpK94L55r6xyQADmrDCEpceNnIyI1tYgVx2a
         CgHgEjOd51WP4RbhohV5p9r+ZCH4Wvwar7oAB7ESB/x9xACr/ZfL2qDXnXkPEYL8UL7z
         VKxxXkKQFt6m0v7ehkLK2IseCYBT9wxWEt1a+NWLonnBbSpGlJx/2C7Blnula3CcYBXE
         EZlU/z/XAekdeNRvIPpZSkYf0RT9g8eMHZPYs4ZE1civ1TyEzbrP5lZ3Y9OUaQGDsBcb
         Tw7YcGaMA8IbC8EX7wlsLq9Ust2OlziR1yd2W5ogKF+Us8UtoO4+kGWb7FxT+94VbeiI
         Vgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=5FhZ36jnVtPYp2moexL6x7c0xT4VPQ85lGFj06T19kk=;
        b=mRJffNBKch/8YohV/vxpD6z/+YivU3TCRycthMedgvddjHt8bED21YQ3R5Gli5HsFO
         yVWqpL3a1J3woKm1/KLa5VxQJXu+H+hLzyOs9syGI61AZ3QpyuiFD0bfxvzLm7sQjei+
         8Tocu/3MRUcsVufXI4HXGW/ZbulCg6SDeI36gWfrhtzuoBSOlwxZnKQvJoMv5YNynOSE
         eKhBcXves8tYnPUJzBAWmwuuRG67aNuc310/CCD6jCJmUG9Uzm2rFpXKnfA2moGrqI0E
         bPACv7FBy3cSfyxSJcqgBMJJXC7IlxSmBh3pQUZ5NtQtPSaugyH+oiNO9s4OK/iThqOw
         vWjQ==
X-Gm-Message-State: APjAAAWSzlwaxng3EHUG6M01Pp29apyMgzK0iFiIt+cH7QMZcvnX7n4C
        GlYFwdOuquc9R+pUaj7+rl6hMR2g8TU=
X-Google-Smtp-Source: APXvYqxVS2qrSZsKDHou5yu2ujmMsKdmvnS/UbAQbGKRBDBbKNG4Sx7mJJNRQq/Hwu9eQTUqNyjr/A==
X-Received: by 2002:a7b:cb0e:: with SMTP id u14mr19896306wmj.115.1570402877056;
        Sun, 06 Oct 2019 16:01:17 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m7sm10293664wrv.40.2019.10.06.16.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 16:01:16 -0700 (PDT)
Message-ID: <5d9a723c.1c69fb81.5aa5b.d173@mx.google.com>
Date:   Sun, 06 Oct 2019 16:01:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.147-69-gb970b501da0b
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/68] 4.14.148-stable review
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

stable-rc/linux-4.14.y boot: 54 boots: 0 failed, 54 passed (v4.14.147-69-gb=
970b501da0b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.147-69-gb970b501da0b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.147-69-gb970b501da0b/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.147-69-gb970b501da0b
Git Commit: b970b501da0bee5eba4e61ea7d424adab428a165
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 32 unique boards, 15 SoC families, 10 builds out of 201

---
For more info write to <info@kernelci.org>
