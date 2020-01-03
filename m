Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB23C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C6921734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvXL8Ajz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgACPDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:03:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33267 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgACPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:03:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so32064468lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXLuplpySrohqFP6kS7OpIEbP/zNERMePL4SR7+mMjs=;
        b=xvXL8AjzcVepvA9glzXDHT0fioLRNmbgVkJ0/9FZHbw7TOvSZOhWG2oTR3lrLr4fFS
         xvJvT3VjsTxoQlt2RRk8qYfOnwTXauUgzaMN6AZ8mmx6mawvrLaObvPuwQFI5cMsS52b
         gdkmpDZoSvX7Oz/7rwqlScIm22M68k6KgpmMNjbBvP/IDpTWp5ontHVuvJsLjq2Q+vwa
         yBmxqrzlpLByYN+vMlQtn+CadZ8L3SJZ97abkEr7kQnQxp3FTVycCcbP4yQcetMwuEoZ
         cjJkGbcIlHNVJ9MWdhHO1pHd2ru6qzdVy2xYQsefeW+tmreZ4XW4bpOuanrf/supdelY
         KmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXLuplpySrohqFP6kS7OpIEbP/zNERMePL4SR7+mMjs=;
        b=BwvCnuPP7twavwR9Voff/MNMejp2QCfGNr//g92FVyVjo6A6dJMcz/MCkIgYIfbQhc
         w2arJ/iOcjXjsnSS3DJZ+winuhJHKGprdFR0HzRwEGjIsuHJjZiSkHH+WRecumrANYQY
         3jcKUH+OxmjSHyoCDxcKe5Agt2N8MLK0R8B0fNCrAzBuHMRaoxnDf+enqxzl11/QoxHB
         B4ME7Fo0BkgnwkVziyvcTgFlDwnH5Wta6b0UTDJouiLqrp533LdpfPqwdGabEw1f/aGA
         cSxAuEZML8ucpw+cXsgXqDZHOxBtmVIH0Hs9hA8qibAvKyXzT69elPGDnlUHCgRAP0k1
         xL4g==
X-Gm-Message-State: APjAAAW6vexQDgYiYOMrdOdXxe/V+I0JUXLzA0oppgDIRSYha7loTBxY
        ltfr+ng7I/0ayKg/E1PLStkVZrkDqHWiKcHjMGvIhg==
X-Google-Smtp-Source: APXvYqw4vzT9NE5JBE4750Ibpsg4DfZbpJYeAmaoiYp8s1njp31bKNa9lXROJc+TkxaJZn7Eff6d3LMnkGO/OqxXMpU=
X-Received: by 2002:a19:784:: with SMTP id 126mr49377262lfh.191.1578063813660;
 Fri, 03 Jan 2020 07:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20200102215829.911231638@linuxfoundation.org>
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Jan 2020 20:33:22 +0530
Message-ID: <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/191] 5.4.8-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020 at 03:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.8 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 04 Jan 2020 21:55:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

LTP syscalls memfd_create04 failed on arm64 devices.
Test PASS on arm, i386 and x86_64.

We are bisecting this failure on arm64.

Test case failed log,
memfd_create04.c:68: INFO: Attempt to create file using 64kB huge page size
memfd_create04.c:76: FAIL: memfd_create() failed unexpectedly: ENOENT (2)

Strace output:
memfd_create(\"tfile\", MFD_HUGETLB|0x40000000) = -1 ENOENT (No such
file or directory)

Test case Description,

/*
* Test: Validating memfd_create() with MFD_HUGETLB and MFD_HUGE_x flags.
*
* Test cases: Attempt to create files in the hugetlbfs filesystem using
* different huge page sizes.
*
* Test logic: memfd_create() should return non-negative value (fd)
* if the system supports that particular huge page size.
* On success, fd is returned.
* On failure, -1 is returned with ENODEV error.
*/

Test code snippet:
<>
check_hugepage_support(&tflag);
tst_res(TINFO,
"Attempt to create file using %s huge page size",
tflag.h_size);

fd = sys_memfd_create("tfile", MFD_HUGETLB | tflag.flag);
if (fd < 0) {
if (errno == tflag.exp_err)
tst_res(TPASS, "Test failed as expected\n");
else
tst_brk(TFAIL | TERRNO,
"memfd_create() failed unexpectedly");
return;
}
<>

Steps to reproduce:
          - cd /opt/ltp/testcases/bin/
          - ./memfd_create04

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/memfd_create/memfd_create04.c#L75

Test output log,
https://lkft.validation.linaro.org/scheduler/job/1081716

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/tests/ltp-syscalls-tests/memfd_create04


-- 
Linaro LKFT
https://lkft.linaro.org
