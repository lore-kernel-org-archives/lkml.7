Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE69C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B7C204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="XaiDIDDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfKMQda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:33:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41553 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKMQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:33:30 -0500
Received: by mail-vs1-f68.google.com with SMTP id 190so1745306vss.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMqO7kO+eGq0uCIQ1EQILqtM2ejcR6sdBUV13AtA/lk=;
        b=XaiDIDDtPVY40xuVO13Q/1v0UVMXCUMTz9cC7XOMCVRm1GcuhOAK9WCwAL0vdpJ3Il
         Jlw/rEZS2aFPaNetjY5RElc/Mfud2PtkVURTTzhq7z/Tzg6IzVx21Wt7xJVyVnQVbjjD
         eF1uGxtrs0jFLbYHX168KizsPTdPhvycgGSrjeTG9H2af0NI0nIyP43tgzsydTeXJQOD
         TnV59ZoVoN/zBwyBIIe+sPskrI9l++l7yvE+nYVsXaoKbvRW/Td7bPyEAiTMRuTxafzc
         edDMQG/94ozk80m58lfWGYU88wihBWMDGk5ZLYOB1Ch7F/wAND0IAjHvQ0zkTTjT7rcq
         6iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMqO7kO+eGq0uCIQ1EQILqtM2ejcR6sdBUV13AtA/lk=;
        b=RTL9mQ2yQ3fCVHR061IkNJA8BsRv5mVljXJW2rcTrDAukF+1TPLP4Ku+MFQ6aH80Jg
         jlYe0RzXUu2KuOGjKFEtiuRRuWB1k0l0I6tTdOxd5YHms86OB8gic8+oPFYBuQGD2R+i
         PSP06fQjROXW3VUokeRn4OWHAU0d8XFNxIEhj+a+1GFDAxka+Po5ulN0v2N5pmGPo9wr
         I4MLzbR/qJfV3QdTMJlV3wClL4HUEu1+vbgCdXwEqMKjf4VRoezcdoTghJDTW6Cp/40N
         LjEVIo1Osqz6XXO+oviBrLqqRWFKX0eY0Em+D4R1gIbYRwRa+O5SWeiHUpC0xORpHgwD
         Kyxg==
X-Gm-Message-State: APjAAAXu0nd3VblHrhTJizDCTQrUa4Bxybd4qRzqyJXXvR6VcehZhzw2
        jvjcWAkIugVteZ1N0EmMU/JPCw==
X-Google-Smtp-Source: APXvYqzI2uGfY1AjLJBGPLMwVGPxmNpIdIDSf0dVimu/BkUp0yx8RWSj5ex9NX6esogZOPKMKUVuzQ==
X-Received: by 2002:a05:6102:7ce:: with SMTP id y14mr2401899vsg.220.1573662808770;
        Wed, 13 Nov 2019 08:33:28 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id b26sm612034uaf.5.2019.11.13.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 08:33:28 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:33:27 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org
Subject: [RFC 2/2] ** do not apply this patch ** Just for illustration
 purposes
Message-ID: <141cb10cc2eabc5c3130496f12d84dd1ef247e20.1573661658.git.frank@generalsoftwareinc.com>
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

Prints a message that will allow us to evaluate the number of pages
allocated by each CPU buffer as well the main values that participate
in its calculation.

 $ echo 0 > /sys/kernel/debug/tracing/tracing_on
 $ echo 4096 > /sys/kernel/debug/tracing/buffer_size_kb
   .... e.g. of output:
   PAGE_SIZE: 4096, BUF_PAGE_HDR_SIZE: 16, size: 4194304, nr_pages: 1029

Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 66358d66c933..c10b6bcb29b9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1730,6 +1730,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 		return size;
 
 	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	printk(KERN_ALERT "PAGE_SIZE: %lu, BUF_PAGE_HDR_SIZE: %lu, size: %lu, nr_pages: %ld",
+	       PAGE_SIZE, BUF_PAGE_HDR_SIZE, size, nr_pages);
 
 	/* we need a minimum of two pages */
 	if (nr_pages < 2)
-- 
2.17.1

