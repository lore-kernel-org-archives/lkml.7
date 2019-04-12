Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A779C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AAA2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDLUEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:04:09 -0400
Received: from cmta19.telus.net ([209.171.16.92]:50387 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLUEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:04:09 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Apr 2019 16:04:07 EDT
Received: from [192.168.20.125] ([104.205.129.92])
        by cmsmtp with SMTP
        id F2HEhPdp7eRl4F2HGhjg8e; Fri, 12 Apr 2019 13:55:58 -0600
X-Telus-Authed: Z2lsbGI0
X-Authority-Analysis: v=2.3 cv=KqozJleN c=1 sm=1 tr=0
 a=HQkQS0yAlVTwKcL7QnORLw==:117 a=HQkQS0yAlVTwKcL7QnORLw==:17
 a=IkcTkHD0fZMA:10 a=JC7Z3Rs-Ch_znha2JcQA:9 a=QEXdDO2ut3YA:10
To:     linux-kernel@vger.kernel.org
From:   bob <gillb4@telusplanet.net>
Subject: NFS won't finish
Message-ID: <a08ed1ef-4c1b-cbb1-d24a-73e471f6144b@telusplanet.net>
Date:   Fri, 12 Apr 2019 13:55:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfEDlufh81R58HY84I3dztwvG8gZPRy7jmioFAIU4xYmlJIiM6exHDVwnbue3au+tv4dou7Sw3MK5D5SBcUSElGNMX+HJ/5q/rrtOsbb57b7wxxM2joJv
 DXZhdZpqfEJpQjBydOS8VZxQs607yccOH4kRzsXlaOj5Su5/NR+lCunNhk+M6Bf/NFuH3oOGk1+3tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: Linux freedom 5.1.0-rc4 #1 SMP Sun Apr 7 18:50:31 MDT 2019 
x86_64 x86_64 x86_64 GNU/Linux

Sending large files to NAS box via NFS failed (It looks like files are 
getting transferred, but NFS

gets stuck/won't finish.

Note:
1. NFS works ok with kernel 5.0.0

2. To test NFS, (using the5.1.0-rc4 kernel), I connected to my NAS box 
and moved a small log file
    (less that 20kB)  and it moved from computer to NAS without problem.
    I then deleted the small log file from the NAS box, again without 
problem.
    (connected via NFS).
    I then copied a database archive (24929 bytes) from NAS box to computer,
    again without fail.  But today I moved 3 large tarball/archives from
    computer to NAS box (TX:   cum:   8.50GB), and it seems
    to have moved OK, but NFS does not want to complete the transfer.
    I can't get a directory listing from where I started the copy, and
    the process queue shows:

root      6176  0.0  0.0  20824  2504 pts/5    D+   10:28   0:11 cp 
site.Apr-05-2019.tgz site.Apr-12-2019.tgz site.Mar-29-2019.tgz 
nas/website/BACKUP/2019.04.12

DMESG:

perf: interrupt took too long (2694 > 2500), lowering 
kernel.perf_event_max_sample_rate to 74250
[ 1644.507579] perf: interrupt took too long (3369 > 3367), lowering 
kernel.perf_event_max_sample_rate to 59250
[ 2349.205399] FS-Cache: Loaded
[ 2349.348842] FS-Cache: Netfs 'nfs' registered for caching
[ 2349.652305] NFS: Registering the id_resolver key type
[ 2349.652316] Key type id_resolver registered
[ 2349.652317] Key type id_legacy registered
[ 3595.680685] nfs: server 192.168.20.114 not responding, still trying
[ 3595.680692] nfs: server 192.168.20.114 not responding, still trying
[ 3595.680695] nfs: server 192.168.20.114 not responding, still trying
[ 3626.400412] INFO: task cp:6176 blocked for more than 120 seconds.
[ 3626.400418]       Tainted: G          I       5.1.0-rc4 #1
[ 3626.400419] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 3626.400422] cp              D    0  6176   5890 0x00000000
[ 3626.400425] Call Trace:
[ 3626.400434]  ? __schedule+0x2a1/0x870
[ 3626.400436]  schedule+0x28/0x70
[ 3626.400440]  io_schedule+0x12/0x40
[ 3626.400443]  wait_on_page_bit_common+0x10a/0x280
[ 3626.400447]  ? file_check_and_advance_wb_err+0xc0/0xc0
[ 3626.400450]  __filemap_fdatawait_range+0xd8/0x140
[ 3626.400453]  filemap_write_and_wait_range+0x3b/0x70
[ 3626.400471]  nfs_file_fsync+0x44/0x1f0 [nfs]
[ 3626.400474]  filp_close+0x2a/0x70
[ 3626.400475]  __x64_sys_close+0x1e/0x50
[ 3626.400477]  do_syscall_64+0x4f/0x100
[ 3626.400479]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3626.400481] RIP: 0033:0x7f6be90958d4
[ 3626.400485] Code: Bad RIP value.
[ 3626.400486] RSP: 002b:00007ffe07ec4398 EFLAGS: 00000246 ORIG_RAX: 
0000000000000003
[ 3626.400487] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f6be90958d4
[ 3626.400488] RDX: 0000000000020000 RSI: 000055b82b141000 RDI: 
0000000000000004
[ 3626.400488] RBP: 00007ffe07ec4770 R08: 0000000000020000 R09: 
0000000000000001
[ 3626.400489] R10: 0000000000020000 R11: 0000000000000246 R12: 
00007ffe07ec4970
[ 3626.400490] R13: 0000000000000000 R14: 00007ffe07ec4900 R15: 
00007ffe07ec52db
[ 3747.231331] INFO: task cp:6176 blocked for more than 241 seconds.
[ 3747.231337]       Tainted: G          I       5.1.0-rc4 #1
[ 3747.231339] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.

According to NTOP, it looks like data was transferred:

TX:             cum:   8.50GB   peak:    208b   rates: 0b      0b     18b

My Hardware:

04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8056 PCI-E 
Gigabit Ethernet Controller (rev 12)
         Subsystem: ASUSTeK Computer Inc. Motherboard
         Flags: bus master, fast devsel, latency 0, IRQ 26
         Memory at fb9fc000 (64-bit, non-prefetchable) [size=16K]
         I/O ports at b800 [size=256]
         Expansion ROM at fb9c0000 [disabled] [size=128K]
         Capabilities: <access denied>
         Kernel driver in use: sky2
         Kernel modules: sky2

06:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8056 PCI-E 
Gigabit Ethernet Controller (rev 12)
         Subsystem: ASUSTeK Computer Inc. Motherboard
         Flags: bus master, fast devsel, latency 0, IRQ 25
         Memory at fbbfc000 (64-bit, non-prefetchable) [size=16K]
         I/O ports at d800 [size=256]
         Expansion ROM at fbbc0000 [disabled] [size=128K]
         Capabilities: <access denied>
         Kernel driver in use: sky2
         Kernel modules: sky2

Drivers:

lsmod | grep nfs yields:
nfsv3                  53248  1
nfsv4                 692224  0
nfs                   315392  3 nfsv4,nfsv3
fscache               380928  2 nfsv4,nfs
nfsd                  413696  13
auth_rpcgss           102400  2 nfsd,rpcsec_gss_krb5
nfs_acl                16384  2 nfsd,nfsv3
lockd                 106496  3 nfsd,nfsv3,nfs
grace                  16384  2 nfsd,lockd
sunrpc                438272  28 
nfsd,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs


I can ftp to the NAS box and see that two of the three files completed:-

rw-r--r--    1 0          0          5027646357 Apr 12 10:31 
site.Apr-05-2019.tgz
-rw-r--r--    1 0          0          5152017050 Apr 12 10:34 
site.Apr-12-2019.tgz


Sorry for the long post, but I wanted to be complete.  Perhaps its a 
corner case.  I'm fairly certain the

NAS machine is using the ext4 filesystem and I don't think its a 
filesystem size limit.

Thanks in advance, please email me directly as I am not on the list,

Bob








