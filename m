Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AB5C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC1A20673
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ca1w28MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfJAAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:23:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfJAAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fsLx0GJUJTlmuF55t2D7ilPhf07K45hnoVtMrAljrE4=; b=ca1w28MK4nxmnpiwVOWOYAEFT
        SbbdtRaAkpUmfqVIFBvvgIuJ/2qShONsmiH2C/5bymEzZ/+8gyH/PIe0rxUmK2h8txKka2DDpEWLk
        LxyTGNhH7zccuYZeLrId029OJTaEJ8cfzubexl5SXsG57PtgsQ4CSKJTpnSUNl8VN4nyzuFHSxOgf
        mYgV3MHWuUwTj/x/4G5qNOutUNU90pGVRBlu4kvtiplKoRfeD7sCWc6SkC0TKgRW8M9+it0ls58vD
        46JdwUseC791j0xbGzijsim6GgpLmQ27keKSlFs/ObB5LUhcEfcrm3IG/6JmStpKBtH1m39lZXeMD
        O4dKNz5/Q==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iF5wh-0005zc-9z; Tue, 01 Oct 2019 00:23:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH mmotm] sparc64: pgtable_64.h: fix mismatched parens
Message-ID: <29dd42d5-52e3-e2a2-679f-f0e8648f2b40@infradead.org>
Date:   Mon, 30 Sep 2019 17:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix lib-untag-user-pointers-in-strn_user.patch unmatched left paren.
Fixes many of these build errors:

../mm/gup.c: In function '__get_user_pages':
../mm/gup.c:791:30: error: expected ')' before ';' token
  start = untagged_addr(start);
                              ^
In file included from ../arch/sparc/include/asm/pgtable.h:5,
                 from ../include/linux/mm.h:99,
                 from ../mm/gup.c:7:
../arch/sparc/include/asm/pgtable_64.h:1102:2: note: to match this '('
  ((__typeof__(addr))(__untagged_addr((unsigned long)(addr)))
  ^
../mm/gup.c:791:10: note: in expansion of macro 'untagged_addr'
  start = untagged_addr(start);
          ^~~~~~~~~~~~~
../mm/gup.c:892:21: error: expected ';' before '}' token

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
---

Is this already fixed???


 arch/sparc/include/asm/pgtable_64.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- mmotm-2019-0925-1810.orig/arch/sparc/include/asm/pgtable_64.h
+++ mmotm-2019-0925-1810/arch/sparc/include/asm/pgtable_64.h
@@ -1099,7 +1099,7 @@ static inline unsigned long __untagged_a
 	return start;
 }
 #define untagged_addr(addr) \
-	((__typeof__(addr))(__untagged_addr((unsigned long)(addr)))
+	((__typeof__(addr))(__untagged_addr((unsigned long)(addr))))
 
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {

