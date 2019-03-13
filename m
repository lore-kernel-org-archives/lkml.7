Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50739C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D452070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCMGp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfCMGp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:45:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7252CACAE;
        Wed, 13 Mar 2019 06:45:57 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 0A2BEE0090; Wed, 13 Mar 2019 07:45:57 +0100 (CET)
Date:   Wed, 13 Mar 2019 07:45:57 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: regression (bisected): "modprobe parport_pc" hangs in current
 mainline
Message-ID: <20190313064557.GA14531@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I encountered a regression in current (post-5.0) mainline kernel which I
bisected to commit 1aec4211204d ("parport: daisy: use new parport device
model"). Running "modprobe parport_pc" hangs up:

tweed:~ # ps ax | grep modprobe
 1206 pts/0    D+     0:00 modprobe parport_pc
 1209 ?        S      0:00 /sbin/modprobe -q -- parport_lowlevel
 1211 pts/1    S+     0:00 grep modprobe
tweed:~ # cat /proc/1206/stack 
[<0>] call_usermodehelper_exec+0xc7/0x140
[<0>] __request_module+0x1a1/0x430
[<0>] __parport_register_driver+0x142/0x150 [parport]
[<0>] parport_bus_init+0x1d/0x30 [parport]
[<0>] parport_default_proc_register+0x28/0x1000 [parport]
[<0>] do_one_initcall+0x46/0x1cd
[<0>] do_init_module+0x5b/0x20d
[<0>] load_module+0x1b3d/0x20f0
[<0>] __do_sys_finit_module+0xbd/0xe0
[<0>] do_syscall_64+0x60/0x120
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[<0>] 0xffffffffffffffff
tweed:~ # cat /proc/1209/stack 
[<0>] load_module+0xe6a/0x20f0
[<0>] __do_sys_finit_module+0xbd/0xe0
[<0>] do_syscall_64+0x60/0x120
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[<0>] 0xffffffffffffffff

call_usermodehelper_exec+0xc7/0x140 is (build from commit 1aec4211204d)
line 583 in kernel/umh.c:

		retval = wait_for_completion_killable(&done);

and load_module+0xe6a/0x20f0 is in add_unformed_module(), line 3577 in
kernel/module.c:

			err = wait_event_interruptible(module_wq,
					       finished_loading(mod->name));

Unfortunately I don't have version of crash able to deal with kernels as
new as these so I wasn't able to find more for now.

I have seen this both on real hardware and in a VM.

Michal Kubecek
