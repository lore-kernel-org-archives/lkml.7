Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E9EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A512080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQSk9KKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfGYKHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:07:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42362 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfGYKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:07:29 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so65631923iob.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJGJTW1AKHX8YCqrP2r6NV3G656oI3naEeYlsNbCITA=;
        b=aQSk9KKCZL/752bvx57luZFDwbVVyriLAPdpFhea49xwFPL0oT12XBl3giRar9BrVP
         i/oy/YogrN95Hq1d7ih0OwO0y7Yetm9YIiURM12MtsgxjbIPiOfO01sH4qVsxc6TFdyK
         Q8lVNfu9mhSE2JWYQEfA41CnKJswOnijSLFOBqz86qNIU3twIWwXu3jgriKpjWNlxoZW
         wDXjFJ+PbESFH9/ZiCdWp88yy414HkRDz7f5KLReOCnYO0H0W2cCiVWxiVdESF3jUW8Y
         Momp21LK/RHd1hJ3vrbid7b6Zl94n4DRCgHLq1pQ3GyJQNiruUNvIPnTljFOqqOYBkVU
         aOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJGJTW1AKHX8YCqrP2r6NV3G656oI3naEeYlsNbCITA=;
        b=J7Ki61FC2Les99eoeMXVMiay8KIfibAexan4T7LlB5btTZe4mTkKCvLDF03t4ouK2H
         R8UV3/qSac0B0HwOmX6hcnkoksIxDYNGeXqhtFqaa6PamhusW6FljtnWABYPduREaUr+
         AR/OIKEi0Kjesdp1zJlIR5fL05XWiPHAPjDhuEGBIt68K+aVUO2tVjub2AqMbG4l/Ojh
         7Hu0+CdL3OisUSzgAI8njlQ8Su9q1diQvV+yOL44D+0pp325syXq80CQvqc/RtN/DbO7
         E0/SkeS9+v3ZRlFmsiyQ6GG6Lg2Azat8SSczBYn2L4G5/cPC9ZuFQdYkksWLRL166S8W
         nQlA==
X-Gm-Message-State: APjAAAVAzSBgDmFAkKvPpU2Xn05XuwmisnveKCdBQJK0Y5yOIY9aDUP3
        t3+E4HIwSJPvQgpTbBV2yLVgPDmLkwsxjhkJMIG+Ag==
X-Google-Smtp-Source: APXvYqxvp/4AZZ10GazJjfXWVO1JW+6pfecmdd43Zjk/XEjqWVsIECKHVeVVLV6njtuWav5szcDbpURRhjsTSnlFNN4=
X-Received: by 2002:a02:a07:: with SMTP id 7mr91538673jaw.65.1564049248162;
 Thu, 25 Jul 2019 03:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003fd4ab058e46951f@google.com> <CACT4Y+YLqSt34ka5kQQNBeo+GvGZ0dzNFL3Rb8_1Cid_C75_2w@mail.gmail.com>
 <500EB100-0253-4934-80FD-689C32ED310C@holtmann.org> <CACT4Y+aRxn2Wgr7OuZRMb-PbvpJqbeLVUAkygUd_2y6+4u_5Jg@mail.gmail.com>
 <9F8A3279-E5BE-4852-B099-7CD94A08C1CE@holtmann.org>
In-Reply-To: <9F8A3279-E5BE-4852-B099-7CD94A08C1CE@holtmann.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Jul 2019 12:07:17 +0200
Message-ID: <CACT4Y+bdU4O4zux4NAxqX5kVgcppDuLAiVxHpJ8TzLEXfAFvTQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in h5_rx_3wire_hdr
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Dmitry,
>
> >>>> syzbot found the following crash on:
> >>>>
> >>>> HEAD commit:    6d21a41b Add linux-next specific files for 20190718
> >>>> git tree:       linux-next
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1377958fa00000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=0abbda0523882250a97a
> >>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e2bb7a00000
> >>>
> >>> +drivers/bluetooth/hci_h5.c maintainers
> >>>
> >>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>>> Reported-by: syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com
> >>>>
> >>>> ==================================================================
> >>>> BUG: KASAN: use-after-free in h5_rx_3wire_hdr+0x35d/0x3c0
> >>>> /drivers/bluetooth/hci_h5.c:438
> >>>> Read of size 1 at addr ffff8880a161d1c8 by task syz-executor.4/12040
> >>>>
> >>>> CPU: 1 PID: 12040 Comm: syz-executor.4 Not tainted 5.2.0-next-20190718 #41
> >>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >>>> Google 01/01/2011
> >>>> Call Trace:
> >>>> __dump_stack /lib/dump_stack.c:77 [inline]
> >>>> dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
> >>>> print_address_description.cold+0xd4/0x306 /mm/kasan/report.c:351
> >>>> __kasan_report.cold+0x1b/0x36 /mm/kasan/report.c:482
> >>>> kasan_report+0x12/0x17 /mm/kasan/common.c:612
> >>>> __asan_report_load1_noabort+0x14/0x20 /mm/kasan/generic_report.c:129
> >>>> h5_rx_3wire_hdr+0x35d/0x3c0 /drivers/bluetooth/hci_h5.c:438
> >>>> h5_recv+0x32f/0x500 /drivers/bluetooth/hci_h5.c:563
> >>>> hci_uart_tty_receive+0x279/0x790 /drivers/bluetooth/hci_ldisc.c:600
> >>>> tiocsti /drivers/tty/tty_io.c:2197 [inline]
> >>>> tty_ioctl+0x949/0x14f0 /drivers/tty/tty_io.c:2573
> >>>> vfs_ioctl /fs/ioctl.c:46 [inline]
> >>>> file_ioctl /fs/ioctl.c:509 [inline]
> >>>> do_vfs_ioctl+0xdb6/0x13e0 /fs/ioctl.c:696
> >>>> ksys_ioctl+0xab/0xd0 /fs/ioctl.c:713
> >>>> __do_sys_ioctl /fs/ioctl.c:720 [inline]
> >>>> __se_sys_ioctl /fs/ioctl.c:718 [inline]
> >>>> __x64_sys_ioctl+0x73/0xb0 /fs/ioctl.c:718
> >>>> do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
> >>>> entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>> RIP: 0033:0x459819
> >>>> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> >>>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> >>>> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> >>>> RSP: 002b:00007f7a3b459c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >>>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459819
> >>>> RDX: 0000000020000080 RSI: 0000000000005412 RDI: 0000000000000003
> >>>> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> >>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a3b45a6d4
> >>>> R13: 00000000004c408a R14: 00000000004d7ff0 R15: 00000000ffffffff
> >>
> >> Is this happening on specific hardware?
> >
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>
> funny ;)
>
> I meant the Bluetooth chip on this machine.

I don't think there are any Bluetooth chips exposed in GCE VMs. I
would expect that this bug does not require any hardware to trigger.
