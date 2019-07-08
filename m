Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC88C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2719821537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600135;
	bh=w8Z8cV22TAELzc0AoWADBasn7wG0myBmDUgyM4n5YNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vB1r1SELaM6fQXAG4XxUMgS7+zmCWyJ9HaohfiDsmz47ROcf3JibJQya7Ao+yeMaA
	 HgwvFMLe23V8l9XQh/WcLdpsAtheOxtc7aPuq0MmxF2rYY5HDTZD3CESQrAqpAw64L
	 0h9OgkUU8hzJayj1fZNLsmRHW49PaW8qLLLYmdLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbfGHPfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390926AbfGHPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:35:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B6B20665;
        Mon,  8 Jul 2019 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600119;
        bh=w8Z8cV22TAELzc0AoWADBasn7wG0myBmDUgyM4n5YNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2zHXrCMtQ7r+osY7fepAhPY1VYIgmopDV/1aRlKEU9+6I9KbyhG42C3KMJic8EEg
         PDlfHynfszBz3SxChlIL/ML2tMMHPVswpOcM0kyEAYZuYvtbfeKURCyZQ7lL0dHTEe
         wwlK8C2KWLQpbsJX1DweFcPuA4wKK3FW3k+Y6bFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5.1 95/96] fs: VALIDATE_FS_PARSER should default to n
Date:   Mon,  8 Jul 2019 17:14:07 +0200
Message-Id: <20190708150531.566385919@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit 75f2d86b20bf6aec0392d6dd2ae3ffff26d2ae0e upstream.

CONFIG_VALIDATE_FS_PARSER is a debugging tool to check that the parser
tables are vaguely sane.  It was set to default to 'Y' for the moment to
catch errors in upcoming fs conversion development.

Make sure it is not enabled by default in the final release of v5.1.

Fixes: 31d921c7fb969172 ("vfs: Add configuration parser helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -10,7 +10,6 @@ config DCACHE_WORD_ACCESS
 
 config VALIDATE_FS_PARSER
 	bool "Validate filesystem parameter description"
-	default y
 	help
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.


