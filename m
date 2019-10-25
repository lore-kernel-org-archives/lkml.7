Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7022CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1072084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bZB4ITvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410020AbfJYLC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:02:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:45941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407262AbfJYLC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572001345;
        bh=OCr093bxZnyjcBZ1MOYfZjEwPSzgpU9FS+pSA2OddSU=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=bZB4ITvnlPPctP5MCnpaYQtsn6GSlbHXPtA4rJWhJTg37t2b4bab5R3m7v0Ro1ZBQ
         GXpWIAOe0myx7xEL6mjCdifkEZoLxEKTRgDK2xqIp9NeplC54qntbdwi2fBfGKSV6c
         Jho4g4hYEYdwbBztmsvacHd/D8VSh7XvDcp0mC5o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([93.200.58.209]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1hlrSd1U8w-00gZlC; Fri, 25
 Oct 2019 13:02:25 +0200
Message-ID: <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, Robert Stupp <snazy@snazy.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 13:02:23 +0200
In-Reply-To: <20191025092143.GE658@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6PnFrk43bgHL0fzPRjMCdixN9CLPUvuuCvELG6smpQuAHCQVmGm
 VpnSfqhX3rOLIthD/fwtcGLIMXGrfgvTVabKE/hQXiU5c5j9UMIlfa0jMSU69TGoOtIJWfK
 JKYYvGNBo7cKyhhPpiB09aaNDhsrs7ZwguzUHa79mqGvORddPS1QQSGkWxgLGmS3LlALSyK
 ca3KS/soqD3lueUFONfqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/2Cp4tpuPp4=:CghetZamqfUrEiI/lpmwWI
 7rGefiipUCkZI+K12JrMWVhHmXd8tkg1wW8GRDNnvjBXerMDXbH1WF3gEgOnGyCYu+QjjKnwX
 /gP7axvHt+BnGy+O66HfKmqsjxzxqVmJrSU6PVcnBZ4xvGNKOiwid+V5RLTwkDMC7TXiJi0OD
 Srs0R10gi8UxEdzfzNC6VTTeY+LBhsueby8vBKbl+CkB+7K+5+c/4feTpYQn0ILWYBRmG9mol
 IZuldaHwqy1BpcScCljYfELMxslS+E3SR1jI4fwF1rXVmnQLVpF4FY4FJTHKvWQSyWnpg3Pwd
 iDYc2BnnYTPUoRQX/Zfik0ISnnM9ipeBIcGBI4e05JMthU1QU3sxPOmkRUHuyBKsWbae+pO7Q
 jv76+/gn9BIG+PtmxHv4Oe1EqTxtHrnjWnm5Z5ZSY1LXvjy3BcIFAl6DjxmuSPyicUp4kYNC+
 T/h0ifUmrQ0APpPKwB40duIgeNI9HYXNHVdsoOqDjjV6G95dJPd07Il+HyL9aPaR4xdDSzqAg
 X8PGUYorl4cKjoi6o5BF9yp7Pex5K3QMbCKuYmKb4GGCqWNVyfzSnWGoTDr7VZS8/ZnwzS/SB
 If0YKzItcSJMFf4ZwYpM6X/rHhkD/czYINRkaT3vhk/vcPWpecBdduo0g/VoFEeynUG5wDLMR
 M0BK7GBSwo1kONinW7hG2Nryk2lmlHsRgrqu4hpJEl/BxdKURQZ1UF8Ifl0mQlyrCdWVioUb6
 CeKppqyQ931KgqAqbMFDNwnkUBGVmS+tvhP2jtmHN1f4jARtWpqOQCPMKaO9GjuipfOAcSNKV
 BfBa+k3ZZLzPmeb80VePh69FS0df7SpzniU+X5YTU90kcOH4WZR4ST392A8tXu3LQ9vxrLYp7
 ZxXBhvKHBipbYybjCoeqlQN2ZLLxsReTDlk2jv1iEE4byFi8E1wjAlInzFxgb+83i0APJHaiC
 pmoF5F0sNOiFtd+aAh3gqy7SpnxHLnJiUN38SVJXgVOYr7sLNqqpiKIuJIU6ICoExOx5iY+KE
 jr7iCmetUR8imkEh6aLpKx+Olul/YUWXtnmpfj+u3SMejeR1TzvVpjX877vsHwuwu5eqe8p8q
 IhGoMtWk7rzKakxo1tdGMTwe+1h8G9VTuzV+hyQNC+CmWXu/e3TMQNoT4H34tfb9kSUqgAVdF
 88K2q/fjkCvYv2r+E5Q7HFsW4qkosWGcYPfq9368kClfLrg9cnrFnyVEOvZKJU3kaEAaJNsDp
 pw0XHa3WfENN6tH15WcQ214Xyip+2uG+FPzTAwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 11:21 +0200, Michal Hocko wrote:
> On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> > [adding linux-mm + people]
> >
> > On 10/24/19 12:36 AM, Robert Stupp wrote:
> > > Hi guys,
> > >
> > > I've got an issue with `mlockall(MCL_CURRENT)` after upgrading
> > > Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x to
> > > 5.3.x.
> > >
> > > The following simple program hangs forever with one CPU running
> > > at 100% (kernel):
>
> Can you capture everal snapshots of proc/$(pidof $YOURTASK)/stack
> while
> this is happening?

Sure,

Approach:
- one shell running
  while true; do cat /proc/$(pidof test)/stack; done
- starting ./test in another shell + ctrl-c quite some times

Vast majority of all ./test invocations return an empty 'stack' file.
Some tries, maybe 1 out of 20, returned these snapshots.
Was running 5.3.7 for this test.


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __do_fault+0x3c/0x130
[<0>] do_fault+0x248/0x640
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


// doubt this one is relevant
[<0>] __wake_up_common_lock+0x7c/0xc0
[<0>] __wake_up_sync_key+0x1e/0x30
[<0>] __wake_up_parent+0x26/0x30
[<0>] do_notify_parent+0x1cc/0x280
[<0>] do_exit+0x703/0xaf0
[<0>] do_group_exit+0x47/0xb0
[<0>] get_signal+0x165/0x880
[<0>] do_signal+0x34/0x280
[<0>] exit_to_usermode_loop+0xbf/0x160
[<0>] do_syscall_64+0x10f/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0


[<0>] __handle_mm_fault+0x4c5/0x7a0


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0xc0/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __do_fault+0x3c/0x130
[<0>] do_fault+0x248/0x640
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0xc0/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0x230/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] __handle_mm_fault+0x4c5/0x7a0
[<0>] handle_mm_fault+0xca/0x1f0
[<0>] __get_user_pages+0xc0/0x770
[<0>] populate_vma_page_range+0x74/0x80
[<0>] __mm_populate+0xb1/0x150
[<0>] __x64_sys_mlockall+0x11c/0x190
[<0>] do_syscall_64+0x5a/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



Some snippets from `dmesg`:
[    0.000000] microcode: microcode updated early to revision
0xb000038, date =3D 2019-06-18
[    0.000000] Linux version 5.3.7-050307-generic (kernel@tangerine)
(gcc version 9.2.1 20191008 (Ubuntu 9.2.1-9ubuntu2)) #201910180652 SMP
Fri Oct 18 10:56:47 UTC 2019
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.3.7-050307-
generic root=3DUUID=3D4325fe2c-ba38-4a75-b4dc-896db1796495 ro
intel_idle.max_cstate=3D0 quiet splash vt.handoff=3D7
...
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff]
usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000038d35fff]
usable
[    0.000000] BIOS-e820: [mem 0x0000000038d36000-0x0000000039a94fff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000039a95000-0x0000000039d4dfff]
usable
[    0.000000] BIOS-e820: [mem 0x0000000039d4e000-0x000000003a8fafff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003a8fb000-0x000000003b159fff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000003b15a000-0x000000003b1befff]
type 20
[    0.000000] BIOS-e820: [mem 0x000000003b1bf000-0x000000003b1bffff]
usable
[    0.000000] BIOS-e820: [mem 0x000000003b1c0000-0x000000003b245fff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000003b246000-0x000000003bffffff]
usable
[    0.000000] BIOS-e820: [mem 0x000000003c000000-0x000000003dffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x000000004fffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed44fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000010bfffffff]
usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ESRT=3D0x3b156218  ACPI=3D0x3a55e000  ACPI
2.0=3D0x3a55e000  SMBIOS=3D0xf05e0  SMBIOS 3.0=3D0x3b01e000  MPS=3D0xfca50
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: MSI MS-7A54/X99A TOMAHAWK (MS-7A54), BIOS 2.10
09/13/2016
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3199.897 MHz processor
[    0.001428] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>
reserved
[    0.001429] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001433] last_pfn =3D 0x10c0000 max_arch_pfn =3D 0x400000000
[    0.001436] MTRR default type: write-back
[    0.001437] MTRR fixed ranges enabled:
[    0.001438]   00000-9FFFF write-back
[    0.001439]   A0000-BFFFF uncachable
[    0.001439]   C0000-FFFFF write-protect
[    0.001440] MTRR variable ranges enabled:
[    0.001441]   0 base 000080000000 mask 3FFF80000000 uncachable
[    0.001441]   1 base 000040000000 mask 3FFFC0000000 uncachable
[    0.001442]   2 base 380000000000 mask 3FC000000000 uncachable
[    0.001443]   3 base 00003F000000 mask 3FFFFF000000 uncachable
[    0.001443]   4 base 0000E0000000 mask 3FFFF0000000 write-through
[    0.001444]   5 base 0000F0000000 mask 3FFFFE000000 write-through
[    0.001444]   6 disabled
[    0.001445]   7 disabled
[    0.001445]   8 disabled
[    0.001445]   9 disabled
[    0.001872] x86/PAT: Configuration [0-7]: WB  WC  UC-
UC  WB  WP  UC- WT
[    0.002037] last_pfn =3D 0x3c000 max_arch_pfn =3D 0x400000000
[    0.008082] found SMP MP-table at [mem 0x000fcd80-0x000fcd8f]
[    0.008091] esrt: Reserving ESRT space from 0x000000003b156218 to
0x000000003b156250.
[    0.008098] check: Scanning 1 areas for low memory corruption
[    0.008101] Using GB pages for direct mapping
[    0.008102] BRK [0xe77001000, 0xe77001fff] PGTABLE
[    0.008104] BRK [0xe77002000, 0xe77002fff] PGTABLE
[    0.008105] BRK [0xe77003000, 0xe77003fff] PGTABLE
[    0.008122] BRK [0xe77004000, 0xe77004fff] PGTABLE
[    0.008123] BRK [0xe77005000, 0xe77005fff] PGTABLE
[    0.008186] BRK [0xe77006000, 0xe77006fff] PGTABLE
[    0.008203] BRK [0xe77007000, 0xe77007fff] PGTABLE
[    0.008206] BRK [0xe77008000, 0xe77008fff] PGTABLE
[    0.008222] BRK [0xe77009000, 0xe77009fff] PGTABLE
[    0.008230] BRK [0xe7700a000, 0xe7700afff] PGTABLE
[    0.008265] Secure boot could not be determined
[    0.008266] RAMDISK: [mem 0x2e47c000-0x310e4fff]
[    0.008271] ACPI: Early table checksum verification disabled
[    0.008274] ACPI: RSDP 0x000000003A55E000 000024 (v02 ALASKA)
[    0.008276] ACPI: XSDT 0x000000003A55E090 0000A4 (v01 ALASKA A M
I    01072009 AMI  00010013)
[    0.008281] ACPI: FACP 0x000000003A591EB8 00010C (v05 ALASKA A M
I    01072009 AMI  00010013)
[    0.008285] ACPI: DSDT 0x000000003A55E1D0 033CE5 (v02 ALASKA A M
I    01072009 INTL 20091013)
[    0.008287] ACPI: FACS 0x000000003A8F9F80 000040
[    0.008289] ACPI: APIC 0x000000003A591FC8 000138 (v03 ALASKA A M
I    01072009 AMI  00010013)
[    0.008291] ACPI: FPDT 0x000000003A592100 000044 (v01 ALASKA A M
I    01072009 AMI  00010013)
[    0.008292] ACPI: FIDT 0x000000003A592148 00009C (v01 ALASKA A M
I    01072009 AMI  00010013)
[    0.008294] ACPI: MCFG 0x000000003A5921E8 00003C (v01 ALASKA A M
I    01072009 MSFT 00000097)
[    0.008296] ACPI: SSDT 0x000000003A592228 00036D (v01 SataRe
SataTabl 00001000 INTL 20120913)
[    0.008298] ACPI: UEFI 0x000000003A592598 000042 (v01 ALASKA A M
I    01072009      00000000)
[    0.008300] ACPI: HPET 0x000000003A5925E0 000038 (v01 ALASKA A M
I    00000001 INTL 20091013)
[    0.008302] ACPI: MSCT 0x000000003A592618 000090 (v01 ALASKA A M
I    00000001 INTL 20091013)
[    0.008304] ACPI: SLIT 0x000000003A5926A8 00002D (v01 ALASKA A M
I    00000001 INTL 20091013)
[    0.008306] ACPI: SRAT 0x000000003A5926D8 001158 (v03 ALASKA A M
I    00000001 INTL 20091013)
[    0.008308] ACPI: WDDT 0x000000003A593830 000040 (v01 ALASKA A M
I    00000000 INTL 20091013)
[    0.008310] ACPI: SSDT 0x000000003A593870 015307 (v02 ALASKA
PmMgt    00000001 INTL 20120913)
[    0.008312] ACPI: NITR 0x000000003A5A8B78 000071 (v02 ALASKA A M
I    00000001 INTL 20091013)
[    0.008314] ACPI: DMAR 0x000000003A5A8BF0 0000E4 (v01 ALASKA A M
I    00000001 INTL 20091013)
[    0.008316] ACPI: ASF! 0x000000003A5A8CD8 0000A0 (v32
INTEL   HCG     00000001 TFSM 000F4240)
[    0.008322] ACPI: Local APIC address 0xfee00000
[    0.008345] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.008345] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.008345] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.008346] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.008346] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.008347] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.008347] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.008347] SRAT: PXM 0 -> APIC 0x0e -> Node 0
[    0.008348] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.008348] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.008349] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.008349] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.008349] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.008350] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.008350] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.008350] SRAT: PXM 0 -> APIC 0x0f -> Node 0
[    0.008357] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x3fffffff]
[    0.008357] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x10bfffffff]
[    0.008362] NUMA: Initialized distance table, cnt=3D1
[    0.008363] NUMA: Node 0 [mem 0x00000000-0x3fffffff] + [mem
0x100000000-0x10bfffffff] -> [mem 0x00000000-0x10bfffffff]
[    0.008370] NODE_DATA(0) allocated [mem 0x10bffd4000-0x10bfffefff]
[    0.008559] Zone ranges:
[    0.008560]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008561]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008562]   Normal   [mem 0x0000000100000000-0x00000010bfffffff]
[    0.008563]   Device   empty
[    0.008563] Movable zone start for each node
[    0.008566] Early memory node ranges
[    0.008566]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.008567]   node   0: [mem 0x0000000000100000-0x0000000038d35fff]
[    0.008568]   node   0: [mem 0x0000000039a95000-0x0000000039d4dfff]
[    0.008568]   node   0: [mem 0x000000003b1bf000-0x000000003b1bffff]
[    0.008568]   node   0: [mem 0x000000003b246000-0x000000003bffffff]
[    0.008569]   node   0: [mem 0x0000000100000000-0x00000010bfffffff]
[    0.008788] Zeroed struct page in unavailable ranges: 25271 pages
[    0.008789] Initmem setup node 0 [mem 0x0000000000001000-
0x00000010bfffffff]
[    0.008790] On node 0 totalpages: 16751945
[    0.008791]   DMA zone: 64 pages used for memmap
[    0.008791]   DMA zone: 25 pages reserved
[    0.008792]   DMA zone: 3999 pages, LIFO batch:0
[    0.008833]   DMA32 zone: 3639 pages used for memmap
[    0.008834]   DMA32 zone: 232874 pages, LIFO batch:63
[    0.014058]   Normal zone: 258048 pages used for memmap
[    0.014058]   Normal zone: 16515072 pages, LIFO batch:63
[    0.168284] ACPI: PM-Timer IO Port: 0x408
[    0.168286] ACPI: Local APIC address 0xfee00000
[    0.168293] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.168293] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.168294] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.168294] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.168295] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.168295] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.168295] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.168296] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.168296] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.168297] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.168297] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.168297] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.168298] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.168298] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.168298] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.168299] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.168309] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000,
GSI 0-23
[    0.168313] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000,
GSI 24-47
[    0.168314] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.168315] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
level)
[    0.168316] ACPI: IRQ0 used by override.
[    0.168317] ACPI: IRQ9 used by override.
[    0.168319] Using ACPI (MADT) for SMP configuration information
[    0.168320] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.168322] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.168334] PM: Registered nosave memory: [mem 0x00000000-
0x00000fff]
[    0.168335] PM: Registered nosave memory: [mem 0x000a0000-
0x000fffff]
[    0.168336] PM: Registered nosave memory: [mem 0x38d36000-
0x39a94fff]
[    0.168337] PM: Registered nosave memory: [mem 0x39d4e000-
0x3a8fafff]
[    0.168337] PM: Registered nosave memory: [mem 0x3a8fb000-
0x3b159fff]
[    0.168338] PM: Registered nosave memory: [mem 0x3b15a000-
0x3b1befff]
[    0.168339] PM: Registered nosave memory: [mem 0x3b1c0000-
0x3b245fff]
[    0.168340] PM: Registered nosave memory: [mem 0x3c000000-
0x3dffffff]
[    0.168340] PM: Registered nosave memory: [mem 0x3e000000-
0x3fffffff]
[    0.168341] PM: Registered nosave memory: [mem 0x40000000-
0x4fffffff]
[    0.168341] PM: Registered nosave memory: [mem 0x50000000-
0xfed1bfff]
[    0.168341] PM: Registered nosave memory: [mem 0xfed1c000-
0xfed44fff]
[    0.168342] PM: Registered nosave memory: [mem 0xfed45000-
0xfeffffff]
[    0.168342] PM: Registered nosave memory: [mem 0xff000000-
0xffffffff]
[    0.168344] [mem 0x50000000-0xfed1bfff] available for PCI devices
[    0.168345] Booting paravirtualized kernel on bare hardware
[    0.168347] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.168352] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16
nr_cpu_ids:16 nr_node_ids:1
[    0.168718] percpu: Embedded 54 pages/cpu s184320 r8192 d28672
u262144
[    0.168724] pcpu-alloc: s184320 r8192 d28672 u262144 alloc=3D1*2097152
[    0.168724] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11
12 13 14 15
[    0.168747] Built 1 zonelists, mobility grouping on.  Total pages:
16490169
[    0.168748] Policy zone: Normal
[    0.168749] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-5.3.7-
050307-generic root=3DUUID=3D4325fe2c-ba38-4a75-b4dc-896db1796495 ro
intel_idle.max_cstate=3D0 quiet splash vt.handoff=3D7
[    0.172892] Dentry cache hash table entries: 8388608 (order: 14,
67108864 bytes, linear)
[    0.175045] Inode-cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.175154] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.179532] Calgary: detecting Calgary via BIOS EBDA area
[    0.179533] Calgary: Unable to locate Rio Grande table in EBDA -
bailing!
[    0.318204] Memory: 65577656K/67007780K available (14339K kernel
code, 2387K rwdata, 4700K rodata, 2664K init, 5060K bss, 1430124K
reserved, 0K cma-reserved)
[    0.318334] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16,
Nodes=3D1
[    0.318344] Kernel/User page tables isolation: enabled
[    0.318357] ftrace: allocating 43143 entries in 169 pages
[    0.330881] rcu: Hierarchical RCU implementation.
[    0.330883] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to
nr_cpu_ids=3D16.
[    0.330883] 	Tasks RCU enabled.
[    0.330884] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.330884] rcu: Adjusting geometry for rcu_fanout_leaf=3D16,
nr_cpu_ids=3D16
[    0.333275] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
[    0.333488] random: crng done (trusting CPU's manufacturer)
[    0.333512] Console: colour dummy device 80x25
[    0.333516] printk: console [tty0] enabled
[    0.333530] ACPI: Core revision 20190703
[    0.333738] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484882848 ns
[    0.333747] APIC: Switch to symmetric I/O mode setup
[    0.333748] DMAR: Host address width 46
[    0.333748] DMAR: DRHD base: 0x000000fbffd000 flags: 0x0
[    0.333752] DMAR: dmar0: reg_base_addr fbffd000 ver 1:0 cap
8d2008c10ef0466 ecap f0205b
[    0.333753] DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
[    0.333755] DMAR: dmar1: reg_base_addr fbffc000 ver 1:0 cap
8d2078c106f0466 ecap f020df
[    0.333756] DMAR: RMRR base: 0x0000003b030000 end: 0x0000003b03ffff
[    0.333757] DMAR: ATSR flags: 0x0
[    0.333757] DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x0
[    0.333759] DMAR-IR: IOAPIC id 1 under DRHD base  0xfbffc000 IOMMU 1
[    0.333759] DMAR-IR: IOAPIC id 2 under DRHD base  0xfbffc000 IOMMU 1
[    0.333760] DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
[    0.333760] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt
out bit.
[    0.333760] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the
BIOS setting.
[    0.334167] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.334168] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.334171] Switched APIC routing to physical flat.
[    0.334649] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
[    0.353749] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2e1fe890e9e, max_idle_ns: 440795268505 ns
[    0.353751] Calibrating delay loop (skipped), value calculated using
timer frequency.. 6399.79 BogoMIPS (lpj=3D12799588)
[    0.353752] pid_max: default: 32768 minimum: 301
[    0.356787] LSM: Security Framework initializing
[    0.356795] Yama: becoming mindful.
[    0.356848] AppArmor: AppArmor initialized
[    0.356976] Mount-cache hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.357078] Mountpoint-cache hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.357204] *** VALIDATE proc ***
[    0.357244] *** VALIDATE cgroup1 ***
[    0.357245] *** VALIDATE cgroup2 ***
[    0.357297] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.357334] process: using mwait in idle threads
[    0.357336] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.357337] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.357338] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.357340] Spectre V2 : Mitigation: Full generic retpoline
[    0.357340] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
RSB on context switch
[    0.357341] Spectre V2 : Enabling Restricted Speculation for
firmware calls
[    0.357342] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.357342] Spectre V2 : User space: Mitigation: STIBP via seccomp
and prctl
[    0.357343] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.357345] MDS: Mitigation: Clear CPU buffers
[    0.357526] Freeing SMP alternatives memory: 36K
[    0.361805] TSC deadline timer enabled
[    0.361806] smpboot: CPU0: Intel(R) Core(TM) i7-6900K CPU @ 3.20GHz
(family: 0x6, model: 0x4f, stepping: 0x1)
[    0.361888] Performance Events: PEBS fmt2+, Broadwell events, 16-
deep LBR, full-width counters, Intel PMU driver.
[    0.361893] ... version:                3
[    0.361893] ... bit width:              48
[    0.361894] ... generic registers:      4
[    0.361894] ... value mask:             0000ffffffffffff
[    0.361895] ... max period:             00007fffffffffff
[    0.361895] ... fixed-purpose events:   3
[    0.361895] ... event mask:             000000070000000f
[    0.361921] rcu: Hierarchical SRCU implementation.
[    0.363125] NMI watchdog: Enabled. Permanently consumes one hw-PMU
counter.
[    0.363220] smp: Bringing up secondary CPUs ...
[    0.363284] x86: Booting SMP configuration:
[    0.363284] .... node  #0,
CPUs:        #1  #2  #3  #4  #5  #6  #7  #8
[    0.381823] MDS CPU bug present and SMT on, data leak possible. See
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for
more details.
[    0.381856]   #9 #10 #11 #12 #13 #14 #15
[    0.386438] smp: Brought up 1 node, 16 CPUs
[    0.386438] smpboot: Max logical packages: 1
[    0.386438] smpboot: Total of 16 processors activated (102396.70
BogoMIPS)
[    0.390924] devtmpfs: initialized
[    0.390924] x86/mm: Memory block size: 1024MB
[    0.390924] PM: Registering ACPI NVS region [mem 0x39d4e000-
0x3a8fafff] (12242944 bytes)
[    0.390924] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.390924] futex hash table entries: 4096 (order: 6, 262144 bytes,
linear)
[    0.390924] pinctrl core: initialized pinctrl subsystem
[    0.390924] PM: RTC time: 08:17:57, date: 2019-10-25
[    0.390924] NET: Registered protocol family 16
[    0.390924] audit: initializing netlink subsys (disabled)
[    0.390924] audit: type=3D2000 audit(1571991477.056:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.390924] EISA bus registered
[    0.390924] cpuidle: using governor ladder
[    0.390924] cpuidle: using governor menu
[    0.390924] ACPI FADT declares the system doesn't support PCIe ASPM,
so disable it
[    0.390924] ACPI: bus type PCI registered
[    0.390924] acpiphp: ACPI Hot Plug PCI Controller Driver version:
0.5
[    0.390924] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0x40000000-0x4fffffff] (base 0x40000000)
[    0.390924] PCI: MMCONFIG at [mem 0x40000000-0x4fffffff] reserved in
E820
[    0.390924] PCI: Using configuration type 1 for base access
[    0.393952] HugeTLB registered 1.00 GiB page size, pre-allocated 0
pages
[    0.393952] HugeTLB registered 2.00 MiB page size, pre-allocated 0
pages
[    0.393952] ACPI: Added _OSI(Module Device)
[    0.393952] ACPI: Added _OSI(Processor Device)
[    0.393952] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.393952] ACPI: Added _OSI(Processor Aggregator Device)
[    0.393952] ACPI: Added _OSI(Linux-Dell-Video)
[    0.393952] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.393952] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.444579] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.448501] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.451495] ACPI: Dynamic OEM Table Load:
[    0.478469] ACPI: Interpreter enabled
[    0.478482] ACPI: (supports S0 S3 S4 S5)
[    0.478483] ACPI: Using IOAPIC for interrupt routing
[    0.478509] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.479312] ACPI: Enabled 4 GPEs in block 00 to 3F
[    0.514946] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    0.514949] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.517147] acpi PNP0A03:03: _OSC: platform does not support
[SHPCHotplug PME AER LTR]
[    0.518203] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug
PCIeCapability]
[    0.518204] acpi PNP0A03:03: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.518234] PCI host bridge to bus 0000:ff
...


