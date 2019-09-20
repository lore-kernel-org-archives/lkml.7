Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75529C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1E02196E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Hvl3PU0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406421AbfITDTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:19:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38638 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405721AbfITDTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:19:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so659971wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Wb4nM1o4hpn6TDve7X6UVxGQm0c4ZWpt+c+J43uiITo=;
        b=Hvl3PU0DmAUtGenROsMmH19sJFDTdjVFgG+cHDvKlCf58x6tHbKCC/IE+dEKfzwikW
         A35SH6S4k8T6B+fcqKLnm5yWEZnH1y1bvpGXicLgCqoBSi63/+ggmTtCNBfMtWDMXAK3
         gXUauMeVu49ne9UTr3PqJVdxa/5ubhGB2kD2fOhpc4OUv3BozzQCxYNWFGV7axMngTsS
         ZJowKq4kPwtH2Br7iVski9nkLfOYmGir5uExX2z3M8CKBch9h4VKU/DuoZGEiKozHXzp
         4TCfR14oSXQ6YuqDbkQRaW4OY1H6RtpO/NyL/TwQ0qLa/xZFbSf+r9L7snJFz0fWhs3X
         3Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Wb4nM1o4hpn6TDve7X6UVxGQm0c4ZWpt+c+J43uiITo=;
        b=DA4S9Ybi2Z8M+WodHBwjFfhGEyzBycx9yveqxxWlQTAO+ROBVd1TkTMZWZwPhKTh+i
         JM+u5tis0Mye1xhTZn6nz7z3T5y/zM5GT/VEhfEbml3sndj9ZQuuVcf0fs4LL075m/FJ
         EFXFMMR8+CwIbSYxIyaICTTJiittmyboQniTDWJnbjpIVhgGUp/3w2moZaU1/JLcsS2f
         /C3rhwHj+xkJ3N0LckZP9jToiuNn+j5mqmW2F1RgOBnvUWx0stxr5mCXhXEstNoc7p3J
         RSjIygeFkwfS0ACMZale72t87SvtdPTrnkqm/70RkU4kLOJW3md/LpAnMO3UWoveFtFr
         ENuA==
X-Gm-Message-State: APjAAAW50dzxGprDGiW9HsdU9SUBgxZD3oxkcDDbzebBXS9LQDha6AWJ
        KhI7U2mEWwKkw1xGAzFyjNl8tg==
X-Google-Smtp-Source: APXvYqxLG4yddaJ4TMKUnPcZN7QCG7Rp9rvQWBQml/CUzUfeVDBIlpv5Lh+3mTePhAJbQ+9Am0GkAA==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr1220641wmb.93.1568949580917;
        Thu, 19 Sep 2019 20:19:40 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d193sm619920wmd.0.2019.09.19.20.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 20:19:39 -0700 (PDT)
Message-ID: <5d84454b.1c69fb81.d3c01.21c2@mx.google.com>
Date:   Thu, 19 Sep 2019 20:19:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.193-75-gfebb363e252b
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/74] 4.9.194-stable review
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

stable-rc/linux-4.9.y boot: 54 boots: 0 failed, 54 passed (v4.9.193-75-gfeb=
b363e252b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.193-75-gfebb363e252b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.193-75-gfebb363e252b/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.193-75-gfebb363e252b
Git Commit: febb363e252bd50629d7efc675ba30286a33f209
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 24 unique boards, 14 SoC families, 10 builds out of 197

---
For more info write to <info@kernelci.org>
