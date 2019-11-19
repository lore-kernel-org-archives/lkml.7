Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6001C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7A222AB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=origamienergy.com header.i=@origamienergy.com header.b="KAzQ+ttn";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="V8ySTx77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfKSRIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:08:55 -0500
Received: from a6-42.smtp-out.eu-west-1.amazonses.com ([54.240.6.42]:39576
        "EHLO a6-42.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbfKSRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=awgt3ic55kqhwizgro5hhdlz56bi7lbf; d=origamienergy.com;
        t=1574183331;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=VTATiDbH0jh8GD8FKDhfky6IOJwNiN1hMmT21Lr7NKc=;
        b=KAzQ+ttnegkL0cbqRJRtB4afoyfug6VZJ11FDA5HGmwLNmgVI6o6aAN7VanLaz3N
        gdMbvQepy8abbPoXD1Y6ofzyhkModUKbfI8uVGR0C7qizup3BA6wmtj60TtqBGIPkTD
        4oA/G1BmG2JaAmI1++A3lg9Eg1djXin4cYRVZnrs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1574183331;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=VTATiDbH0jh8GD8FKDhfky6IOJwNiN1hMmT21Lr7NKc=;
        b=V8ySTx77RE/2L2A3RCVhQhvyeYhQ/tdUeUX+229ZDKIB0qWC+24ldLhI2KASex6p
        9q1n57OEjWTZTuDfGBAEFc4YLaqk4/AveA+rN0l43cOO332NeA7lTXstLKj70AhztHd
        grzvnAJeo01qr8OHCrkWl4vMebK5UOoQmpFvVfd8=
From:   James Byrne <james.byrne@origamienergy.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     James Byrne <james.byrne@origamienergy.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/2] printk: Support message continuation from /dev/kmsg
Date:   Tue, 19 Nov 2019 17:08:50 +0000
Message-ID: <0102016e84a36465-3c9627a0-8511-4bfb-9f49-9cc62fe1f692-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.19-54.240.6.42
Feedback-ID: 1.eu-west-1.sQ65CuNSNkrvjFrT7j7oeWmhxZgivYoP5c3BHSC7Qc8=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am submitting two patches to printk which possibly need a little
context to explain why we found them to be necessary.

We develop an embedded Linux device in which we use a unified logging
scheme where the userspace applications write their logs into /dev/kmsg,
and then log reader applications (like dmesg) read them out for logging
to the console and syslog. There are some advantages to this scheme,
such as having common timestamps for kernel and userspace messages and
being more easily able to correlate how userspace application events
trigger kernel activity.

We recently upgraded our kernel from 3.18 to 4.14 and found that
behaviour around continuation lines we had been using no longer worked.
Since it is not possible to write more than LOG_LINE_MAX (992) bytes
into /dev/kmsg in one write, we were relying on the fact that we could
break up a longer message into several consecutive writes where only the
last write of the sequence was terminated by a newline, and the kernel
would treat the messages as a sequence of continuations. When you then
read the messages back from /dev/kmsg you could tell this because the
first record of the sequence would be flagged with 'c' and subsequent
ones with '+', meaning that the log reader could easily join them back
together. Obviously there are times where a sequence could be broken by
an unrelated printk occuring in the middle, but it generally worked very
well.

Subsequent kernel changes mean that it is currently not possible to
write continuation lines into the printk buffer from userspace, and also
that the flags that you read back in /dev/kmsg records are now either
'-' or 'c', something I previously submitted a documentation patch for
in commit 085a3a8fdf3e ("ABI: Update dev-kmsg documentation to match
current kernel behaviour"), which makes the documentation correct, but
glosses over the fact that the flags are no longer useful.

These patches are what we have done to resolve this issue, by giving a
new way to write continuation lines into /dev/kmsg from userspace, and
the have meaningful flags come back that will allow a reader to join the
lines together again.

James Byrne


James Byrne (2):
  printk: Make continuation flags from /dev/kmsg useful again
  printk: Support message continuation from /dev/kmsg

 Documentation/ABI/testing/dev-kmsg | 20 +++++++++++++-------
 kernel/printk/printk.c             | 25 +++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.24.0

