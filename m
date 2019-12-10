Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8979720663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dcOCk7/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLJFG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:06:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46493 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfLJFG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:06:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id z21so6864694pjq.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 21:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ur1bt3xTjtkHmcaGa2TtGWJXPFbPuLGPncSr9nhfgIU=;
        b=dcOCk7/ZdsHF8xtRIQ2ARAIobuNALOOeQ2c0Bg+/US+dqaJ3mwWRX62ZBhfA0Qk7fF
         OTYggx+k5Bj889hv9EScMPTGasi8B9F43+fXW9cd9MxrFHQd9ML55swAGdohg8Zqzomv
         mXbGaO8NixOlcRgHkwthiPQ8CNI28HTKklYGwapo3q331N3jLCGD0uFrCRq7NKe0aFKw
         J4Bigb6yWgnNuvD6Kp5Hc0MLguOHsIbPqwG1WLiIuQHikYVJU22wrqJO/LLlZC6HvgQN
         D3uKis4U32f5Twfguz7BL/H0toFyoWwTLmbBiCKymUZgKgngSRtjNM4SZqv4/ZdwONOb
         P4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ur1bt3xTjtkHmcaGa2TtGWJXPFbPuLGPncSr9nhfgIU=;
        b=g8ha0yWzL6hal3lGJnNWAS7EO9Kw08ixlJBAVUvo9GWkXtMpF4wessx4hL/wXa0Wg/
         epFIEZuvam9xOgkVH/0f2YCnw39GCx8yR44j0RL0o7GRKKCh4Gtz7xO9rJV82ZTaPD8N
         jazWnDfnkdaR94AWLlWI9Lq3Gf8cL8ikiF08+WwdHSCvJv0AkmbMy7kg5TbjuBYl+FBi
         1KhZh7v6UWmQzJQ6SIYtl+0VW/OmddCI3cthFrxKNVGLa2QVpyHbDFLCE2BWtfVhdrEF
         EY2vR96CI69NI/lenuwJqVh+Q2AThWTUBLC7q96p767JLn2rqw1zlv8IS2ROu14NjtCb
         tyNQ==
X-Gm-Message-State: APjAAAUy/NBfGpJ1wlXHHNQEKZg/jAazl0f9cqQ/oKsH7pmjVUPMKRbT
        xgPLriXUja+aaXp1vbyKA/0DcZNDZFs=
X-Google-Smtp-Source: APXvYqwtVx0T/GBthcNljPLvnKI3P3dum7lsbViRGFiBl18i0ByWVNIJ51tPBTD6LluypmeyTyQujQ==
X-Received: by 2002:a17:90a:ba04:: with SMTP id s4mr3251449pjr.92.1575954386282;
        Mon, 09 Dec 2019 21:06:26 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11c7? ([2620:10d:c090:180::240])
        by smtp.gmail.com with ESMTPSA id e27sm1275309pfm.26.2019.12.09.21.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 21:06:25 -0800 (PST)
Subject: Re: [block] 48d9b0d431: BUG:kernel_NULL_pointer_dereference,address
To:     kernel test robot <rong.a.chen@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191208154020.GK32275@shao2-debian>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee156e51-bede-9c58-b48b-31aac65976ea@kernel.dk>
Date:   Mon, 9 Dec 2019 22:06:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191208154020.GK32275@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logan,

Are you looking into this one?


On 12/8/19 8:40 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 48d9b0d43105e0da2b7c135eedd24e51234fb5e4 ("block: account statistics for passthrough requests")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: rcuperf
> with following parameters:
> 
> 	runtime: 300s
> 	perf_type: tasks
> 
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------------+------------+------------+
> |                                                       | 8148f0b564 | 48d9b0d431 |
> +-------------------------------------------------------+------------+------------+
> | boot_successes                                        | 8          | 0          |
> | boot_failures                                         | 0          | 8          |
> | BUG:kernel_NULL_pointer_dereference,address           | 0          | 8          |
> | Oops:#[##]                                            | 0          | 8          |
> | EIP:blk_account_io_completion                         | 0          | 8          |
> | EIP:ide_output_data                                   | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 8          |
> +-------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   14.392111] BUG: kernel NULL pointer dereference, address: 000002ac
> [   14.392607] #PF: supervisor write access in kernel mode
> [   14.392607] #PF: error_code(0x0002) - not-present page
> [   14.392607] *pde = 00000000 
> [   14.392607] Oops: 0002 [#1]
> [   14.392607] CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted 5.4.0-rc2-00011-g48d9b0d43105e #1
> [   14.392607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   14.392607] Workqueue: kblockd drive_rq_insert_work
> [   14.392607] EIP: blk_account_io_completion+0x7a/0xf0
> [   14.392607] Code: 89 54 24 08 31 d2 89 4c 24 04 31 c9 c7 04 24 02 00 00 00 c1 ee 09 e8 f5 21 a6 ff e8 70 5c a7 ff 8b 53 60 8d 04 bd 00 00 00 00 <01> b4 02 ac 02 00 00 8b 9a 88 02 00 00 85 db 74 11 85 d2 74 51 8b
> [   14.392607] EAX: 00000000 EBX: f5b80000 ECX: 00000000 EDX: 00000000
> [   14.392607] ESI: 00000000 EDI: 00000000 EBP: f3031e70 ESP: f3031e54
> [   14.392607] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
> [   14.392607] CR0: 80050033 CR2: 000002ac CR3: 03c25000 CR4: 000406d0
> [   14.392607] Call Trace:
> [   14.392607]  <IRQ>
> [   14.392607]  ? blk_account_io_completion+0x38/0xf0
> [   14.392607]  blk_update_request+0x85/0x420
> [   14.392607]  ? _raw_spin_unlock_irqrestore+0x4f/0x60
> [   14.392607]  ? trace_hardirqs_off+0xca/0xe0
> [   14.392607]  ? _raw_spin_unlock_irqrestore+0x4f/0x60
> [   14.392607]  ? complete+0x41/0x50
> [   14.392607]  ide_end_rq+0x38/0xa0
> [   14.392607]  ide_complete_rq+0x3d/0x70
> [   14.392607]  cdrom_newpc_intr+0x258/0xba0
> [   14.392607]  ? find_held_lock+0x2f/0xa0
> [   14.392607]  ? cdrom_analyze_sense_data+0x1b0/0x1b0
> [   14.392607]  ide_intr+0x135/0x250
> [   14.392607]  __handle_irq_event_percpu+0x3e/0x250
> [   14.392607]  handle_irq_event_percpu+0x1f/0x50
> [   14.392607]  handle_irq_event+0x32/0x60
> [   14.392607]  ? handle_fasteoi_irq+0x160/0x160
> [   14.392607]  handle_level_irq+0x6c/0x110
> [   14.392607]  handle_irq+0x72/0xa0
> [   14.392607]  </IRQ>
> [   14.392607]  do_IRQ+0x45/0xad
> [   14.392607]  common_interrupt+0x115/0x11c
> [   14.392607] EIP: ide_output_data+0xb7/0x140
> [   14.392607] Code: 00 00 00 0f b7 03 66 89 07 83 c3 02 39 d3 75 f3 83 c4 14 5b 5e 5f 5d c3 8d 76 00 8b 4d ec d1 e9 80 7d f0 00 75 15 89 de 89 fa <f3> 66 6f 83 c4 14 5b 5e 5f 5d c3 8d b6 00 00 00 00 85 c9 74 ee 49
> [   14.392607] EAX: 00000000 EBX: f5b800ac ECX: 00000000 EDX: 00000170
> [   14.392607] ESI: f5b800b8 EDI: 00000170 EBP: f6a57dac ESP: f6a57d8c
> [   14.392607] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   14.392607]  ? print_usage_bug+0x9b/0x1f0
> [   14.392607]  ? ide_output_data+0xb7/0x140
> [   14.392607]  ? ide_set_handler+0x42/0x50
> [   14.392607]  ide_transfer_pc+0x11c/0x2a0
> [   14.392607]  ? ide_check_atapi_device+0x130/0x130
> [   14.392607]  ? ide_pc_intr+0x3d0/0x3d0
> [   14.392607]  ide_issue_pc+0x160/0x250
> [   14.392607]  ? ide_check_atapi_device+0x130/0x130
> [   14.392607]  ide_cd_do_request+0x18e/0x3d0
> [   14.392607]  ide_issue_rq+0x13a/0x6a0
> [   14.392607]  ? _raw_spin_unlock_irq+0x22/0x30
> [   14.392607]  ? lockdep_hardirqs_on+0xe4/0x190
> [   14.392607]  ? _raw_spin_unlock_irq+0x22/0x30
> [   14.392607]  ? trace_hardirqs_on+0x38/0xe0
> [   14.392607]  ? drive_rq_insert_work+0x7a/0xf0
> [   14.392607]  drive_rq_insert_work+0x8a/0xf0
> [   14.392607]  process_one_work+0x207/0x500
> [   14.392607]  ? process_one_work+0x16b/0x500
> [   14.392607]  worker_thread+0x39/0x400
> [   14.392607]  kthread+0xee/0x110
> [   14.392607]  ? process_one_work+0x500/0x500
> [   14.392607]  ? kthread_create_on_node+0x30/0x30
> [   14.392607]  ret_from_fork+0x1e/0x28
> [   14.392607] Modules linked in:
> [   14.392607] CR2: 00000000000002ac
> [   14.392607] ---[ end trace 2efe0b990b41cd59 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.4.0-rc2-00011-g48d9b0d43105e .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
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


-- 
Jens Axboe

