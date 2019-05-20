Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78175C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B0B20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWn+EsvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392786AbfETRRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:17:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45932 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390577AbfETRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:17:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so6985236pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=5elJHjWFjcHkVboxjAYPJGmbdCVMyqMVQma7x79oi5w=;
        b=rWn+EsvAorjVENwh7JlIbDVc57R3JWoqjR73qwRihQZiBnK+YwG0K6l1wYwLD8rFPp
         Z6D+3/fdsOX87p9owDzg6F4IbYUuxR0DU7jiJYpYmKP/x0g/aC6C+y9D6XguDr2CVtNu
         ldjLIQnx2Dk+vzONRFJskS4t+DH5N6uuoNSYPNK/gz5hAWYPPr0jWMbDOlLqaaVZdaq6
         LqV4vIkHgbK/6SIu9wGtKbtABkTv7/GZOOdmGDYirNW6X56x6KdapnSlqk2lXnTLHJIg
         BTRqKv7qCurs/xhLh81Ohe6/ZwjUeWiPDlSfqlihmxhnyJGkpsH199xLbUhAiaZEDETm
         mvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=5elJHjWFjcHkVboxjAYPJGmbdCVMyqMVQma7x79oi5w=;
        b=W9k1j9LlIRrteI5GcWLiLOR12pVYWcT3ibW4qSrfmaZ5hFvt9Cmn6VSLV0g3mGQaxI
         s7a3HObO2GXO2UPmnhDWTWIbkQQvHiyC4G+x27e4UlkDLrCptRnI1XP3tJwt45xUAWoG
         CdBXNVvFSzksvRxpUYSBBuweA8nPmGUXw4WTvVXB2/VU39xXBu+NflDo4zQAjr5PLFjz
         LtjJS4dl5bNinxsRMGpjAIk1sdC381aepfFl99cPfoCD4P1bphTi6R7hGfz+zgtX60Pu
         vqzA07D9P1wLBh/yHmVoDy6NkmKBqdJ+z3Zy7uUb+WOD5GvuSOTAbTwuFOwkov2PWZId
         ZpCg==
X-Gm-Message-State: APjAAAULpWmk62kzFx4pu0ocVAZ7P008MwXCe5zP7oJPq2YwObvwgH1g
        asnbUiEP0PmImyOpUB//9YOAwQ==
X-Google-Smtp-Source: APXvYqyFCPpqDFtqCO69hkM+WWU7MeJZkOtx1/BENRwuW7Ovz9W3qeVavkcieYfqDUbQl7zah2+kYg==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10mr63981326plz.231.1558372629432;
        Mon, 20 May 2019 10:17:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e10sm37445962pfm.137.2019.05.20.10.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:17:08 -0700 (PDT)
Date:   Mon, 20 May 2019 10:17:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        tcharding <me@tobin.cc>, Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: [patch] mm, slab: remove obsoleted CONFIG_DEBUG_SLAB_LEAK
Message-ID: <alpine.DEB.2.21.1905201015460.96074@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_SLAB_LEAK has been removed, so remove it from defconfig.

Fixes: 7878c231dae0 ("slab: remove /proc/slab_allocators")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/parisc/configs/c8000_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/configs/c8000_defconfig b/arch/parisc/configs/c8000_defconfig
--- a/arch/parisc/configs/c8000_defconfig
+++ b/arch/parisc/configs/c8000_defconfig
@@ -225,7 +225,6 @@ CONFIG_UNUSED_SYMBOLS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_PANIC_ON_OOPS=y
