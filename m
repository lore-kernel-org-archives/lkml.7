Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D037ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DDF206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBQB7O1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfJGQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:43:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41792 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfJGQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:43:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so14419921ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Zqyp+EzMxcNslBkEtpTkjVzHDniuE8hee0J+iYqh3k=;
        b=aBQB7O1P30QBMIkkPZhqXSR1LSNwIFJunCsW0X06VXb6Bvn7XGsj+dfsdmKJd3CiyH
         q4YvufUqrT1Hl2obL2UFRAJ0wxp6agBulsApTGbnil8AS4Np7O9esp+A5jY5NwIg0JSd
         RpBHTMJRN/H+4aVNuNC5hqI0Qu/sjY/LPbTozg6YRYLbF782F+gyGqNIMOoKNJpwoVpy
         ta5VuMWLvsa9ZciN2uga5H197TX2KmRWtRzJicu9jUjZ+Bokh7Xx7sl09aUOAtPXJcMz
         +aOwcQygCF0lmSh5PDuNNQekjaI73UMxFU81oRTqcD+8ihU/wRPI7ju9ANoRCRE717vY
         BYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Zqyp+EzMxcNslBkEtpTkjVzHDniuE8hee0J+iYqh3k=;
        b=AFSyGn34HI4YjMLpbeFNpbKjh2nefiYz6siCybzuKQ9d8wwfoRe4Y2p/qOxwH9A5rA
         v9l8O+5yB/XjgsRFlq0VU4fTL3ID7SkDQghh8kFqYDvVuJ/TUJ0SG8pYTISpjvaglQ+f
         YX74ZOMn7GDaGk5iJfEgNLyNN73vhnJ+ydAwXfEtzMioDqBoRlzK3T1lBoeVdcHR9VLO
         ntHLJbq7s492s/7S6FRcD8qhSy7/fqRPYAlPqU4CkUL3KydNBeuByKVns49YUKUIKS+B
         KnyAMJIoWFv9UjS+WP42b0lauXYkAFPPzz1rEqzfscd3xLEdKICpCIv6m4W84/lkWI48
         z+rA==
X-Gm-Message-State: APjAAAVFHLJofXjOa36Fx62cta2I8/4cQHo6U+3n9sChVAl4QX1aKpuv
        3Grbr/ybhIl9hBvRUA4sgdaPJrHjAN2QY5RNf80HvSM4lAY=
X-Google-Smtp-Source: APXvYqwPaGHjD2F43p7X3DF5o0DsdFVhMZoHPQhp/6xiPe8/10mLuBDcg6DzDAbtohD03hpCeRgCA2gh2dbsFQ2DPJA=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr15666974ljj.129.1570466631777;
 Mon, 07 Oct 2019 09:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191006171212.850660298@linuxfoundation.org> <7148ff93-bac0-f78a-df3a-b9dbbee3db1a@linaro.org>
In-Reply-To: <7148ff93-bac0-f78a-df3a-b9dbbee3db1a@linaro.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 7 Oct 2019 11:43:39 -0500
Message-ID: <CAEUSe79aYVt1=MUqsWefBWQsucskuG6NpP5KRxQsjouJw+yXJQ@mail.gmail.com>
Subject: Re: [PATCH 5.3 000/166] 5.3.5-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 7 Oct 2019 at 11:25, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wrot=
e:
> Results from Linaro=E2=80=99s test farm.
> Regressions detected.

My bad. Should read: "No regressions detected" here, in line with the
other reports.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org


> As mentioned, we found a problem with the mismatch of kselftests 5.3.1 an=
d net/udpgso.sh, but everything is fine.
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 5.3.5-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> git branch: linux-5.3.y
> git commit: a2703e78c28a6166f8796b4733620c6d0b8f479a
> git describe: v5.3.4-167-ga2703e78c28a
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/b=
uild/v5.3.4-167-ga2703e78c28a
>
> No regressions (compared to build v5.3.4)
>
> No fixes (compared to build v5.3.4)
>
> Ran 25519 total tests in the following environments and test suites.
>
> Environments
> --------------
> - dragonboard-410c
> - hi6220-hikey
> - i386
> - juno-r2
> - qemu_arm
> - qemu_arm64
> - qemu_i386
> - qemu_x86_64
> - x15
> - x86
>
> Test Suites
> -----------
> * build
> * install-android-platform-tools-r2600
> * kselftest
> * libgpiod
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-commands-tests
> * ltp-containers-tests
> * ltp-cpuhotplug-tests
> * ltp-cve-tests
> * ltp-dio-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-mm-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * perf
> * spectre-meltdown-checker-test
> * v4l2-compliance
> * ltp-fs-tests
> * network-basic-tests
> * ltp-open-posix-tests
> * kvm-unit-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> * ssuite
>
>
> Greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
