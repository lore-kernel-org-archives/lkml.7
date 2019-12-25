Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D24C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867DE20679
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="CXMiU9Ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLYAG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:06:29 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43202 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfLYAG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:06:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id s16so11690249vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 16:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Idc35g1w0/GlmcsF+XXoVkvDVls2Q3kl8rta/LhgxNI=;
        b=CXMiU9Ih6AXaoifwZjAboxubdU0AbFB3iA0NBanJeo46LgADnez6TZuvQVe3Jmj+Ox
         Iy31n932Xz9PI3G/rYsGaFrWvYa6Z5NdnL+8RA+cVHNSrWIVQIn/m833imgTG7kFzoQ+
         56J/Vc7Dvp2tjviVAHffCT056L7oUhADfxtWtiMwfEOQ3ro2QsiwV9vsDnTxYgAXSsGB
         iouR849vlADCstAAhErQWq2JmTHrpdB2OTUcG36Au7Js7+W/N2Zo/rSUov5zv0d0h6At
         IeM1hQPQ4YvI83ipM/STQa2Garb6xtZstf1nEHQRT2s0pRkg/fzSwGg2C9jad+PkDMfn
         C8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Idc35g1w0/GlmcsF+XXoVkvDVls2Q3kl8rta/LhgxNI=;
        b=rN7nyTC87XGrDmwT5OxUU4KRcjOuiJwdChY5lJD9abu6FG2Pcu1c6/J02yGuPSSeDt
         2An3hrg9NRY0dsZ4daBGh1hnyQDQgiSI+sTaSyq0zSvSNXWP0sUfpY5vS1rIXZkP9eJr
         BSwg2lVMXTnZ1HF8qC5XAB9XqN+9WJ5SqnLrle1lAP1UC045/2f4NVZIflbqnSIayn73
         KY5PQTSSm8vtzt5p4RjTROylaFbjDM3mBCk48nAH/X4jdfM6V0f94ktpQoDtprKYrBDT
         vk3G8rroJj0unSxiDvAK6SBaxazyOkSCk7+0SYqLn1Nkb59ZWr0rgcTFBG0O3oi9y0a0
         DVxA==
X-Gm-Message-State: APjAAAV7MXLQOiY2y+rqprxgJcamueFUbADtZ4HO+oGVSGH/vymArfRc
        Z6WK+g1Qa6PaXVl6OPHg5TxzXA==
X-Google-Smtp-Source: APXvYqyFrqqVDi2xavMq3jKeehmmxZ4jGfdxkqd5rypLfr6TF6LdZUlObipdWlwxf4m5AvV7KTcKLg==
X-Received: by 2002:a05:6102:405:: with SMTP id d5mr20539619vsq.94.1577232388286;
        Tue, 24 Dec 2019 16:06:28 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id v13sm3177665vsd.28.2019.12.24.16.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 16:06:27 -0800 (PST)
Date:   Tue, 24 Dec 2019 19:06:27 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH v3 2/3] docs: ftrace: Fix typos
Message-ID: <9ef705d0208a4ca0852fed69bc0838a589a4df85.1577231751.git.frank@generalsoftwareinc.com>
References: <cover.1577231751.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577231751.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor typos in the doc.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 5a037bedbf6a..1f6e0a794b1c 100644
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
+	the number of comms to cache into this file.
 
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

