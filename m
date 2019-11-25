Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD6BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 04:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7490207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 04:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="iVnF55OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKYEio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:38:44 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40324 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKYEin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 23:38:43 -0500
Received: by mail-vs1-f65.google.com with SMTP id m9so9142282vsq.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 20:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/1EK85gV2xzpYVPN8XZ+VyAr2nvnXehztAHoG5Uwuo=;
        b=iVnF55OFYqH3adApUlTdJ7wNdQcTaUz0vcEss0b3GFq0c3xA0LRLArzMOTgStT15gG
         2BZJ/71VDuHZHNU7WN79Faj9MrqhW9VybX5sOBxDqH0goyQtN4NEsyhSjyq/viUhNr5n
         eH65h1wv1uB0o/eMF6eB2ZYtS1l8a1DLmNRbUz1AynwTWdUQPSB2YVMwyV7EfLXPECyp
         O66nHJVC2sMmO2DNxiQrtk7iggYx2ZbnJSmn4qcyumzISiHl1SujO30BMuTGVqSqzKHW
         S2crWtOUqZtoyOF0zFQLfQnW53BWvm0pLoiS9v/n0tq6qtDZH7yHw02L3eoK0X6Alnt+
         uo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/1EK85gV2xzpYVPN8XZ+VyAr2nvnXehztAHoG5Uwuo=;
        b=sqNzrrM2ONyQxz4mbbgv4qeSKvKw7SePv6bL5uEun1RyQ9APU0m9VVN3gyj6ai0wJa
         hUrh+7k6G/IoI19KotZlD0M2K/4WVr+VcAvLgwJLteShrqg5vBYaezk435JoE7xgZz4X
         Q978ljpwo0MYiSpfrwwUoZT0BRGFq0D401M8yExuakZMcnSVI3W3zwzQpLCVmYQ13Zg4
         Lb5NnTeaKG69w0SBRUJI+eoDKsb0/QPGJV/9BvVpUt+coLRiDkiahRSfUykPY70X88IF
         tFzkUFjmiKh6hw+wp86Rr5UnfyK6NdY4slo4cvNz1k/2+nOKFObRk5+fPTmlNY66UJYM
         7KeA==
X-Gm-Message-State: APjAAAWiYvxDjccs/0jlk4yOnVIkXYSBEO/xn7+x/JmjaQAmXtsfxUj+
        L7sGyIsllpyiCbe3ROBCftFbtPpR2JLCAw==
X-Google-Smtp-Source: APXvYqyKTt+LUQk2+QaI4iFwqc7D1j2lcRZOw0IRERUBl1oH0xdy53tPTcu5z8l6AmvxkstlbY+mXA==
X-Received: by 2002:a05:6102:2e7:: with SMTP id j7mr18637370vsj.101.1574656722382;
        Sun, 24 Nov 2019 20:38:42 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id j133sm1782410vke.35.2019.11.24.20.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 20:38:41 -0800 (PST)
Date:   Sun, 24 Nov 2019 23:38:41 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org
Subject: [RFC v2 2/2] docs: ftrace: Fix typos
Message-ID: <a843617511989679b29fbd62b1b8b3e991f2101e.1574655670.git.frank@generalsoftwareinc.com>
References: <cover.1574655670.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574655670.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor typos in the doc.

Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst             | 6 +++---
 Documentation/trace/ring-buffer-design.txt | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 2b21068ebf8e..9e7b45485ea1 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -236,7 +236,7 @@ of ftrace. Here is a list of some of the key files:
 	This interface also allows for commands to be used. See the
 	"Filter commands" section for more details.
 
-	As a speed up, since processing strings can't be quite expensive
+	As a speed up, since processing strings can be quite expensive
 	and requires a check of all functions registered to tracing, instead
 	an index can be written into this file. A number (starting with "1")
 	written will instead select the same corresponding at the line position
@@ -383,7 +383,7 @@ of ftrace. Here is a list of some of the key files:
 
 	By default, 128 comms are saved (see "saved_cmdlines" above). To
 	increase or decrease the amount of comms that are cached, echo
-	in a the number of comms to cache, into this file.
+	in the number of comms to cache, into this file.
 
   saved_tgids:
 
@@ -3325,7 +3325,7 @@ directories after it is created.
 
 As you can see, the new directory looks similar to the tracing directory
 itself. In fact, it is very similar, except that the buffer and
-events are agnostic from the main director, or from any other
+events are agnostic from the main directory, or from any other
 instances that are created.
 
 The files in the new directory work just like the files with the
diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation/trace/ring-buffer-design.txt
index ff747b6fa39b..2d53c6f25b91 100644
--- a/Documentation/trace/ring-buffer-design.txt
+++ b/Documentation/trace/ring-buffer-design.txt
@@ -37,7 +37,7 @@ commit_page - a pointer to the page with the last finished non-nested write.
 
 cmpxchg - hardware-assisted atomic transaction that performs the following:
 
-   A = B iff previous A == C
+   A = B if previous A == C
 
    R = cmpxchg(A, C, B) is saying that we replace A with B if and only if
       current A is equal to C, and we put the old (current) A into R
-- 
2.17.1

