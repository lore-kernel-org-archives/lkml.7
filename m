Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADECC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F022466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhbbMiXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfLEVTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:19:04 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39139 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEVTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:19:04 -0500
Received: by mail-vs1-f68.google.com with SMTP id p21so3506678vsq.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WUgUU6EFepvf+3kAqmDr43zIZXXpWpmN9fMRSnPoU50=;
        b=GhbbMiXNO+52x6ilNuXdv3jbg9SDpfn/SNVQYAL81EU/BAzAVfXVlBGPhnB3h0RKrm
         URB6nPgLTfCNL0afqXoH7hiIThk8paeWprPaXK0bWHzlm45/bIbr6ffbdCfPtXm57yXQ
         2nepNfcdthxQWhGpm+S4+a+ar89B9dVEQ6uiQiyE+xbS/0a/ff9oAX8k9GydkBJwGg72
         OPW4XCi8YgmxtV/kIhNI3IW0TxrZKeQyAgnGxQpQEn5Feop46znp9NccTIIiFiCfm/WR
         Z+Y3QNwoTUREMADLe+jMPK4PTLVVcFWwlSbxqo4p6NLTfTgfuWsdSbFwFQs2jamY0/xM
         dIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WUgUU6EFepvf+3kAqmDr43zIZXXpWpmN9fMRSnPoU50=;
        b=AGzW9iuZ1ZJ8Tr34yj9aYqf4xuseW10NLgAli96Kw9WdDjpZli8YX9HDqKjjXQ2J3j
         ax5uEmKUfB/vwZQea0Ebu+Wlzc1qrHzIJK3ry3g8VJUhZ9lPHQLBttfV//OWP+usbnC2
         qql5Uz7sw2nMXc5Uo/PDshdyUxug5c1ChifWYJW/ng1LEO5wpSPpn3hSde7UVv7ayXEW
         SAxX9AkqBU00yuAgb1RuReeehCocKiMa6zoM52HW4qF62PZRXpQnC2AJnuwAPxM2cEsL
         An+H125H8vFiKy0N+vW8kPe/yYa6FpxN7Qe5NDuPbgAxkwL9THjNYbWZQZJWBEskn5d/
         P/kA==
X-Gm-Message-State: APjAAAWe9pgSxtBnXmGKcX/vxlGRPclqwDt3tBbFHvR9/wPilgAWPdTg
        kFdAe0jrr6qquFro1fShwaCWJmJSLQcPbZ8QLb0Qu1srl16Wnw==
X-Google-Smtp-Source: APXvYqw+JfxGYjWJsiq/H7mWHop2og5CHsBAEcSLNsIEIlOdqLpDfatp9QmBgqbR0KgsZdBuDBdtJvU6MGbnVApAc2g=
X-Received: by 2002:a67:dc90:: with SMTP id g16mr7083274vsk.110.1575580742997;
 Thu, 05 Dec 2019 13:19:02 -0800 (PST)
MIME-Version: 1.0
From:   Anatol Pomozov <anatol.pomozov@gmail.com>
Date:   Thu, 5 Dec 2019 13:18:52 -0800
Message-ID: <CAOMFOmXU8RoeAOEjP=gkkiZdPS8Ok_wzXcgUZxL11u1zMSEtMQ@mail.gmail.com>
Subject: dmesg spammed with "caller memremap+0x64/0x160 mapping multiple BARs"
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     avid@redhat.com, hch@lst.de, namit@vmware.com, tglx@linutronix.de,
        delvare@suse.de, rrichter@marvell.com, rppt@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

We have several servers that run on kernel 4.14.12 and their logs
spammed with following messages:

 [20633911.311910] caller memremap+0x64/0x160 mapping multiple BARs
 [20633911.318577] resource sanity check: requesting [mem
0x000eb570-0x000edc34], which spans more than PCI Bus 0000:00 [mem
0x000e8000-0x000ebfff window]
 [20633911.333650] caller memremap+0x64/0x160 mapping multiple BARs
 [20633911.340412] resource sanity check: requesting [mem
0x000eb570-0x000edc34], which spans more than PCI Bus 0000:00 [mem
0x000e8000-0x000ebfff window]
 [20633911.355481] caller memremap+0x64/0x160 mapping multiple BARs

After some debugging I've found that the warning is printed when I open the file
/sys/firmware/dmi/entries/*/raw The stacktrace is

[   14.839284] Call Trace:
[   14.839289]  dump_stack+0x46/0x59
[   14.839293]  iomem_map_sanity_check+0xb8/0xc0
[   14.839296]  __ioremap_caller+0x225/0x2f0
[   14.839302]  memremap+0x113/0x170
[   14.856703]  ? dmi_name_in_serial+0x30/0x30
[   14.856705]  dmi_walk+0x30/0x70
[   14.856706]  find_dmi_entry+0x46/0x80
[   14.856708]  ? dmi_entry_free+0x10/0x10
[   14.856710]  dmi_entry_raw_read+0x3a/0x60
[   14.856712]  kernfs_fop_read+0xa1/0x170
[   14.856714]  __vfs_read+0x36/0x170
[   14.856717]  vfs_read+0x89/0x130
[   14.856719]  SyS_read+0x52/0xc0
[   14.856721]  do_syscall_64+0x60/0x110
[   14.856723]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[   14.856725] RIP: 0033:0x7f60aceedf70

As it turned out the root of the problem is BIOS region mapping. Here
are ACPI mappings:

000e0000-000fffff : Reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00

Or the same mapping from IASL tool:

DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
Cacheable, ReadWrite,
    0x00000000,         // Granularity
    0x000E8000,         // Range Minimum
    0x000EBFFF,         // Range Maximum
    0x00000000,         // Translation Offset
    0x00004000,         // Length
    ,, , AddressRangeMemory, TypeStatic)
DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
Cacheable, ReadWrite,
    0x00000000,         // Granularity
    0x000EC000,         // Range Minimum
    0x000EFFFF,         // Range Maximum
    0x00000000,         // Translation Offset
    0x00004000,         // Length
    ,, , AddressRangeMemory, TypeStatic)


SMBIOS table is located at 0x000eb570-0x000edc34 address range. When
find_dmi_entry() tries to map SMBIOS to kernel address space the
warning above is printed.



So I have a few questions here:
 - What exactly kernel tries to tell us here? Why mapping SMBIOS over
multiple PCI mappings is bad. Sorry I am not familiar with this
codepath and I am trying to understand the issue.
 - Is the warning really bad? The code works just fine despite the
warnings. Can the warning be turned into info/debug()?
 - Is the mapping need to be fixed in BIOS? What other possible
problems can happen due to such BIOS mapping misconfiguration?
 - Why SMBIOS table mapped for every sysfs file read? Would it make
sense to map SMBIOS only once at the kernel boot?
 - Does it make sense to ratelimit the warning? I will be glad to send
the path for it.
