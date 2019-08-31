Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0F2187F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tpod4DNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHaUZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 16:25:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 16:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WhEmmlSfoWPVMMEnd4fAu09w+lcZbkWOYX9SlSyM9FQ=; b=tpod4DNP4f3Zzqv9BAj8TZsqP
        ZRAVFjuQfZBQmWbrwidT84LpRKOAvex27C72vzAy2eYupcoeCvuwVBXO8bJwCgj6WFhWCmN/0nabT
        ahE57OIzYaxZ8+b8V+0psf22YNlFbk6HbrAfLsXcvD6+nChaMnRBzHDbXYc+CC9hS/fUQpNRgR47a
        Hhjp7RBryRDRWmDOGuylEskx6sgmmm+QSG7bdqzN6qvYdiN3r7A+jyxjbsb8dTY9LtCgfwEyaTKf4
        0UzfcfNog9fGzjAAJDrTsGHASLBgLRP0kOs6qGaQRc8gM44fMbOWQDKAYAhyetqJloweqh9/mKWZD
        m9nf0FbLg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i49wJ-0005G8-By; Sat, 31 Aug 2019 20:25:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next RESEND] tracing: fix iomap.h build warnings
Message-ID: <8a706c7b-5209-4bdd-e09f-5c2d619d75f5@infradead.org>
Date:   Sat, 31 Aug 2019 13:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix 30 warnings for missing "struct inode" declaration (like these) by
adding a forward reference for it.
These warnings come from 'headers_check' (CONFIG_HEADERS_CHECK):
  CC      include/trace/events/iomap.h.s

./../include/trace/events/iomap.h:49:18: warning: 'struct inode' declared inside parameter list will not be visible outside of this definition or declaration
./../include/trace/events/iomap.h:77:18: warning: 'struct inode' declared inside parameter list will not be visible outside of this definition or declaration

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
---
Resend to correct maintainer(s).

 include/trace/events/iomap.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20190829.orig/include/trace/events/iomap.h
+++ linux-next-20190829/include/trace/events/iomap.h
@@ -44,6 +44,8 @@ DECLARE_EVENT_CLASS(iomap_page_class,
 		  __entry->length)
 )
 
+struct inode;
+
 #define DEFINE_PAGE_EVENT(name)		\
 DEFINE_EVENT(iomap_page_class, name,	\
 	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \


