Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65621D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="vn0WHtPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLRTP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:15:57 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:34132 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfLRTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:15:56 -0500
Received: by mail-vs1-f48.google.com with SMTP id g15so2155811vsf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E4X+tp6ZlTv3HTGbUp4WMcWmcsmZ7lp6RfccYvi6Rck=;
        b=vn0WHtPsCeyB7ZuaJQJMj9mWysnldTc9xeZIdeqP4+3+d6ztsAqgfknx/TbZf7tMiz
         dTatR/527dMLtlSjdJOoQdqXk0ck/fo8OdYWa4FOUxcWhnFRvDCZV2AU7D0W8vTLVOVy
         zRS9VZjW62b+l1LWQHOAAtPeQeokxxFaXe+Muz4UVhxdcnY1lkrsydWzcgo5wQXyYO2y
         I+vwWhlZWFPpHN7nh2J5kWgb3FomQueE2cxTLKyWLlmE51zMbNEPgQ+dfQnuZkAog/k8
         1DU2OP7LcPhyJ6etZfE6vMm+FVC9n5FQ37MyctT3tAfdTH1fPfUcDJZ8zFkA5pGlBly+
         qU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E4X+tp6ZlTv3HTGbUp4WMcWmcsmZ7lp6RfccYvi6Rck=;
        b=EyRWy5QjpWwtjzo5js4GJAhIme8JZsNAkrNWfG1GfwqR7ohLNklGBm3lJvr98nmurd
         03dnCrJEEUgQJmR6CLGVYLa/A0vXAT0DK5mt52ba1gu+1UfmOSRyCnKxLh4QyOE0+8Hd
         QEJ9gd6r8M7G0r1gfRMiWPzxbA7ShDhLNMbfjre3fAmWQZHhoLblzTfQmEWUOfsnEKXe
         HKjQptulOVWP15c8X3XkHAnNLWLc77Dt4i3sX5XN9hV2EwikoAzJMnBmY+Js4hOD7D7K
         smvm78f9xl8+yFwXrrapRT5bsx4hPazWn3jb1pkllK2rN7yXMfuL1vPpPouzIZdpYjdZ
         KDWA==
X-Gm-Message-State: APjAAAXBwzjNsxcgUfq9c70T3Oqwz+655l3S74cXutUxAYRkNsVO6F3B
        Fqd3Qlc6Sdz8dMvQXXVFLIF2mg==
X-Google-Smtp-Source: APXvYqw/ttgnVScl28xFvl7VA6vFHiQp9lh7gssrEstHml3An690zz7rANxDuaUFIWc7ge2X7Jaygg==
X-Received: by 2002:a67:fe50:: with SMTP id m16mr2520466vsr.114.1576696554730;
        Wed, 18 Dec 2019 11:15:54 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id p18sm788913vsq.0.2019.12.18.11.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:15:54 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:15:53 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, nachukannan@gmail.com,
        saiprakash.ranjan@outlook.com
Subject: [PATCH v2] docs: ftrace: Specifies when buffers get clear
Message-ID: <20191218191553.q4lwyxmquvtjzjfz@frank-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify a few places where the ring buffer and the "snapshot" buffer
are cleared as a side effect of an operation.

This will avoid users lost of tracing data because of these so far
undocumented behavior.

Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
Changes in v2:
  - Per Steven comment correct the fact that the "snapshot" buffer is
    not touched when writing in the "trace" file.
  - Use tab instead of spaces for alignment.

 Documentation/trace/ftrace.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d2b5657ed33e..46df39300d22 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -95,7 +95,8 @@ of ftrace. Here is a list of some of the key files:
   current_tracer:
 
 	This is used to set or display the current tracer
-	that is configured.
+	that is configured. Changing the current tracer clears
+	the ring buffer content as well as the "snapshot" buffer.
 
   available_tracers:
 
@@ -126,7 +127,8 @@ of ftrace. Here is a list of some of the key files:
 	This file holds the output of the trace in a human
 	readable format (described below). Note, tracing is temporarily
 	disabled when the file is open for reading. Once all readers
-	are closed, tracing is re-enabled.
+	are closed, tracing is re-enabled. Opening this file for
+	writing with the O_TRUNC flag clears the ring buffer content.
 
   trace_pipe:
 
@@ -490,6 +492,9 @@ of ftrace. Here is a list of some of the key files:
 
 	  # echo global > trace_clock
 
+	Setting a clock clears the ring buffer content as well as the
+	"snapshot" buffer.
+
   trace_marker:
 
 	This is a very useful file for synchronizing user space
-- 
2.17.1

