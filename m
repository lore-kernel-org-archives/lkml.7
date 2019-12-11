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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553A22077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COcgnXUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfLKRrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:47:07 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35168 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfLKRrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:47:06 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so20224718ild.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mv3G6o6Z9tMj7+Sy/jZZ8/jXLx9VysmevIPlbyPHn/8=;
        b=COcgnXUBNYB/Rl3Oki0yRZgpspChEw1cmbd5Q5u7Y9YzoVtN8IE2CvhR3GmlisPDH3
         y+8cYeLLNU4MDl4rIKvcdMNsPMauYStsjkzXCY2lZ5Rh6UDz5SeYWrQb77PNA0C8qBcy
         pAjQBGvKqvE2MOoUGnMfAmIT9IrE0mqum4GGR4PZuTj97S/GrpAsxZ6X6vALkfn4XTkg
         GJKH/oNkOYrM1VsxEODQMsu74179Ino84p6bLrxMsLnCSwtM130435A821IWZnn6jh0i
         Owwq93pMCAXitfQcthPN9OO2rCw8XBZB7GL5vCza9x4XSmI+mNMXyft02kd3RO8iB7EN
         kWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mv3G6o6Z9tMj7+Sy/jZZ8/jXLx9VysmevIPlbyPHn/8=;
        b=i98b64BJzjIOej57BggWEjip+krR9sjrkE2JSZeWaCjhDm5oz6bJyPFtwPBlt8Ab/+
         9IfC0z+ua1JHcJ9FCQNPubu3eIjiHOSnmkJ8mfDdrkCjf8MIz4hVW/eM8R5P/Y2UFKDk
         wRKSyrZuhy2mx7rSwjteVVkgkJYCDqLc6ewqf+0r4CUGxhJYPau/0XznMrxgUFsXtsle
         Fv9KYdSbkCqFfAgRSqK3uOnEDlGTC7wGYmFRROS9/Fkpn+Vm6dWyMJU53PlIFSXW0vpG
         y3wjecXU70zMHK++4NrZuCR4SaAXUgN0Hp9S84FyRIE+5YqlpkAZnJsXDgKfcAseFMO8
         IP2w==
X-Gm-Message-State: APjAAAW++A9arPd9rABsqL/Rd0YOkbPYPBDn6TJ0LJjRhwCBS12d5Yuq
        aEEU/iz9Xh8cG2SPR5Ufa0k=
X-Google-Smtp-Source: APXvYqxTeHmeiR/F/c3T6cnthW2k8jzvG61BeBNihjMnIFLpN5suFslzeokdOLRH+9CG0LrXRsChtQ==
X-Received: by 2002:a92:c0c7:: with SMTP id t7mr4442152ilf.113.1576086426189;
        Wed, 11 Dec 2019 09:47:06 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id o83sm902731ild.13.2019.12.11.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:47:05 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] mm/gup: Fix memory leak in __gup_benchmark_ioctl
Date:   Wed, 11 Dec 2019 11:46:51 -0600
Message-Id: <20191211174653.4102-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of __gup_benchmark_ioctl() the allocated pages
should be released before returning in case of an invalid cmd. Release
pages via kvfree().

Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 mm/gup_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 7dd602d7f8db..b160638f647e 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -63,6 +63,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 					    NULL);
 			break;
 		default:
+			kvfree(pages);
 			return -1;
 		}
 
-- 
2.17.1

