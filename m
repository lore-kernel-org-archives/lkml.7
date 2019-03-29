Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB8920811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPYuYb83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfC2Rfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:35:54 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34121 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfC2Rfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:35:53 -0400
Received: by mail-ua1-f66.google.com with SMTP id c6so954964uan.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2cpBgZ7Ig/8y5RpmU0RR6Dgc5O5dTt5mjYyooBXcumI=;
        b=rPYuYb83UYVjZH9KvcrQNwQRKCeRiBnzXS5Rreu1FG/bttbMFVBJgHS428pb82Nr9+
         uhrvO4QBzJaTrTvqGOakM9s5s+eKeledZs5Azdy2+9B7O/9CoJoxbJlS3ZudDAhLb98q
         0m+8fd370KWt0TEM3xEqlZB3lFwksRuj13xpz8fo1lmMd/nExq8K3dIUOP5PwGbPBgYO
         XMsEAH3nOImIXtSgVqYpmHo5hEtQseUdIn4sRhsV12Pp0ZLN/lFPvr27tc1EL3qmpENy
         Ne4jb7fwe1KvNprJuiB6b9MtrTd5NpmuiqnanXuqAf0NnlYcwJTSEzdpa4iLZ+rRZ4Hp
         K+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2cpBgZ7Ig/8y5RpmU0RR6Dgc5O5dTt5mjYyooBXcumI=;
        b=IxAJjWhBv/6wwBbIHee0vJrdRSNAhYd8hW2Y/4KvVHYhb1A6VwldydtAw47JKNfAHc
         E46c11cpwQojzuk3d89kofEEXwPUWBUhp4z5HihJpu6HQ4Rnnxst8yUYMSyuU096T/It
         KEqiLif6+owLmgEHe0Trmq/NU8jnp9huIhSq6rFMaaJRO0cUqy0VSCBQ/qjobex7patd
         TaYaNAIOiDsZoePU8so974HCy3VEfZtyH/4MXaZjEJMQvqMk6yOF07sw/HPaWatqj/Ha
         ltzJ5E6EWl77vAr8TxfL8qyeagNz6bRPr/VGOOOvfngfszUx3ZbfncyRJUNSNrgM7h0V
         qXpg==
X-Gm-Message-State: APjAAAXYwqWndSk0yh6va5NIqfDKosQJwBaZTP5oTVBgDEHIh6XNXR87
        +Jgv3exP0oP/Gn9EB0z9UJrGZQAvEU1hlzrZnVOL7g==
X-Google-Smtp-Source: APXvYqwsMMI84cmHddZ+lEeSww5spPpDHuS2GutHSZFRMjoyg+MwooaY0LKjqvPTbNd6hcfb8sHVT7nudvkqgKraa9U=
X-Received: by 2002:ab0:270f:: with SMTP id s15mr29181398uao.110.1553880952164;
 Fri, 29 Mar 2019 10:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000407080058529ff40@google.com> <20190329123025.GB30213@hmswarspite.think-freely.org>
In-Reply-To: <20190329123025.GB30213@hmswarspite.think-freely.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 29 Mar 2019 18:35:40 +0100
Message-ID: <CAG_fn=XiNEhWiswHUschD2dma9SfS+eLRU8gXVJnbo7AozomPg@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in sctp_getsockopt (3)
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     syzbot <syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 3:51 PM Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Thu, Mar 28, 2019 at 09:25:06AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c10a026b kmsan: use __free_pages() in kmsan_iounmap_pag=
e_r..
> > git tree:       kmsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D107d3c7d200=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da5675814e8e=
ae69e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D86b5c7c236a22=
616a72f
> > compiler:       clang version 8.0.0 (trunk 350509)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1252834d2=
00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com
> >
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_hsr: link becomes ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
> > 8021q: adding VLAN 0 to HW filter on device batadv0
> > 8021q: adding VLAN 0 to HW filter on device batadv0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c=
:32
> > CPU: 0 PID: 10131 Comm: syz-executor.4 Not tainted 5.0.0+ #16
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
> >  kmsan_report+0x131/0x2a0 mm/kmsan/kmsan.c:636
> >  kmsan_internal_check_memory+0xaa1/0xbb0 mm/kmsan/kmsan.c:730
> >  kmsan_copy_to_user+0xab/0xc0 mm/kmsan/kmsan_hooks.c:485
> >  _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
> >  copy_to_user include/linux/uaccess.h:174 [inline]
> >  sctp_getsockopt_peer_addrs net/sctp/socket.c:5911 [inline]
> >  sctp_getsockopt+0x1668e/0x17f70 net/sctp/socket.c:7562
> >  sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2950
> >  __sys_getsockopt+0x489/0x550 net/socket.c:1938
> >  __do_sys_getsockopt net/socket.c:1949 [inline]
> >  __se_sys_getsockopt+0xe1/0x100 net/socket.c:1946
> >  __x64_sys_getsockopt+0x62/0x80 net/socket.c:1946
> >  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
> >  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > RIP: 0033:0x458209
> > Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89=
 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff
> > 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fdbef191c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
> > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458209
> > RDX: 000000000000006c RSI: 0000000000000084 RDI: 0000000000000004
> > RBP: 000000000073bf00 R08: 0000000020000300 R09: 0000000000000000
> > R10: 0000000020000280 R11: 0000000000000246 R12: 00007fdbef1926d4
> > R13: 00000000004c96c8 R14: 00000000004d0310 R15: 00000000ffffffff
> >
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
> >  kmsan_save_stack mm/kmsan/kmsan.c:220 [inline]
> >  kmsan_internal_chain_origin+0x134/0x230 mm/kmsan/kmsan.c:426
> >  kmsan_memcpy_memmove_metadata+0xb5b/0xfe0 mm/kmsan/kmsan.c:304
> >  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:324
> >  __msan_memcpy+0x58/0x70 mm/kmsan/kmsan_instr.c:139
> >  sctp_getsockopt_peer_addrs net/sctp/socket.c:5906 [inline]
> >  sctp_getsockopt+0x16556/0x17f70 net/sctp/socket.c:7562
> >  sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2950
> >  __sys_getsockopt+0x489/0x550 net/socket.c:1938
> >  __do_sys_getsockopt net/socket.c:1949 [inline]
> >  __se_sys_getsockopt+0xe1/0x100 net/socket.c:1946
> >  __x64_sys_getsockopt+0x62/0x80 net/socket.c:1946
> >  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
> >  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> >
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
> >  kmsan_save_stack mm/kmsan/kmsan.c:220 [inline]
> >  kmsan_internal_chain_origin+0x134/0x230 mm/kmsan/kmsan.c:426
> >  kmsan_memcpy_memmove_metadata+0xb5b/0xfe0 mm/kmsan/kmsan.c:304
> >  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:324
> >  __msan_memcpy+0x58/0x70 mm/kmsan/kmsan_instr.c:139
> >  sctp_transport_init net/sctp/transport.c:61 [inline]
> >  sctp_transport_new+0x16d/0x9a0 net/sctp/transport.c:115
> >  sctp_assoc_add_peer+0x532/0x1f70 net/sctp/associola.c:637
> >  sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
> >  sctp_process_init+0x1a1b/0x3ed0 net/sctp/sm_make_chunk.c:2361
> >  sctp_cmd_process_init net/sctp/sm_sideeffect.c:682 [inline]
> >  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1410 [inline]
> >  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
> >  sctp_do_sm+0x3cfc/0x9af0 net/sctp/sm_sideeffect.c:1191
> >  sctp_assoc_bh_rcv+0x65a/0xd80 net/sctp/associola.c:1074
> >  sctp_inq_push+0x300/0x420 net/sctp/inqueue.c:95
> >  sctp_backlog_rcv+0x20a/0xaf0 net/sctp/input.c:354
> >  sk_backlog_rcv include/net/sock.h:936 [inline]
> >  __release_sock+0x281/0x5f0 net/core/sock.c:2284
> >  release_sock+0x99/0x2a0 net/core/sock.c:2800
> >  sctp_wait_for_connect+0x3ee/0x860 net/sctp/socket.c:8751
> >  sctp_sendmsg_to_asoc+0x2167/0x21a0 net/sctp/socket.c:1967
> >  sctp_sendmsg+0x3fd7/0x6700 net/sctp/socket.c:2113
> >  inet_sendmsg+0x54a/0x720 net/ipv4/af_inet.c:798
> >  sock_sendmsg_nosec net/socket.c:622 [inline]
> >  sock_sendmsg net/socket.c:632 [inline]
> >  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
> >  __sys_sendmsg net/socket.c:2153 [inline]
> >  __do_sys_sendmsg net/socket.c:2162 [inline]
> >  __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
> >  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
> >  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
> >  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> >
> > Local variable description: ----addr.i@sctp_process_init
> > Variable was created at:
> >  sctp_process_init+0xb5/0x3ed0 net/sctp/sm_make_chunk.c:2324
> >  sctp_cmd_process_init net/sctp/sm_sideeffect.c:682 [inline]
> >  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1410 [inline]
> >  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
> >  sctp_do_sm+0x3cfc/0x9af0 net/sctp/sm_sideeffect.c:1191
> >
> > Bytes 8-15 of 16 are uninitialized
> > Memory access of size 16 starts at ffff88809511fc28
> > Data copied to user address 0000000020000298
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
> >
>
>
> Hmm, odd.  I see where we are doing the copy_to_user call in
> getsockopt_peer_addrs, but the length we copy should always be equal to o=
r less
> than what was memcopied to the temp variable.  False positive?
I'll take a closer look next week.
The bug is reproducible with the following syzkaller program:

r0 =3D socket$inet(0x2, 0x80001, 0x84)
bind$inet(r0, &(0x7f0000000080)=3D{0x2, 0x4e20, @empty}, 0x10)
sendmsg(r0, &(0x7f0000000100)=3D{&(0x7f0000006000)=3D@in=3D{0x2, 0x4e20,
@loopback}, 0x80, &(0x7f0000007f80)=3D[{&(0x7f00000001c0)=3D"de", 0x1}],
0x1}, 0x0)
getsockopt$inet_sctp_SCTP_GET_PEER_ADDRS(r0, 0x84, 0x6c,
&(0x7f0000000000)=3D{<r5=3D>0x0, 0x38,
"41925f90e4121fadc9c1296dd22ae19d0b1b0942e46fc79e2ecec1056b23199f0ca008915d=
8dba1b3896c154f2244bbe859fe3423a4b437a"},
&(0x7f0000000040)=3D0x40)

Just need to check where the uninitializedness comes from.
> Neil
>



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
