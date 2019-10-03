Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1872CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22D421848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118357;
	bh=UlT1vVNnYM1l4hs0IoF416jJpsFv0w3g3CY/qZ0IhEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=og8mbAIVk18F78I8Zm117mMNzv8nGmMnvYv40eFFYPkYyGUCxsoEXIY6TM6iSfaii
	 u1h7h4fT6GxGVBqB9emIJWIFWahXH772eMNLDvILDrJg01wD/yWR7VcdcDuN8++OfP
	 /nu5floPOw0/OPLH8vMlKzWuTPGUvPJLh9y0LJZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfJCP7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbfJCP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9768D21783;
        Thu,  3 Oct 2019 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118351;
        bh=UlT1vVNnYM1l4hs0IoF416jJpsFv0w3g3CY/qZ0IhEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9rHmToFIGH9S1/HSKowSBitTcrBgw50qvwNkPKqarTbNYxUSDXBNS6ZjF+iJCkVl
         FxyuyT9cmR17b3yjADQoug+P85Ypva69K3aW216aSej+LYiSbW88rhjkrwu+clB0mz
         q4txaK+tii6t5vHfrqnyMCRcFnf8JQ5dFDcIa2e8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 78/99] printk: Do not lose last line in kmsg buffer dump
Date:   Thu,  3 Oct 2019 17:53:41 +0200
Message-Id: <20191003154334.935575003@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit b46eff55ad5bd98e746c0a7022fe7ee071de5fee ]

kmsg_dump_get_buffer() is supposed to select all the youngest log
messages which fit into the provided buffer.  It determines the correct
start index by using msg_print_text() with a NULL buffer to calculate
the size of each entry.  However, when performing the actual writes,
msg_print_text() only writes the entry to the buffer if the written len
is lesser than the size of the buffer.  So if the lengths of the
selected youngest log messages happen to precisely fill up the provided
buffer, the last log message is not included.

We don't want to modify msg_print_text() to fill up the buffer and start
returning a length which is equal to the size of the buffer, since
callers of its other users, such as kmsg_dump_get_line(), depend upon
the current behaviour.

Instead, fix kmsg_dump_get_buffer() to compensate for this.

For example, with the following two final prints:

[    6.427502] AAAAAAAAAAAAA
[    6.427769] BBBBBBBB12345

A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
patch:

 00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
 00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

After this patch:

 00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 35 36 36 37 38  <0>[    6.456678
 00000010: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

Link: http://lkml.kernel.org/r/20190711142937.4083-1-vincent.whitchurch@axis.com
Fixes: e2ae715d66bf4bec ("kmsg - kmsg_dump() use iterator to receive log buffer content")
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.5+
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3048,7 +3048,7 @@ bool kmsg_dump_get_buffer(struct kmsg_du
 	seq = dumper->cur_seq;
 	idx = dumper->cur_idx;
 	prev = 0;
-	while (l > size && seq < dumper->next_seq) {
+	while (l >= size && seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
 		l -= msg_print_text(msg, prev, true, NULL, 0);


