Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7441BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2704820693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0WFva8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfC1Qc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:32:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42152 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfC1QcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:32:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so23787487qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzV8Uw2+62HstYsM3vywVNsHQqrNHk3w1e0jmJkK0sM=;
        b=F0WFva8cEqzn6/Txb7zDh4UG+E0Fru4jxjPbZBPQRQAtrcCbC3h9fXw8yTmzW3ONjN
         uAOLNpG7qPAjHnl1F164zaEhDHMbUoFoGvoghno08eF1bG0aIIzpw+67tbL2aC7FrnRy
         oCae2KOhs9AT/6++FZxLAlxOnzSsP7vrGopo6N7EGTZsywmaRrMqf2/xDxEyYwIrPIua
         O+0Zwg0zchymcek6qwDPSylyofs4sQOHh8RiKc0uluV8s8OqTE/CR+gOlyVmxpB/9BOM
         6IixUel8Qz+YAds27zXsgDApm5YQ6oUsoDNkxHfRSL9CG7O/cgd2gIumvQa6v5RHcyTO
         Nk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzV8Uw2+62HstYsM3vywVNsHQqrNHk3w1e0jmJkK0sM=;
        b=dk3ltOH7HqYDPwDuxXpxFFdLFhSR7jCWFuEGcLPV8o0gnYXmVl7c5cB1hmGcvcokFc
         qodHJyFPfBxGZrQCLM73VDs+lqdxBVNqDdp0WoJS/qNribYhF9+/aPK64TfaIKotqC2N
         KuAGLud0eKJq90BAmN+LyPUECa25wkao1g5KOt1SAeEwOOADjUWO8SE3lrPDvHiwATUn
         swjb5g1Td66ujPqPxJa3i72IKH8tLpjnLEIOeskTOGELmUOtrYPI9VdPR5zWElu2RFSp
         Tt8iIhWm/Nwj3m3iftMGuq1RAXePal/Te0CogMKgxMrMMVlmP8gIH9bV77IG3n95T8r3
         tDYw==
X-Gm-Message-State: APjAAAUIRDlP9XDuxiz/PwEnUbTxjIaWMaAppFB0jSYCuefahUenEZhg
        Q4sRO1XPiMTWW9rfnMmYr/POpsccE456hqk7vIWUaw==
X-Google-Smtp-Source: APXvYqwz3mBX+qTYJ/peoJoAJCWgOft10W87ol4uksOrrguJ0lNWox+RzCVQQS/CyBKMH2xp2AlnSaEI9XNs2mWIGd8=
X-Received: by 2002:ac8:44c3:: with SMTP id b3mr25130035qto.349.1553790743381;
 Thu, 28 Mar 2019 09:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ea60e6058529d77b@google.com>
In-Reply-To: <000000000000ea60e6058529d77b@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 28 Mar 2019 09:32:11 -0700
Message-ID: <CAHRSSEzdN_PyZNg51PMosxR5w1Q6h8hqb4fg-r7uOWngA-eAZA@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
To:     syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs@googlegroups.com, Todd Kjos <tkjos@android.com>
Content-Type: multipart/mixed; boundary="00000000000051adca05852a19a2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000051adca05852a19a2
Content-Type: text/plain; charset="UTF-8"

The fix for this is in Greg KH's char-misc-linus branch. Pointing
syzbot at it to verify:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
char-misc-linus


On Thu, Mar 28, 2019 at 9:14 AM syzbot
<syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1a9df9e2 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fed11f200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9f3f388440283da2965
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d05637200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1677e62f200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
>
> binder: 7824:7824 DecRefs 0 refcount change on invalid ref 1 ret -22
> ------------[ cut here ]------------
> kernel BUG at drivers/android/binder_alloc.c:1141!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7824 Comm: syz-executor570 Not tainted 5.1.0-rc2+ #40
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510
> drivers/android/binder_alloc.c:1141
> Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 4f f4 23 fc 4c 89
> e6 4c 89 ef e8 64 f5 23 fc 4d 39 e5 76 07 e8 3a f4 23 fc <0f> 0b e8 33 f4
> 23 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 41
> RSP: 0018:ffff88808b497550 EFLAGS: 00010293
> RAX: ffff88808620e540 RBX: 0000000020001000 RCX: ffffffff854c7d3c
> RDX: 0000000000000000 RSI: ffffffff854c7d46 RDI: 0000000000000006
> RBP: ffff88808b4975d0 R08: ffff88808620e540 R09: 0000000000000028
> R10: ffffed1011692f01 R11: ffff88808b49780f R12: 0000000000000008
> R13: 0000000000000028 R14: ffff888088a0cb10 R15: 0000000000000000
> FS:  00000000006de940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004c4d28 CR3: 0000000090d8e000 CR4: 00000000001406e0
> Call Trace:
>   binder_alloc_copy_from_buffer+0x37/0x42 drivers/android/binder_alloc.c:1187
>   binder_get_object+0xc3/0x200 drivers/android/binder.c:2062
>   binder_transaction+0x2b4a/0x6690 drivers/android/binder.c:3231
>   binder_thread_write+0x87e/0x2820 drivers/android/binder.c:3781
>   binder_ioctl_write_read drivers/android/binder.c:4825 [inline]
>   binder_ioctl+0x1033/0x183b drivers/android/binder.c:5002
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
>   ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445f19
> Code: e8 7c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 db cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fffeaa7b578 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000445f19
> RDX: 0000000020000240 RSI: 00000000c0306201 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000403010
> R10: 00007fffeaa7b0d0 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000403010 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 0f3d90ce4ca56ff6 ]---
> RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510
> drivers/android/binder_alloc.c:1141
> Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 4f f4 23 fc 4c 89
> e6 4c 89 ef e8 64 f5 23 fc 4d 39 e5 76 07 e8 3a f4 23 fc <0f> 0b e8 33 f4
> 23 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 41
> RSP: 0018:ffff88808b497550 EFLAGS: 00010293
> RAX: ffff88808620e540 RBX: 0000000020001000 RCX: ffffffff854c7d3c
> RDX: 0000000000000000 RSI: ffffffff854c7d46 RDI: 0000000000000006
> RBP: ffff88808b4975d0 R08: ffff88808620e540 R09: 0000000000000028
> R10: ffffed1011692f01 R11: ffff88808b49780f R12: 0000000000000008
> R13: 0000000000000028 R14: ffff888088a0cb10 R15: 0000000000000000
> FS:  00000000006de940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004c4d28 CR3: 0000000090d8e000 CR4: 00000000001406f0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

--00000000000051adca05852a19a2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-binder-fix-crash-in-binder_alloc_do_buffer_copy.patch"
Content-Disposition: attachment; 
	filename="0001-binder-fix-crash-in-binder_alloc_do_buffer_copy.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtsur0wq0>
X-Attachment-Id: f_jtsur0wq0

RnJvbSBkNDljOTVjOTQ0YzE1NzMyZWY1N2YxYzg3NmUyNDgzOGIyZGRmMzRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb2RkIEtqb3MgPHRram9zQGdvb2dsZS5jb20+CkRhdGU6IFR1
ZSwgMTkgTWFyIDIwMTkgMDk6NTM6MDEgLTA3MDAKU3ViamVjdDogW1BBVENIXSBiaW5kZXI6IGZp
eCBCVUdfT04gZm91bmQgYnkgc2VsaW51eC10ZXN0c3VpdGUKClRoZSBzZWxpbnV4LXRlc3RzdWl0
ZSBmb3VuZCBhbiBpc3N1ZSByZXN1bHRpbmcgaW4gYSBCVUdfT04oKQp3aGVyZSBhIGNvbmRpdGlv
bmFsIHJlbGllZCBvbiBhIHNpemVfdCBnb2luZyBuZWdhdGl2ZSB3aGVuCmNoZWNraW5nIHRoZSB2
YWxpZGl0eSBvZiBhIGJ1ZmZlciBvZmZzZXQuCgpGaXhlczogN2E2N2EzOTMyMGRmICgiYmluZGVy
OiBhZGQgZnVuY3Rpb24gdG8gY29weSBiaW5kZXIgb2JqZWN0IGZyb20gYnVmZmVyIikKUmVwb3J0
ZWQtYnk6IFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+ClRlc3RlZC1ieTogUGF1bCBN
b29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KU2lnbmVkLW9mZi1ieTogVG9kZCBLam9zIDx0a2pv
c0Bnb29nbGUuY29tPgotLS0KUGxlYXNlIGFkZCB0byA1LjEgKGZpeGVzIHByb2JsZW0gaW50cm9k
dWNlZCBpbiA1LjEtcmMxKQoKIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyB8IDMgKystCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jCmluZGV4
IDg2ODU4ODJkYTY0Y2QuLjRiOWM3Y2E0OTJlNmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYW5kcm9p
ZC9iaW5kZXIuYworKysgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMKQEAgLTIwNTcsNyArMjA1
Nyw4IEBAIHN0YXRpYyBzaXplX3QgYmluZGVyX2dldF9vYmplY3Qoc3RydWN0IGJpbmRlcl9wcm9j
ICpwcm9jLAogCXNpemVfdCBvYmplY3Rfc2l6ZSA9IDA7CiAKIAlyZWFkX3NpemUgPSBtaW5fdChz
aXplX3QsIHNpemVvZigqb2JqZWN0KSwgYnVmZmVyLT5kYXRhX3NpemUgLSBvZmZzZXQpOwotCWlm
IChyZWFkX3NpemUgPCBzaXplb2YoKmhkcikgfHwgIUlTX0FMSUdORUQob2Zmc2V0LCBzaXplb2Yo
dTMyKSkpCisJaWYgKG9mZnNldCA+IGJ1ZmZlci0+ZGF0YV9zaXplIHx8IHJlYWRfc2l6ZSA8IHNp
emVvZigqaGRyKSB8fAorCSAgICAhSVNfQUxJR05FRChvZmZzZXQsIHNpemVvZih1MzIpKSkKIAkJ
cmV0dXJuIDA7CiAJYmluZGVyX2FsbG9jX2NvcHlfZnJvbV9idWZmZXIoJnByb2MtPmFsbG9jLCBv
YmplY3QsIGJ1ZmZlciwKIAkJCQkgICAgICBvZmZzZXQsIHJlYWRfc2l6ZSk7Ci0tIAoyLjIxLjAu
MjI1Lmc4MTBiMjY5ZDFhYy1nb29nCgo=
--00000000000051adca05852a19a2--
