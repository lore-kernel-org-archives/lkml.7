Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41429C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC52053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="gesTRIR6";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="Sdc6lEhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEFRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:50:37 -0400
Received: from mail133-31.atl131.mandrillapp.com ([198.2.133.31]:9935 "EHLO
        mail133-31.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbfEFRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:50:36 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 13:50:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=qZUWN1kEJ7Nm/rElYRgeKRzf22qzOgyt1hGga7WcdSQ=;
 b=gesTRIR6LDf8YcS9zLoRDJMivzaaBsbLOfZBe9CT9hI2eNC5lEq5DpzjVk06J2Yqwls68vtejVFP
   f4o1vG/Q9uI1nZuSBhMT92dWr9Fw1aZ/x4a59XFkKnkpPHNXTCoEJ07So1tFhfbcfqajdh//VxPp
   JL7yaLdzyQ2cZ+MHOZo=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-31.atl131.mandrillapp.com id hq1pum1sar8v for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 17:20:46 +0000 (envelope-from <bounce-md_31050260.5cd06cee.v1-f8d245da4ae841b3af7ef1de2104dc03@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1557163246; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=qZUWN1kEJ7Nm/rElYRgeKRzf22qzOgyt1hGga7WcdSQ=; 
 b=Sdc6lEhxvTqK/oRgEBz9bpOyYs3iJQ6uq3yJZh+l7IMYP+snij2yP3q8B73gJkNgJQVy55
 WMXhgcOpvt4kDMdAvnu36udb3KzS13w31mice/OPo8fUF9ONxNZgcIxw6bDsINMqp5Tt7OnJ
 Ds+Vel3v1WfAe0JqNtNZUb7HpX1Qw=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 1/3] dtlk: remove double call to nonseekable_open
Received: from [87.98.221.171] by mandrillapp.com id f8d245da4ae841b3af7ef1de2104dc03; Mon, 06 May 2019 17:20:46 +0000
X-Mailer: git-send-email 2.20.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <184012ad69b275a17d6fa40a8d4dcf15ef76c4d2.1557162679.git.kirr@nexedi.com>
In-Reply-To: <cover.1557162679.git.kirr@nexedi.com>
References: <cover.1557162679.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.f8d245da4ae841b3af7ef1de2104dc03
X-Mandrill-User: md_31050260
Date:   Mon, 06 May 2019 17:20:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtlk_open currently has 2 calls to nonseekable_open which are both
executed on success path. It was not hurting to make the extra call as
nonseekable_open is only changing file->f_flags in idempotent way.
However the first nonseekable_open is indeed both unneeded and looks
suspicious.

The first nonseekable_open was added in 6244f13c51 ("Fix up a couple of
drivers - notable sg - for nonseekability."; 2004-Aug-7). The second
nonseekable_open call was introduced in dc5c724584 ("Remove ESPIPE logic
from drivers, letting the VFS layer handle it instead.; 2004-Aug-8). The
latter patch being mass change probably missed to remove
nonseekable_open that was introduced into dtlk_open the day before.

Fix it: remove the extra/unneeded nonseekable_open call and leave the
call to nonseekable_open only on the path where we are actually opening
the file.

Suggested-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 drivers/char/dtlk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
index f882460b5a44..669c3311adc4 100644
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -298,7 +298,6 @@ static int dtlk_open(struct inode *inode, struct file *file)
 {
 	TRACE_TEXT("(dtlk_open");
 
-	nonseekable_open(inode, file);
 	switch (iminor(inode)) {
 	case DTLK_MINOR:
 		if (dtlk_busy)
-- 
2.20.1
