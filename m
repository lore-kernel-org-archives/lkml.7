Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020AC28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8926F27564
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396118;
	bh=5s0BY3y/LEMma9RGzlqGAsLaSIhKj8hnh+bloAVdmM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=waAt/XTwxXip4ltqZC8thyQII5HXzDZHbJ7QTcrjcuL26vNggVx8TjLOGTiomQbyv
	 rWBuRF210Q2tryoFMnbC+XA1G1flb2aD28WB2Dr5XBeL5rn7P2WG5L0SSARdcGb3oL
	 s4fPBsRUTC1fWxJfAo6Tp7XWyx3Vjzmkm8h1l25U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfFANfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfFANXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E66C264C3;
        Sat,  1 Jun 2019 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395404;
        bh=5s0BY3y/LEMma9RGzlqGAsLaSIhKj8hnh+bloAVdmM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1KPbsk2k2UMgqNbngoZAdw4NE9tCNKtMYdzZljs5IPY+beusLc7LafYiqxBJaz8O
         4dQH/0X4VxAlK//64kewQCBqORPzFy6c4i6aIl+iNs44WX7oIm1501A/QH/JxKuJ5b
         +nAXgmlBd8zl6/3Zjw2/hMSYr+tZvtHmaThoFJAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Elazar Leibovich <elazar@lightbitslabs.com>,
        Orit Wasserman <orit.was@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 044/141] tracing: Fix partial reading of trace event's id file
Date:   Sat,  1 Jun 2019 09:20:20 -0400
Message-Id: <20190601132158.25821-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elazar Leibovich <elazar@lightbitslabs.com>

[ Upstream commit cbe08bcbbe787315c425dde284dcb715cfbf3f39 ]

When reading only part of the id file, the ppos isn't tracked correctly.
This is taken care by simple_read_from_buffer.

Reading a single byte, and then the next byte would result EOF.

While this seems like not a big deal, this breaks abstractions that
reads information from files unbuffered. See for example
https://github.com/golang/go/issues/29399

This code was mentioned as problematic in
commit cd458ba9d5a5
("tracing: Do not (ab)use trace_seq in event_id_read()")

An example C code that show this bug is:

  #include <stdio.h>
  #include <stdint.h>

  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <unistd.h>

  int main(int argc, char **argv) {
    if (argc < 2)
      return 1;
    int fd = open(argv[1], O_RDONLY);
    char c;
    read(fd, &c, 1);
    printf("First  %c\n", c);
    read(fd, &c, 1);
    printf("Second %c\n", c);
  }

Then run with, e.g.

  sudo ./a.out /sys/kernel/debug/tracing/events/tcp/tcp_set_state/id

You'll notice you're getting the first character twice, instead of the
first two characters in the id file.

Link: http://lkml.kernel.org/r/20181231115837.4932-1-elazar@lightbitslabs.com

Cc: Orit Wasserman <orit.was@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 23725aeeab10b ("ftrace: provide an id file for each event")
Signed-off-by: Elazar Leibovich <elazar@lightbitslabs.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f94be0c2827b0..7345f5f8f3fe6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1318,9 +1318,6 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 	char buf[32];
 	int len;
 
-	if (*ppos)
-		return 0;
-
 	if (unlikely(!id))
 		return -ENODEV;
 
-- 
2.20.1

