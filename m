Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91876C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512952173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKk/J2F5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbfHHUzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:55:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37424 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390151AbfHHUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:55:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so58706794otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXpp+XKezdn11YJZlmvGzWByn0IYUl0lRqPbcEZTEWQ=;
        b=kKk/J2F5M7qPBG/wD7N+G59ApgKMv6wsTyxzoDzIFw4HfK59tL5PIFXAo6xqZ+JyQE
         iZQpLctO2WSbLi/TV4dU2+zwoWpMcJDDqPDyt4jwBbAJko+EsOV/CWI9S19zm5jWKyDt
         nUojNSUpXX5qVlSbeoQo6rFojS0wouaevXsC3KZyttDl0/jbaW/MDDYLzI3EKhlpLiSN
         8qA2Q6k1YGzNh1bRPuV8aiGFCWEzXK658KELjl9icUVINATxteajAgfboi4gp7hT8rst
         AU5I9Zb+DvO79n1fHJf+NE5cydEVrWsAjzB6fMPBq3ZDRxSd2ovXyODQ1mOw34S607i4
         3vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXpp+XKezdn11YJZlmvGzWByn0IYUl0lRqPbcEZTEWQ=;
        b=k66HCXsl41vgfXel8y5CHo5+ZxwlYSOLatK2FAETauHpTpeVc+uXm8RrzZH34g/lz0
         S/y5LJVyGwXrgjp6jIWCZs3cqaKNG734zrv0Tt+ZeH9mW2Wp8RqMffaHzBFjPAenbqcR
         ExxFGlDTz0Mt5QVG9q2+pu//9Y6my1Z7MMorrMgUsJfxd+3BvnS+rXyHqpsM3gaVPV6I
         qwNICoaQPz+zbQJduZw7FyU95QCFZT+Q54lmnN0CHBQCwtHwV4MltfN5tX5q+bOOi2/W
         S24jnjbjYOwegV53pUHECJPwtoyBIq8jwH4vdgl/wIkQMftE0zkwNOISdn4muwaB2HnC
         Cr7Q==
X-Gm-Message-State: APjAAAXALMRiIH2yLJdGnhHAEVRysG8/9my0lYfQcubbyZFFMhaAT/+F
        JdLKfzQ/XDSYwEEKGyHRp9+qXKUInkTc+iYWivjdmGRdXJdPQQ==
X-Google-Smtp-Source: APXvYqzPBR4jAZ8pk4CbMmZ1tOi/jtQ8LAipnHjaTO7d4wfL7DNvuSltfke+hAzQlE+FfBeBZNMYtGZjpm/HnwUAX/4=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr15614921otr.231.1565297741535;
 Thu, 08 Aug 2019 13:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <5d4bce76.Bu8zZv8tcbDqokLR%lkp@intel.com>
In-Reply-To: <5d4bce76.Bu8zZv8tcbDqokLR%lkp@intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 8 Aug 2019 13:55:05 -0700
Message-ID: <CAGETcx__STm5jSWRCFc3eZYVm4sW7P=HNjuGBa+Tj_YCc3o8Bg@mail.gmail.com>
Subject: Re: 21871a99b3 ("of/platform: Pause/resume sync state during init
 .."): WARNING: CPU: 0 PID: 1 at drivers/base/core.c:691 device_links_supplier_sync_state_resume
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        philip.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 12:25 AM kernel test robot <lkp@intel.com> wrote:
>
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
>
> commit 21871a99b34c65c56a24193c277a4981529c306f
> Author:     Saravana Kannan <saravanak@google.com>
> AuthorDate: Wed Jul 31 15:17:18 2019 -0700
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Thu Aug 1 16:04:14 2019 +0200
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
>     Similarly, when children devices are populated after kernel init using
>     of_platform_populate(), there could be supplier-consumer dependencies
>     between the children devices that are populated. To avoid the same
>     problem with sync_state() being called prematurely, pause and resume
>     sync_state() callbacks across of_platform_populate().
>
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Link: https://lore.kernel.org/r/20190731221721.187713-6-saravanak@google.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> 8f8184d6bf  driver core: Add sync_state driver/bus callback
> 21871a99b3  of/platform: Pause/resume sync state during init and of_platform_populate()
> 5adf578101  of/platform: Fix device_links_supplier_sync_state_resume() warning
> 3880be629e  Add linux-next specific files for 20190807
> +-------------------------------------------------------------------------+------------+------------+------------+---------------+
> |                                                                         | 8f8184d6bf | 21871a99b3 | 5adf578101 | next-20190807 |
> +-------------------------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                                          | 27         | 0          | 0          | 0             |
> | boot_failures                                                           | 2          | 11         | 11         | 11            |
> | WARNING:at_mm/usercopy.c:#usercopy_warn                                 | 1          |            |            |               |
> | RIP:usercopy_warn                                                       | 1          |            |            |               |
> | invoked_oom-killer:gfp_mask=0x                                          | 1          |            |            |               |
> | Mem-Info                                                                | 1          |            |            |               |
> | WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 11         | 11            |
> | RIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 11         | 11            |
> +-------------------------------------------------------------------------+------------+------------+------------+---------------+
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>
> [   26.905004] i2c i2c-1: Added multiplexed i2c bus 3
> [   26.917068] ### dt-test ### FAIL of_unittest_overlay_high_level():2380 overlay_base_root not initialized
> [   26.920311] ### dt-test ### end of unittest - 219 passed, 1 failed
> [   26.922504] ------------[ cut here ]------------
> [   26.924102] Unmatched sync_state pause/resume!
> [   26.924192] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:691 device_links_supplier_sync_state_resume+0x140/0x160
> [   26.929493] Modules linked in:
> [   26.930681] CPU: 0 PID: 1 Comm: swapper Tainted: G                T 5.3.0-rc1-00025-g21871a99b34c6 #1
> [   26.933665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   26.936451] RIP: 0010:device_links_supplier_sync_state_resume+0x140/0x160
> [   26.938611] Code: 84 c0 49 8d 84 24 c8 00 00 00 0f 85 48 ff ff ff 49 8d 94 24 d0 00 00 00 48 89 55 d0 eb 86 48 c7 c7 c0 30 be 83 e8 10 c0 e5 fe <0f> 0b 48 c7 c7 80 33 c4 84 e8 12 19 d0 00 48 83 c4 10 5b 41 5c 41
> [   26.944420] RSP: 0018:ffff88801a397da8 EFLAGS: 00010286
> [   26.946213] RAX: 0000000000000022 RBX: b05332a62e1f2e76 RCX: 0000000000000000
> [   26.948487] RDX: 0000000000000022 RSI: ffffffff81276c83 RDI: 0000000000000246
> [   26.950858] RBP: ffff88801a397de0 R08: fffffbfff0aa192d R09: fffffbfff0aa192d
> [   26.953192] R10: ffff88801a397df0 R11: 0000000000000001 R12: 0000000000000000
> [   26.955411] R13: 00000000ffffffff R14: 1ffff11003472fc3 R15: ffff88801a397eb8
> [   26.957678] FS:  0000000000000000(0000) GS:ffffffff846b3000(0000) knlGS:0000000000000000
> [   26.960398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.962374] CR2: 00007fb42acb9480 CR3: 000000000462a006 CR4: 00000000001606f0
> [   26.964683] Call Trace:
> [   26.965713]  of_platform_sync_state_init+0x17/0x3a
> [   26.967381]  ? of_core_init+0x16a/0x16a
> [   26.968769]  do_one_initcall+0x103/0x295
> [   26.970179]  ? trace_event_raw_event_initcall_finish+0x150/0x150
> [   26.972130]  ? down_write+0xbe/0x100
> [   26.973467]  ? __down_killable+0x260/0x260
> [   26.974933]  ? __kasan_check_write+0x1f/0x30
> [   26.976433]  kernel_init_freeable+0x232/0x349
> [   26.978003]  ? rest_init+0xd0/0xd0
> [   26.979274]  kernel_init+0xe/0x120
> [   26.980580]  ? rest_init+0xd0/0xd0
> [   26.981870]  ret_from_fork+0x24/0x30
> [   26.983168] ---[ end trace fa753e8363323d3d ]---
> [   26.991111] Freeing unused decrypted memory: 2040K

This looks like the same issue fixed by:
https://lore.kernel.org/lkml/20190807020559.74458-1-saravanak@google.com/

If anyone thinks otherwise, please let me know.

-Saravana
