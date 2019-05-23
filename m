Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B226C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AE20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="hjvolu2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfEWQbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:31:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33228 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:31:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id z5so1115596qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=d4yxOBIwn0FSxMfzAT+WIvqWKOH8KRCi69z+n+22Kqs=;
        b=hjvolu2dB+58iS4YDGxQnMR4xhkqWdh/4SMGHdkFeaPjNmvS3GHdeXkDzleWWT4stH
         b1YfpnshsrP0owpAdoWVcB4bq9xPwFMtSkE1n3fEDfZDIGYKGjRawVeoDjRz85/29JD0
         a4Zx7LNqJN1XQxlr+ZDmOgFWUzAkX+yUTaXKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=d4yxOBIwn0FSxMfzAT+WIvqWKOH8KRCi69z+n+22Kqs=;
        b=DelrcbCcn8R9WNxU92ZL3VU4QE2dcx4XUGBTrFsiwt0y5GmC3/VbT9tlg1pRXA52fa
         f3aEGqh/cRXxgqRfEf0n+MnkJPlvAjqYz6WuTVSNz1ig8MqRsxEk5QAuTHVOsljIpj7k
         qLMy0vGkBOWi84+s/l3RAxYyWjC8MlozXv1MQuYphUggceMPO+bKMLxUD5vvIk4oGUGB
         CppvR4IzWwVy0cvRML9ETOmWeiMqZ4rIMSQ/wXGrVbF792K2zS253XZ7ea551VxVbmdF
         /J6PheZB5jZ8+NLmZ4JACIn7C0uaGQudUOnB9XudXK9Y2uyFEyiSFC17MJv8uUGdxGo/
         bnyg==
X-Gm-Message-State: APjAAAV9on+oNUn7fynt7coUZC1Fx5Q4+vlhzhfE9jwUOr4+FIONyYsM
        OItlwkeXJBAtsePp8sQEbk73pQ==
X-Google-Smtp-Source: APXvYqxZ9nHy4Gm0KJX7DbhUxp+LwJPV2z5M8q/dwCFHL0sE+rvvCTfos00zCwiu1E5xlj7ihqVDpQ==
X-Received: by 2002:a0c:9679:: with SMTP id 54mr67918327qvy.168.1558629060865;
        Thu, 23 May 2019 09:31:00 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id h17sm12968726qkk.13.2019.05.23.09.30.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 09:31:00 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 23 May 2019 12:30:56 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: perf: fuzzer causes crash in new XMM code
In-Reply-To: <a7cde307-8c53-14b5-2272-03dd3a8985c6@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1905231226190.4041@macbook-air>
References: <alpine.DEB.2.21.1905221154300.22830@macbook-air> <a7cde307-8c53-14b5-2272-03dd3a8985c6@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Liang, Kan wrote:

> XMM registers can only collected by hardware PEBS events. We should disable it
> for all software/probe events.
> 
> Could you please try the patch as below?

I tested the patch (it was whitespace damaged for some reason, not 
sure if that was on my end though).

Running a few hours here, it hasn't crashed, but it did produce this 
warning which appears to map to:
	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
		return 0;

[ 5552.352046] WARNING: CPU: 1 PID: 11469 at arch/x86/kernel/perf_regs.c:76 perf_reg_value+0x45/0x50
[ 5552.352083] CPU: 1 PID: 11469 Comm: perf_fuzzer Tainted: G        W         5.2.0-rc1+ #38
[ 5552.352084] Hardware name: LENOVO 10FY0017US/SKYBAY, BIOS FWKT53A   06/06/2016
[ 5552.352086] RIP: 0010:perf_reg_value+0x45/0x50
[ 5552.352089] Code: 48 63 f6 48 8b 84 f2 00 ff ff ff c3 31 c0 c3 83 fe 17 77 16 48 63 f6 8b 04 b5 60 a4 a0 8f 3d a0 00 00 00 77 e7 48 8b 04 07 c3 <0f> 0b 31 c0 c3 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 12 81
[ 5552.352090] RSP: 0000:ffffa13005f23bd8 EFLAGS: 00010206
[ 5552.352092] RAX: 00000000fffffffd RBX: 000000000000001d RCX: 000000000000001d
[ 5552.352093] RDX: 000000000000001d RSI: 000000000000001d RDI: ffffa13005f23f58
[ 5552.352094] RBP: ffffa13005f23c90 R08: 0000000000000000 R09: 0000000000029340
[ 5552.352096] R10: 0000114c8f85b92c R11: 0000000000000001 R12: ffffa13005f23f58
[ 5552.352097] R13: ffff8cc1aa3f4030 R14: 0000000000000030 R15: 0000000000000000
[ 5552.352098] FS:  00007f2154803540(0000) GS:ffff8cc1b5a40000(0000) knlGS:0000000000000000
[ 5552.352100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5552.352101] CR2: 00007ffe0cb894f8 CR3: 000000022d87e006 CR4: 00000000003607e0
[ 5552.352102] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5552.352103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[ 5552.352104] Call Trace:
[ 5552.352109]  perf_output_sample_regs+0x43/0xa0
[ 5552.352115]  perf_output_sample+0x3aa/0x7a0
[ 5552.352119]  perf_event_output_forward+0x53/0x80
[ 5552.352123]  __perf_event_overflow+0x52/0xf0
[ 5552.352126]  perf_swevent_overflow+0x99/0xc0
[ 5552.352128]  ___perf_sw_event+0xe7/0x120
[ 5552.352131]  ? ptep_set_access_flags+0x23/0x30
[ 5552.352134]  ? do_wp_page+0x2c5/0x5c0
[ 5552.352136]  ? __handle_mm_fault+0xba8/0x1220
[ 5552.352140]  ? _cond_resched+0x15/0x30
[ 5552.352143]  ? handle_mm_fault+0xc2/0x1d0
[ 5552.352146]  ? __do_page_fault+0x268/0x4f0
[ 5552.352149]  ? page_fault+0x8/0x30
[ 5552.352151]  __perf_sw_event+0x55/0xa0
[ 5552.352154]  page_fault+0x1e/0x30
[ 5552.352157] RIP: 0033:0x55e5a5ec6494
[ 5552.352159] Code: b8 00 00 00 00 e8 bc 2c ff ff 48 8b 05 c5 a2 22 00 48 83 c0 01 48 89 05 ba a2 22 00 90 c9 c3 55 48 89 e5 48 81 ec 10 24 00 00 <e8> 07 30 ff ff 89 c2 89 d0 c1 f8 1f c1 e8 19 01 c2 83 e2 7f 29 c2
[ 5552.352160] RSP: 002b:00007ffe0cb89500 EFLAGS: 00010206
[ 5552.352161] RAX: 0000000000000400 RBX: 000000000000000c RCX: 0000000000000008
[ 5552.352162] RDX: 000055e5a5ecd9c0 RSI: 00007ffe0cb8b8f4 RDI: 00007f21547fc740
[ 5552.352163] RBP: 00007ffe0cb8b910 R08: 00007f21547fc1c4 R09: 00007f21547fc240
[ 5552.352164] R10: 0000000000000001 R11: 0000000000000202 R12: 000055e5a5eb94c0
[ 5552.352165] R13: 00007ffe0cb8dd00 R14: 0000000000000000 R15: 0000000000000000
[ 5552.352168] ---[ end trace 199d9be3b0c594ae ]---

