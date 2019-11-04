Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF0CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1123921D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3zy5URT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfKDN0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:26:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41487 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfKDN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:26:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id e9so10144808oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 05:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zu3cItEhhjzP4PpVvjjoEfIOJMPodKK4NOwxxjxVsmQ=;
        b=Q3zy5URTK0IGfOd/Wquujs5+H3PxKerKVaqGYBflrXtjvYmTR5uFUZxmB/qeDFGn4j
         AVng0V1Yc3fOrLyRRU/JPQFLCWk+7c711G9Yq27TP3DfMCCn1d2rSa+W6t2fgahChlWv
         ALdkaRxS77m184QhZy5YteGy6Ze0fXuf9HyQqa2s3ZhaAP/25OJFHGcJ4IGIj4Ve7G4v
         HOV2V0mK1THew6ITjJFjwtkhmhqY8Dzn6o9aObSM8Irk21gB6/aiUU0HZkEV8tYiPUqB
         UzZtytvWOn+ICwgtNe9U8xoy95W/LwnTQQ5aYJtt+HB8ttZJ6PKrOx6O+eBInYbj1bHE
         ONmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zu3cItEhhjzP4PpVvjjoEfIOJMPodKK4NOwxxjxVsmQ=;
        b=bZ3NSwLQfyR4AwFMxNaKP3QIEq/lm4mNly2PxxlLUTTKrkd0iPXNmPkHeM0blg/MUd
         gxWkUlq1hDTVPvdk/oCadz87stV8Ih1837+mjTgcq9rqeD/mDTfEJ5S66xwxUWoa2ql8
         9FPY2g5zuiu4n/B9DGKhZOZJmVmEvvhZoP4/J1LFieWNDiBYw3RV+slKR1cFJmPR6pt/
         YaHN+ZLGNmjmro91lPVeT/a1I5QohCvjIV8kau1O3lsgJJHUA9TVHnTESf/lMTYqLoxF
         2+a/vl0DRzCmCOEPGWO4sPDDfeihm3B3muC2wctKHwChM94ypD76qWci7gQ2GzPDu97X
         b0TQ==
X-Gm-Message-State: APjAAAVz07HoKAQezZqakq3dJkBrNkh1/d2nKzyymmgc39mNuHwrTfSh
        yONFQo2PRjW9qkOVx2AgImcrXtBSvowFTVeTMI+mzg==
X-Google-Smtp-Source: APXvYqyOsBDL3cd+XvCfKx1hcKpgvu3j5+7SalQMpcqjV58BX954vDf2msdjkkpNSoD+R7BitQTDf9JouOVPAB3wGdQ=
X-Received: by 2002:aca:fc0d:: with SMTP id a13mr1437695oii.83.1572873976476;
 Mon, 04 Nov 2019 05:26:16 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006881cf059683d5fb@google.com> <a00b37e3-86f8-db3f-2a39-f9603021676e@suse.com>
In-Reply-To: <a00b37e3-86f8-db3f-2a39-f9603021676e@suse.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Nov 2019 14:26:04 +0100
Message-ID: <CANpmjNP3TukFx_oJD7pwJ1aTZr-G3cjP4TUET08PWzvG+81YLw@mail.gmail.com>
Subject: Re: KCSAN: data-race in echo_char / n_tty_receive_buf_common
To:     Jiri Slaby <jslaby@suse.com>
Cc:     syzbot <syzbot+e518b0df8f4e19495d3e@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 at 13:08, Jiri Slaby <jslaby@suse.com> wrote:
>
> On 04. 11. 19, 12:44, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > git tree:       https://github.com/google/ktsan.git kcsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=106bdb60e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=e518b0df8f4e19495d3e
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e518b0df8f4e19495d3e@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in echo_char / n_tty_receive_buf_common
> >
> > write to 0xffffc9000c433018 of 8 bytes by task 18008 on cpu 0:
> >  add_echo_byte drivers/tty/n_tty.c:845 [inline]
>
> IMO it's expected add_echo_byte is called without output_lock. That's
> exactly what the barrier there is for. See:

Agree it should remain lock-free. It's still a data race because we
have 2 racing concurrent *plain* accesses that are subject to compiler
optimizations such as load/store tearing etc (avoided with
READ_ONCE/WRITE_ONCE).

This data race also highlights the increment, although preceded by a
barrier may still be problematic. I think the increment actually needs
to be atomic (e.g. atomic_inc). If the compiler or the arch turns the
ldata->echo_data++ into a non-atomic increment (something like
"ldata->echo_data = ldata->echo_data + 1"), then concurrent
add_echo_byte can overwrite and loose bytes.

> commit ebec3f8f5271139df618ebdf8427e24ba102ba94
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Sat May 26 09:53:14 2018 +0900
>
>     n_tty: Access echo_* variables carefully.
>
> >  echo_char+0x14e/0x1c0 drivers/tty/n_tty.c:948
> >  n_tty_receive_char_special+0xb5f/0x1c10 drivers/tty/n_tty.c:1339
> >  n_tty_receive_buf_fast drivers/tty/n_tty.c:1610 [inline]
> >  __receive_buf drivers/tty/n_tty.c:1644 [inline]
> >  n_tty_receive_buf_common+0x1844/0x1b00 drivers/tty/n_tty.c:1742
> >  n_tty_receive_buf+0x3a/0x50 drivers/tty/n_tty.c:1771
> >  tiocsti drivers/tty/tty_io.c:2197 [inline]
> >  tty_ioctl+0xb75/0xe10 drivers/tty/tty_io.c:2573
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:509 [inline]
> >  do_vfs_ioctl+0x991/0xc60 fs/ioctl.c:696
> >  ksys_ioctl+0xbd/0xe0 fs/ioctl.c:713
> >  __do_sys_ioctl fs/ioctl.c:720 [inline]
> >  __se_sys_ioctl fs/ioctl.c:718 [inline]
> >  __x64_sys_ioctl+0x4c/0x60 fs/ioctl.c:718
> >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > read to 0xffffc9000c433018 of 8 bytes by task 7 on cpu 1:
> >  flush_echoes drivers/tty/n_tty.c:828 [inline]
> >  __receive_buf drivers/tty/n_tty.c:1648 [inline]
> >  n_tty_receive_buf_common+0xe3f/0x1b00 drivers/tty/n_tty.c:1742
> >  n_tty_receive_buf2+0x3d/0x60 drivers/tty/n_tty.c:1777
> >  tty_ldisc_receive_buf+0x71/0xf0 drivers/tty/tty_buffer.c:461
> >  tty_port_default_receive_buf+0x87/0xd0 drivers/tty/tty_port.c:38
> >  receive_buf drivers/tty/tty_buffer.c:481 [inline]
> >  flush_to_ldisc+0x1d5/0x260 drivers/tty/tty_buffer.c:533
> >  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> >  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> >  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.4.0-rc3+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: events_unbound flush_to_ldisc
> > ==================================================================
>
> thanks,
> --
> js
> suse labs
