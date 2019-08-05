Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D29C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE72064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxr2l8y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfHEQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:03:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38088 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:03:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id z14so2744038pga.5;
        Mon, 05 Aug 2019 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAXH7dmfPxkVKecczubWm28FV2SWqcc9gtgOItNZVds=;
        b=Gxr2l8y9Iy7q36cxCIwqgG158KVCtlGm8lkLRUTOv98oC1Wod5J5OKLzhTcJxGIU3W
         T1zKPk1hL60RlPdDYiOTAWf9MwJIP9vagDX9NnaedrXfOwZvJYn9QrtZ3JT0luCQvIDF
         WodtpFaOOJwSsvXWeatwwE5bo5LGHCxe+DOOpXov01IWS+50r+Ji9AUoQypZ7ctvIH14
         W/2ZV0yihcylvdOXU4zZejgAoYLGdATzhBfjLKYAZ8sYK4SqMdQoTOf7qXunsSxXwXkp
         wydhszXgY9YN2Q2y2aoj3zKKGWQyqmEMDIZ9ThwJCGq+TsexbxSWcc5A93L0zM+Hgvra
         O/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAXH7dmfPxkVKecczubWm28FV2SWqcc9gtgOItNZVds=;
        b=SeOei+HXOicHR35jR3iThYFKrQL6jxr5f1ab721EB759rC4HlhgWHQe8aU2+/5Zwd1
         aUw3+NgZBOlJrP7ROKHzCrGxBG4kPV262oyB+T1ewn93aoQyZ55e+rSCnqEENjLxE993
         xjoR2IMJTMmut4xloKKYcNuNz9tod9lbRfgVLLiPMaXKzzgBeZWEuCbJJ3GnHaCn/prJ
         UYqLs8/dsVFX9MAnNVxe3ESYjgZNxoVZOgbkLdGO6shaI4SnP2Cm4B2Ier5glsnxmMZF
         bUGKvvA92oBKCzDhqKOnC6llCQG7Vzhkrm1SR2tlaDqG2pGrLc6hu4DZx1cc2bovn73j
         4AtQ==
X-Gm-Message-State: APjAAAWwG3EhTdWQUE0UoA4cdPCb13GKmkBfYyQkGNkdaMNrvZU4kjfn
        VrnMjPaKqGsYzkBWxOhREDk=
X-Google-Smtp-Source: APXvYqwake9iGeyg5D1izNDXJGpczYP7MTnQ0K9ZBLacoJxfwKE3BBfH2t95Ti8VkSC7zx/6UqqtbA==
X-Received: by 2002:a17:90a:bb01:: with SMTP id u1mr18412038pjr.92.1565021002178;
        Mon, 05 Aug 2019 09:03:22 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n98sm17061262pjc.26.2019.08.05.09.03.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:03:21 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 1/3] fs: export put_filesystem()
Date:   Tue,  6 Aug 2019 01:03:05 +0900
Message-Id: <20190805160307.5418-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modules can use get_fs_type(), which is exported, but are unable
to put_filesystem(). Export it and let modules to also decrement
corresponding file systems' reference counters.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/filesystems.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..02669839b584 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -45,6 +45,7 @@ void put_filesystem(struct file_system_type *fs)
 {
 	module_put(fs->owner);
 }
+EXPORT_SYMBOL(put_filesystem);
 
 static struct file_system_type **find_filesystem(const char *name, unsigned len)
 {
-- 
2.22.0

