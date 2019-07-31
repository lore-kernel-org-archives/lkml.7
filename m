Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A87C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0342064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CKwTGfqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfGaPJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:09:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37834 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388550AbfGaPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so66060989eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZeKfM6T8HTy5YM9YTF4CgvrEAh9gYOHMqOdjRE0jKs=;
        b=CKwTGfqftPDIaRPn/xve4w1+BQofkrfeJaRVwasir0N2gaI86NFwFxg8DcKYfpIb/T
         zdNo86h2blPndRDZ0oHF3nNNsbgPZ9ud4MhkHLJUh9aosb3WLdon2l9jywmf1XS3jazD
         g+s2wGJDplnGgg9Qx97RNw21ATe0b/cZO3XgAZrx09sWV5aW3VlaqaOo2g4JU5CT9iwW
         yz2yB+EFutNa/7GS4L0SAD0v5gg+PKoI8gwxEIyl2R8ZLpFFN6/9CPEQuZXLnwQfKbfG
         RkPDW9JM4nmysiqjOl3J1FDnQRNyj344DXF7M/ds/1YTDGBt9yWaHdPd+cmulzWlE01x
         654g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZeKfM6T8HTy5YM9YTF4CgvrEAh9gYOHMqOdjRE0jKs=;
        b=tadOnBLzl7rrmEtIkv63w09YuBv1PGfUs2MYQ5JhiXX4a4y8dySG8HGOrZDbmpRtYO
         COmpocjoIhu8wrb5ey/ElmAzD/8SEzVxbMxM5C0v9nP2kTs0qpOhmNYU6kOnuLHiT25s
         DdMLPSi8lGwU2Z33ujVa+yuBJaGm2PXiboGpOQdkzFlOgjhHbtfyPGF2PzECNPUEGJXO
         lrf02IEmhdA9V/8N9TgBvXF3aW57xPou0ynM2WUpU36UY+/xVj+/ri5Yd0ulR3rJAt9m
         cd1C6UGXhTtPJqJtoFnVJr93hbMuuevnj7p6BGBZF1vBTWkHTgo9+yo8UJj8vQlBfkSF
         FQ4A==
X-Gm-Message-State: APjAAAX0DzKFGO2a4bQtlJdbNBt7DJDs7m9zJgT2NC8NtIhnDHozVgJn
        ja2qwiz90C5RrlsV8tdz45o=
X-Google-Smtp-Source: APXvYqwyxRQn953dpG335++68BakS/voatLNiC782RPJuiyRVUELnhQKN8Sxlq6UNG5ozqtqFSTkKg==
X-Received: by 2002:a17:906:7013:: with SMTP id n19mr94845741ejj.65.1564585706382;
        Wed, 31 Jul 2019 08:08:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p15sm10516388ejr.1.2019.07.31.08.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:26 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 80E941030BC; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 21/59] mm/page_ext: Export lookup_page_ext() symbol
Date:   Wed, 31 Jul 2019 18:07:35 +0300
Message-Id: <20190731150813.26289-22-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_keyid() is inline funcation that uses lookup_page_ext(). KVM is
going to use page_keyid() and since KVM can be built as a module
lookup_page_ext() has to be exported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index c52b77c13cd9..eeca218891e7 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -139,6 +139,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
 					MAX_ORDER_NR_PAGES);
 	return get_entry(base, index);
 }
+EXPORT_SYMBOL_GPL(lookup_page_ext);
 
 static int __init alloc_node_page_ext(int nid)
 {
@@ -209,6 +210,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
 		return NULL;
 	return get_entry(section->page_ext, pfn);
 }
+EXPORT_SYMBOL_GPL(lookup_page_ext);
 
 static void *__meminit alloc_page_ext(size_t size, int nid)
 {
-- 
2.21.0

