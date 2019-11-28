Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E614215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfK1BxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:53:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45767 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfK1BxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:53:10 -0500
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ia8zI-00083b-6R; Thu, 28 Nov 2019 02:52:57 +0100
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
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Date:   Thu, 28 Nov 2019 02:58:32 +0106
Message-Id: <20191128015235.12940-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a follow-up RFC on the work to re-implement much of the
core of printk. The threads for the previous RFC versions are
here[0][1][2][3].

This RFC includes only the ringbuffer and a test module. This is
a rewrite of the proposed ringbuffer, now based on the proof of
concept[4] from Petr Mladek as agreed at the meeting[5] during
LPC2019 in Lisbon.

The internal structure has been reworked such that the printk
strings are in their own array, each separated by a 32-bit
integer.

A 2nd array contains the dictionary strings (also with each
separated by a 32-bit integer).

A 3rd array is made up of descriptors that contain all the
meta-data for each printk record (sequence number, timestamp,
loglevel, caller, etc.) as well as pointers into the other data
arrays for the text and dictionary data.

The writer interface is somewhat similar to v4, but the reader
interface has changed significantly. Rather than using an
iterator object, readers just specify the sequence number they
want to read. In effect, the sequence number acts as the
iterator.

I have been communicating with Petr the last couple months to
make sure this implementation fits his expectations. This RFC is
mainly to get some feedback from anyone else that may see
something that Petr and I have missed.

This series also includes my test module. On a 16-core ARM64
test machine, the module runs without any errors. I am seeing
the 15 writing cores each writing about 34500 records per
second, while the 1 reading core misses only about 15% of the
total records.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
[2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
[3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de
[4] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
[5] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de

John Ogness (3):
  printk-rb: new printk ringbuffer implementation (writer)
  printk-rb: new printk ringbuffer implementation (reader)
  printk-rb: add test module

 kernel/printk/Makefile            |   3 +
 kernel/printk/printk_ringbuffer.c | 910 ++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h | 249 ++++++++
 kernel/printk/test_prb.c          | 347 ++++++++++++
 4 files changed, 1509 insertions(+)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h
 create mode 100644 kernel/printk/test_prb.c

-- 
2.20.1

