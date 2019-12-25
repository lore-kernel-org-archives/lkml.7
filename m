Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA189C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F320679
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="X56ddrQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLYAGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:06:08 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38581 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfLYAGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:06:08 -0500
Received: by mail-vs1-f68.google.com with SMTP id v12so13243110vsv.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6JkYU0nutAHI9fyqNTIL32WnpIq1wjmijBcPApKYOGg=;
        b=X56ddrQAgTUH+6OaXULY/PlX326fEAR8fWv0+2AWiOkdsAzn4Hk9h0hUJC22q+AHA9
         gmgFOfnyC7OLGP91jG/SbhNYXrs5W9nI13evYoXWkbfW+CjPo3G2Fl27M3UaNYOF3g9L
         Vz5DQderiWDkdIZ+K+2DXodKCYJWnRyIndjS9402l+K/m4/WVktyFNH/2Z/w51jmZjvb
         tRDM5gr5BKTlTgsKx/G8Poo68MPkEvW0Xi9rx7UEYNgiqW0FEzAmwbi75VX1123EOOUV
         Xz3tgUr/kWRv26IWn+jsYA7IMEtIVQg+o8WDrx4S2cUxaTp3HyWu77dgn07TEqoyZ/di
         JFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6JkYU0nutAHI9fyqNTIL32WnpIq1wjmijBcPApKYOGg=;
        b=dDEWQ5bpLg9/0GLwls4nj6o3I/y+Yyk/gbVqMSH5mT2r3yVmxD/mKcD44RW6q0AqAW
         Vn9Myn3/Sv3KXvGApFU9yrQtGIpnlb0PF7mQ5DEEbPwT4mItAVo9fo3gGfNMQF0Xd8fT
         AmMFF6npj/2FNVj4ERJXjYq5Jwe/oRgZru4DG+fkgLrpD2sfLuItS4H01XkyiEQFTtRx
         ZZC97IebS2Z7nF6GIZPeuCQsN4dfWS0gVBzgs6E0lFlC3B/j6w8SC+IVPHfeSkCQ9oD5
         cFsLUjbGiCT6BuJOZGg1gNsFb1PWQc4LoJCJLbI83WyZX6UfwHw7mHqcL8TB/iLjpaM6
         8B8Q==
X-Gm-Message-State: APjAAAV+1wabF3K7LDPFquXqYulYn6d0+svMcTgA5EXve18wL5+9kiyv
        HIEi5KrNIrHOY3hkS6pwEVCrxg==
X-Google-Smtp-Source: APXvYqwWfe1HVNqBk5SEXAN2GpLyMDihtcCKHOewMfVOQsbgapX/oyvbfl11pLjomq4L5zYUu2BmmA==
X-Received: by 2002:a67:c484:: with SMTP id d4mr18418329vsk.4.1577232367106;
        Tue, 24 Dec 2019 16:06:07 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id n25sm7360013vkk.56.2019.12.24.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 16:06:06 -0800 (PST)
Date:   Tue, 24 Dec 2019 19:06:05 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH v3 1/3] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <6f33be5f3d60e5ffc061d8d2b329d3d3ccf22a8c.1577231751.git.frank@generalsoftwareinc.com>
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

