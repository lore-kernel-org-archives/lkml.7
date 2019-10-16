Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632D821D80
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijBxkcdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404390AbfJPJy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:54:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45991 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfJPJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:54:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so23301639ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZoZqPU58/r7tmZ5PSLpDxdfOuQtypWPAK4xAcMDbso=;
        b=ijBxkcdl1C3p3Gf7uWxe52LorIx/LjRVkwiJGk0CWquv3ePAFCZEe2wexe2Fz3JwPO
         esV4vb9Z4BI9Pngz2wu8YntDZSLjS9aeJKg33rADix7xL2qvVJEbliL8UkQYb2oodX/c
         nTFchhA2yD3GZXz7ytWbJY46syb/wzIKfh4MTYpfxArMLUOUe7dKXBE0yiyCYg9jS2YC
         SVTMBbaErQHePI585OlSi5XYmCK7LdQH3/ZYv7xon+fhEyTE2UK02EmGZwX+M7J/D5wL
         L+JIgM6+u7B2SbK9HioC8RlEabIcuXU0yWorEcyOtH9xhbt2n0flhgdI2OCdcRwHR9+c
         veTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZoZqPU58/r7tmZ5PSLpDxdfOuQtypWPAK4xAcMDbso=;
        b=s+VItEuxRPK2YFBpcs6JH533v4XUjeDfQiIJwUZJjU0uZk3zBA+NrXG28IaGTp+RM5
         jiz2mQOy9RF6ThWcf/qcvu00J/SxJHIyZB/3l82MiixNwvE98ZA8LBhKtY0XoJieVXPv
         hL3bTmS2ykPN5glpYtoCQH7aJaHTyfIBxQeMKHZ4iB5gBlsuCNr75XQr1/y9w6V+xPf4
         ZmywlxQtTY/3bHWmYZTsK2gH/rsky4m4+59GsEU+YhoKhmsC8woYDU8nMLEPMpsgkP+y
         OelpwpGVbKc7HQwC40Bu5eSFbUwkGFHRGycBD1k7CIIDg+p/rVMoruHaWzmbT2eQMqpX
         Me7Q==
X-Gm-Message-State: APjAAAUT/vYR8tgA4ozXNHOysc1o2ufW4Qor8KIiULOHBCjjhvla6lL3
        LrKaBrni8dppFZ+y5qSXpRo=
X-Google-Smtp-Source: APXvYqzPH+636QBSKvduXVSag2KSoZKJjqlR0+ZPMMRfitxESnYfCgGkOEj80hsD56wUCQvi6U1GZw==
X-Received: by 2002:a2e:9bcb:: with SMTP id w11mr24632508ljj.11.1571219690788;
        Wed, 16 Oct 2019 02:54:50 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id b2sm886452lfq.27.2019.10.16.02.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:54:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 3/3] mm/vmalloc: add more comments to the adjust_va_to_fit_type()
Date:   Wed, 16 Oct 2019 11:54:38 +0200
Message-Id: <20191016095438.12391-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016095438.12391-1-urezki@gmail.com>
References: <20191016095438.12391-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fit type is NE_FIT_TYPE there is a need in one extra object.
Usually the "ne_fit_preload_node" per-CPU variable has it and
there is no need in GFP_NOWAIT allocation, but there are exceptions.

This commit just adds more explanations, as a result giving
answers on questions like when it can occur, how often, under
which conditions and what happens if GFP_NOWAIT gets failed.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 593bf554518d..2290a0d270e4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -969,6 +969,19 @@ adjust_va_to_fit_type(struct vmap_area *va,
 			 * There are a few exceptions though, as an example it is
 			 * a first allocation (early boot up) when we have "one"
 			 * big free space that has to be split.
+			 *
+			 * Also we can hit this path in case of regular "vmap"
+			 * allocations, if "this" current CPU was not preloaded.
+			 * See the comment in alloc_vmap_area() why. If so, then
+			 * GFP_NOWAIT is used instead to get an extra object for
+			 * split purpose. That is rare and most time does not
+			 * occur.
+			 *
+			 * What happens if an allocation gets failed. Basically,
+			 * an "overflow" path is triggered to purge lazily freed
+			 * areas to free some memory, then, the "retry" path is
+			 * triggered to repeat one more time. See more details
+			 * in alloc_vmap_area() function.
 			 */
 			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
 			if (!lva)
-- 
2.20.1

