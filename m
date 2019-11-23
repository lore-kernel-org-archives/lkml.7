Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A1BC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272820719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N85SUdQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfKWN21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:27 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39544 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKWN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkc000733;
        Sat, 23 Nov 2019 22:27:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkc000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515660;
        bh=7GX2WjlpLbqGoaEHNabrSpwDglBUHJ7U4pgd8VDnbJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N85SUdQujbubtocMqLhU8ab+LMgOFbjmqCW2+pDR5QuUdFSlVXl1WfcDuc2YIl1DP
         LhpXB5v9kq586eMLSiXzINnuMSKD3TMchRKDq00iMWpQRPT+fLJ/w+CHXpbnHe7qML
         5UYc8LlRI667jDTiqQlL0p61zE8KsnB8WCaE67lQ1DAExl+p39H5Vwzx+G7eN/HT6d
         ZvnfSjD4jUR4g49QEpc9mlDT9PDNXbNnUt5mfa7EbZlhefjvU8XAAp286O5Um5J5aN
         9h4SN8UWq06tlNo0qLHiZoxpWxe0Z8YT6avbsYoYuuAJz0RbFVGmc/2Z4PKFr+6HN1
         C4kV72XZoqNNg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] scripts/kallsyms: set relative_base more effectively
Date:   Sat, 23 Nov 2019 22:27:14 +0900
Message-Id: <20191123132727.30151-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, record_relative_base() iterates over the entire table to
find the minimum address, but it is not efficient because we sort
the table anyway.

After sort_symbol(), the table is sorted by address. (kallsyms parses
the 'nm -n' output, so the data is already sorted by address, but this
commit does not rely on it.)

Move record_relative_base() after sort_symbols(), and take the first
non-absolute symbol value.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 79641874d860..0959e1de381c 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -731,11 +731,15 @@ static void record_relative_base(void)
 {
 	unsigned int i;
 
-	relative_base = -1ULL;
 	for (i = 0; i < table_cnt; i++)
-		if (!symbol_absolute(&table[i]) &&
-		    table[i].addr < relative_base)
+		if (!symbol_absolute(&table[i])) {
+			/*
+			 * The table is sorted by address.
+			 * Take the first non-absolute symbol value.
+			 */
 			relative_base = table[i].addr;
+			return;
+		}
 }
 
 int main(int argc, char **argv)
@@ -758,9 +762,9 @@ int main(int argc, char **argv)
 	read_map(stdin);
 	if (absolute_percpu)
 		make_percpus_absolute();
+	sort_symbols();
 	if (base_relative)
 		record_relative_base();
-	sort_symbols();
 	optimize_token_table();
 	write_src();
 
-- 
2.17.1

