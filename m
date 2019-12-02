Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD05C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3260A20675
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjS2Bjfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLBVUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:20:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42167 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLBVUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:20:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so866482otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2uB+/TzMRfuXTzQ7bU449yX1FcyufRJbPoSOJ+c3b0=;
        b=YjS2BjfgIad+yr/+k7u+m/tqwJlSMc306BJTD1R5TazsQg2W7cfJ9FfJsaHT4l7CQO
         jh1+EvC5J9CoSXHl14gwyx/ChCj3zGXoNYgOGCvs0mUTuuKDbNHUWXeFgZzuvnEOtbpD
         ZzXIjnObv/CGwdOK/eDZTrsI9E/RcXoe41Ha4QozYVBFL6jFmAzqFHW4lLt27jb6Da9O
         cEpHFCqT9zjgAqGnaYrn0jAUBNCxXDn+qhlswz+DhyfbIZ9NsOjVBJ01N2r++1D0zyLB
         8HHSB6jb+5TX8T0Ma57wQTefq25AllLETsyab1+fAsPmRcB8XnrzpN4pMnLoxkTCmoIu
         sVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2uB+/TzMRfuXTzQ7bU449yX1FcyufRJbPoSOJ+c3b0=;
        b=Ih1C5sTyKtV3KFeLbgutdQaTC8LGos+be7VgbQUGWEeR+NYytpJfmBFuRFpIVxxCyt
         vTBXYJwJI210KDQhf8ouxhh1ElNbHRDzlwPoQ38XMTQDX9GXfUV3TMVJOKpdIllRGCMG
         /zmyaO/e6gpqhsB4IquY1dEQZvmkN+VI3o9ycKtJZBxzIvPzDLM6xaO0zEccsaS0wrE3
         FjcKw6WEk3RhbOWpBo+cnMDCIvR1rnS3LQHR6y8y392GxBkymt6/tA2Wz01AMX3AHBiF
         kPakV2D5padyuxdUxAoFXIC4JCk9yHs/fHwSXV7WKuFYITnA7fz51k1hLim0FWXizFQA
         mB0A==
X-Gm-Message-State: APjAAAXP8IQb9+tFuv03WNpP2XtKmCYzgkoYpx9LbrLpKbqM3ANfCX0H
        avL656MaxrYXISKyRJVyPasStraVOADX0ykYrpojRA==
X-Google-Smtp-Source: APXvYqykoqTX4clV94B0+24/eTdmMzmP3M1dBPtTZhuddmIhYXFIEk7t4XfCzz/I6yQtBNdvOPcm4xoLtzhy9BkNS10=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr844588otl.195.1575321598246;
 Mon, 02 Dec 2019 13:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20191201150015.GC18573@shao2-debian>
In-Reply-To: <20191201150015.GC18573@shao2-debian>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 2 Dec 2019 13:19:22 -0800
Message-ID: <CAGETcx9r0u=-WSnQ2ZS1KmZSVQqKwvpnhO-w41=jk8iF6BdALA@mail.gmail.com>
Subject: Re: 5e6669387e ("of/platform: Pause/resume sync state during init
 .."): [ 3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@lists.01.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 1, 2019 at 7:00 AM kernel test robot <lkp@intel.com> wrote:
>
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit 5e6669387e2287f25f09fd0abd279dae104cfa7e
> Author:     Saravana Kannan <saravanak@google.com>
> AuthorDate: Wed Sep 4 14:11:24 2019 -0700
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Fri Oct 4 17:30:19 2019 +0200
>
>     of/platform: Pause/resume sync state during init and of_platform_populate()
>
>     When all the top level devices are populated from DT during kernel
>     init, the supplier devices could be added and probed before the
>     consumer devices are added and linked to the suppliers. To avoid the
>     sync_state() callback from being called prematurely, pause the
>     sync_state() callbacks before populating the devices and resume them
>     at late_initcall_sync().
>
>     Similarly, when children devices are populated from a module using
>     of_platform_populate(), there could be supplier-consumer dependencies
>     between the children devices that are populated. To avoid the same
>     problem with sync_state() being called prematurely, pause and resume
>     sync_state() callbacks across of_platform_populate().
>
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Link: https://lore.kernel.org/r/20190904211126.47518-6-saravanak@google.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> fc5a251d0f  driver core: Add sync_state driver/bus callback
> 5e6669387e  of/platform: Pause/resume sync state during init and of_platform_populate()
> 81b6b96475  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
> +-------------------------------------------------------------------------+------------+------------+------------+
> |                                                                         | fc5a251d0f | 5e6669387e | 81b6b96475 |
> +-------------------------------------------------------------------------+------------+------------+------------+
> | boot_successes                                                          | 30         | 0          | 0          |
> | boot_failures                                                           | 1          | 11         | 22         |
> | Oops:#[##]                                                              | 1          |            |            |
> | EIP:unmap_vmas                                                          | 1          |            |            |
> | PANIC:double_fault                                                      | 1          |            |            |
> | Kernel_panic-not_syncing:Fatal_exception                                | 1          |            |            |
> | WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 22         |
> | EIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 22         |
> +-------------------------------------------------------------------------+------------+------------+------------+
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>
> [    3.186107] OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
> [    3.188595] platform testcase-data:testcase-device2: IRQ index 0 not found
> [    3.191047] ### dt-test ### end of unittest - 199 passed, 0 failed
> [    3.191932] ------------[ cut here ]------------
> [    3.192571] Unmatched sync_state pause/resume!
> [    3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume+0x27/0xc0
> [    3.195084] Modules linked in:
> [    3.195494] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc1-00005-g5e6669387e228 #1
> [    3.196674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    3.197693] EIP: device_links_supplier_sync_state_resume+0x27/0xc0
> [    3.198680] Code: 00 00 00 3e 8d 74 26 00 57 56 31 d2 53 b8 a0 d0 d9 c1 e8 6c b6 38 00 a1 e4 d0 d9 c1 85 c0 75 13 68 84 ba c4 c1 e8 29 30 b1 ff <0f> 0b 58 eb 7f 8d 74 26 00 83 e8 01 85 c0 a3 e4 d0 d9 c1 75 6f 8b
> [    3.201560] EAX: 00000022 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [    3.202466] ESI: 000001ab EDI: c02c7f80 EBP: c1e87d27 ESP: c02c7f20
> [    3.203301] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
> [    3.204258] CR0: 80050033 CR2: bfa1bf98 CR3: 01f28000 CR4: 00140690
> [    3.205022] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    3.205919] DR6: fffe0ff0 DR7: 00000400
> [    3.206529] Call Trace:
> [    3.207011]  ? of_platform_sync_state_init+0x13/0x16
> [    3.207719]  ? do_one_initcall+0xda/0x260
> [    3.208247]  ? kernel_init_freeable+0x110/0x197
> [    3.208906]  ? rest_init+0x120/0x120
> [    3.209369]  ? kernel_init+0xa/0x100
> [    3.209775]  ? ret_from_fork+0x19/0x24
> [    3.210283] ---[ end trace 81d0f2d2ee65199b ]---
> [    3.210955] ALSA device list:

Rob/Frank,

This seems to be an issue with the unit test code not properly
cleaning up the state after it's done.

Specifically, unittest_data_add() setting up of_root on systems where
there's no device tree (of_root == NULL). It doesn't clean up of_root
after the tests are done. This affects the of_have_populated_dt() API
that in turn affects calls to
device_links_supplier_sync_state_pause/resume(). I think unittests
shouldn't affect the of_have_populated_dt() API.

I was looking into writing a unittest patch to fix this, but I don't
know enough about the FDT parsing code to make sure I don't leak any
memory or free stuff that's in use. I'm not sure I can simply set
of_root = NULL if it was NULL before the unittest started. Let me know
how I should proceed or if you plan to write up a patch for this.

Thanks,
Saravana
