Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E76AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EC1214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK6h1Cg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfLKNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:12:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37518 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfLKNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:12:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so23999283lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5/0ZBikutXWOJ31rU6hg6aGxrvJUH76bQXGJKKYojpY=;
        b=iK6h1Cg9FdlrPFU87KU+xLgNHXCKK2p6RA6z+BCM9m46/6FXKCWr9VdZJgPRmO66xu
         evRnLRN5L5pZjfpi1CYMKrYL5uNE4hbF3EW/KiGtcBdfnirsd6HBm8/N8O91xuSxq3m4
         4tuA/Yh18sNwVpmDHSCbI5DhEM78lOIGIJ/q/Ne+mUqGmRwCOk1ikfM88r4dYduuZq3z
         IZIP8PVmFN8OG9p0SQsyzaA4+e7TrHQpMkLRjn0jETB4bZZw6PzOAB8R7V9g04kYC0sO
         bsHNrJD3PuQ3q6KL4MVELAxSd1OT6KWpK+j7sLGfDvM+KOoOMoLgGUsRI5KkyQgTF1fD
         PWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5/0ZBikutXWOJ31rU6hg6aGxrvJUH76bQXGJKKYojpY=;
        b=TvED+Ljk2X/spcGfNSeVUpoieI7Gk1NtFVizxz49C912g3DaH3trh2G5uBOXymGcSM
         BTuxmeVEibMs9yv02MtOn2u1ZeV87+huHgf/A550+X7yU7N6PxApdmLXI7OphyEPOWMl
         WOFOUThRwj9rq9HzroV65YfhEaciFLpU1cagR40okaPu/3SJcakaZM/ORlga1/ZF5xoY
         B7QW8KVjWz8uAP+4KsBVN8ssrbne2iJ/dvv106nmCFWy0biBnuVIXLYi0r9ieWfji0mD
         S2wNu1kKsW8O1uem6WlkKCguNjYnSk8gIYHnqWVGlvU7pVq90Mg9+UD3Zn96r3ekfQ36
         Qzpg==
X-Gm-Message-State: APjAAAW2oVOxESyVGfhS85QnusPQDuYUqRtOkSC4Cy9vXjKiF2D2D6ZA
        LOK4/ioWPprR0wPC/0Ae2t+FE8c0KbxThXVE2/8aCQgxino=
X-Google-Smtp-Source: APXvYqxV71KfxBzviOwWllK6shghdv8YHUIv9XyXgcb4RhWO6/nelJ3QmezJ0qgqVLjMmFB+OYMCg9vSV7ZxrPqx7lE=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr2055375ljh.183.1576069919462;
 Wed, 11 Dec 2019 05:11:59 -0800 (PST)
MIME-Version: 1.0
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 11 Dec 2019 21:11:46 +0800
Message-ID: <CAFH1YnMX5oYUT7-_swssWgxQvzKTZUzvOmREBOh5vhfvqX1vNA@mail.gmail.com>
Subject: [PATCH] ttyprintk: fix a potential sleeping in interrupt context issue
To:     linux-kernel@vger.kernel.org,
        syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, bp@alien8.de,
        john.wanghui@huawei.com, keescook@chromium.org,
        kernelfans@gmail.com, len.brown@intel.com, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        zhangshaokun@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Google syzbot reports:
BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:938
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
1 lock held by swapper/1/0:
...
Call Trace:
  <IRQ>
  dump_stack+0x197/0x210
  ___might_sleep.cold+0x1fb/0x23e
  __might_sleep+0x95/0x190
  __mutex_lock+0xc5/0x13c0
  mutex_lock_nested+0x16/0x20
  tpk_write+0x5d/0x340
  resync_tnc+0x1b6/0x320
  call_timer_fn+0x1ac/0x780
  run_timer_softirq+0x6c3/0x1790
  __do_softirq+0x262/0x98c
  irq_exit+0x19b/0x1e0
  smp_apic_timer_interrupt+0x1a3/0x610
  apic_timer_interrupt+0xf/0x20
  </IRQ>

This patch fix it by using spinlock in process context instead of
mutex and having interrupt disabled in critical section.

Reported-by: syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 drivers/char/ttyprintk.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 4f24e46ebe7c..56db949a7b70 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -15,10 +15,11 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>

 struct ttyprintk_port {
  struct tty_port port;
- struct mutex port_write_mutex;
+ spinlock_t spinlock;
 };

 static struct ttyprintk_port tpk_port;
@@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty,
struct file *filp)
 static void tpk_close(struct tty_struct *tty, struct file *filp)
 {
  struct ttyprintk_port *tpkp = tty->driver_data;
+ unsigned long flags;

- mutex_lock(&tpkp->port_write_mutex);
+ spin_lock_irqsave(&tpkp->spinlock, flags);
  /* flush tpk_printk buffer */
  tpk_printk(NULL, 0);
- mutex_unlock(&tpkp->port_write_mutex);
+ spin_unlock_irqrestore(&tpkp->spinlock, flags);

  tty_port_close(&tpkp->port, tty, filp);
 }
@@ -115,13 +117,14 @@ static int tpk_write(struct tty_struct *tty,
  const unsigned char *buf, int count)
 {
  struct ttyprintk_port *tpkp = tty->driver_data;
+ unsigned long flags;
  int ret;


  /* exclusive use of tpk_printk within this tty */
- mutex_lock(&tpkp->port_write_mutex);
+ spin_lock_irqsave(&tpkp->spinlock, flags);
  ret = tpk_printk(buf, count);
- mutex_unlock(&tpkp->port_write_mutex);
+ spin_unlock_irqrestore(&tpkp->spinlock, flags);

  return ret;
 }
@@ -171,7 +174,7 @@ static int __init ttyprintk_init(void)
 {
  int ret = -ENOMEM;

- mutex_init(&tpk_port.port_write_mutex);
+ spin_lock_init(&tpk_port.spinlock);

  ttyprintk_driver = tty_alloc_driver(1,
  TTY_DRIVER_RESET_TERMIOS |
--
2.23.0
