Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F00CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51532206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfJGSau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:30:50 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:49815 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729335AbfJGSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:30:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6D0351802E6D3;
        Mon,  7 Oct 2019 18:30:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sort50_6e6fb6466222
X-Filterd-Recvd-Size: 3066
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 18:30:47 +0000 (UTC)
Message-ID: <cce61906a5f7f42f5b2b8b947fc61357bcb56e71.camel@perches.com>
Subject: [PATCH] sgi-gru: simplify procfs code some more
From:   Joe Perches <joe@perches.com>
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Oct 2019 11:30:46 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use seq_puts and simple string output and not seq_printf with formats
and individual strings to reduce overall object size.

$ size drivers/misc/sgi-gru/gruprocfs.o* (x86-64 defconfig with gru)
   text	   data	    bss	    dec	    hex	filename
   7006	      8	      0	   7014	   1b66	drivers/misc/sgi-gru/gruprocfs.o.new
   7472	      8	      0	   7480	   1d38	drivers/misc/sgi-gru/gruprocfs.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/misc/sgi-gru/gruprocfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sgi-gru/gruprocfs.c b/drivers/misc/sgi-gru/gruprocfs.c
index 3a8d76d1ccae..2817f4751306 100644
--- a/drivers/misc/sgi-gru/gruprocfs.c
+++ b/drivers/misc/sgi-gru/gruprocfs.c
@@ -119,7 +119,7 @@ static int mcs_statistics_show(struct seq_file *s, void *p)
 		"cch_interrupt_sync", "cch_deallocate", "tfh_write_only",
 		"tfh_write_restart", "tgh_invalidate"};
 
-	seq_printf(s, "%-20s%12s%12s%12s\n", "#id", "count", "aver-clks", "max-clks");
+	seq_puts(s, "#id                        count   aver-clks    max-clks\n");
 	for (op = 0; op < mcsop_last; op++) {
 		count = atomic_long_read(&mcs_op_statistics[op].count);
 		total = atomic_long_read(&mcs_op_statistics[op].total);
@@ -165,8 +165,7 @@ static int cch_seq_show(struct seq_file *file, void *data)
 	const char *mode[] = { "??", "UPM", "INTR", "OS_POLL" };
 
 	if (gid == 0)
-		seq_printf(file, "#%5s%5s%6s%7s%9s%6s%8s%8s\n", "gid", "bid",
-			   "ctx#", "asid", "pid", "cbrs", "dsbytes", "mode");
+		seq_puts(file, "#  gid  bid  ctx#   asid      pid  cbrs dsbytes    mode\n");
 	if (gru)
 		for (i = 0; i < GRU_NUM_CCH; i++) {
 			ts = gru->gs_gts[i];
@@ -191,10 +190,8 @@ static int gru_seq_show(struct seq_file *file, void *data)
 	struct gru_state *gru = GID_TO_GRU(gid);
 
 	if (gid == 0) {
-		seq_printf(file, "#%5s%5s%7s%6s%6s%8s%6s%6s\n", "gid", "nid",
-			   "ctx", "cbr", "dsr", "ctx", "cbr", "dsr");
-		seq_printf(file, "#%5s%5s%7s%6s%6s%8s%6s%6s\n", "", "", "busy",
-			   "busy", "busy", "free", "free", "free");
+		seq_puts(file, "#  gid  nid    ctx   cbr   dsr     ctx   cbr   dsr\n");
+		seq_puts(file, "#             busy  busy  busy    free  free  free\n");
 	}
 	if (gru) {
 		ctxfree = GRU_NUM_CCH - gru->gs_active_contexts;


