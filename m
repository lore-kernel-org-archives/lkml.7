Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8959FC04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E8D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="lwVcWn4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfECAGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:06:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfECAGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:06:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so5627992wrn.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=u9fjAdS4qdgFfKFlDRvvkJV9M4g4jVaDIHEILhziWRQ=;
        b=lwVcWn4fm6lmr28FcUaQsljk8FqtLm5Hte6ys8oWd59t9ygx2NiGxEPj6JoZwF5opJ
         J79wAJ1J3kHm4sOV32Or83vLTqNxrm3DquSx7ekcoR+7DhwXYRYG8pp7TBo2WQF0xm/t
         DJjD6mWcgA132V1mYKqI6H8hho1Ap79YKUK3OD0Er7zooJvKvkUnFuOtI6Y0+c3afkAM
         Ppiz/is79P/UvLNDKzgSXsqjLxnT2sofXL9WLTfkQGcKc+rG/6rh3lSV3nS0s7WlJMiB
         uV/4MWxjwJwve8u+o7KnkALqqwEZTqaREypJEnYhiL836pxNRsQGyjLX86NBV7mhvBMb
         FegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=u9fjAdS4qdgFfKFlDRvvkJV9M4g4jVaDIHEILhziWRQ=;
        b=BGihTxfxR+f+Y4ro8wi7O1RsGgN1Qgt//PuyPfB7MJ2M6dj8ZAsO0Grq+g4Kivnp03
         Lav7desjVRahyrO2ozDkyvbHyRIXPq/A1tJCAkIDlyKGiL7f0ue3ZyIpGBYb5QmVz1Qq
         CAJD4kAojnvE+fwzqXi4S9o5Xph8NL2PGzSyt3HTX6uv0X2G/LMUAXoQWgVl/lSzYFjr
         RVYgYrLl5f5VbbS/WsD1bMXOAkq26iWzqLxAYiplQHQIWoRFFpb6+PDKZ2qGWsgqF5nM
         yPHo97xF/kLqEDyjB/Dt+SxXme0GVvUBzH8cfHd/pUS3DaYS9lPoFDi0rVSbUzu9wp/D
         X0LA==
X-Gm-Message-State: APjAAAU4PGjAw2dqifrWE2yQyN1mIMdCSRfvvVP1+UGeQWUuTBBdiKZm
        MdDl3S6fQCMeKhvkREsH3onz8A==
X-Google-Smtp-Source: APXvYqxe7cb/mNz0rZXAg3iZnw2AsmeMfr8H9O8EUYtf1Wley4+M0XNIm8yW59JI2swvkgST7iOeXw==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr4671872wrp.302.1556841990764;
        Thu, 02 May 2019 17:06:30 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u9sm538056wmd.14.2019.05.02.17.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 17:06:30 -0700 (PDT)
Message-ID: <5ccb8606.1c69fb81.24d63.3313@mx.google.com>
Date:   Thu, 02 May 2019 17:06:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.115-50-ga4aa5bff0752
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/49] 4.14.116-stable review
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

stable-rc/linux-4.14.y boot: 122 boots: 1 failed, 121 passed (v4.14.115-50-=
ga4aa5bff0752)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.115-50-ga4aa5bff0752/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.115-50-ga4aa5bff0752/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.115-50-ga4aa5bff0752
Git Commit: a4aa5bff075214a024ba945abb791813e33860ac
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 65 unique boards, 24 SoC families, 14 builds out of 201

Boot Failure Detected:

arm64:
    defconfig:
        gcc-7:
            rk3399-firefly: 1 failed lab

---
For more info write to <info@kernelci.org>
