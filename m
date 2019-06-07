Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466B4208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HphELCqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfFGSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:25:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44589 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbfFGSZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:25:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1564192pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LJsPxMHN5mRLNhdY8OET9hdOhfdqbOfb/Za+S2jI47w=;
        b=HphELCqzG/dA6xqy7s90h9/+P4EvcS+84hXn397BERneYct0xpSifW9EfH06ato5Kz
         SCJILbDs46qAYnyrJCwLhCYm+J+4E3NeQCgClpNnUraXDxGdwR1CxbKEF/7n7po6KsUD
         ctpSUQYRvnXBYmQZp7shd4hlpivhIan1tFKLTWoN7NqgpfVIXuPHPc0P6dB8vDMCaipc
         DSAH0EhAXf73Qlrj2zcBWQFxz61/SZFieteWUlcjb+m2cI4DMFQKvjCA2FnOy4TSjvYm
         QFkqBQajmlNpM7Y6wDFNat7AfrFDVoTAIjlQMMoV0Pv+K9LHIAuia28AtF7W4kKWF6+2
         kyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LJsPxMHN5mRLNhdY8OET9hdOhfdqbOfb/Za+S2jI47w=;
        b=hMUG0kSPp0d5gxnu1gbhZ9C8K9JHFuUgFIEXyCq2MyuQYYunYhWYSMXpH1P71phzci
         XmjWomqeZbJx2dQGVcoVVe+YdtYKjbwy/zJDIsUtVAgWZM+p/VlDbs+fKLsvdQbkQoWo
         CVOOISK9L+PqfI5WIZiHw4hh2y+Tt7NMApPNd0srdbSeyoyiPPDsTH2F1xLxklusZ8zz
         /GFiFWaUgQk3HsKpL6tiP5WBiKJ/Vejp+5B6EhKrvtHH5qH8UgRqgtmWQpX9f7PKS3Vx
         5kT/Dn+9p6gWOBYbUTVZGZVLUWY5e9/erJlqAbHfSXfLApsG0yB6KGbn8DsguZegrgtl
         RC2A==
X-Gm-Message-State: APjAAAWPW0OISGoj93V6PxQS36yIpWv4W8ywljRountt+aiIVw6t7n3k
        ex+n7xoQjeXzP9vjUSiNpXDfRJ6BlDY=
X-Google-Smtp-Source: APXvYqzf4cIcL8M8wtsn3/Fn558uV8MfwDb5hvePNv/HoV9kguUhkbsa0EgiPRLXFauGKukOub8g/Q==
X-Received: by 2002:a17:90a:1706:: with SMTP id z6mr7055495pjd.108.1559931922601;
        Fri, 07 Jun 2019 11:25:22 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b17sm3036466pfb.18.2019.06.07.11.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:25:20 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/5] random: remove unnecessary unlikely()
Date:   Fri,  7 Jun 2019 14:25:13 -0400
Message-Id: <20190607182517.28266-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/char/random.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..bebf622c61c4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -759,10 +759,9 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		} while (unlikely(entropy_count < pool_size-2 && pnfrac));
 	}
 
-	if (unlikely(entropy_count < 0)) {
+	if (WARN_ON(entropy_count < 0)) {
 		pr_warn("random: negative entropy/overflow: pool %s count %d\n",
 			r->name, entropy_count);
-		WARN_ON(1);
 		entropy_count = 0;
 	} else if (entropy_count > pool_size)
 		entropy_count = pool_size;
@@ -1465,10 +1464,9 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 	if (ibytes < min)
 		ibytes = 0;
 
-	if (unlikely(entropy_count < 0)) {
+	if (WARN_ON(entropy_count < 0)) {
 		pr_warn("random: negative entropy count: pool %s count %d\n",
 			r->name, entropy_count);
-		WARN_ON(1);
 		entropy_count = 0;
 	}
 	nfrac = ibytes << (ENTROPY_SHIFT + 3);
-- 
2.17.0

