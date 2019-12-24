Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C11C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FC62071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="cJ+uugMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLXR5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:57:38 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42620 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfLXR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:57:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id u17so6029579uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sICKJX3/XI07f0teIy07j5x3F/fvE6TXsmzD4IPgBEI=;
        b=cJ+uugMgU+MeJjbaPQLMy9EhEyXAX0iyHATDur4uNYSczLt5jXUSaEh+ROV0QfiPs5
         j+e8Kq4dDSoOZwrh/oLSjlDMJr/8fCyfJE3mf/g4MyxzFFPtLJQawta84h9xJU4bvGXE
         7Zf/uQ9kPYou4sGmaLGLRewwk5gSc9ASPoT06f7+2mUxld/0caN6MuFmjAshvNwwPXoa
         Q48RK4uY+BwqAkj50/OMP7SB5PMNNKfM3tRGU29tIh7goYswD9wYP7ejZJPBx/nlc6/J
         ae3TyB05UYMfuCUkJtwGLEvmKuknmgr/XRsNQPRgqHD7V/ieHApxzNwwdx2deA3GevaE
         FrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sICKJX3/XI07f0teIy07j5x3F/fvE6TXsmzD4IPgBEI=;
        b=d7IEEXz+UCNXeNII7FxvEe/jNNiP1qJOvlvULtdBlMEEK5VflHeGO22kDYuB0UecUc
         d7xZ+hwX4u3RTmXkAaHjs/tmSH1hkRqZpz+t9CIBgGKAKnf3Zhl1I3gLVdpYWZym5gGD
         2Ho34NLlDu5/ZcITWG+FpXzHnFSjhblmt3r70OZJqC4cijyb984rb7X7YCl0fRr0j0wb
         qWFEmCfPIYiFqY3y1jLQUNXbhC106OFELdLHyXYjHc/ejR4VYQYH6m7MWh1YUK3Wwf2L
         mtT77Y7ryyFDITT2BFerB38lauoBs0daz1MMRDALD3AOFeOLkXyNACh5RNMAk/P77asB
         +7Zg==
X-Gm-Message-State: APjAAAXEb5koDUOTHV52ZQoqIyg9tQ5JR3gD0kyCUpFjJstk6qaXnGtJ
        SEp+GY9R9CpJtn3IFWrNAt25tA==
X-Google-Smtp-Source: APXvYqzj+fc3EKmaXr7lc7UizYcF4Up9tNbB+IUXs6Ba9pxCzBTWFHS2nRcUlqHtb0vlaED4G6xh5A==
X-Received: by 2002:ab0:2a1a:: with SMTP id o26mr22237892uar.62.1577210257342;
        Tue, 24 Dec 2019 09:57:37 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id o132sm3366621vke.2.2019.12.24.09.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 09:57:36 -0800 (PST)
Date:   Tue, 24 Dec 2019 12:57:36 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com
Subject: [PATCH 2/3] docs: ftrace: Fix typos
Message-ID: <638f1c8b6f4a47e4e25b62a01fe960e70a8364bc.1577209218.git.frank@generalsoftwareinc.com>
References: <cover.1577209218.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577209218.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor typos in the doc.

Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 5a037bedbf6a..6c9f40d5a2f9 100644
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
-- 
2.17.1

