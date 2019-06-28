Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52B208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfF1TbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:31:10 -0400
Received: from cmta16.telus.net ([209.171.16.89]:36398 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfF1TbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:31:09 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 15:31:08 EDT
Received: from [192.168.20.125] ([198.166.38.237])
        by cmsmtp with SMTP
        id gwSYh8IFeJEJsgwSZhVPA1; Fri, 28 Jun 2019 13:23:00 -0600
X-Telus-Authed: Z2lsbGI0
X-Authority-Analysis: v=2.3 cv=S/CnP7kP c=1 sm=1 tr=0
 a=QfZzCQsbt0HVy7a44IFCgA==:117 a=QfZzCQsbt0HVy7a44IFCgA==:17
 a=IkcTkHD0fZMA:10 a=6kz4nMx4ya8eIV57nl0A:9 a=QEXdDO2ut3YA:10
To:     linux-kernel@vger.kernel.org
From:   bob <gillb4@telusplanet.net>
Subject: NFS oops
Message-ID: <a4aa70ec-d17a-b5ab-035b-92ff38788017@telusplanet.net>
Date:   Fri, 28 Jun 2019 13:22:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfCUiWi1FC0kG3rA7wKJxkrO+QiFphhOmF5+RXFO6Ujz4h6Nc0/QOixwabT2FNs/4idDjAnADlKxb26vkkORjSlHpaPERLCRnqGerf1uP3BCe0hOl9Xdg
 fy6/WWnySbtajobl6MFm7Uf50geMQqWXZ5eF9eRBTiS+zGEiZwq09jD6bGJFB0IO05BPwWjlPV0LDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I know that NFS is undergoing continuing changes and updates and 
don't know if

the oops I'm getting is already on someones todo list.  I run a database 
archive then

  push to a nas box via nfs.  It looks like most of the data arrives, 
but then the file transfer fails to end.

It initially ends like this:

nfs: server 192.168.20.114 not responding, still trying

And then becomes this:

[ 5801.324005] INFO: task cp:5368 blocked for more than 1208 seconds.
[ 5801.324011]       Tainted: G          I       5.2.0-rc6 #1
[ 5801.324013] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 5801.324015] cp              D    0  5368   5095 0x00004000
[ 5801.324019] Call Trace:
[ 5801.324030]  ? __schedule+0x284/0x660
[ 5801.324033]  schedule+0x29/0x90
[ 5801.324037]  io_schedule+0x12/0x40
[ 5801.324041]  wait_on_page_bit+0x10e/0x1c0
[ 5801.324044]  ? file_fdatawait_range+0x20/0x20
[ 5801.324047]  __filemap_fdatawait_range+0x8b/0xf0
[ 5801.324050]  filemap_write_and_wait+0x42/0x70
[ 5801.324072]  nfs_wb_all+0x1a/0x120 [nfs]
[ 5801.324076]  filp_close+0x2a/0x70
[ 5801.324078]  __x64_sys_close+0x1e/0x50
[ 5801.324081]  do_syscall_64+0x4f/0x130
[ 5801.324085]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5801.324088] RIP: 0033:0x7efcd8e908d4
[ 5801.324094] Code: Bad RIP value.
[ 5801.324095] RSP: 002b:00007ffdfc946108 EFLAGS: 00000246 ORIG_RAX: 
0000000000000003
[ 5801.324097] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007efcd8e908d4
[ 5801.324098] RDX: 0000000000020000 RSI: 00007efcd99ac000 RDI: 
0000000000000004
[ 5801.324100] RBP: 00007ffdfc9464e0 R08: 0000000000020000 R09: 
0000000000000001
[ 5801.324101] R10: 0000000000020000 R11: 0000000000000246 R12: 
00007ffdfc9466b0
[ 5801.324102] R13: 0000000000000000 R14: 00007ffdfc946600 R15: 
00007ffdfc9482df

...and the oops repeats

I'm running kernel Linux freedom 5.2.0-rc6 #1 SMP Sun Jun 23 18:31:56 
MDT 2019 x86_64 x86_64 x86_64 GNU/Linux

If you need more info, please reply to me directly as I'm not on the list,

Thanks,

Bob

