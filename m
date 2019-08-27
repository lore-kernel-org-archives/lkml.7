Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFFEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EABE2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfH0QG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:06:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34063 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfH0QG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:06:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so2749485wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJQ3YPvF66148dHwd0LxCwhaCfiEwfreqcK+Q38PugE=;
        b=OTUjPJRpudIIqoWhpWAuhwv7DHRyDMuKN9ckovHh3XwPlj70mrGhgOnRW/lTRbJBlN
         V4asRmPcPoY43wajCmKURPDOGYlZaWgkpPfH7Ini7SSmcdKzCq9P5+MvL/XWY9TaQD4J
         gcfXDFkg6NcB7+W1YctlpULTFnqPmDPExW6Nj41pAek/7H+4F6NJzDD2ERb0OXpgOmfg
         FTkx1dV7kxLG5XrTCYitHnS6K81SrLGe783mljvCQ/6nKmQAyxs5Rff0o15klBcV/HSZ
         fKybSWghJk3hbpjlkmVHbLDlcP5YejIXL6KBEZ2tCiNQuOnZVxGMY7wEINLmVYyGpKUr
         V8+A==
X-Gm-Message-State: APjAAAWgbAVWFmqA7huIonuTq16czEcCW/SWhO7LDbUJkux0JmA6GMrA
        PWptMG7l55cGTVzRTIgNzk2Oyc6z
X-Google-Smtp-Source: APXvYqy9CPftcpgkgkjITnmepdRucCpop2334ZZCbmFMVGOkWMCiiJBc/5qYdPU7yb2pMPoQbdumPA==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr28751013wmc.126.1566921987104;
        Tue, 27 Aug 2019 09:06:27 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id t14sm14146684wrs.58.2019.08.27.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:06:26 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] ASN.1: Fix NULL check after strdup call
Date:   Tue, 27 Aug 2019 19:06:12 +0300
Message-Id: <20190827160612.11114-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strdup function returns a pointer to the newly allocated string,
or a NULL if an error occurred. Thus, grammar_name should be checked
right after strdup call. p variable can't be NULL in this context.
This follows from p check before the strdup call.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/asn1_compiler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index adabd4145264..985fb81cae79 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -625,7 +625,7 @@ int main(int argc, char **argv)
 	p = strrchr(argv[1], '/');
 	p = p ? p + 1 : argv[1];
 	grammar_name = strdup(p);
-	if (!p) {
+	if (!grammar_name) {
 		perror(NULL);
 		exit(1);
 	}
-- 
2.21.0

