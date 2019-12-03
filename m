Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2616C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818BA2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHOC9yt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfLCXIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:08:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728973AbfLCWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575413155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DiiGSGkRP92W9wYg+3MzqszVWv8338ggO0jEY4QJvxc=;
        b=CHOC9yt2eJ59833H7h6k4c2n92PIaOHbZ2N9xGjkZ771wAq9K7PhdbG19NZ+1s5/lJCn26
        XJQVj8D+bP4dHMntLtVC9oZgzybRrzNIhEsBKZk70f8IcdVS3m9DCWkRaLM3aDuATNn4cB
        vf1bE3Ej0Tj3BgMgjWOxdnHCXa5eBNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-391Gr8fNMrS7PiPeCrcKvg-1; Tue, 03 Dec 2019 17:45:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7589A18AAFA4;
        Tue,  3 Dec 2019 22:45:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-16.rdu2.redhat.com [10.10.124.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72127600D1;
        Tue,  3 Dec 2019 22:45:48 +0000 (UTC)
Subject: Re: [PATCH] x86/tsc: Fix incorrect enabling of __use_tsc static_key
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <20191203204053.12956-1-longman@redhat.com>
 <CA+CK2bBvoM5bb0q2Ha7-+_6Pt5Qx_Vptx7zs2cEYUVuU=vWt7Q@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1dfd996c-ef25-a622-879a-977f57193ca7@redhat.com>
Date:   Tue, 3 Dec 2019 17:45:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBvoM5bb0q2Ha7-+_6Pt5Qx_Vptx7zs2cEYUVuU=vWt7Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 391Gr8fNMrS7PiPeCrcKvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 3:54 PM, Pavel Tatashin wrote:
> On Tue, Dec 3, 2019 at 3:41 PM Waiman Long <longman@redhat.com> wrote:
>> After applying the commit 4763f03d3d18 ("x86/tsc: Use TSC as sched clock
>> early") and the commit 608008a45798 ("x86/tsc: Consolidate init code"),
>> some x86 systems boot up with the following warnings:
>>
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] tsc: Detected 2599.853 MHz processor
>> [    0.000000] ------------[ cut here ]------------
>> [    0.000000] static_key_enable_cpuslocked(): static key
>> '__use_tsc+0x0/0x10' used before call to jump_label_init()
>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:132 static_key_enable_cpuslocked+0x7b/0x80
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-154.el8.x86_64 #1
>> [    0.000000] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
>> [    0.000000] RIP: 0010:static_key_enable_cpuslocked+0x7b/0x80
>>   :
>> [    0.000000] Call Trace:
>> [    0.000000]  ? static_key_enable+0x16/0x20
>> [    0.000000]  ? setup_arch+0x43f/0xf68
>> [    0.000000]  ? printk+0x58/0x6f
>> [    0.000000]  ? start_kernel+0x63/0x55b
>> [    0.000000]  ? load_ucode_bsp+0xfb/0x12e
>> [    0.000000]  ? secondary_startup_64+0xb7/0xc0
>> [    0.000000] ---[ end trace fc2166797a50a8e0 ]---
>>   :
>> [ 1781.404905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
>> [ 1781.409905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
>> [ 1781.412905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
>> [ 1781.578905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
>> [ 1781.973905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
>>   :
>>
>> In this particular case,
>>
>>   setup_arch() => tsc_early_init()
>>                => tsc_enable_sched_clock()
>>                => static_branch_enable()
>>
>> However, jump_label_init() is called after setup_arch(). Before the
>> 2 commits listed above, static_branch_enable() was only called in
>> tsc_init() which is after jump_label_init().
> Hi Waiman,
>
> jump_label_init() is called from setup_arch():
> https://soleen.com/source/xref/linux/arch/x86/kernel/setup.c?r=11a98f37#911
>
>  tsc_early_init() early init is also called from setup_arch() but later:
> https://soleen.com/source/xref/linux/arch/x86/kernel/setup.c?r=11a98f37#1053
>
> I think that the kernel where this problem is seen, might be missing
> 8990cac6e5ea7fa57607736019fe8dca961b998f x86/jump_label: Initialize
> static branching early
> Or some other patches from that series.
>
> Thank you,
> Pasha
>
Yes, you are right. I overlooked the jump_label_init() call in
arch/x86/kernel/setup.c. The test kernel that I used did not have that
patch.

Sorry for the noise.

Thanks,
Longman

