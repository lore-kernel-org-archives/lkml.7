Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CEBC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D228220861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="CaWsqiT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfFRCKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:10:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33119 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFRCKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:10:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so1194535wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0HepCJwDYsm0Shu2CNf2eE/kc71TZil5tCl+GGac7oY=;
        b=CaWsqiT77lYoVb2YmjxPGR9bLi51Nci0UQlYM4j+6FQoLfrPwBGT9lSvvqx6eOExks
         AnwSaKTUCC9IDF2jQQv6O1mSUdLJQxvOjL/myL1auL5zaAYpfJ5FuG+qjKU2LVeGJKLg
         UOZlahxTHXkad+uhc8pKSgBRytoEPeL5sieBqdZYLzcywRwDyQo9zOWsqMg+8vEF7W43
         eELaJ43T4IXHt6JbkFOoMT2emdDGuepnvGlEctySvBJbwC3mO2YmBrMHtKA1aVs/VBSm
         gxLKCyxnpEz0tt7UqaMM6t+Ixii/c3qQXWSCK2OpmFoBoEXlFMYlFA63o75v849Q/Q7h
         8L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0HepCJwDYsm0Shu2CNf2eE/kc71TZil5tCl+GGac7oY=;
        b=jVB2CoRucNx7wVLlGeKUe2iivQtbKBgzJYcrcUWfYqd6j1XMTs+Oaw1do+Ck4Cnhfp
         lUzg+frLCiAazMdbX3iZZE5On1mzkgiZ4ghKQmkd1HIgafKi5wOg4dmVJozjzHixJpC0
         VuS9URdjWUmn6yYC6PBCmTj8euCMDpliw3ODd/4MzGUJFUaLHIFSH82BPAi7K0tTQWIi
         DlBt0VjPqNidHoDRP2wPun4UKJSGE4aOQJK8JknY4o2pEo2z8yXeBGJIHW/PCvRcDKXN
         VcLRFj+cs5FCSN9sw7MSupuf1PAIbhbRa4qkHcfzhqhbCZoKPO0iDP6RWaDLei2FHJSS
         S3kQ==
X-Gm-Message-State: APjAAAW/GrnxCWtiHEq0qch6eYVXBIuZuafioLlQ4NgNB+NumoyAvhA/
        Wp32gqQ8zKG6II5wPheYQVVxXA==
X-Google-Smtp-Source: APXvYqw5KWO9F2tqT4j5MXJXPkE+RxobAqq3NxEovZBmdx84DNP/3sOe6Sezfwz18rKp7Za0hcGBtw==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr1031058wmb.142.1560823848282;
        Mon, 17 Jun 2019 19:10:48 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z6sm14894808wrw.2.2019.06.17.19.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 19:10:47 -0700 (PDT)
Message-ID: <5d084827.1c69fb81.2aabf.ffec@mx.google.com>
Date:   Mon, 17 Jun 2019 19:10:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.52-76-ge7db76b325b2
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/75] 4.19.53-stable review
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

stable-rc/linux-4.19.y boot: 110 boots: 1 failed, 109 passed (v4.19.52-76-g=
e7db76b325b2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.52-76-ge7db76b325b2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.52-76-ge7db76b325b2/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.52-76-ge7db76b325b2
Git Commit: e7db76b325b2967d1db43452cac4b11c0a37bcbf
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 64 unique boards, 24 SoC families, 15 builds out of 206

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxm-khadas-vim2:
              lab-baylibre: new failure (last pass: v4.19.52)

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxm-khadas-vim2: 1 failed lab

---
For more info write to <info@kernelci.org>
