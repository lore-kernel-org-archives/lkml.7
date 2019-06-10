Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B00DC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BDD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1SjbKam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbfFJTOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:14:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34602 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389353AbfFJTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id q64so6227258vsd.1;
        Mon, 10 Jun 2019 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+OkbCIxuFLegTVpH06BqaBwHcYDWj2efUoxZ29HmLU=;
        b=W1SjbKamopitAaoclsyBsK7m8S7AzERGRKlTfb+yFZ3adAWG2rzZr2hfUwnov+P87B
         vw18tsCdYvV8bx6u1lOYDktyzZbiKLEcNhxpFOiq/u53g3rN9bLIAzGy83lfCqbLtR4B
         IsoDXAhb8whDoMpnKFF9Cp7dWDFsMWwJ6+dj354s5d5Bq118PwSWtaOPd5+JB4agqV8A
         lRXpFX+waaRVdsPbZJS9Hfvb8/kaYk0hNBGs/IRL/gL09al/thBKjIc7RGjYrKYrX8Sb
         f6phYca2bykOr7RMkMFIYQHOgnxR4RL9AidVs34lmo20OitiRtakSp113Fksx4pfd3sr
         +FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+OkbCIxuFLegTVpH06BqaBwHcYDWj2efUoxZ29HmLU=;
        b=IswXtzt08rMYe6SHcgqsnOx5+r7v/f4jyrOV/kX/2EjTiEZzoGT6KbzJQmXo7u1YQW
         3YLSgLoyqcld74iE4m1X3UT8ZJtKCofifnzawOjgF9/6lW9634/oqL6NIay7qcfQJQOe
         fkJwZSc8aCv5nbtQWBUKyOVuME4Nqtq4jsDTsxukKnWpn9lzdr5Xixfjqrataopohbyu
         gg6xccLQloXF0ymCLFyIz1h6M0H8HSvpfFS7C+mvuHQljCzmigUbo7JswAc+sn/BIInG
         FKzAVKQ6l8ax4dnUFACiN9R30/xNjQRZySGRNajXJTLhan9yEW8N4AKJBXpFuooWRFTW
         YLKg==
X-Gm-Message-State: APjAAAUGRf2c/gwWBcldYX7AIBmPJrKm+gjytQr/oBcEjJztNOUC8vYV
        yLmk142iriVYP5jYk0Lviv0MdwG4ew==
X-Google-Smtp-Source: APXvYqxMjxT/TOdBkrDkVRcyvJVVBlm14OQBM2ULXJus1NpZtycPr2ZumLGbzRGxbtqTqldyNuKg9w==
X-Received: by 2002:a67:f759:: with SMTP id w25mr18307516vso.235.1560194084934;
        Mon, 10 Jun 2019 12:14:44 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:44 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 12/12] closures: fix a race on wakeup from closure_sync
Date:   Mon, 10 Jun 2019 15:14:20 -0400
Message-Id: <20190610191420.27007-13-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/closure.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/closure.c b/lib/closure.c
index 46cfe4c382..3e6366c262 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -104,8 +104,14 @@ struct closure_syncer {
 
 static void closure_sync_fn(struct closure *cl)
 {
-	cl->s->done = 1;
-	wake_up_process(cl->s->task);
+	struct closure_syncer *s = cl->s;
+	struct task_struct *p;
+
+	rcu_read_lock();
+	p = READ_ONCE(s->task);
+	s->done = 1;
+	wake_up_process(p);
+	rcu_read_unlock();
 }
 
 void __sched __closure_sync(struct closure *cl)
-- 
2.20.1

