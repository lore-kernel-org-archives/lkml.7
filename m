Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9698C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA87206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTHczTQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfLKTPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:15:02 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41842 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:15:02 -0500
Received: by mail-il1-f196.google.com with SMTP id z90so20432686ilc.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=53qkjI6ZBdfT9sBcAvpI7gyCuS6wDN7BtLYRFiKA88M=;
        b=tTHczTQDunKZGk6vB8Um71SCnnPT3YdJmKncrvhuLhysa1ErTemqeVlp93yEw9Umbb
         OTlOm/K+H50affTgNRQ05YeCKi3Q5BgPxHVKgjj+U5wwU4clCvpJqfFvGoUaMB0s/U9D
         v580KFiUAUBt1xvSRPyk8rOHC7MOwm7dpOyERcf6LPlGh8tN+oRST8woqLXJOdrZoFWs
         3rDEUB13nUWfP98RfE5PmvHn1bYBWa94gYvuWZTqZEL4GY715+Po3TJQtXpbtlQKBGla
         l8fgAz5mbyD6I4Zpn9uPJwT/V3iZxvT070HeRQwcDMijjv4wi+TJAP+zvGWIe+VzoB4y
         y90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53qkjI6ZBdfT9sBcAvpI7gyCuS6wDN7BtLYRFiKA88M=;
        b=Y3qYO4ihaNg3yr4Z1gdNSawOwue/KWHUr4e+iEtAc+RFQ423lO14CW6p48XRCpuVCd
         oZ68i8vX7/vQsaQ1bWszW7dO4MLxfOg5koE73pW5GUntXNcHbBNy6hOUc0lvwIB31BSg
         wwkUisYiHFvkoSuNjI8aIzlYRhZoBojYdG6w/gfooehhbxXAqeUJZ7W6EaZoczhYVDnw
         J8rnfWwOeA1ms7zuzk/1YiT3SGi4wzFU/J4SBqrPkH1yYMTL3YI3Sr3V0edF+dXwzow6
         uMbEqmh31eJ3WVL1ofRyFiaH0dCgJx3XjZRxvCPv4cxEj3HuSjd+AjusH+JgPHFKmrrE
         XMDQ==
X-Gm-Message-State: APjAAAW7jv87hp2MPDOvM5NPomoyEF+RAQRksd5HKeYNeQ977cDPzJ3W
        i+LomWcCzebzMwWJaLF/lXg=
X-Google-Smtp-Source: APXvYqwp54HHs7nbDE6JYLzCdDMucpT7I10wlyxBU7hFmDPhVXD8yhnABe/JQvwDXgv+pGvFpelAbw==
X-Received: by 2002:a92:9a57:: with SMTP id t84mr4727985ili.290.1576091701692;
        Wed, 11 Dec 2019 11:15:01 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id q3sm953054ils.72.2019.12.11.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 11:15:01 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] pstore/ram: Fix memory leak in persistent_ram_new
Date:   Wed, 11 Dec 2019 13:13:51 -0600
Message-Id: <20191211191353.14385-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of persistent_ram_new(), if the allocation for prz
fails, "label" should be released as part of error handling. Release the
label via kfree().

Fixes: 8cf5aff89e59 ("staging: android: persistent_ram: Introduce persistent_ram_new()")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/pstore/ram_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 8823f65888f0..7d2d86999211 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -568,6 +568,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	prz = kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
 	if (!prz) {
 		pr_err("failed to allocate persistent ram zone\n");
+		kfree(label);
 		goto err;
 	}
 
-- 
2.17.1

