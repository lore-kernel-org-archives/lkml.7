Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CBEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE720657
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="FUqpNoFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbfGXXyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:54:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36730 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfGXXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:54:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so38948206wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=tj6543EOVuENgGgQ8S37JO7H+aPWdIzff/HjCmUyA78=;
        b=FUqpNoFE+1fYp1EQmILPIAHdjr+MGQ7sKyU6Rc3kUL0WNuNw9eoaV9iHL0Rvq3e5K/
         8a2gjva3ePJgWga05Mku984/eXfGDZW1glWiE0TKgDTOrlMYl6B2oXXbLbiXrAFKP3so
         OV3sWWvqIBjB4rGKAVAEBrGJxgkL1F1wBQT/1Sfi/0/s5bumTi6Bfa/dVtmdr4b1p4wx
         CTw7KV+Rp7KTpvk729PT/y0D84eDWpF8fnrbyWvYT0eOHH1AjgDhbVGB1i6Uvhu+qPfP
         +eegXw5wgLku2XPiW4isIt7MdPudQOy0mphOzCT0pcmwyibxGjbVyQA8xUDOF9BQTofm
         qwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=tj6543EOVuENgGgQ8S37JO7H+aPWdIzff/HjCmUyA78=;
        b=Fkym91LkHb9HHy9LBFxIL+zwL0eZ7O2x75S1P6t7NDDThbKMMbUraDvggy+Kc5nANH
         p0DdqkToVbolWfKeo9f64QWQNfHg0NrJX054t6ocT6Amna+SEgqYIW+ptoE9DAnMtV19
         K4bwfM4BiYheIArVMwDAkKUl7urUlTP4KLOdoVWnpclBFppoB7y6JRHjNaraSOOo8h9a
         uL5iPx9KANWPlZoXmZ8/QT2EY7A5h2eaxqdTFJz0gX2VN+svkqM9/Fc9QR/XZFyTgjcj
         8h/+apoXz5pJSh0E87A/AeFGwzhppSLYrbpcwdR+EnSKJyTCSADjSfIfBCORFTmWiIie
         OpCw==
X-Gm-Message-State: APjAAAWq0ckjF7yqqDABRdYcNTm0bM4kTKPK/DTnOhfL0n/n3MPEXJ27
        WZ9OokBYAcpcsiGrT1XG5GCxKfU+vjI=
X-Google-Smtp-Source: APXvYqyCcTh2ltFhIK2HcylO0+ZXKQ8V10x/wTy/ETjgAwbve+oCVMd4wk1wqKvRnwnPgftZHhR5MQ==
X-Received: by 2002:a05:600c:114f:: with SMTP id z15mr75311961wmz.131.1564012452506;
        Wed, 24 Jul 2019 16:54:12 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o6sm92612551wra.27.2019.07.24.16.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 16:54:11 -0700 (PDT)
Message-ID: <5d38efa3.1c69fb81.409b9.9873@mx.google.com>
Date:   Wed, 24 Jul 2019 16:54:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.60-272-g975cffe32ab5
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/271] 4.19.61-stable review
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

stable-rc/linux-4.19.y boot: 130 boots: 2 failed, 127 passed with 1 offline=
 (v4.19.60-272-g975cffe32ab5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.60-272-g975cffe32ab5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.60-272-g975cffe32ab5/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.60-272-g975cffe32ab5
Git Commit: 975cffe32ab513d7307a360d34c483c3b53840fd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 73 unique boards, 27 SoC families, 17 builds out of 206

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-nexbox-a95x: 1 failed lab

arc:
    hsdk_defconfig:
        gcc-8:
            hsdk: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
