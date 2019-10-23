Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6EACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46CE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571826480;
	bh=i6C23c2v7IUvd9FJLhpmJogF6/Mc6ZQR0Q9bl9hRHRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kn+uq2B3CS2cXxaVuwVK+C3td+0nz3SIZwLPv0qqEsPxrd+Bcyq89eM8vQLCL9HHJ
	 q4T8XPP9oQuGgyweQwwVfuD5v8bSrm8VJcak/V+mSkVKurhCwmJ3DoCFzlVCgBWBgI
	 vBHqI9YLnxs/EWaJb6YIMwI5OOFOBSpyoIxXXTMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404432AbfJWK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:27:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45099 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404354AbfJWK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:27:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so16486311wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HogpH9E/f0iRGMXfxCc+U7lRJjZn9ahpkT4ZsQUlsRA=;
        b=mb6ln6M5ZifdSxPIOMH+pyjiWtraqiD6e6mJ/ehutBNtfEc5JymRZqiLDXGpPwvLqh
         zU+U/2q7KARnMy6uW8US71c3FNip0LrGmW6oiqe828XGF+ooYjGbPYc2KrC9SXKg+Hm1
         lbL+SYF8JGjQZ/6vNbAojpfzG8fpWx9Ub+b8hJRU/0qoZPlH7TxTBVMxx1q86MAx/UZm
         6ZGAqe7rhq0CN917goX9KEsHe3kjYy5N6YWHgONYc7vhC7/4ZWNWK5r0hgbWlhxP9HgF
         ofBQeLjTZu8tnw0AWu7YsIPWJPyb+WkW14Pqjc2L7Tu4dEtr+A1ip7R8HHmFxh+pbp+G
         e68Q==
X-Gm-Message-State: APjAAAWaTXbBw2mm8Edn6tRph6bVx6HFKD5mZoBCJhj9H6xbFlDu/nSw
        o8PlfvpYT2I8qSSWjAmAXKo=
X-Google-Smtp-Source: APXvYqxgZBZbWr+ZaAPWcVFpHB2ZDTH3/EHAddQJLlI72Frxl1clvXwGfNlUONV6WKYAB5Vnp2ejpw==
X-Received: by 2002:adf:f685:: with SMTP id v5mr7993017wrp.246.1571826473245;
        Wed, 23 Oct 2019 03:27:53 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-173-3.eurotel.cz. [37.188.173.3])
        by smtp.gmail.com with ESMTPSA id u21sm18234122wmu.27.2019.10.23.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:27:52 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by /proc/pagetypeinfo
Date:   Wed, 23 Oct 2019 12:27:37 +0200
Message-Id: <20191023102737.32274-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023102737.32274-1-mhocko@kernel.org>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
This is not really nice because it blocks both any interrupts on that
cpu and the page allocator. On large machines this might even trigger
the hard lockup detector.

Considering the pagetypeinfo is a debugging tool we do not really need
exact numbers here. The primary reason to look at the outuput is to see
how pageblocks are spread among different migratetypes therefore putting
a bound on the number of pages on the free_list sounds like a reasonable
tradeoff.

The new output will simply tell
[...]
Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648

instead of
Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  41019  31560  23996  10054   3229    983    648

The limit has been chosen arbitrary and it is a subject of a future
change should there be a need for that.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmstat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4e885ecd44d1..762034fc3b83 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 
 			area = &(zone->free_area[order]);
 
-			list_for_each(curr, &area->free_list[mtype])
+			list_for_each(curr, &area->free_list[mtype]) {
 				freecount++;
+				/*
+				 * Cap the free_list iteration because it might
+				 * be really large and we are under a spinlock
+				 * so a long time spent here could trigger a
+				 * hard lockup detector. Anyway this is a
+				 * debugging tool so knowing there is a handful
+				 * of pages in this order should be more than
+				 * sufficient
+				 */
+				if (freecount > 100000) {
+					seq_printf(m, ">%6lu ", freecount);
+					spin_unlock_irq(&zone->lock);
+					cond_resched();
+					spin_lock_irq(&zone->lock);
+					continue;
+				}
+			}
 			seq_printf(m, "%6lu ", freecount);
 		}
 		seq_putc(m, '\n');
-- 
2.20.1

