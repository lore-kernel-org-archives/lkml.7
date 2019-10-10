Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF981ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B8B21835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LA7cSGj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfJJPaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:30:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XF1dfGMSpDW66HI1cGgQOXZSop4na+NieFHtTNAhj2s=; b=LA7cSGj57rV+6/LL3KsTZxyFc
        zAqEnEmjCY1zPQijinIyjbcme2nevlFroU1bo6U6Bex4b6MfRIBccRh1lxiMeAmkfCasPXMvsu+UH
        7MUBioSfQAK1HV8/jNTxrF4y15cPVuMtdts9jTG0rRALJRd6uY/28AZ6GKZ3rYLHsVIgUDNNxDitC
        ZUTacSy/crM2KS51aqi7QmBMYvhasW1JWczpJzxeTdDpRz9Mk5n9kpn814KfMIYJ1r5BV225vQYnZ
        yTstuc0o6K2h8hshfuxLwJR8YxLkkAjQsR7eWGIcPyogsCdmT4E+6Na9nUoexBFwDhGxxOrToEOy5
        KKtQkYi9g==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIaOc-0006m5-0i; Thu, 10 Oct 2019 15:30:30 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] samples: watch_queue: depends on HEADERS_INSTALL
Message-ID: <32afa048-0b12-ce26-2bb0-7672dca8ffb8@infradead.org>
Date:   Thu, 10 Oct 2019 08:30:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Building samples/watch_queue/ uses installed headers, so make it
depends on HEADERS_INSTALL to prevent a build error.

../samples/watch_queue/watch_test.c:23:10: fatal error: linux/watch_queue.h: No such file or directory

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
---
 samples/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20191010.orig/samples/Kconfig
+++ linux-next-20191010/samples/Kconfig
@@ -171,6 +171,7 @@ config SAMPLE_VFS
 
 config SAMPLE_WATCH_QUEUE
 	bool "Build example /dev/watch_queue notification consumer"
+	depends on HEADERS_INSTALL
 	help
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.


