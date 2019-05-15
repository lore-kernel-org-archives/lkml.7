Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7698C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8509B20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="olPe8E8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEOHZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:25:26 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:38491 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOHZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:25:26 -0400
Received: by mail-qt1-f177.google.com with SMTP id d13so2144083qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=u25M0RcXN5c39KhEp+qIAfvV4PolgDkReJdK1myvgTY=;
        b=olPe8E8oLHtkmveo+cKaMvDgYyMfQvWEzc1OnO6RlSFKqILek7UkvoHtzEdGCoN50W
         9e4PKJK2Z14HGGDCXUFS7EnIlbFxozkkXodiyWlrSkKkjjwNsHAlNXpFyOEiHulzI1dZ
         67DiagFc7aBEGFOdNS+URTPltjevKUk98AUyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=u25M0RcXN5c39KhEp+qIAfvV4PolgDkReJdK1myvgTY=;
        b=P+LmSv/1xFD7AKGpn4sEOW6VLtG/ej/cFw109wIX+Gu31n4THMh9spowBzohH4divl
         QMVGRC3h2gtlGz4333zZXKcJj7/e2pp91t8djj+fk7KqgYPkK38HfW/xFfmAKOiys1Jx
         zy6JsCKgj8jLJLPxBtn+IXQY8f2ClUkbBSqaicvekm+VW7WqKfBqnMli+rEFMUvp2BFb
         t063NVBCrySL+dByJxFsTSr/HCZDc7inS0mFYXw+vN3UeZGruFRNLlbR1Ab9iKysutgl
         KTHvAHR9DaJsLrhTGHaYjN6WWqDrVdWrJltnXesegfhO5o7UMK3AVzdin7u7eQyIXRDA
         xZDw==
X-Gm-Message-State: APjAAAVGjoMXlv8uZR3kG2bWO9muobT9K+QJz2sbkMo3DtamJyP/CcYi
        WIV6iCG9BuFw7tXTiLnc2ohPwt4Ji/4PzA==
X-Google-Smtp-Source: APXvYqxCnMa0pfwylfSaLy2M3/t0c2fLxeci4LJFgNkIgoIzzlDzghGv4TR7pwF1v1V9RY9J0to5sA==
X-Received: by 2002:ac8:7506:: with SMTP id u6mr33973867qtq.331.1557905124153;
        Wed, 15 May 2019 00:25:24 -0700 (PDT)
Received: from warpc ([2600:4040:4001:1e00::f7aa])
        by smtp.gmail.com with ESMTPSA id h62sm520796qkd.92.2019.05.15.00.25.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 May 2019 00:25:22 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     "'Kirill A. Shutemov'" <kirill@shutemov.name>
Cc:     <linux-kernel@vger.kernel.org>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com> <20190509111343.rvmy5noqlf4os3zk@box>
In-Reply-To: <20190509111343.rvmy5noqlf4os3zk@box>
Subject: RE: 5.1 kernel: khugepaged stuck at 100%
Date:   Wed, 15 May 2019 03:25:22 -0400
Message-ID: <000101d50aef$5b8f09e0$12ad1da0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHZkV4erg9Yn3SUQRSCOqzXaVbBEgIPUcihplJA6KA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kirill A. Shutemov [mailto:kirill@shutemov.name]
> Sent: Thursday, May 09, 2019 7:14 AM
> To: Justin Piszcz
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 5.1 kernel: khugepaged stuck at 100%
> 
> On Thu, May 09, 2019 at 05:54:56AM -0400, Justin Piszcz wrote:

[ ... ]

> > Thoughts on debugging / before reboot to clear this up?
> 
> Could you check what khugepaged doing?
> 
> cat /proc/$(pidof khugepaged)/stack

Hello, the next time I see this (khugepage at 100%) I will provide the
requested info.

However, this time I'm getting a kernel read fault (below) under 5.1.1,
under 5.0.x and earlier I've never seen any of these errors before:

[54101.281515] BUG: unable to handle kernel paging request at
ffffea0002060000
[54101.281519] #PF error: [normal kernel read fault]
[54101.281521] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
[54101.281524] Oops: 0000 [#1] SMP PTI
[54101.281527] CPU: 0 PID: 77 Comm: khugepaged Tainted: G                T
5.1.1 #1
[54101.281528] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2
01/16/2015
[54101.281534] RIP: 0010:isolate_freepages_block+0xb9/0x310
[54101.281535] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49 8d 45
79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef 00 00 00 <48>
8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01 0f 84
[54101.281537] RSP: 0018:ffffc900003a7860 EFLAGS: 00010246
[54101.281538] RAX: 0000000000000000 RBX: ffffea0002060000 RCX:
ffffc900003a7b69
[54101.281539] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffffff828c4790
[54101.281540] RBP: 0000000000081800 R08: 0000000000000001 R09:
0000000000000000
[54101.281542] R10: 0000000000000202 R11: ffffffff828c43d0 R12:
0000000000000000
[54101.281543] R13: 0000000000000000 R14: ffffc900003a7af0 R15:
0000000000000000
[54101.281544] FS:  0000000000000000(0000) GS:ffff88903f800000(0000)
knlGS:0000000000000000
[54101.281546] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[54101.281547] CR2: ffffea0002060000 CR3: 000000000280e002 CR4:
00000000001606f0
[54101.281548] Call Trace:
[54101.281552]  compaction_alloc+0x83d/0x8d0
[54101.281555]  migrate_pages+0x30d/0x750
[54101.281557]  ? isolate_migratepages_block+0xa10/0xa10
[54101.281559]  ? __reset_isolation_suitable+0x110/0x110
[54101.281561]  compact_zone+0x684/0xa70
[54101.281563]  compact_zone_order+0x109/0x150
[54101.281566]  ? schedule_timeout+0x1ba/0x290
[54101.281569]  ? record_times+0x13/0xa0
[54101.281571]  try_to_compact_pages+0x10d/0x220
[54101.281574]  __alloc_pages_direct_compact+0x93/0x180
[54101.281576]  __alloc_pages_nodemask+0x6c7/0xe20
[54101.281579]  ? __wake_up_common_lock+0xb0/0xb0
[54101.281581]  khugepaged+0x31f/0x19b0
[54101.281584]  ? __wake_up_common_lock+0xb0/0xb0
[54101.281586]  ? collapse_shmem.isra.4+0xc20/0xc20
[54101.281589]  kthread+0x10a/0x120
[54101.281592]  ? __kthread_create_on_node+0x1b0/0x1b0
[54101.281595]  ret_from_fork+0x35/0x40
[54101.281597] CR2: ffffea0002060000
[54101.281599] ---[ end trace d9bfd1c296893a64 ]---
[54101.281601] RIP: 0010:isolate_freepages_block+0xb9/0x310
[54101.281602] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49 8d 45
79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef 00 00 00 <48>
8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01 0f 84
[54101.281604] RSP: 0018:ffffc900003a7860 EFLAGS: 00010246
[54101.281605] RAX: 0000000000000000 RBX: ffffea0002060000 RCX:
ffffc900003a7b69
[54101.281606] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffffff828c4790
[54101.281607] RBP: 0000000000081800 R08: 0000000000000001 R09:
0000000000000000
[54101.281608] R10: 0000000000000202 R11: ffffffff828c43d0 R12:
0000000000000000
[54101.281609] R13: 0000000000000000 R14: ffffc900003a7af0 R15:
0000000000000000
[54101.281610] FS:  0000000000000000(0000) GS:ffff88903f800000(0000)
knlGS:0000000000000000
[54101.281611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[54101.281613] CR2: ffffea0002060000 CR3: 000000000280e002 CR4:
00000000001606f0




