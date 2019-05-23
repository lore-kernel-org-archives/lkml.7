Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0582BC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ED321019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdD/TwAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfEWAfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:35:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35942 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWAfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:35:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so2219214pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5JdUm2l2J0nCnS+Im0smPlNxmaAWXWEhfMhOXXEzL2A=;
        b=tdD/TwAniWVHAhadj6ugXUkpEST28d+VKlQXMQrFV5gpA8rEWtIs8RKzEgC3+hiQJJ
         E1kYTqViIG2hW4QHl4NZ+kWTn5te5FI6S/U5LDFhH5su+NLfdSHKG7k605HsArFlGldF
         yYRlqO3y50cvIef3Gcx4QHL7fq5mkPEXDqbGvGtM0Tz+cy5pVjocVftO6DreKFdXDCKc
         uOOHvTKu/j6tlTqBTa+dNM5H76h5ccccPBYpZLzqs8qGCECc3O3yxBUDazcgYu5XF5jQ
         fS/2BHC4ciFlgu6QKcXedoA9V/tXigsV5xFM6KtkPbWEer7qisfJJKPKQboYXYz9qT7+
         /wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5JdUm2l2J0nCnS+Im0smPlNxmaAWXWEhfMhOXXEzL2A=;
        b=CZt4Tzj7Jfq451OcJHaHWSzWJUMoKBlo586vE7duk+lUZDh5/mgGoTQFFFrEP1AcYB
         UwtvM/DOIrnlAB0mMuDYf3gF2u9nF8Q9rsw0HVTJBKFkyNfotVNiqCFX5Gz9EiKChwN0
         IrNlcRWnbMrFEqQF53k53Jl3ZvCrFb2Xu9yH1JdhGOr0eu/fmQB4NcCBh6EWi/LmBiKy
         D8C2rPVP6e3aw2l46arF5tZE9U2ggC2reDyVhvxc/Iic+0ESv8GVM9m0xiruDVAm/1vm
         qojurexS2KwLyCDaF3jJQyxnZeE+y9A64Xb3VJcr0p9JVsdqgGcEzztjhsPafxYqUniW
         WtKA==
X-Gm-Message-State: APjAAAUXVGe5XLAXT6nZRqvRbR0TAJ/PmmZiR0uYBsENH3lCid6B2OJy
        MGzIA/I+2Nt1PVWrfJUaPTk/7LGSwv1nTA==
X-Google-Smtp-Source: APXvYqxIIH7q6FTtOAdaxUueO/x9Iog1QnaHVMHZov/mi5+tA+4ZjvOxmDGWNvm4htSaL6JevcEppQ==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr100660401pfu.206.1558571703912;
        Wed, 22 May 2019 17:35:03 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 63sm36845105pfu.95.2019.05.22.17.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 17:35:03 -0700 (PDT)
Date:   Thu, 23 May 2019 08:34:52 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Kees Cook <keescook@chromium.org>, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <20190523003452.GB14060@zhanggen-UX430UQ>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905221353.AD8E585E6D@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function con_insert_unipair(), when allocation for p2 and p1[n]
fails, ENOMEM is returned, but previously allocated p1 is not freed, 
remains as leaking memory. Thus we should free p1 as well when this
allocation fails.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index b28aa0d..79fcc96 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	p2 = p1[n = (unicode >> 6) & 0x1f];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		if (!p2) {
+			kfree(p1);
+			p->uni_pgdir[n] = NULL;
+			return -ENOMEM;
+		}
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
 	}
 
---
