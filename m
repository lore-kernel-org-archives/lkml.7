Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65809C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 04:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B820725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 04:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="rfEhQFDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLPE17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 23:27:59 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45587 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfLPE17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 23:27:59 -0500
Received: by mail-vk1-f193.google.com with SMTP id g7so1249073vkl.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 20:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t+XRxHVrP9U17siccMaQ+m4HAah0KCw9evb79XHQSbE=;
        b=rfEhQFDihRv6E2ioKZN90QnWaa10oUN0+pBCvB+Pe4DWE9C86YsOoFqzCMpbPaDHoB
         eZshE7lGmNmvIoqJO80qDiqPSQUoeHw7cZNsrSk6f53WpqIz4iyKRXdNmF+X4PiRlsPx
         1iTMjLOSWhnEYSnA2Nf4+iuGewqFWFdAtAh6X+nDLAD+S5kc2juzVx+XcUpfRFy5vOPK
         soCt9Fpg79r6hXA8UUdFGzH2OVcKw5t7iv2vX5hnv2n05DlQ2F0VSFk1R1KINcIU1++1
         9/edRvzJyMy9bR+qcDYH8AFd+/b+pKZAQKB9xFsFmX2jEsh2tNTZtjwysXtDaD9XS3Gg
         zixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t+XRxHVrP9U17siccMaQ+m4HAah0KCw9evb79XHQSbE=;
        b=fRcDqniVrWBIt33Bdf9+Mcuk7liySzWZMdfRP2GS/B5DpWxi5rnQZA+c3o2OYAaFva
         gvEo2LnzNgYprBnU4BQw3swEaGeF/sqIkKDFaZ2eWhDC/Bh5mfsHsuVyOL7C39Tg4Ty7
         4Ii01ClORFRU4g6kd6S/C7V7ogQmVin/R0p6ddc35sjoIstjSg8B9FRTjHLussgSfPp/
         BtaKfddN7Ayet40oeaykdKWozWZHQF3mDeJyWOV7dtMr5aGXc4vixeZ8zgET8+bkEtnt
         NPa8ophIW41AT8Nzo4kdWNCusGhJQ/MCiLZbusiZ0fKTtKpLnwGAmIkP8A2kFc5mh73z
         aYBg==
X-Gm-Message-State: APjAAAX7B0GWJj12sIDfKi3+vBzDlyvJB8YSBwgb4Q4ahXAtLLR9jRgp
        OxkCVhPjl2KIeIPCT8zH87geAw==
X-Google-Smtp-Source: APXvYqw2N+LM/vdcn5AER3Ms5ZoSIyNZAqrZP0V5FuAy9A2SF01zP9VSfOK/wVM7wJDtYr+aajqZzQ==
X-Received: by 2002:a1f:434b:: with SMTP id q72mr23125511vka.53.1576470477855;
        Sun, 15 Dec 2019 20:27:57 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id l21sm6786902vsi.1.2019.12.15.20.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 20:27:57 -0800 (PST)
Date:   Sun, 15 Dec 2019 23:27:56 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, nachukannan@gmail.com,
        saiprakash.ranjan@outlook.com
Subject: [PATCH] docs: ftrace: Specifies when buffers get clear
Message-ID: <20191216042756.qnho3v2upqg4wm7o@frank-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify in a few places where the ring buffer and the "snapshot"
buffer are cleared as a side effect of an operation.

This will avoid users lost of tracing data because of these so far
undocumented behavior.

Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d2b5657ed33e..5cc65314e16d 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -95,7 +95,8 @@ of ftrace. Here is a list of some of the key files:
   current_tracer:
 
 	This is used to set or display the current tracer
-	that is configured.
+	that is configured. Changing the current tracer clears
+        the ring buffer content as well as the "snapshot" buffer.
 
   available_tracers:
 
@@ -126,7 +127,9 @@ of ftrace. Here is a list of some of the key files:
 	This file holds the output of the trace in a human
 	readable format (described below). Note, tracing is temporarily
 	disabled when the file is open for reading. Once all readers
-	are closed, tracing is re-enabled.
+	are closed, tracing is re-enabled. Opening this file for
+        writing with the O_TRUNC flag clears the ring buffer content
+        as well as the "snapshot" buffer.
 
   trace_pipe:
 
@@ -490,6 +493,9 @@ of ftrace. Here is a list of some of the key files:
 
 	  # echo global > trace_clock
 
+        Setting a clock clears the ring buffer content as well as the
+        "snapshot" buffer.
+
   trace_marker:
 
 	This is a very useful file for synchronizing user space
-- 
2.17.1

