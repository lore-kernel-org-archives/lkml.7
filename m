Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD29FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE1C206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLRA4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:56:48 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61358 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfLRA4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:56:47 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBI0txmv079214;
        Wed, 18 Dec 2019 09:55:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Wed, 18 Dec 2019 09:55:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBI0tx9E079208;
        Wed, 18 Dec 2019 09:55:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id xBI0txro079201;
        Wed, 18 Dec 2019 09:55:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201912180055.xBI0txro079201@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 =?ISO-2022-JP?B?bWVtX3NlcmlhbF9vdXQ=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
MIME-Version: 1.0
Date:   Wed, 18 Dec 2019 09:55:59 +0900
References: <20191213093357.GB2135612@kroah.com> <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
In-Reply-To: <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, this is a surprising bug. syzbot provided a C reproducer, but the definition
of "struct serial_struct" used in that reproducer is wrong. As a result, syzbot was
reporting crash caused by passing wrong arguments. ;-)

close_delay field used in the C reproducer is sizeof(unsigned int) bytes rather than
sizeof(unsigned short) bytes, thus fields after close_delay field are incorrectly
interpreted.

----------------------------------------
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/serial.h>

struct bad_serial_struct {
        int     type;
        int     line;
        unsigned int    port;
        int     irq;
        int     flags;
        int     xmit_fifo_size;
        int     custom_divisor;
        int     baud_base;
        unsigned int    close_delay; /* Correct type is "unsigned short". */
        char    io_type;
        char    reserved_char[1];
        int     hub6;
        unsigned short  closing_wait;
        unsigned short  closing_wait2;
        unsigned char   *iomem_base;
        unsigned short  iomem_reg_shift;
        unsigned int    port_high;
        unsigned long   iomap_base;
};

int main(int argc, char *argv[])
{
        struct bad_serial_struct ss = { };
        int fd = open("/dev/ttyS3", O_RDONLY);
        ss.type = 0xa;
        ss.line = 0x400000;
        ss.port = 0x100;
        ss.irq = 0;
        ss.flags = 0x400000;
        ss.xmit_fifo_size = 0;
        ss.custom_divisor = 0;
        ss.baud_base = 0x80000;
        ss.close_delay = 0x200ff;
        ss.io_type = 0;
        ss.reserved_char[0] = 0x41;
        ss.hub6 = 3;
        ss.closing_wait = 0;
        ss.closing_wait2 = 0x7c5;
        ss.iomem_base = NULL;
        ss.iomem_reg_shift = 0;
        ss.port_high = 0;
        ss.iomap_base = 0;
        ioctl(fd, TIOCSSERIAL, &ss);
        return 0;
}
----------------------------------------
