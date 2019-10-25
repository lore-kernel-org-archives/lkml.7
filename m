Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CB6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB412084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Aurd4Qyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504819AbfJYNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:45:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:54003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfJYNp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572011140;
        bh=/HsTi1dztkO8Q8vr9S/zWc9EDaATqPDR1thsyNEi6sw=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=Aurd4QyfvbFkOd6PGzNeayblqDPrWEYfBjsz9hQsQOfpZ32A02YfnbQ34p3yU6LF4
         iRUnAwO5HyPJAGelhcuL4pVmOZFuzqrUaYWb+nZ+jhRaVHqLkILPbZh2Bc6KhwT6Li
         0AkKOe2cU0pSz5pT/MEEXyPr5nTUomd/csxunmmY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1hv8Iu0Ry4-016Pz0; Fri, 25
 Oct 2019 15:45:40 +0200
Message-ID: <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 15:45:37 +0200
In-Reply-To: <20191025132700.GJ17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
         <20191025120505.GG17610@dhcp22.suse.cz>
         <20191025121104.GH17610@dhcp22.suse.cz>
         <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
         <20191025132700.GJ17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6oBhnmUVyPcXLYH4pMnK/nGPDOJy4FT00tTh+gkgvhoLdCF3EzJ
 19cw+0holvjEkt4ggmUjVV1v2UD5Hu0RaaOHj8gRXpL6c5bw1W1RtwvJj5WIWlY6iZAug87
 JSw/tTPO6zCFDpvu8ddTSIp34hPjTxenQc8/iGmWAk+btNy0RskmDqZ0poBBbw3f2RNvPPu
 kBKFqotedj2PGudl/rE1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:thLs0UVyfHE=:pahLy/i7bL5/JTwIjVgOPf
 5vm8R23ZVUbYnYSGZ0u6gu2OyxKP/BlaPJ2AJ3V1fxlcxig/uI+/CfPglheQRGh77Su1C38JO
 oGeLoNarlCbzgtF7UqZ87EPxKtXlsfMeuz93spksdgouAH4rGIhoKku9Jazd8tKj3bqTKC/Fl
 P6J6hPnHGCoyQHNoIY9yUM/j94SAFyxwFOi14Hj6tkOx0yapgLa17SmxEJ7tAM3rLpzHm6YZa
 nJKlaFAMEJJqzUPCz3FtNHoPmuPZMdp3EdmgNHReKlkOQaw+X5j07SAV5vtO9MSkZkaFstz4X
 SC7VMnopCICF/BC5GiG7NN2Zoo51v9jqoQb2rIndZp4z3jibRYabviEvmdCCNb989V7AMTN51
 WezeIaPK0fWjiu7rhpWNmo2efkq3fZlorDW0SBIb5LyUnTcYDc+/sjCAJ9WFXp0SlSXIywnCt
 LkgB3KqGBVWpWH1HYELq9rt8KkkQ1qNaO7eXC0lk7Q714xpuh5fNKG1lhRzLLj0rcQmV4L8/p
 XvqrcFjeDOubufMMaJiTSVmSXDHNJebhnyEbEB7YFtL1RruNvl5EH51XzoNcbhBODdYu7MDbN
 TOIgsuNF1t1DPpIinqWy8DjqvyZhw/3kZvXZgYUbf63UKbPhO9QZ6purnL8TBvUPbBpvRq9V0
 umVAlCHIH7jTcpmoFflzP6VjtLpNRoAIjI6q1L9AGp7RYukBQGKIZoYBHXp+3zVNQkCWEygVi
 tT2xLFK0h3ecD7rsPGNgh21Wu1LAx4MU84tKkRVXVwoGRm+DnVFPGS4Vkf+BT7ejwRA8KhB4P
 h7W9/NlmszcMgtWByqpBvcq/Y+Uj6QXaIkkm660NFP719GEMI8Q0jmEyyjtgI+zwwsu+4khkd
 fNjAMMLlPgGANVs6omWPjuNgfdnTbVWrt6cRS4hYuPTO4pPylk13nBAaSYuG+wR8zzjYDLxpc
 aGL+LOglNbr4Ca0TNYv0z9YFY56TTtUZwBuD8KdMhbESc0HRPTU9jT8M/PnO7D/8VTThltBpE
 hmguAhccQj03QfTSAmV50uEX4ArrnjUJWNqgRO0htZSbaatGEDa39jtzJYTE6Viip3PoRa8Yh
 /mfukXyJzT4edH6OdIbve6JVgfBi0mBnP0GeXcrcQ1X1N/O5eWiOuGIpatg5n6qqSREYJ3A80
 TjBRdA3D1o+N7H7VPit0u7nXPhJZEqCWNSHs8fEUDkteJ7q0Ioo7K8iyvSyPiLirFHvOEdQ3Q
 Pf2pjUSsR9hEeU10+rqKP+wgGp6QCDKNz+G9XRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 15:27 +0200, Michal Hocko wrote:
> On Fri 25-10-19 15:10:39, Robert Stupp wrote:
> [...]
> > cat /proc/$(pidof test)/smaps
>
> Nothing really unusual that would jump at me except for
> > 7f8be90ed000-7f8be9265000 r-xp 00025000 103:02
> > 44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
> > Size:               1504 kB
> > KernelPageSize:        4 kB
> > MMUPageSize:           4 kB
> > Rss:                 832 kB
> > Pss:                   5 kB
> > Shared_Clean:        832 kB
> > Shared_Dirty:          0 kB
> > Private_Clean:         0 kB
> > Private_Dirty:         0 kB
> > Referenced:          832 kB
> > Anonymous:             0 kB
> > LazyFree:              0 kB
> > AnonHugePages:         0 kB
> > ShmemPmdMapped:        0 kB
> > Shared_Hugetlb:        0 kB
> > Private_Hugetlb:       0 kB
> > Swap:                  0 kB
> > SwapPss:               0 kB
> > Locked:                5 kB
>
> Huh, 5kB, is this really the case or some copy&paste error?
> How can we end up with !pagesize multiple here?
>
> > THPeligible:		0
> > VmFlags: rd ex mr mw me lo sd

mlockall() seems to lock everything though, it just never returns.

Pretty sure that it's not a copy&paste error. Got a couple more runs
that have an "odd size" - this time with 3kB...
All "Locked" values seem to be okay - except that one. And it's always
odd for the same one (the one with `Size: 1504 kB`).
It's not always odd (3 kB or 5 kB) though - sometimes it says 4 kB.
Seems it's a little breadcrumb?


560429953000-560429954000 r--p 00000000 103:02
49172550                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         4 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
560429954000-560429955000 r-xp 00001000 103:02
49172550                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         4 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd ex mr mw me dw lo sd
560429955000-560429956000 r--p 00002000 103:02
49172550                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         4 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
560429956000-560429957000 r--p 00002000 103:02
49172550                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo ac sd
560429957000-560429958000 rw-p 00003000 103:02
49172550                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd wr mr mw me dw lo ac sd
5604299e7000-560429a08000 rw-p 00000000 00:00
0                          [heap]
Size:                132 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 132 kB
Pss:                 132 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:       132 kB
Referenced:          132 kB
Anonymous:           132 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:              132 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7f243057c000-7f24305a1000 r--p 00000000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                148 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 144 kB
Pss:                   0 kB
Shared_Clean:        144 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          144 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me lo sd
7f24305a1000-7f2430719000 r-xp 00025000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:               1504 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 816 kB
Pss:                   3 kB
Shared_Clean:        816 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          816 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                3 kB
THPeligible:		0
VmFlags: rd ex mr mw me lo sd
7f2430719000-7f2430763000 r--p 0019d000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                296 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 128 kB
Pss:                   0 kB
Shared_Clean:        128 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          128 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me lo sd
7f2430763000-7f2430766000 r--p 001e6000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                 12 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  12 kB
Pss:                  12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               12 kB
THPeligible:		0
VmFlags: rd mr mw me lo ac sd
7f2430766000-7f2430769000 rw-p 001e9000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                 12 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  12 kB
Pss:                  12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               12 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7f2430769000-7f243076f000 rw-p 00000000 00:00 0
Size:                 24 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  24 kB
Pss:                  24 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        24 kB
Referenced:           24 kB
Anonymous:            24 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               24 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7f243079a000-7f243079b000 r--p 00000000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   0 kB
Shared_Clean:          4 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
7f243079b000-7f24307bd000 r-xp 00001000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                136 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 136 kB
Pss:                   0 kB
Shared_Clean:        136 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          136 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd ex mr mw me dw lo sd
7f24307bd000-7f24307c5000 r--p 00023000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                 32 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  32 kB
Pss:                   0 kB
Shared_Clean:         32 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:           32 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
7f24307c6000-7f24307c7000 r--p 0002b000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo ac sd
7f24307c7000-7f24307c8000 rw-p 0002c000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd wr mr mw me dw lo ac sd
7f24307c8000-7f24307c9000 rw-p 00000000 00:00 0
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7ffe7d4d0000-7ffe7d4f2000 rw-p 00000000 00:00
0                          [stack]
Size:                136 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  20 kB
Pss:                  20 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        20 kB
Referenced:           20 kB
Anonymous:            20 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               20 kB
THPeligible:		0
VmFlags: rd wr mr mw me gd lo ac
7ffe7d502000-7ffe7d505000 r--p 00000000 00:00
0                          [vvar]
Size:                 12 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr pf io de dd sd
7ffe7d505000-7ffe7d506000 r-xp 00000000 00:00
0                          [vdso]
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   0 kB
Shared_Clean:          4 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd ex mr mw me de sd
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00
0                  [vsyscall]
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: ex


