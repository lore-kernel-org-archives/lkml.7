Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64192205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639340;
	bh=kiG2Z147l4GuJ/myFhrqydpFyu3ZbV9OGO+gjWFZCQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKSDeRltNRN9fAzMawHzNThKhrz0ioKhp1SVRSjfGeqXFt+0XrOe+O6IKrs2+vTDm
	 7J+rKKuFuYWsuWMCqQA2k9Sn3ZrKM4T6rLN4YnRRJO5S6YRdrLT287DCH9tIPOdZsJ
	 0fOXu0KsfsTPWREj5nLtbM4oH27vaDv/ajByYCiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbfEWTWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389740AbfEWTWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:22:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F50821850;
        Thu, 23 May 2019 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639335;
        bh=kiG2Z147l4GuJ/myFhrqydpFyu3ZbV9OGO+gjWFZCQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9YiUv0CfhXY9EjcQS7HUdzacSvIdD0+bCbCTfAJZzveEL97BKX4TfDdE1ij995St
         uncHZH0bf55yEeOmaaSp4vXt8N4WyFad+sMixUAdK2M1zaBsEMBSjJ4Sji5fK4T8To
         ar9TdtkxPB31oz0t2GBgQg8kVhVRezJRylae4niA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Orit Wasserman <orit.was@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Elazar Leibovich <elazar@lightbitslabs.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 067/139] tracing: Fix partial reading of trace events id file
Date:   Thu, 23 May 2019 21:05:55 +0200
Message-Id: <20190523181729.548435244@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elazar Leibovich <elazar@lightbitslabs.com>

commit cbe08bcbbe787315c425dde284dcb715cfbf3f39 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1318,9 +1318,6 @@ event_id_read(struct file *filp, char __
 	char buf[32];
 	int len;
 
-	if (*ppos)
-		return 0;
-
 	if (unlikely(!id))
 		return -ENODEV;
 


