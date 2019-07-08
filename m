Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A922C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19598216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="yRP35joY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbfGHTMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:12:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfGHTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:12:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so601130wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=dMil1FF/9REos4dHEvshh6LKzpYeBc8wUcAzB7CI8Tc=;
        b=yRP35joYO5y3RvQxJ+Tg5qKQQHzyEjrQELOBFFI//iRwsiDLPZ2P3rhQpYDrASm5fa
         /oISGUmC//2EDrUiJ+Fc3P0o2+hhGlDL7XT3/+cdacufN9C/VyoIRNOn5hr5BD16d1l3
         EwqBv8caKn2R76pKCv0S0RLwm9fDq0CtnVxJ6UVKSzqpM22IHMNpknex6yViGuwzpFqE
         WdIJOp4YH1m+l/DLm+bgO/B7QoWXb5bD2nk/FCKmkdofItfc4HikqMJEZOIyU6xFBApR
         LOKqOuPzrWY78Vg486C7KWm8hUiqZhN6/3MmFmgM/GXNuixs5DSUCD4v1z91Z7lM/qJU
         dfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=dMil1FF/9REos4dHEvshh6LKzpYeBc8wUcAzB7CI8Tc=;
        b=dDhOo0kqlQBZ1JphV4IgWNo3kKdvYY2kjuXbn49MgAha96O6MhouVyZtZNZaah3fvz
         ki7+2vf+xhzpk/Y1+APrbgyyNMCJBU4Z3QhhcRT8yftag1T8nG1pQQNOgFz8Y8be4SGw
         XnU08wWmppaCyUmLWiS9oHkJ8qOQbEhfF9H1+lMM+pfK41sKKTVa8qc42xKW5EdAuHCl
         7t30obR837fTLm0TTEXAdlGsV63PsWWeFSlX5ktLBKqmPS76i0EyuEx/97IDsBWj6pUH
         EU8QXKc8p0Z5zfra0dozSr2FmHZEuBdzHUnZNU8uOtrGnyxF+pV6qIWsZkaj1TPG0vgy
         S6Gg==
X-Gm-Message-State: APjAAAVeRvX5zHR5lZMMdCyy7Y3qp3EzZhs7+JdoEQRMbH7zT8nM7LYn
        bQDmpdavhqUFn4TMfY73zROq3A==
X-Google-Smtp-Source: APXvYqzSjfPRtwxOTL9skUSR1bbuTNHs/2Tl/ZWO+lUZjmE9WR63Kb6S2H25DEBsa1+uk2sA4OWoFQ==
X-Received: by 2002:a1c:f505:: with SMTP id t5mr17559349wmh.67.1562613163480;
        Mon, 08 Jul 2019 12:12:43 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 2sm22474071wrn.29.2019.07.08.12.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
Message-ID: <5d2395aa.1c69fb81.75e33.192a@mx.google.com>
Date:   Mon, 08 Jul 2019 12:12:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.57-91-g7b63e70b83fc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/90] 4.19.58-stable review
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

stable-rc/linux-4.19.y boot: 100 boots: 2 failed, 98 passed (v4.19.57-91-g7=
b63e70b83fc)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.57-91-g7b63e70b83fc/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.57-91-g7b63e70b83fc/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.57-91-g7b63e70b83fc
Git Commit: 7b63e70b83fca977d86fe50ca2a48f40addac0a4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 60 unique boards, 24 SoC families, 15 builds out of 206

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

---
For more info write to <info@kernelci.org>
