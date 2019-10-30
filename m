Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A777DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779612086A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhWOQCdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfJ3BE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:04:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:04:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so383895wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFZAes7RgqxwDdAozi0+EhyJ8wlf2q6asfkI7/l0nZQ=;
        b=PhWOQCduAFNlpHk5otLDnS8E0eO+4NqcYc4hqHbSIRLm6MIy3cvpjxH9ti4DbTMoyI
         9GatfmkxLy4U0Kz0LDJwsUp2dHXUMNZwNZGdDixICgmwujo5CJHDEDyl9o4qWy0Z8VRC
         SAPg5VqJh3v7DOt2M65ZsVZKA1/7hr0Ly4+Ga/TvGZ3TjTz++rNttLZPsriyk3e5xNI/
         P2ppn9QqgEbZODju2Wgs1uDoN7jbF8DGFwL8qKRhYmWTSodvPESopogE3C4IATi9mmzv
         yKsMiO/Oj7DtI5EkxIALSbEdv/itHCQpMZrat/tLSoGSrIEzS1HLcZSs+UOaRkfPlIgC
         1XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFZAes7RgqxwDdAozi0+EhyJ8wlf2q6asfkI7/l0nZQ=;
        b=fK1ME1QVesCQbyoFLgJA2P3UjrLO8rysoLH+zX4q42DEj5NHmN0K2tKkWNpP4cD8oa
         +WQQb4jlej8GFAVnyxRwny94kvZvQUrUeVcBQZBU0h6XMh8p0NjqRag962+AhS1ZLljZ
         3umhFGUpU2ngb8j0tiOKzN23Iu7D4meAdRStIehURDcA+rolAqJobJAXLTRPju6NfE+P
         ahtfXxAXONNThPj23edFcS1zgVpIPiapLjM6N+DDUNA3wzoS/7uZNQ5tn7MoysNHGKUr
         K6oglxOJ5OzTue+ICCDkyPkcxP+zsESf+9C4doAmxe7Lnn55THT9H5RknmnGWVxrBihL
         GQIw==
X-Gm-Message-State: APjAAAXpzUd4ni5xaHruJGJ6xgfJExoFGd9UUqEZWYPjGmXD5YGhOEnm
        XK1LVpzJ2hUsmgfmQ09DLeKOb+m7QlQ=
X-Google-Smtp-Source: APXvYqwkVFwqr5MhwXSZX6YpuXfC+SDENrbR0rJwNfSDfXV3/y9VfPK+hEw/PXgJxE1i3qtmbl7JYQ==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr21519313wrx.197.1572397495128;
        Tue, 29 Oct 2019 18:04:55 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id g184sm537493wma.8.2019.10.29.18.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:04:54 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 3/6] staging: exfat: remove unnecessary new line in if condition
Date:   Wed, 30 Oct 2019 02:03:25 +0100
Message-Id: <20191030010328.10203-4-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030010328.10203-1-jroi.martin@gmail.com>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning:

	CHECK: Logical continuations should be on the previous line

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 drivers/staging/exfat/exfat_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 177787296ab9..4d6ea5c809d3 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1727,8 +1727,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	ep = (struct dentry_t *)(buf + off);
 	entry_type = p_fs->fs_func->get_entry_type(ep);
 
-	if ((entry_type != TYPE_FILE)
-		&& (entry_type != TYPE_DIR))
+	if ((entry_type != TYPE_FILE) && (entry_type != TYPE_DIR))
 		goto err_out;
 
 	if (type == ES_ALL_ENTRIES)
-- 
2.20.1

