Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E67C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C7F20721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwCMX0MU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfKSSp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:45:27 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36679 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:45:27 -0500
Received: by mail-yw1-f67.google.com with SMTP id y64so7678100ywe.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n3QQWfM+2/3SKmpoDbV5y5lk3O6h7i41cgHTX8w97ZM=;
        b=YwCMX0MUrerr2z1fhDl+9kN/5yNqSf+NnmkuojTSD3/3VBu6RyKxd431ImktRVh/0U
         stuZ6WOG6x+IckvYQ0ja/C1FDZA+gEXGTVqQzCvufTsPv3+bDn1c/HsrGDqXPz4pu+jE
         dR1xAeRCYb5Ua/bLcd0cgWOGigi7pmWWiBpUoa7bIQFLxKrUvUFXCsGCasyUugY9A8St
         ymY6BV8iplwqw73PCz8ktcsVY+EN3ZZIC5BxHKvz17CFYS1j3xr0LLGs/qsFFRZKRUkF
         QsGLchXhr86NZ9xQu3nfBBjJMPPUYUmxJrKNaWoxkMqoaco3DuySmh1pZliZuZfz0p+o
         8+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=n3QQWfM+2/3SKmpoDbV5y5lk3O6h7i41cgHTX8w97ZM=;
        b=tABXgR2blfBRl4uIyoMN+lfxfXiAQwAQiQGUcgAzg55rlhRSPBz/s1Aq/VV6rpIyBb
         2ASZowm+HvKSVi3R1/vi0hyDcXUASAqXkYHUL5mxP7tVfvz/AFWc4fBo/HJ+HiKvCgP4
         NMgu+0HboBk7Ihig3GP9+Kjnf0Fa2/tO7TRKrASA6EsT6dWK6YRthhShODNZmj8KK0fk
         WfWv3EXUfVi3G0OTKOpsprohvseBxVKZqOOlAkhPfYKjT6AR3mJlQyNMUSSEqPlmcfbo
         SL6/g3CfeKHrHxxNQi0PhLlz6LQLiWk6SMhtgfHiarI4rxL+xEwGgdsv6g+n0+zQb5fA
         N7TQ==
X-Gm-Message-State: APjAAAUEej6QGy+U2YxFmt3r+fBWUGLh70/oZhd7uFktDq2Js8drm/aO
        0V9D+hdq3dQcglgkSn0Z2mbSQKG0cPA=
X-Google-Smtp-Source: APXvYqzfodfw1xn+xEbJ7wmRHKb7xmj7cCT9PcBYeJJXmwiFKuyZjtwD6HqbEEcFikS+OVdk5oSZrA==
X-Received: by 2002:a0d:eb85:: with SMTP id u127mr25916166ywe.402.1574189126177;
        Tue, 19 Nov 2019 10:45:26 -0800 (PST)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id g71sm12369834ywe.90.2019.11.19.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:45:25 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:45:24 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.3 00/48] 5.3.12-stable review
Message-ID: <20191119184524.v7b5mkopvv2zunpc@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191119050946.745015350@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 06:19:20AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.12 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.3.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.3.y
git commit: 6d539b8f097b64486da01863c6ae6e21b1003af7
git describe: v5.3.11-50-g6d539b8f097b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/build/v5.3.11-50-g6d539b8f097b

No regressions (compared to build v5.3.11)

No fixes (compared to build v5.3.11)

Ran 34194 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
