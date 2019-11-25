Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23899C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 21:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C3820706
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 21:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKYVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:46:35 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:50933 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfKYVqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 16:46:35 -0500
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 16:46:33 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 47MKvr2g9lzDkf
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 16:30:48 -0500 (EST)
Received: from hp-x360n (50-76-61-131-ip-static.hfc.comcastbusiness.net [50.76.61.131])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MKvq2mkdz1tRQ;
        Mon, 25 Nov 2019 16:30:47 -0500 (EST)
Date:   Mon, 25 Nov 2019 13:30:45 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org
Subject: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in fdget_pos()")
 breaking userspace
Message-ID: <alpine.DEB.2.21.1911251322160.2408@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FYI. Don't know if the fault lies with these subsystems or not, but I know
it's been a goal to keep things working. In both cases, reverting this commit
fixes both these issues. If you need additional information from me, please
let me know.

First issue manifests itself as a timeout in KDE's upower daemon:

----
Nov 25 13:18:51 hp-x360n systemd[1]: upower.service: Start operation timed out. Terminating.
Nov 25 13:18:51 hp-x360n systemd[1]: upower.service: Main process exited, code=killed, status=15/TERM
Nov 25 13:18:51 hp-x360n systemd[1]: upower.service: Failed with result 'timeout'.
Nov 25 13:18:51 hp-x360n systemd[1]: Failed to start Daemon for power management.
Nov 25 13:18:51 hp-x360n systemd[1]: upower.service: Service RestartSec=100ms expired, scheduling restart.
Nov 25 13:18:51 hp-x360n systemd[1]: upower.service: Scheduled restart job, restart counter is at 9.
Nov 25 13:18:51 hp-x360n systemd[1]: Stopped Daemon for power management.
Nov 25 13:18:51 hp-x360n systemd[1]: Starting Daemon for power management...
----

Second issue:

----
Nov 25 13:19:22 hp-x360n kernel: [  861.213047] INFO: task vmware-vmblock-:1179 blocked for more than 737 seconds.
Nov 25 13:19:22 hp-x360n kernel: [  861.213053]       Tainted: G     U            5.4.0-Kenny+ #8
Nov 25 13:19:22 hp-x360n kernel: [  861.213054] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Nov 25 13:19:22 hp-x360n kernel: [  861.213056] vmware-vmblock- D    0  1179      1 0x00000000
Nov 25 13:19:22 hp-x360n kernel: [  861.213060] Call Trace:
Nov 25 13:19:22 hp-x360n kernel: [  861.213068]  ? __schedule+0x2b8/0x580
Nov 25 13:19:22 hp-x360n kernel: [  861.213071]  schedule+0x36/0xc0
Nov 25 13:19:22 hp-x360n kernel: [  861.213074]  schedule_preempt_disabled+0x11/0x20
Nov 25 13:19:22 hp-x360n kernel: [  861.213077]  __mutex_lock.isra.11+0x2f0/0x500
Nov 25 13:19:22 hp-x360n kernel: [  861.213082]  __fdget_pos+0x42/0x50
Nov 25 13:19:22 hp-x360n kernel: [  861.213085]  do_writev+0x2f/0x110
Nov 25 13:19:22 hp-x360n kernel: [  861.213088]  do_syscall_64+0x46/0x170
Nov 25 13:19:22 hp-x360n kernel: [  861.213091]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov 25 13:19:22 hp-x360n kernel: [  861.213094] RIP: 0033:0x7f4c6da1d527
Nov 25 13:19:22 hp-x360n kernel: [  861.213098] Code: Bad RIP value.
Nov 25 13:19:22 hp-x360n kernel: [  861.213100] RSP: 002b:00007f4c6d6aebc0 EFLAGS: 00000297 ORIG_RAX: 0000000000000014
Nov 25 13:19:22 hp-x360n kernel: [  861.213102] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4c6da1d527
Nov 25 13:19:22 hp-x360n kernel: [  861.213103] RDX: 0000000000000002 RSI: 00007f4c6d6aec50 RDI: 0000000000000003
Nov 25 13:19:22 hp-x360n kernel: [  861.213104] RBP: 00007f4c6d6aec50 R08: 0000000000000001 R09: 00007f4c6ce8c700
Nov 25 13:19:22 hp-x360n kernel: [  861.213106] R10: 00007f4c68000080 R11: 0000000000000297 R12: 0000000000000002
Nov 25 13:19:22 hp-x360n kernel: [  861.213107] R13: 0000000000020000 R14: 0000000000000000 R15: 0000000000000000
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
