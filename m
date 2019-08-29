Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F1D2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kfJGvl6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfH2VeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:34:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2VeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RQQPh7HUuYLWqBsw6FRzvsQQIdBccUjIH8yxqrd27Lg=; b=kfJGvl6n43AuCnzvFDtu8BcYr
        coMfqy8sGxRdpXHQ0nFpBX6wm07pksN7vm/jbNSS5cxj9YHXcSRAbZE2xFsYWHTmCGEkfrZbcMjvO
        0VCca+i5r2Ps8o8W8oVMzYZG7Z33+Dl0fwLqMTZtrN2BIsGx/ViYIxsUbcRyEiCL8L0tizTuP/G9G
        nG5wqW7p15BgCjsK1FkcO+PKVra+nZzlMz71aTlG4DcYpcpYM1dLMI2FTexaxT4BuSRsCj6/qVkpl
        HDGDHetwuNGYTgHX4kztmYC/7iv0UQHM3447vyDmbMVnJY75iaWcia2kYUUGQx7sop0IJIMZ46ZIH
        4xb4HDaWg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3S3f-0003Sr-Nh; Thu, 29 Aug 2019 21:34:19 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] tracing: silence noisy warnings about struct inode
Message-ID: <27a4b48e-9a63-d04e-64a1-081c1f6cab36@infradead.org>
Date:   Thu, 29 Aug 2019 14:34:18 -0700
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
---
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

