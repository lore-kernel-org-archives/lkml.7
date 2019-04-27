Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CEEC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9D4206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfD0PSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:18:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34210 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbfD0PPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:38 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP38-0000zL-4u; Sat, 27 Apr 2019 16:15:34 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004TA-Ft; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eugene Loh" <eugene.loh@oracle.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.129114130@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 069/202] kallsyms: Handle too long symbols in kallsyms.c
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eugene Loh <eugene.loh@oracle.com>

commit 6db2983cd8064808141ccefd75218f5b4345ffae upstream.

When checking for symbols with excessively long names,
account for null terminating character.

Fixes: f3462aa952cf ("Kbuild: Handle longer symbols in kallsyms.c")
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -121,8 +121,8 @@ static int read_symbol(FILE *in, struct
 			fprintf(stderr, "Read error or end of file.\n");
 		return -1;
 	}
-	if (strlen(str) > KSYM_NAME_LEN) {
-		fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
+	if (strlen(str) >= KSYM_NAME_LEN) {
+		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
 			str, strlen(str), KSYM_NAME_LEN);
 		return -1;

