Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC14C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E875A22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="f42WUOOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH1F0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:26:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33358 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfH1F0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:26:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id s15so1556596edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qA4PSSdqjoOpph2hobcewUXBDQL3bMSeYsI6r57zU48=;
        b=f42WUOOhSzrpbvcGfwlOGEJFtB+wYyem4nVwnrzxY5ayNYMNR4Krz4ZT/yKTAe9OEZ
         U7H6Q2hxPf5eJBmLpFq1Dn1tXPx40mkz5WxEenmSTQ02q9xyhsLtXlUyGG/4OFo2c4fa
         4RteqI5bUhPzMDBm8YgPg0PczvDbWunQ8I0Pw/68EZdNZVbD/L89qQtp6mqePBoy9RCc
         cLw8tM+M3D4iKAprpB88aAMe0VuAeR+yBIFZV6cIEQvpUdJE7rwsl2q/AEwDZxL8FUjf
         qX13EfakB9Q/q5JyJHrWjKGC90rgwpvsHOa00v9M/TrJaiSsCLT9LwGecmK1nEAVdQkG
         GMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qA4PSSdqjoOpph2hobcewUXBDQL3bMSeYsI6r57zU48=;
        b=QVWIjDqRKwTZpNDWmijBiG2rMUVRVN1R98sT3vkWAbXUL45YH/9unTHpjSUEZ5xi9Z
         JuuUJLzrHtHHJJT2W2oCAH3s3MKjmJVJufoOip7Ci5bYbWBQxLcAI/dg5naXDzulDIMk
         kbjGfmPmRnXJP++onDzi+tM8KbBdSaKi57G+23IjMWuLGQBwFO2fJaiPtUW+ruWBNzOQ
         Yz/qro5//6aUak8iYb6Vkf9oHc+4vXvfrmgohjsBu4OlZegvxEEwNCnGyjWUFCurhGJc
         8vxnYx6bF94JDJZVKOwxz2m7CHkR5xu6B1v1zq6BXeojnJyN14E8FoebzYd24dIgumpq
         D0tg==
X-Gm-Message-State: APjAAAWig9gLazCAwzM1vRpPfnkARaNpSJieEd6lpw1pk7nmwQenz/Qr
        5bTDHbN3TgMelYwSNIBXs/S9eQ==
X-Google-Smtp-Source: APXvYqzL5IsLjn/8PUfzvgwk6wNvOlWf4LKRmZaD1+2IbC+1KFWvohLWelE1bCXKBZq2Qk9SQlRv4w==
X-Received: by 2002:a17:907:208f:: with SMTP id pv15mr1555065ejb.103.1566969976128;
        Tue, 27 Aug 2019 22:26:16 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id la5sm213063ejb.30.2019.08.27.22.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 22:26:15 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 2/3] tracing: remove exported but unused trace_array_destroy()
Date:   Tue, 27 Aug 2019 22:25:48 -0700
Message-Id: <20190828052549.2472-3-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828052549.2472-1-jakub.kicinski@netronome.com>
References: <20190828052549.2472-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_array_destroy() is an exported symbol, but not only
are there no in-tree callers, it doesn't actually have
a declaration in any header.

This fixes the "no previous prototype for" warning.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/trace/trace.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 947ba433865f..4cd9855dcd88 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8438,25 +8438,6 @@ static int __remove_instance(struct trace_array *tr)
 	return 0;
 }
 
-int trace_array_destroy(struct trace_array *tr)
-{
-	int ret;
-
-	if (!tr)
-		return -EINVAL;
-
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
-
-	ret = __remove_instance(tr);
-
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(trace_array_destroy);
-
 static int instance_rmdir(const char *name)
 {
 	struct trace_array *tr;
-- 
2.21.0

