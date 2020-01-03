Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC0D206DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyToewWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgACDqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:46:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45664 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgACDqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:46:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so22824508pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 19:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XGzDwEKryl/njIEsg+eGczbmkTamUbnwIpvGpsNWo24=;
        b=SyToewWLwMb/Q8NsXcEypx9gH0lNVlm+4vKTWg9+WdHhDut2aZCy+rBvmk1/+7Emtl
         42SUQsmu3vIPZpeMpGSpwo/u/h8fEmG/CzX75+HKjbJ04gM7t+SKqbbOvosnIpPojyuL
         JKeETirGcMXcYlbPF+jcmTcjisIthyXBpwgUFHs2WZtk5wpalI5R6bzvi0OngEci64LQ
         lwqDFWpuT7P08dpUirumpmdegy13c/qwHQ9BOb3pBH42ZhDW/ffGmKVBMkfhT1W7qCyk
         03RfJZiOzuWzDPhN76Jrrk2QrEth63NLic15qDXKCR32x83kqeidsXN6GNxYn5o9Mqgg
         iIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XGzDwEKryl/njIEsg+eGczbmkTamUbnwIpvGpsNWo24=;
        b=OyECOrm3ZLai+h8GKs3ZXAmHKd7HA4cyadwYu8f4sLqt0Oxt47BUWPjFdPGBVuUTnX
         ZCD7CzPbOp18UAiQvKB1U7eDlG86Ci8VFXWcYwyYjR1ujcb2uqLQ9SghLMHiHcPhr2bS
         36rbtdF+62ZehSMCx3X3EP6k/iMNspeZ7X6oC8IOZcXv3r2df5gW5Ice3dhlT/YIBBXF
         uQvFtLP66zCYLY2VyoYtHW9P7jmkmFnly3Jb5qQwqU90b9TY3baSEslfgJ7R/A3vwhXe
         LDl3/vM1s7GUPheIARAoyJnA6asG7+LTB/NluGg659caFbAsgK3bmIV4EkJgu3+oArcr
         /WQQ==
X-Gm-Message-State: APjAAAUwqfuxLypykYcvAZ+9TnVgq7TUueB9UM1hyyJz+dU409mSw3tK
        6ikpKCe0+WYnd3YKJAOPKy6+a6Cg/kR/hQ==
X-Google-Smtp-Source: APXvYqwuzgCuL9MdQUcSAqoCuGCNWz7idXlWIdQauSLL3yrSUda3WTyXiy/9JPi3R6PKYu3yxE2Esg==
X-Received: by 2002:a63:5243:: with SMTP id s3mr90794069pgl.449.1578023159961;
        Thu, 02 Jan 2020 19:45:59 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id z4sm12561907pjn.29.2020.01.02.19.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 19:45:59 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH RESEND] ttyprintk: fix a potential sleeping in interrupt context issue
Date:   Fri,  3 Jan 2020 11:45:41 +0800
Message-Id: <20200103034541.5302-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Fix it by using spinlock in process context instead of mutex and having
interrupt disabled in critical section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
-	struct mutex port_write_mutex;
+	spinlock_t spinlock;
 };
 
 static struct ttyprintk_port tpk_port;
@@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty, struct file *filp)
 static void tpk_close(struct tty_struct *tty, struct file *filp)
 {
 	struct ttyprintk_port *tpkp = tty->driver_data;
+	unsigned long flags;
 
-	mutex_lock(&tpkp->port_write_mutex);
+	spin_lock_irqsave(&tpkp->spinlock, flags);
 	/* flush tpk_printk buffer */
 	tpk_printk(NULL, 0);
-	mutex_unlock(&tpkp->port_write_mutex);
+	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
 }
@@ -115,13 +117,14 @@ static int tpk_write(struct tty_struct *tty,
 		const unsigned char *buf, int count)
 {
 	struct ttyprintk_port *tpkp = tty->driver_data;
+	unsigned long flags;
 	int ret;
 
 
 	/* exclusive use of tpk_printk within this tty */
-	mutex_lock(&tpkp->port_write_mutex);
+	spin_lock_irqsave(&tpkp->spinlock, flags);
 	ret = tpk_printk(buf, count);
-	mutex_unlock(&tpkp->port_write_mutex);
+	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	return ret;
 }
@@ -171,7 +174,7 @@ static int __init ttyprintk_init(void)
 {
 	int ret = -ENOMEM;
 
-	mutex_init(&tpk_port.port_write_mutex);
+	spin_lock_init(&tpk_port.spinlock);
 
 	ttyprintk_driver = tty_alloc_driver(1,
 			TTY_DRIVER_RESET_TERMIOS |
-- 
2.17.1

