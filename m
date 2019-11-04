Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FBACA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41308217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfKDMIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:08:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfKDMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:08:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id l10so16772463wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 04:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qzDTKfW6uOj8KJIkFW+JxCwN1599ezZYj5NFJla47uU=;
        b=daliQahWP9XSpyMak3GTPRKf42VHheavQzRB9FD+z1UC7gnB0WL8aldCQ4DUP+l25o
         T8NSnDDDhjR1qq1CBI5fO6czQOlkNqbSRA3vuVKOBtuRjlsQC5ket/D/PpMvrMVlNoy5
         xmCXriKpDlXoRsn0ACShmU7k79RJNTgWb66NAQIOpAYIORmwJjkX1dQZpnrfZEjX2iEp
         UWjC5Duk/ai7CU0RsP/OP43o952/I3c+a5KZlFkui4y6t0bbW/dEIrufn5oqXBw54IL1
         pyBpAi/p83LfBJO/DCgwo1xpkoyq7UsM9nv8CHXNCT/f5tf/mLbGzpzbViiEzTJPSD4K
         bATg==
X-Gm-Message-State: APjAAAWhn0GVh1wdLOLF5Xtm95iXU3r0tY5y1OsOQWJWQiAeJ6CU/X9i
        pX0vz4Y8fh9hTotDKN3lCFY=
X-Google-Smtp-Source: APXvYqybefZmKxxeKUnNEJ82xYEAhLkA36diihLq47lhVHwejzWH87xfdg6bK5dT9678W2HtuhSF6Q==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr22451845wrn.116.1572869308854;
        Mon, 04 Nov 2019 04:08:28 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r5sm15917667wrl.86.2019.11.04.04.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:08:28 -0800 (PST)
Subject: Re: KCSAN: data-race in echo_char / n_tty_receive_buf_common
To:     syzbot <syzbot+e518b0df8f4e19495d3e@syzkaller.appspotmail.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000006881cf059683d5fb@google.com>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a00b37e3-86f8-db3f-2a39-f9603021676e@suse.com>
Date:   Mon, 4 Nov 2019 13:08:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0000000000006881cf059683d5fb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 11. 19, 12:44, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=106bdb60e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=e518b0df8f4e19495d3e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e518b0df8f4e19495d3e@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in echo_char / n_tty_receive_buf_common
> 
> write to 0xffffc9000c433018 of 8 bytes by task 18008 on cpu 0:
>  add_echo_byte drivers/tty/n_tty.c:845 [inline]

IMO it's expected add_echo_byte is called without output_lock. That's
exactly what the barrier there is for. See:

commit ebec3f8f5271139df618ebdf8427e24ba102ba94
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sat May 26 09:53:14 2018 +0900

    n_tty: Access echo_* variables carefully.

>  echo_char+0x14e/0x1c0 drivers/tty/n_tty.c:948
>  n_tty_receive_char_special+0xb5f/0x1c10 drivers/tty/n_tty.c:1339
>  n_tty_receive_buf_fast drivers/tty/n_tty.c:1610 [inline]
>  __receive_buf drivers/tty/n_tty.c:1644 [inline]
>  n_tty_receive_buf_common+0x1844/0x1b00 drivers/tty/n_tty.c:1742
>  n_tty_receive_buf+0x3a/0x50 drivers/tty/n_tty.c:1771
>  tiocsti drivers/tty/tty_io.c:2197 [inline]
>  tty_ioctl+0xb75/0xe10 drivers/tty/tty_io.c:2573
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0x991/0xc60 fs/ioctl.c:696
>  ksys_ioctl+0xbd/0xe0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x4c/0x60 fs/ioctl.c:718
>  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> read to 0xffffc9000c433018 of 8 bytes by task 7 on cpu 1:
>  flush_echoes drivers/tty/n_tty.c:828 [inline]
>  __receive_buf drivers/tty/n_tty.c:1648 [inline]
>  n_tty_receive_buf_common+0xe3f/0x1b00 drivers/tty/n_tty.c:1742
>  n_tty_receive_buf2+0x3d/0x60 drivers/tty/n_tty.c:1777
>  tty_ldisc_receive_buf+0x71/0xf0 drivers/tty/tty_buffer.c:461
>  tty_port_default_receive_buf+0x87/0xd0 drivers/tty/tty_port.c:38
>  receive_buf drivers/tty/tty_buffer.c:481 [inline]
>  flush_to_ldisc+0x1d5/0x260 drivers/tty/tty_buffer.c:533
>  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound flush_to_ldisc
> ==================================================================

thanks,
-- 
js
suse labs
