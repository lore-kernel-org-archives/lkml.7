Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57040C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233992072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431817;
	bh=d0LqO0vrL2w/6NnlUQCVD3jiBBsm4uHXS+n2zv8EHXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ynYU458Z4fq00m+c9h4YpgQGXM/OM0xvx+6rgBQYF0lYO4Ue16pSBfl7YqRrqX+Rr
	 k8u5Gxp4T8Woim7LpPlG7JI9dModXWaKrfI0Ov4bqHq3chSe1lD0RYwZcZ+mXCdGpS
	 gzubl5AkQBgb2LNZY1MUUXZ8D3S373gPGwyPPzjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgAGVGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgAGVGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:06:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60816208C4;
        Tue,  7 Jan 2020 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431189;
        bh=d0LqO0vrL2w/6NnlUQCVD3jiBBsm4uHXS+n2zv8EHXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2HglTne0C6tNsDPOSMQQpXODSKUbF3DMLJyAGyz8FO1o7swVkZS+jMWQI6Q0/tHBX
         v7P6o7JQY3A1g7v6ms7Vh6BBNS8mSTSUOkPlx5S9djKsprMBgrPMvHz3/W0HlRzE7K
         pZvjKQPl9qlIZ7kT/9DxEGUYyOB6SL+v2iyd4DwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 070/115] tracing: Avoid memory leak in process_system_preds()
Date:   Tue,  7 Jan 2020 21:54:40 +0100
Message-Id: <20200107205303.879912341@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>

commit 79e65c27f09683fbb50c33acab395d0ddf5302d2 upstream.

When failing in the allocation of filter_item, process_system_preds()
goes to fail_mem, where the allocated filter is freed.

However, this leads to memory leak of filter->filter_string and
filter->prog, which is allocated before and in process_preds().
This bug has been detected by kmemleak as well.

Fix this by changing kfree to __free_fiter.

unreferenced object 0xffff8880658007c0 (size 32):
  comm "bash", pid 579, jiffies 4295096372 (age 17.752s)
  hex dump (first 32 bytes):
    63 6f 6d 6d 6f 6e 5f 70 69 64 20 20 3e 20 31 30  common_pid  > 10
    00 00 00 00 00 00 00 00 65 73 00 00 00 00 00 00  ........es......
  backtrace:
    [<0000000067441602>] kstrdup+0x2d/0x60
    [<00000000141cf7b7>] apply_subsystem_event_filter+0x378/0x932
    [<000000009ca32334>] subsystem_filter_write+0x5a/0x90
    [<0000000072da2bee>] vfs_write+0xe1/0x240
    [<000000004f14f473>] ksys_write+0xb4/0x150
    [<00000000a968b4a0>] do_syscall_64+0x6d/0x1e0
    [<000000001a189f40>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff888060c22d00 (size 64):
  comm "bash", pid 579, jiffies 4295096372 (age 17.752s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 e8 d7 41 80 88 ff ff  ...........A....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b8c1b109>] process_preds+0x243/0x1820
    [<000000003972c7f0>] apply_subsystem_event_filter+0x3be/0x932
    [<000000009ca32334>] subsystem_filter_write+0x5a/0x90
    [<0000000072da2bee>] vfs_write+0xe1/0x240
    [<000000004f14f473>] ksys_write+0xb4/0x150
    [<00000000a968b4a0>] do_syscall_64+0x6d/0x1e0
    [<000000001a189f40>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff888041d7e800 (size 512):
  comm "bash", pid 579, jiffies 4295096372 (age 17.752s)
  hex dump (first 32 bytes):
    70 bc 85 97 ff ff ff ff 0a 00 00 00 00 00 00 00  p...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001e04af34>] process_preds+0x71a/0x1820
    [<000000003972c7f0>] apply_subsystem_event_filter+0x3be/0x932
    [<000000009ca32334>] subsystem_filter_write+0x5a/0x90
    [<0000000072da2bee>] vfs_write+0xe1/0x240
    [<000000004f14f473>] ksys_write+0xb4/0x150
    [<00000000a968b4a0>] do_syscall_64+0x6d/0x1e0
    [<000000001a189f40>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Link: http://lkml.kernel.org/r/20191211091258.11310-1-keitasuzuki.park@sslab.ics.keio.ac.jp

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 404a3add43c9c ("tracing: Only add filter list when needed")
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1642,7 +1642,7 @@ static int process_system_preds(struct t
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
-	kfree(filter);
+	__free_filter(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
 		tracepoint_synchronize_unregister();


