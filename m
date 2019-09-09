Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC90C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5862F21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hJiNQQMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405632AbfIISN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:13:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36402 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405427AbfIISMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so17316187qtf.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9qwJvK7duEPa5cSydJwLuayx187fiYj4pOWC7XOD35U=;
        b=hJiNQQMhPzUeNhjSqA+wl+M2Yw4VzmLAzetQQIh1yJcVnbibJdozQMUJIPTj7G1fZ5
         uIcSVRVD7sQv4/zb3vvoXmG7nEkgaDTeuvoEu2B5hEQ4HKyKvqCdxkrMNxnLQvbnC5Sp
         GXJFdIB9Aa+WwqYBwe5OAvMNEHi0mE0MDeX0ZPZjHb8snLd1akNp9JPJJYPCGkMalc8q
         KUixyhfh6ehZRO08DryaR+QFPF2S0018x6Gv5fzx8kXs+kuCJp2nCeGP2cJBD0372qDa
         S1kzC6KQRbcG17aW6isKu0YCKQmeUiKgxNFdBtuyymq/m8jbblhdUBGwoKmff1pBx6J7
         /Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qwJvK7duEPa5cSydJwLuayx187fiYj4pOWC7XOD35U=;
        b=CHrAkrJ3nHQT6fGNMPIj+5k41WAKFGgvC99UtbH6KlsBPk9RqhqLuVlMpmfisiTWxD
         tjbTFTkgwJH1WtGWJeVv+vlAGouKyhSmwBMJXFOELqDpGBKLiQNboPJEq1NRa6cvYCkl
         Ui0rG/3Ow0xp0uAG+EJDThXgvbioP2E8Evhg2MMNEr9jGGW1EmlmzZSu2C48XgXdoNy3
         u1w/LArD4VV9p9CXfviM4aC1yqoM6MSU5vZn+u2mI10QuFqK7n0SlEjRGbzGZuq+Kzrk
         kupbIaZPYAbj+mh0nyX7p72FtP/tOt23eAncpe1TskBCQUoj0PvlR3Fw9VL+wB6VQsrH
         Oimg==
X-Gm-Message-State: APjAAAXIutnuPrYwRctR5BMAp4L8RxleC5j2LGeJJfVfZdnoXce1uyzT
        tHqOgpHIkbdJZMiMVWIs2p2g0g==
X-Google-Smtp-Source: APXvYqz8CjF5wzOFrAWFe3y7s/Lo+3E4+zqXPfUNMu+qW08GhYxza7uSUBke5A6jwxTbDkv2QIy0jg==
X-Received: by 2002:a0c:9665:: with SMTP id 34mr15164929qvy.223.1568052754025;
        Mon, 09 Sep 2019 11:12:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:33 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 07/17] arm64: hibernate: add PUD_SECT_RDONLY
Date:   Mon,  9 Sep 2019 14:12:11 -0400
Message-Id: <20190909181221.309510-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is PMD_SECT_RDONLY that is used in pud_* function which is confusing.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/kernel/hibernate.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index db92950bb1a0..dcb4f13c7888 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -110,6 +110,7 @@
 #define PUD_TABLE_BIT		(_AT(pudval_t, 1) << 1)
 #define PUD_TYPE_MASK		(_AT(pudval_t, 3) << 0)
 #define PUD_TYPE_SECT		(_AT(pudval_t, 1) << 0)
+#define PUD_SECT_RDONLY		(_AT(pudval_t, 1) << 7)		/* AP[2] */
 
 /*
  * Level 2 descriptor (PMD).
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 750ecc7f2cbe..da2b3c5e94cb 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -436,7 +436,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
+				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
 		}
 	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
-- 
2.23.0

