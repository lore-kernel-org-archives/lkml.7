Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CA7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250CC206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="rNUdDPYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLXXwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:52:04 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42607 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLXXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:52:03 -0500
Received: by mail-ua1-f65.google.com with SMTP id u17so6206983uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Idc35g1w0/GlmcsF+XXoVkvDVls2Q3kl8rta/LhgxNI=;
        b=rNUdDPYiCzhEgMM1U8c8mrjmiMCjqJFPZ+r2DygvtQ78GHZ/4jmOx6Fzkg48+U4wtR
         wypDZgaLCWWo0aLI3AMt66KI45rDKW01/1eVrwLdi9dIFXveceCrwoz+lhCMTmULVGqR
         nPaIALs/FT6v2LmL6PjjDO9mQyXliibiHakeDVTNvzxplhANkR+q8v5j7qFEDP062Icr
         CdM+GRjdxuZu9X9gDa5zJ8rTMZISVaD+Fv235eGN1SiUinNFDtRt/0rTUrRPqOoNbfCc
         haD8AoKJ6JfVdofWHxXjfLvWEJG/Sy6sfQo2yxRgbs2jnVm8K/y8Jnjr8hbdPsCS/Sz7
         EZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Idc35g1w0/GlmcsF+XXoVkvDVls2Q3kl8rta/LhgxNI=;
        b=DQOGqvYxHsUMDK/u+QbC3KSfBiTNtAERBqqju6mM+OLLJg3QZo7VgED+dqS4QI/tnB
         ZPHB4UqDmqh7JhWF7tjiXZlVckb75Ce/QINAGpMNKk6SIxLfURy0u6RgPs0GguOgsoiD
         9AqMGAXn5bXp99aRZIMaS6t6xkLptztEzvBv9vU0Gf/udxZwcelIuRrlh5k4xaIgtuUr
         Fw6tN8qMcRXDG4zdlbaYECTBFHGkmQ+iPhrOtY4Ctx1TNf9xo1s1QkQtatGDGQbPm3tH
         X2gIlEW4cs6K0H/3Lm9m6jjqRH+/CEskL6Z+AdQGoMGwNsMaKoFmsCM06gf2weIurIGd
         Hhtw==
X-Gm-Message-State: APjAAAX+c95Wl5Xh3mTYRy7kj3Pbv4B3IwSf3YTuTJkEAAPa5o9OGg2P
        WS/sxuYEqA6leoRlomATTXzhYQ==
X-Google-Smtp-Source: APXvYqxv7vc0KCp6Bc1Na95c3RUTHz1zfLjCxHUHEjfKcA2EG8fbxxU0Hx+YsyrqqsRde9cDed4fYQ==
X-Received: by 2002:ab0:5c8:: with SMTP id e66mr23539394uae.120.1577231522820;
        Tue, 24 Dec 2019 15:52:02 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id w125sm7331085vkh.50.2019.12.24.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 15:52:02 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:52:01 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH 2/3] docs: ftrace: Fix typos
Message-ID: <9ef705d0208a4ca0852fed69bc0838a589a4df85.1577230982.git.frank@generalsoftwareinc.com>
References: <cover.1577230982.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577230982.git.frank@generalsoftwareinc.com>
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

