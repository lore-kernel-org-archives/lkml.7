Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D0C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F0721734
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRi655oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbfGWNIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:08:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41915 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfGWNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:08:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so20511788pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mMJGMBwbdv3BuUIrB2fh3trkXMpns9zS+fKqqtIDYso=;
        b=hRi655ohdlnFYbeJACxTYv4WXDTzYM6muo+fQ0W+9swzRbEC7whe7L3x9g32g/hhgs
         FOFAtZGhZ7Br9Gn+HA0jF78wSvG99IiJ3YuANkCoB7L5DbI91alE1V0JI4ZkQJfFBq5Y
         k/k2hEvsSaom9j+dXabOqm14XrLUCDPWGkPhDV0fLeuQzdi/Aa2cPG4m+i5XDM9Z3RES
         zgaGcscpo3/b589RlE8M5NazmIvL0BTxFYRKmU+8NZaT/IMzpVeQXj8F+/kksyCZ3dEj
         qyQwY1ixuMDC0Y97X2wxJ0nxggbFTKck4L2WG9UqymiYN/KL91OpdcwcBP0tOH2FIer9
         rUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mMJGMBwbdv3BuUIrB2fh3trkXMpns9zS+fKqqtIDYso=;
        b=mBtTxYjqOeljMbBbWeDE2jvUgL+A4WrhNewa6nB5AzktI15/XbvKQ1uDbXRq/PCBIV
         jnB2w3HH/4UiHFvqkkrdEczlmIP4ymq16xXf1YfyqXOYPC8BcVRTo18SFWTG1Hp14LDe
         ceEYz7hK6cU43+dfYHqKvA6grpAQWYF5/VyptsygcP3as8w3kkhjJuSalu/N7Tv62Ydv
         5PBCdf+zjzZ5VIeyjoBL6JmEc0reWJFhdR7H1yK0VWGBsADq6gWIxLjjiCtPN9tEndwd
         /DPCZ/Q470A05zHJnFyjIRXMWWGuhJ71ktRR5IGhA0e6DNECk3GyNkPcH9gVf9VTDUcG
         G1Pw==
X-Gm-Message-State: APjAAAUXCJPlRryPg4QgPDjL06HwP8ZQFvuh1Ya+eQrwesw8IA4/hslg
        rj3UvE6k/p4DogOUZ0w2NKI=
X-Google-Smtp-Source: APXvYqwmCu4VygQO+Rx9bAtrtscNWk4NIlhSZPtvsVz1VJIBxtoVYfY0lrSZLTcdwQEQ3YSz/ESs3w==
X-Received: by 2002:a17:902:28c9:: with SMTP id f67mr41262500plb.19.1563887300481;
        Tue, 23 Jul 2019 06:08:20 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id r2sm58250026pfl.67.2019.07.23.06.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:08:19 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com,
        david@redhat.com, pasha.tatashin@soleen.com,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] mm/hotplug: remove unneeded return for void function
Date:   Tue, 23 Jul 2019 21:08:14 +0800
Message-Id: <20190723130814.21826-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return is unneeded in void function

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 mm/memory_hotplug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a9bbddb0e55..c73f09913165 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -132,7 +132,6 @@ static void release_memory_resource(struct resource *res)
 		return;
 	release_resource(res);
 	kfree(res);
-	return;
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
@@ -979,7 +978,6 @@ static void rollback_node_hotadd(int nid)
 	arch_refresh_nodedata(nid, NULL);
 	free_percpu(pgdat->per_cpu_nodestats);
 	arch_free_nodedata(pgdat);
-	return;
 }
 
 
-- 
2.18.0

