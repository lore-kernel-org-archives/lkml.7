Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63382C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B362054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="dDSjpfir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfLLPgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:36:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33327 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbfLLPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:36:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so1956895qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=gIwYLUzszV3geI4ukrW8B4lSOTUNSeedDso0EaQItzE=;
        b=dDSjpfirLbv7d6k2mTPxpsic2/rDOJrgY3n6PKek0w973z4YU8jBremPRplGOTZUsG
         Sfiou7mzQeGnyb40XHMzCvxfh+jVmJP/Xtxdba47b/ZPPhIBERWQ3HbAwLnT3E8HKYiL
         lwes7qeikAyzF4NOet2Zppz1Yw7H1wyP4Qh6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=gIwYLUzszV3geI4ukrW8B4lSOTUNSeedDso0EaQItzE=;
        b=BbjcNUqPmSu462uFchIcpjW6FXwG2jSinwpKVkKwsqdHmclurXSogxfiilDupi/AS9
         uguTWBkRhhsrTaxxZp177OSW6Q1e4fTLfDaZ3grBIi5hr03NsQiHjGn1PKDnXfGyTXQH
         DpuUVCeRk9f/sd70da6FlhBEAAyr3IPyCJimc3yH5Tt6yVnVTvq8D2ybLdSWOlj09lYe
         //NctvIY2Ltj5Woql4YwGkml+W+A9VpVYtwvnLTObLjKUiEDrlNvt/i/CLDXGSqmDea3
         VUUKEVgaMoCG2urbO3Q02utSWkhBcpIFEtoXfzhcIBOp1jQs4EmuaHAZQJgZl0alNeB1
         ydLg==
X-Gm-Message-State: APjAAAWFFWdyHW6cWgwffJAbuVnohJ0AMNemA3FElNXdV2tdy0Vbb77v
        SVT1CxOFRBjVaRROz1OlbbpHVez+WiK6zA==
X-Google-Smtp-Source: APXvYqy8LV17daVjgLVRFIgTGl6WhbprTUviAigzfW+yvBKyWlRec1h99dp3g6yKPp5zI7BfxOgTIA==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr8801192qkg.38.1576164999343;
        Thu, 12 Dec 2019 07:36:39 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id p14sm2267925qtq.97.2019.12.12.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 07:36:38 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 12 Dec 2019 10:36:37 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [perf] perf_fuzzer triggers NULL pointer derefernce in i915 driver
Message-ID: <alpine.DEB.2.21.1912121032420.15237@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

with current git the perf_fuzzer was able to trigger this NULL pointer
de-reference in the i915 driver.

Vince

[40119.349172] BUG: kernel NULL pointer dereference, address: 0000000000000000
[40119.356626] #PF: supervisor read access in kernel mode
[40119.362121] #PF: error_code(0x0000) - not-present page
[40119.367606] PGD 0 P4D 0 
[40119.370320] Oops: 0000 [#1] SMP PTI
[40119.374035] CPU: 0 PID: 654 Comm: Xorg Tainted: G        W         5.5.0-rc1+ #138
[40119.382149] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[40119.390053] RIP: 0010:get_timeline_name+0x13/0x20 [i915]
[40119.395747] Code: 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 c7 c0 12 56 4e a0 c3 0f 1f 00 0f 1f 44 00 00 48 8b 87 d0 00 00 00 48 c7 c2 1c 56 4e a0 <48> 8b 00 48 85 c0 48 0f 44 c2 c3 66 90 0f 1f 44 00 00 55 48 8b 87
[40119.415853] RSP: 0018:ffffc90000903938 EFLAGS: 00010206
[40119.421479] RAX: 0000000000000000 RBX: ffff88811093af00 RCX: 0000000000000000
[40119.429148] RDX: ffffffffa04e561c RSI: ffff88811093af00 RDI: ffff88811093af00
[40119.436782] RBP: ffffc90000903990 R08: 0000000000000000 R09: ffff88811093af00
[40119.444420] R10: ffff88811371d208 R11: 0000000000000005 R12: 000000000000000a
[40119.452063] R13: 0000000000000881 R14: ffffffff822f1840 R15: 00000000000a0018
[40119.459671] FS:  00007f61e3f0ff00(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
[40119.468347] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40119.474482] CR2: 0000000000000000 CR3: 0000000111f76003 CR4: 00000000001606f0
[40119.482134] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000009000000
[40119.489841] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[40119.497477] Call Trace:
[40119.500099]  perf_trace_dma_fence+0x80/0x230
[40119.504687]  dma_fence_init+0x9a/0xb0
[40119.508657]  dma_fence_work_init+0x40/0xa0 [i915]
[40119.513726]  i915_vma_work+0x34/0x50 [i915]
[40119.518256]  i915_vma_pin+0x2a4/0x6d0 [i915]
[40119.522884]  eb_lookup_vmas+0x205/0xb80 [i915]
[40119.527667]  i915_gem_do_execbuffer+0x676/0x19c0 [i915]
[40119.533290]  ? __alloc_pages_nodemask+0x16f/0x300
[40119.538331]  ? xas_store+0x56/0x5e0
[40119.542051]  ? mem_cgroup_charge_statistics+0x4c/0xd0
[40119.547436]  i915_gem_execbuffer2_ioctl+0x1df/0x3d0 [i915]
[40119.553348]  ? i915_gem_execbuffer_ioctl+0x2e0/0x2e0 [i915]
[40119.559359]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[40119.564034]  drm_ioctl+0x1f7/0x390 [drm]
[40119.568271]  ? i915_gem_execbuffer_ioctl+0x2e0/0x2e0 [i915]
[40119.574280]  ? _raw_spin_unlock+0xa/0x10
[40119.578475]  ? __handle_mm_fault+0x8ca/0x15f0
[40119.583163]  do_vfs_ioctl+0x45f/0x6e0
[40119.587075]  ksys_ioctl+0x5e/0x90
[40119.590653]  __x64_sys_ioctl+0x16/0x20
[40119.594665]  do_syscall_64+0x52/0x1a0
[40119.598592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
