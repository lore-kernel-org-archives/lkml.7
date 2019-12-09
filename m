Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E51C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4CA2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=datto.com header.i=@datto.com header.b="B/iGffQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLIT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:59:25 -0500
Received: from us-smtp-delivery-195.mimecast.com ([216.205.24.195]:21208 "EHLO
        us-smtp-delivery-195.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfLIT7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:59:25 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Dec 2019 14:59:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datto.com;
        s=mimecast20190208; t=1575921563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GXbJQO11/TWae0ryVXOITy0cOIXqpDwu47mOcppG8Fo=;
        b=B/iGffQ+fb4S0g6Hv/zvitIEUrVSR9tZQX0ZOd35bU/WYgTCjkC47yP1rVJ3iN+CthC8B8
        Gf3csAV34m+LHBmU22L8Ycuhp9YjdedjCDz1sxt/ZSSvikHjpu9EgNb1HxODYDSAG7KaqT
        IgVyt81pT1UF/7GJrDMq+S19GjvtmkA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-y2NRlfuvNOupGhPDsJL0fA-1; Mon, 09 Dec 2019 14:53:15 -0500
Received: by mail-qt1-f200.google.com with SMTP id r9so240578qtc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=ajn0KC5RaqzYgaWbgkt2HTHeOvum5iKT1iwYlkTbgOk=;
        b=TqKf0V1PIEUwTt2wAijNC4wHjtrH7fw60tux6Kw6MvCXYAtauAroslh40n1IAYKfRj
         TDfVD12mG18LNE/DbK74AhZzKg8yXnC8QsJNa9o+ReOqOSuxDtI94Obg1WGd4bgt1I1i
         v3P4LcMpNKYNpNuMiyT2pYkefkij9e/MjQ2a1J0kHUWsN248SWau1vI9Q2K1sD5tNlkd
         vwhHsKNTFdjJpZTM2cY4mnuka3lUafqv4eJvmTJK7c0pzITYGBCv7kGQYCgw92Oqnwuc
         jmttihNiDTvFhpGp+PfScrVSiHSZBmtXt/aG/RdUM7hIqc8DdicS2+nhoVSVDxbtR4tg
         XDuA==
X-Gm-Message-State: APjAAAVEe8QffPmrvOvIEsS1qGpNYXIbXuS0kbfWK/pUnGBIRkVeVGJq
        DANEbNCln5TEKuB6JSTe81Dyh0QVhOZ0i6pbl1qkdNKgYzQBKFxaEg/CsjZ1Mpd7JjcKnxh6EqI
        thsSyU+LyNQZjK2dSYSScL+PD
X-Received: by 2002:a0c:e2cf:: with SMTP id t15mr25929800qvl.127.1575921194424;
        Mon, 09 Dec 2019 11:53:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuwxMCqKVwAITnRfTGiX20qv2FCFHxHhAulfQsRAyxcePfy9h9DQlMPBwimGb8ZTTXJ5O9Ow==
X-Received: by 2002:a0c:e2cf:: with SMTP id t15mr25929767qvl.127.1575921193897;
        Mon, 09 Dec 2019 11:53:13 -0800 (PST)
Received: from scofield.datto.lan ([47.19.105.250])
        by smtp.gmail.com with ESMTPSA id c3sm179203qkk.8.2019.12.09.11.53.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:53:13 -0800 (PST)
From:   Matt Coleman <mcoleman@datto.com>
X-Mao-Original-Outgoing-Id: 597613992.521252-30e863ea15e17e9f08f993d4a603c344
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: target/iscsi: dangling reference preventing tpg_np completion
Message-Id: <12137728-4E94-4B56-8E3D-122D7C498077@datto.com>
Date:   Mon, 9 Dec 2019 14:53:12 -0500
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-MC-Unique: y2NRlfuvNOupGhPDsJL0fA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is my first post to LKML. I'm not subscribed to the mailing list, so p=
lease CC me on any responses. I posted an earlier version of this bug repor=
t to the target-devel mailing list, but have not gotten any responses there=
 (https://www.spinics.net/lists/target-devel/msg17905.html).

We're migrating from ietd to LIO & targetcli and have experienced targetcli=
 processes stacking up in uninterruptible sleep. Here are some details abou=
t the platform:
- Ubuntu 16.04
- kernel 4.15.0-64-generic (package linux-image-4.15.0-64-generic version 4=
.15.0-64.73~16.04.1)
- targetcli-fb 2.1.fb43
- python3-rtslib-fb 2.1.fb57

It does not appear to be tied to specific hardware; I've witnessed it occur=
ring on several different Intel CPU families (Celeron, Core i3, and several=
 generations of Xeon [E5620 - E5 2650 v4]) on motherboards from ASRock, ASR=
ockRack, Dell, Gigabyte, and SuperMicro with at least 8GB and up to 256GB o=
f RAM.

I haven't found a way to force the issue to happen. The systems I've observ=
ed it on all create short-lived iSCSI targets with backstores that are all =
loop devices backed by files on ZFS. Each target has a single initiator con=
nect to it, and each initiator only connects to a single target. Some of th=
e systems are creating/removing targets several dozen times per hour, and l=
ess active systems are creating/removing one or two targets per day.

When the issue occurs, targetcli/LIO interactions completely lock up: if mo=
re targetcli commands are executed, the system will eventually have 251 ins=
tances of targetcli stuck in the 'D' state, at which point DBUS refuses add=
itional connections:

root@mdcSIRIS:~# ps axo lstart,pid,stat,wchan:32,command | awk '$10=3D=3D"/=
usr/bin/targetcli" && $7~/D/ {print}' | sort -k 2.1M,4 | head -10
Mon Oct 28 00:22:42 2019  6489 D iscsit_reset_np_thread           /usr/bin/=
python3 /usr/bin/targetcli /iscsi delete iqn.2007-01.net.datto.dev.temp.mdc=
siris:agentmdc-debian7-server
Mon Oct 28 00:23:42 2019 25858 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /backstores/block delete screenshot-centos7_fb9d2=
49c-b136-4446-9340-22bc878803c0.checksum_temp
Mon Oct 28 00:24:44 2019  2755 D call_rwsem_down_write_failed     /usr/bin/=
python3 /usr/bin/targetcli /iscsi/iqn.2007-01.net.datto.dev.temp.mdcsiris:a=
gentmdc-debian7-server/tpg1/ disable
Mon Oct 28 00:25:44 2019 23585 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi delete iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentmdc-debian7-server
Mon Oct 28 00:26:44 2019  4552 D call_rwsem_down_write_failed     /usr/bin/=
python3 /usr/bin/targetcli /backstores/block delete screenshot-centos7_fb9d=
249c-b136-4446-9340-22bc878803c0.checksum_temp
Mon Oct 28 00:27:45 2019 13799 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi create iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentscreenshot-debian7
Mon Oct 28 00:28:45 2019 20693 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi/iqn.2007-01.net.datto.dev.temp.mdcsiris:ag=
entmdc-debian7-server/tpg1/ disable
Mon Oct 28 00:29:45 2019 29207 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi delete iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentmdc-debian7-server
Mon Oct 28 00:30:46 2019  7376 D call_rwsem_down_write_failed     /usr/bin/=
python3 /usr/bin/targetcli /iscsi create iqn.2007-01.net.datto.dev.temp.mdc=
siris:agentscreenshot-debian7
Mon Oct 28 00:31:46 2019 24431 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi create iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentscreenshot-ubuntu1204desktop
root@mdcSIRIS:~# ps aux | grep -c [t]argetcli
251
root@mdcSIRIS:~# targetcli
org.freedesktop.DBus.Error.LimitsExceeded: The maximum number of active con=
nections for UID 0 has been reached

The kernel crash dump for the earliest targetcli process (PID 6489) is=E2=
=80=A6

Oct 28 00:26:16 mdcSIRIS kernel: [788187.169202] INFO: task targetcli:6489 =
blocked for more than 120 seconds.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.169291]       Tainted: P OE 4.15.0=
-64-generic #73~16.04.1-Ubuntu
Oct 28 00:26:16 mdcSIRIS kernel: [788187.170914] "echo 0 > /proc/sys/kernel=
/hung_task_timeout_secs" disables this message.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172072] targetcli       D 0 6489 1=
 0x00000080
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172078] Call Trace:
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172093]  __schedule+0x3d6/0x8b0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172099]  ? wake_up_state+0x10/0x20
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172103]  schedule+0x36/0x80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172106]  schedule_timeout+0x1db/0x=
370
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172110]  ? __send_signal+0x1d4/0x4=
70
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172114]  wait_for_completion+0xb4/=
0x140
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172117]  ? wake_up_q+0x70/0x70
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172140]  iscsit_reset_np_thread+0x=
a4/0xe0 [iscsi_target_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172155]  iscsit_tpg_del_network_po=
rtal+0xf9/0x1e0 [iscsi_target_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172168]  lio_target_call_delnpfrom=
tpg+0x35/0x90 [iscsi_target_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172190]  target_fabric_np_base_rel=
ease+0x31/0x40 [target_core_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172195]  config_item_release+0x62/=
0xe0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172199]  config_item_put+0x27/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172202]  configfs_rmdir+0x1fd/0x30=
0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172208]  vfs_rmdir+0xba/0x130
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172212]  do_rmdir+0x1c7/0x1e0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172217]  SyS_rmdir+0x16/0x20
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172221]  do_syscall_64+0x73/0x130
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172225]  entry_SYSCALL_64_after_hw=
frame+0x3d/0xa2
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172228] RIP: 0033:0x7f64960f8af7
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172230] RSP: 002b:00007fff977dec68=
 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172234] RAX: ffffffffffffffda RBX:=
 00000000ffffff9c RCX: 00007f64960f8af7
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172235] RDX: 0000000000000000 RSI:=
 0000000000000000 RDI: 00007f64922f7218
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172237] RBP: 00000000026db5f0 R08:=
 0000000000000000 R09: 000000000074486c
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172239] R10: 000000000000036f R11:=
 0000000000000202 R12: 00007f6495448868
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172240] R13: 0000000000637e90 R14:=
 00000000026db5f0 R15: 00007f649544acf0

The kernel crash dump for the second targetcli process (PID 25858) is=E2=80=
=A6

Oct 28 00:26:16 mdcSIRIS kernel: [788187.172246] INFO: task targetcli:25858=
 blocked for more than 120 seconds.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.173356]       Tainted: P OE 4.15.0=
-64-generic #73~16.04.1-Ubuntu
Oct 28 00:26:16 mdcSIRIS kernel: [788187.174465] "echo 0 > /proc/sys/kernel=
/hung_task_timeout_secs" disables this message.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175603] targetcli       D 0 25858 =
1 0x00000080
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175607] Call Trace:
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175615]  __schedule+0x3d6/0x8b0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175619]  schedule+0x36/0x80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175622]  rwsem_down_write_failed+0=
x1fc/0x390
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175627]  call_rwsem_down_write_fai=
led+0x17/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175630]  ? call_rwsem_down_write_f=
ailed+0x17/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175633]  down_write+0x2d/0x40
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175637]  configfs_dir_open+0x32/0x=
80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175640]  do_dentry_open+0x25a/0x39=
0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175644]  ? configfs_lookup+0x170/0=
x170
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175647]  vfs_open+0x4f/0x80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175651]  path_openat+0x2ef/0x1550
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175656]  ? filename_lookup+0xf8/0x=
1a0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175661]  ? __check_object_size+0x1=
10/0x1a0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175665]  do_filp_open+0x99/0x110
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175670]  ? __check_object_size+0x1=
10/0x1a0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175673]  ? path_get+0x27/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175677]  ? __alloc_fd+0x46/0x170
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175680]  do_sys_open+0x12d/0x290
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175682]  ? do_sys_open+0x12d/0x290
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175686]  ? __audit_syscall_exit+0x=
230/0x2c0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175689]  SyS_open+0x1e/0x20
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175693]  do_syscall_64+0x73/0x130
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175696]  entry_SYSCALL_64_after_hw=
frame+0x3d/0xa2
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175699] RIP: 0033:0x7fdcd08a3160
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175700] RSP: 002b:00007ffdf044de30=
 EFLAGS: 00000206 ORIG_RAX: 0000000000000002
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175704] RAX: ffffffffffffffda RBX:=
 00007fdcccb71830 RCX: 00007fdcd08a3160
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175705] RDX: 0000000000000000 RSI:=
 0000000000090800 RDI: 00007fdcccb71830
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175707] RBP: 00007fdccfc25a68 R08:=
 0000000000000000 R09: 00007ffdf044def0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175708] R10: 0000000001a79a35 R11:=
 0000000000000206 R12: 00007fdcd0fd3698
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175710] R13: 0000000001a0d620 R14:=
 0000000000000001 R15: 00007fdccfc25a68

All other targetcli PIDs' stacks are exactly the same as PID 25858's.

iscsi_np's stack suggests that it's just waiting for connections...
[<0>] inet_csk_accept+0x281/0x330
[<0>] inet_accept+0x45/0x180
[<0>] kernel_accept+0x59/0xb0
[<0>] iscsit_accept_np+0x43/0x230 [iscsi_target_mod]
[<0>] iscsi_target_login_thread+0x366/0x1060 [iscsi_target_mod]
[<0>] kthread+0x105/0x140
[<0>] ret_from_fork+0x35/0x40
[<0>] 0xffffffffffffffff

Using bpftrace, I determined that the reset command is hanging on this code=
 in iscsit_reset_np_thread():

if (tpg_np && shutdown) {
        kref_put(&tpg_np->tpg_np_kref, iscsit_login_kref_put);

        wait_for_completion(&tpg_np->tpg_np_comp);
}

This bit of code is a bit hard for me to debug. The code here drops its lon=
g-held reference to the tgp_np and waits for all other outstanding referenc=
es to be dropped. However, something has not let go of its reference and so=
 the thread is currently stuck. Since I cannot find any other threads stuck=
 in an =E2=80=9Ciscsi*=E2=80=9D function, I assume that some code path forg=
ot to call kref_put() on its own, causing the struct to end up with a perma=
nent leftover reference.

I'm posting to the mailing list because I've been unable to find the missin=
g call and am hoping that this bug report will be helpful to someone famili=
ar with the life cycle of this structure.

Thank you,
Matt

