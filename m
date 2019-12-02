Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BCBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511F20705
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KldH7d9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLBJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:41:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38285 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLBJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:41:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so9516488wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNXsoGRkeV+9oPq3u6Qc5ytFYrW1pi4ZmdbejetvXlc=;
        b=KldH7d9nsW22vsf6pHjOvoHIz09katpCBpZuRU2xrO2hVsZrdu53lA8hje0CTOz2cy
         kq2FQ3FZHjp+0KT+sznWHON7mCmQJBHrE2T00Lwl/4u2MI9U86rcZUF1SeMITQdHhMfL
         K53I3axzBZ7M4sYdaulTKw8OGIN3tp5YfY62e0OFLi2+drvjBvd8/FcarQAGE6AOePeA
         CFcj1Amw13mFMYG9kEklzFUBXLnkDnHnkYzRTABT65e556RdovKSRIUc9A1nVgF6KF/j
         wGDVyG2I/ADjpkDlwW9Ycw78Yth2vhQRRgZFp6gOcLkeRhxmcqva3YyVUvChVq50Wmn6
         LzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNXsoGRkeV+9oPq3u6Qc5ytFYrW1pi4ZmdbejetvXlc=;
        b=SwobKrbGVEukcYuKI5r8CB3jFOWG+K6R/YPrv9icfzEdfJNZ1hHoUTHJCCOzljoJAu
         JCD5Ief3x+VEHxCLAO56bfVILH8LJeaN1ZNzfStiJYlmMm2l6aJOKQTEPvQgOaegi2sY
         lTDzvYOw13RcNT2lH7x/vJZoutDLnzAcGGfLX2zV0L4IkEEiUB47gMnVVU1778UsN59w
         GzZZo9+BZpT1dYmvEI+4qwilo7Z5mtHFpVcbs9HUcyOIu12XHzZeYD+IpwDgemAfQve8
         JRydIPZMQANRBI8bPNgaT4YK053NiIs1rE+eJ8f6X3+Of+n2Ye3Vf9Hbh67RhdDrVd4g
         kMKA==
X-Gm-Message-State: APjAAAVB/XNu5kPx9ml6/scBnY/+5h2UG/do4mh3U4GspR6l9MRo+JE9
        gb7DOi/h3y7v/EJ7w5V1erD8GlO1z3nBKWe8NfXiag==
X-Google-Smtp-Source: APXvYqxnet7ppU/SHR2rHYN537piB6hE4+i9EBQeeW6bxLGuGO1hD0GgI+4TYSTlsods2DS+0CeQ2jeD7Odi5iB8m7U=
X-Received: by 2002:a1c:49c3:: with SMTP id w186mr27302288wma.53.1575279691198;
 Mon, 02 Dec 2019 01:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20191201155238.GR18573@shao2-debian>
In-Reply-To: <20191201155238.GR18573@shao2-debian>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 2 Dec 2019 10:41:23 +0100
Message-ID: <CAKv+Gu8MO_85Fa0y7YZ0iEgxrXbfR5-1e37FbiByzP8LrohcYA@mail.gmail.com>
Subject: Re: [efi] 1c5fecb612: WARNING:at_kernel/iomem.c:#memremap
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Narendra K <Narendra.K@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2019 at 16:53, kernel test robot <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 1c5fecb61255aa12a16c4c06335ab68979865914 ("efi: Export Runtime Configuration Interface table to sysfs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: rcutorture
> with following parameters:
>
>         runtime: 300s
>         test: default
>         torture_type: tasks
>
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +------------------------------------------------+------------+------------+
> |                                                | 5828efb95b | 1c5fecb612 |
> +------------------------------------------------+------------+------------+
> | boot_successes                                 | 0          | 0          |
> | boot_failures                                  | 4          | 4          |
> | Kernel_panic-not_syncing:No_working_init_found | 4          | 4          |
> | WARNING:at_kernel/iomem.c:#memremap            | 0          | 4          |
> | EIP:memremap                                   | 0          | 4          |
> +------------------------------------------------+------------+------------+
>

I don't understand this result. Doesn't it say the number of failures
is the same, but it just fails in a different place? Is there a
working config that breaks due to that commit?


>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> [   27.829857] WARNING: CPU: 0 PID: 1 at kernel/iomem.c:82 memremap+0x62/0x148
> [   27.832571] Modules linked in:
> [   27.833528] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.3.0-rc1-00004-g1c5fecb61255a #2
> [   27.836364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   27.838876] EIP: memremap+0x62/0x148
> [   27.840028] Code: 89 c7 83 f8 02 75 2a 80 3d bb 47 c8 c1 00 0f 85 bd 00 00 00 c6 05 bb 47 c8 c1 01 53 8d 45 ec 50 68 78 3c a5 c1 e8 f2 ff f1 ff <0f> 0b e9 9d 00 00 00 31 c0 f7 c6 01 00 00 00 74 65 85 ff 74 0f 89
> [   27.845798] EAX: 0000003f EBX: 0000001e ECX: 00000000 EDX: 30706000
> [   27.847665] ESI: 00000001 EDI: 00000002 EBP: e9e03f0c ESP: e9e03ee4
> [   27.849523] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010282
> [   27.851616] CR0: 80050033 CR2: 08056130 CR3: 01db5000 CR4: 000406b0
> [   27.853465] Call Trace:
> [   27.853896]  ? kobject_add+0x5b/0x66
> [   27.854502]  ? map_properties+0x425/0x425
> [   27.855171]  efi_rci2_sysfs_init+0x1f/0x1e2
> [   27.855873]  ? map_properties+0x425/0x425
> [   27.856545]  do_one_initcall+0xa0/0x1cb
> [   27.857187]  ? parse_args+0xa3/0x28b
> [   27.857823]  ? trace_initcall_level+0x53/0x6e
> [   27.858548]  kernel_init_freeable+0x102/0x190
> [   27.859300]  ? rest_init+0xee/0xee
> [   27.859887]  kernel_init+0xd/0xdf
> [   27.860443]  ret_from_fork+0x1e/0x28
> [   27.861144] ---[ end trace c5c6f0b028e1905c ]---
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.3.0-rc1-00004-g1c5fecb61255a .config
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> Rong Chen
>
