Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7570C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8187220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo/bYAEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfFFME3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:04:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42504 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfFFME0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:04:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so1328354lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tSlWixv8IsvTJaR5wWju6+N+gv5t7ksDAwbc0pe3EIc=;
        b=uo/bYAECP+lJOkvdd6HNBObFeZirBPefZcLHVmO1hypQ59nvutuCoABltauglPwvqa
         Nl9KAZ7lpc9I/siL6djGDZXANHMdr/hKUY/0Wtg/8CJ6v8s2ua96EB7/Ikx8BpgkMRcR
         1jzop2g7p82ZamqXdZKiYANa/XXHS0nJjeDElbOWzEtc3N52euhAjcvranvQX/oAAk9L
         m4SYC1H8gLNFh3Q5RuggzpduF2YQEMkl2h/662SUCqsVXxe6igui3vy2e2qnFYHSgxnf
         hDt2ULRisUPRhEc3GJtppLb3TNtnV8M1pHwhjCBxQ34MVVip0v8j03p1jqCCL8gtmYI7
         6Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSlWixv8IsvTJaR5wWju6+N+gv5t7ksDAwbc0pe3EIc=;
        b=P1YSwfMVBalawGleRqWjBwJD4jZL2d2xNfOynDri8cSHUi1odMWh52pS6hsVHTmnC2
         yRT6PA83avzW9uj/RRaK0XHNgLhHGg6XinABuILJvD68TWdfkzuQaXKoumspdkbuTTAF
         tYb3BgD4OdDJdEezdeP1I+OXIqLy00tw4Xy2x34NUFK64r5kJ7SfY2H3l6iB8QytuE+4
         SYlh0vA1MlmX7fyrpeyvuvKnXE6mOpgbF+LiuRPabW8BtmZTrVInTpNTg7OpuPeAQDv9
         0LkshRlOsrQusCpWc+/VBtkodoJ9Gaa+y7n7NbJRYDaoTxuByqgvv7jfm9/axN/7wUVs
         YCrQ==
X-Gm-Message-State: APjAAAUiUo9fbYH2g4vuRwBCf+9zs++FPgv5Qnn8Fbv4IRhkOJoB1b1D
        EUWPwY1X9d+42GHMpqczagBNjbyoR+U=
X-Google-Smtp-Source: APXvYqxBXnv+S0Y5hu8OhQxFX3OJWWZVDxpvO95/4636pF8ZSPX2vsTgwse7qghOIBiFu/zcfM79qg==
X-Received: by 2002:ac2:5446:: with SMTP id d6mr23078445lfn.138.1559822664793;
        Thu, 06 Jun 2019 05:04:24 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm309036lja.94.2019.06.06.05.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:04:23 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5 1/4] mm/vmalloc.c: remove "node" argument
Date:   Thu,  6 Jun 2019 14:04:08 +0200
Message-Id: <20190606120411.8298-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606120411.8298-1-urezki@gmail.com>
References: <20190606120411.8298-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused argument from the __alloc_vmap_area() function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bed6a065f73a..6e5e3e39c05e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -986,7 +986,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
  */
 static __always_inline unsigned long
 __alloc_vmap_area(unsigned long size, unsigned long align,
-	unsigned long vstart, unsigned long vend, int node)
+	unsigned long vstart, unsigned long vend)
 {
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
@@ -1063,7 +1063,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend, node);
+	addr = __alloc_vmap_area(size, align, vstart, vend);
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0

