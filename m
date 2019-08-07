Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E67C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FEC217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbfHGW1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:02 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUON-0007mg-B2; Thu, 08 Aug 2019 00:26:48 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Date:   Thu,  8 Aug 2019 00:32:25 +0206
Message-Id: <20190807222634.1723-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a follow-up RFC on the work to re-implement much of
the core of printk. The threads for the previous RFC versions
are here: v1[0], v2[1], v3[2].

This series only builds upon v3 (i.e. the first part of this
series is exactly v3). The main purpose of this series is to
replace the current printk ringbuffer with the new
ringbuffer. As was discussed[3], this is a conservative
first step to rework printk. For example, all logbuf_lock
usage is kept even though the new ringbuffer does not
require it. This avoids any side-effect bugs in case the
logbuf_lock is (unintentionally) synchronizing more than
just the ringbuffer. However, this also means that the
series does not bring any improvements, just swapping out
implementations. A future patch will remove the logbuf_lock.

Except for the test module (patches 2 and 6), the rest may
already be interesting for mainline as is. I have tested
the various interfaces (console, /dev/kmsg, syslog,
kmsg_dump) and their features and all looks good AFAICT.

The patches can be broken down as follows:

1-2: the previously posted RFCv3

3-7: addresses minor issues from RFCv3

8:   adds new high-level ringbuffer functions to support
     printk (nothing involving new memory barriers)

9:   replace the ringbuffer usage in printk.c

One important thing to know (as is mentioned in the commit
message of patch 9), there are 2 externally visible
changes:

    - vmcore info changes

    - powerpc powernv/opal memdump of log discontinued

I have no idea how acceptable these changes are.

I will not be posting any further printk patches until I
have received some feedback on this. I appreciate all the
help so far. I realize that this is a lot of code to go
through.

The series is based on 5.3-rc3. I would encourage people to
apply the series and give it a run. I expect that you
will not notice any difference with your printk behaviour.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
[2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
[3] https://lkml.kernel.org/r/87y35hn6ih.fsf@linutronix.de

John Ogness (9):
  printk-rb: add a new printk ringbuffer implementation
  printk-rb: add test module
  printk-rb: fix missing includes/exports
  printk-rb: initialize new descriptors as invalid
  printk-rb: remove extra data buffer size allocation
  printk-rb: adjust test module ringbuffer sizes
  printk-rb: increase size of seq and size variables
  printk-rb: new functionality to support printk
  printk: use a new ringbuffer implementation

 arch/powerpc/platforms/powernv/opal.c |   22 +-
 include/linux/kmsg_dump.h             |    6 +-
 include/linux/printk.h                |   12 -
 kernel/printk/Makefile                |    5 +
 kernel/printk/dataring.c              |  809 ++++++++++++++++++
 kernel/printk/dataring.h              |  108 +++
 kernel/printk/numlist.c               |  376 +++++++++
 kernel/printk/numlist.h               |   72 ++
 kernel/printk/printk.c                |  745 +++++++++--------
 kernel/printk/ringbuffer.c            | 1079 +++++++++++++++++++++++++
 kernel/printk/ringbuffer.h            |  354 ++++++++
 kernel/printk/test_prb.c              |  256 ++++++
 12 files changed, 3450 insertions(+), 394 deletions(-)
 create mode 100644 kernel/printk/dataring.c
 create mode 100644 kernel/printk/dataring.h
 create mode 100644 kernel/printk/numlist.c
 create mode 100644 kernel/printk/numlist.h
 create mode 100644 kernel/printk/ringbuffer.c
 create mode 100644 kernel/printk/ringbuffer.h
 create mode 100644 kernel/printk/test_prb.c

-- 
2.20.1

