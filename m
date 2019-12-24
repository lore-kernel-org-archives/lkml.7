Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99037C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F92071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="GX4NEHxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLXR4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:56:55 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36843 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfLXR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:56:55 -0500
Received: by mail-vk1-f194.google.com with SMTP id i4so5285422vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6JkYU0nutAHI9fyqNTIL32WnpIq1wjmijBcPApKYOGg=;
        b=GX4NEHxa/eNvv8Upt1fHOxVZ1O6oIZjoUX9zbKrPdkG8See6tu+JA8VMgMDhiHp/gr
         HaqXEA7jKLJ/dv5EEyDX24qIe7f5fN5YmH3T38+FuLLfXeMUtsAup7vlnhnO4i3+Ge41
         bwKHVK+j2/7kKMht56OeVUBE+mNmwlsif2tom39GyuVye2eeib+qIqCi2P74eecIpGlN
         ptR76RtaYvFF7MAyTX1HbAnzXSu7YCZCP3Ulx6nWxMtEkH35Y3VGvfeujyu1L1nl+Ky0
         as+t68bmCol3yspwYI+toTFAgDmUgKtNliUyzL5d9evZVHa8qsFQaJaH2sAP7VnVQ6Y9
         ahGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6JkYU0nutAHI9fyqNTIL32WnpIq1wjmijBcPApKYOGg=;
        b=pEC0sYHd9sMzPPiQxsEzCXcPnBiamHqogEw1QXTFBWynQyYH1FNakJb6HGMbKM8FIK
         mDN+V4xNOKXdy1NH+ZDccoAZC6OPrnqBzdufhlG0XAhjNQRLMmW9U5/HR1ZxXLDnku2j
         nov184G5Qyjkw8pxq/lNMImLIb6Go/7p0CWE5tV4Y42blgqAcjbCVrOQ9m04e2FpiUEy
         3EoybC1BwguZbJquzszKRv6J7I5oQrH8aR4NWwtOCMydh+Lk1E6YsW1GmE+hvVmOaYHV
         rzBuHcDNZyuTspR0Nn3EbEkNddhxWdidzlB7ZdZC6PHkDi0Tm4udxbRVrQBbRSrZBdhb
         hGYQ==
X-Gm-Message-State: APjAAAUrSngZLfvD2XtCkLLIyY4zL2XeXynOTTvmkc3PBDXXO0r7dx4y
        HMOfcGuJaxNmSpGiM7N+y7tARA==
X-Google-Smtp-Source: APXvYqyjBZ1NurPGO+HgSYVLXT6SowxhxEuP5FAEl6GUlAxrm05M+ZjmQe2kv4+aqF0wFzrxvE4Awg==
X-Received: by 2002:a1f:20c2:: with SMTP id g185mr21903533vkg.44.1577210213987;
        Tue, 24 Dec 2019 09:56:53 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id z17sm7132492vkb.5.2019.12.24.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 09:56:53 -0800 (PST)
Date:   Tue, 24 Dec 2019 12:56:53 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com
Subject: [PATCH 1/3] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <6f33be5f3d60e5ffc061d8d2b329d3d3ccf22a8c.1577209218.git.frank@generalsoftwareinc.com>
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

The current text could mislead the user into believing that the number
of pages allocated by each CPU ring buffer is calculated by the round
up of the division: buffer_size_kb / PAGE_SIZE.

Clarifies that a few extra pages may be allocated to accommodate buffer
management meta-data.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d2b5657ed33e..5a037bedbf6a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -185,7 +185,8 @@ of ftrace. Here is a list of some of the key files:
 	CPU buffer and not total size of all buffers. The
 	trace buffers are allocated in pages (blocks of memory
 	that the kernel uses for allocation, usually 4 KB in size).
-	If the last page allocated has room for more bytes
+	A few extra pages may be allocated to accommodate buffer management
+	meta-data. If the last page allocated has room for more bytes
 	than requested, the rest of the page will be used,
 	making the actual allocation bigger than requested or shown.
 	( Note, the size may not be a multiple of the page size
-- 
2.17.1

