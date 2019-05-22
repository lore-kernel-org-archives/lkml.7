Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92872C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6105C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uchLVR9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfEVPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:09:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42490 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfEVPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:09:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so1958297lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=uchLVR9yDZbCoZFcLTDWBlnr+qGgHM4l53knuFUtS4cszF3qq07ggcXLTPp4f1w3EH
         j1IHk6vbdley5IzodGb/tQoWS8N0fMqt6Ua8kNPLmWewxcufW+1xVNb0e7fViD9CgcIp
         pJhh60QlEvljx7FQwox0+5OIj33+h7stGNT/5aqWO1weU6FRfCFZdHnUWEfTxAC5OMij
         t74E5/Or9Z4xug+txof7zAQd6NGIvQn4vfDdCBnBtueDJS3roYMhnTqSiVT58a1ZFUXz
         1chdk61oyigEWPE2i+mrhDPq+UCbJ9K7zrek8mWwqK7o2ecTG/tzzZbzagqaoi1i97aJ
         BgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=TTR8kmVCecMLBTX03znStLJsLcVkz7sk3as43QNaM16taS01belCO0ojb8OJBSCLTM
         Di8IpsdlDE8MYHYudIBW58SlKl1MyeeiIkKq0PJwkUirPP+9uSc8KIiSTfm6ebJvL71L
         ZM2Cskp/xFVXWFAHIWnlBbaoQsbUnycD0pq9c/25+aypISP9FxKxKwKxpvHlVvppQNj0
         2B4pyHluK8PNfxSqLwaFE/Igy9X5+Vsqi7ff64dTc7YeQ+npk+9dhpblDbZrMar3wfGM
         WBBV7MPriqfXhgoA536oMR/LXpdoY43h1xJ+T0sZ+Nz6kQJ62rgTKd14C4wSv4YYtCDa
         bd8Q==
X-Gm-Message-State: APjAAAUxXwVVh4p7i7/Gl8P+ukPJjtyN4hDtW+d671KajxLRbcKhQ3KE
        DLIYRBNk/D58sslqWqH8wJQ=
X-Google-Smtp-Source: APXvYqx5GGN3+wrZiJyukNG7wlTWckT2VbaD042N799w2UxWzlHPswK9PIYTsPn1Y77SbReZyTnRUQ==
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr41492644lfn.111.1558537790380;
        Wed, 22 May 2019 08:09:50 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t22sm5303615lje.58.2019.05.22.08.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:09:48 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] mm/vmap: remove "node" argument
Date:   Wed, 22 May 2019 17:09:36 +0200
Message-Id: <20190522150939.24605-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused argument from the __alloc_vmap_area() function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c42872ed82ac..ea1b65fac599 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -985,7 +985,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
  */
 static __always_inline unsigned long
 __alloc_vmap_area(unsigned long size, unsigned long align,
-	unsigned long vstart, unsigned long vend, int node)
+	unsigned long vstart, unsigned long vend)
 {
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
@@ -1062,7 +1062,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend, node);
+	addr = __alloc_vmap_area(size, align, vstart, vend);
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0

