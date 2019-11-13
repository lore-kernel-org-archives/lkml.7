Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A94204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="18309h9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfKMQcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:32:41 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:33106 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKMQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:32:41 -0500
Received: by mail-ua1-f46.google.com with SMTP id a13so867060uaq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pDKKsEnNSRaRtnTtkPfEq2dSlMtAaoLWzVsslXGiAh0=;
        b=18309h9PFFwMrlS/XYWNpakfrkLyFf5WzDSkRkznyRjceSIwnZc1mNodE+ZWZjDd46
         XWqzYpymjBA7c11tSENL50ARuSWF8gsMk8nwGV2UHCn8Di5UFWpQKoq7Yq4HMsd/TJOT
         rtmfa2/1EKe7LrY8HjjxXWgSdRsQXlY49MIcfDyeV5fu/CprhZKmQuCPvazseo7f+DDp
         mbzQoBB/iYc1WEXsQLM7mfzHRYgsvPW5TrxNxbTbhuTL/J4EyOCh3t4+G9oYpQ8fW+kW
         g9VghxVQ6sELRogY0wGDB67jZlWDfPnzdBjcGmRj8Hi505v+Qzjqyu3JFuJUsfXGwA7H
         GF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pDKKsEnNSRaRtnTtkPfEq2dSlMtAaoLWzVsslXGiAh0=;
        b=ho01cOrr3/mxR2Wpj7VJwih9/I401xtjIv/Equ9iv6vsWIDfjfll+hDXbXNojkiicc
         wSDcqx1bKnO6W2+ZsVhLZHNWMV23zuQ9b+xpmfko2Sc94/L55iRftGZQSl2J3ezAeSMr
         TVimU/KN2n/rInaMRYR0+w4F1WkzLFR0YaGnvag0AiwEYxIbLw93QKUbRzkGAAjCT86P
         FZQh0U1qDqGNYhroP1rqXnLrN8GOWNo9Gwfgz8oeUZKThamDVUa/LVBKu/RLyY8w6wRt
         RL4P6NWQfqcE5G1MwN5rB1LNHGPcnKPIJdO6tQop9Oupozxq84VJMh1QbwfrC39XX0yL
         n12w==
X-Gm-Message-State: APjAAAXWGDgIPAk3RrwDaNs3SlPnNV2Jv8EdoWtEg0X7ZvV6DLQy5YHZ
        BjbHGrAU8hiD8CdAc3s5hDAZVrvTCtLHdg==
X-Google-Smtp-Source: APXvYqx9moaQoSBbBI34MchfRiqFzHdBM7CLPKC6eS2MV1lVBMSwkkSDF+V4lf6h3qgkrlCcuUFuEQ==
X-Received: by 2002:a9f:3c13:: with SMTP id u19mr2369395uah.27.1573662758781;
        Wed, 13 Nov 2019 08:32:38 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id r15sm587351uap.19.2019.11.13.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 08:32:37 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:32:36 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org
Subject: [RFC 1/2] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573661658.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current text could mislead the user into believing that the number
of pages allocated by each CPU ring buffer is calculated by the round
up of the division: buffer_size_kb / PAGE_SIZE.

Clarify that the number of pages allocated is the round up of the
division: buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE). Add an
example that shows how the number of pages allocated could be off by
5 pages more compared with how the current text suggests it should be.

Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index e3060eedb22d..ec2c4eff95a6 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -188,8 +188,17 @@ of ftrace. Here is a list of some of the key files:
 	If the last page allocated has room for more bytes
 	than requested, the rest of the page will be used,
 	making the actual allocation bigger than requested or shown.
-	( Note, the size may not be a multiple of the page size
-	due to buffer management meta-data. )
+
+        The number of pages allocated for each CPU buffer may not
+        be the same than the round up of the division:
+        buffer_size_kb / PAGE_SIZE. This is because part of each page is
+        used to store a page header with metadata. E.g. with
+        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
+        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
+        page header with metadata) the number of pages allocated for each
+        CPU buffer is 1029, not 1024. The formula for calculating the
+        number of pages allocated for each CPU buffer is the round up of:
+        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).
 
 	Buffer sizes for individual CPUs may vary
 	(see "per_cpu/cpu0/buffer_size_kb" below), and if they do
-- 
2.17.1

