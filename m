Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50666C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8CF20748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIpkpEOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfKYOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:53:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45089 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfKYOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:53:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so7292494pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZoiMBQHXkQbxRss7TAYb2fNUzJGxzT4/8Kr2W4f2ACw=;
        b=XIpkpEOIPbe9cqE9ANzttj2W6RToIpSEuQPu9qXqzH7H9d70uu6fZkpiReEAdmtpFy
         4cYI1C61UQAoRbtuyl5abh8M9s/c3fhQT+wchCrC3eF9h7AcJ+sS7WXdNx2ED3LdFDX8
         Wskl9p0jfv9uYie0topaRhW1tPPDfpVQEhCbggSVWXe5rGSfK2ipfYUSIsUoaONH2Zpj
         Ed4hjgBEvb1JJHiKk3uq+QZZOwucx9CX4xLwXvlZPYoL1IuKv2VeXE3hvF2glMI6CauF
         o3gNy7pd3DykPeJRhIVtOpgSBCC7xQzS7UVus0SHJVW7Q7EIP1FSPRdIKeDZyyvTLFYW
         wiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZoiMBQHXkQbxRss7TAYb2fNUzJGxzT4/8Kr2W4f2ACw=;
        b=Gdybdw3hlTM+kPEvIdu/toevsFY8hoqgXTtSOMdrBdQIKaek6jtAXsASUhs0Mlu95a
         YL6KyWdXcHWzZnW128jNlhbUrSZmvBmRLNF/4Jkmc5Ky93jJFXqDgRw2A7rFb2teUuo6
         BI2l0WzVOgI5+S0Ksn0qhCW44h2b8UXMiYj0/sH3olPh2PmGp75eWx3O1KpvlBapKMFD
         Kx3ISoiroFtV9HJuDXBg9r0FNwowYGVyEs2NESdHMkBMgWPNvqTgGgEOkSnkABYXzF7J
         A9TFRPruTlHphANfdgQao+eRDICArTfA7udl7wnUBimxXc4taNAoki0GD4iLlRm0FWWU
         le6w==
X-Gm-Message-State: APjAAAW77uBPc1HXVueGg5zCI4qUa9oR4f9O7HEXCSsRc837ksPjiqQ/
        v4iSXqtmBV76R4Gn6xkd5qI=
X-Google-Smtp-Source: APXvYqxMwG6GEyEMXmp9TXTq2iArwnsZZPz3Dz4w98AvDF4Lv6cC+vNhPausdEFicpUBCQW70J3JfQ==
X-Received: by 2002:a63:fb03:: with SMTP id o3mr32668501pgh.378.1574693603111;
        Mon, 25 Nov 2019 06:53:23 -0800 (PST)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id v3sm9009534pfi.26.2019.11.25.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:53:22 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:53:20 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        haolee.swjtu@gmail.com
Subject: [PATCH] mm: use the existing variable instead of a duplicate
 statement
Message-ID: <20191125145320.GA21484@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of zone has been stored in variable 'zone', so there is no need
to get it again with a duplicate statement.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 mm/vmscan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee4eecc7e1c2..de4b2d1e66be 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -363,22 +363,21 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 	for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
 		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
 		unsigned long size;
 
 		if (!managed_zone(zone))
 			continue;
 
 		if (!mem_cgroup_disabled())
 			size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
 		else
-			size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
-				       NR_ZONE_LRU_BASE + lru);
+			size = zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
 		lru_size -= min(size, lru_size);
 	}
 
 	return lru_size;
 
 }
 
 /*
  * Add a shrinker callback to be called from the vm.
  */
-- 
2.14.5

