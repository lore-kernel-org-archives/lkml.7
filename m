Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBEC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE3A252BD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZXxpMeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE3Mll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:41:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41686 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3Mll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:41:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so1957635pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=XS1GrKWyZnetUAZw+qazRGfQxYpyPONGBgzB6aYIx5A=;
        b=mZXxpMeUoxhFtGjHpOeOq0JQCsoUcLJunKvq34tfWEpz3NigldLVt48RoEHRDhAK7E
         Ec7MbSqDutMds072aG5Nt9c5FLczVZmkBk+4EuYaaCxFMd/Keb3Kg3zJ9gbJVUBKw+p9
         vFltyinHtCqD/jyTUVLyWhQQNjsD+zG+0R4lfoVO2AKOXVo0xlg61T/DPhPq/+ZbAzVQ
         rwH+K9N86xQ2ElLG6Wu8YZyJD/00PvygPD7uq1cVhnPYcA4ka0DqofVfpaGFBZODg2Ao
         O3TBsf14TwA6EibzsUq1ratPIlLFi/hl9GEyrt0JPTRosG63ke0kRsLocSWPYoCaEjQg
         6qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=XS1GrKWyZnetUAZw+qazRGfQxYpyPONGBgzB6aYIx5A=;
        b=HQ07VlKVjDavJj5zNf5LA+EQSbs4DTPINbzvFysw0LIMkT6XyCWE/p1EqQS4as/zE2
         BhgpKpqhQD04ytV32fft3Fdn84V0ui2JPjX52hOVXwmMXR8yOvP9e1EwqFD9WLiy3CPj
         pdDpcSRUJCFcnyE0xRIiRaFsdEfwiGMbk/Kht/MiacOKMJ0srPHW03+fj6AUMO0W3NJp
         1wQuZc2a4Tllcs6FMK/FDs5Os8hKgLRWvdPn6ML6bE+zAiFKoe687uEZi6b2YrEOYWOs
         B46A1DiwYawEdl1N0uMIshHpePTi7B8ZgVVzHXnFnO1b3HjclpGW5AFfWKwg1hTQhB2f
         BL8Q==
X-Gm-Message-State: APjAAAU0cLcF5MWhbQFkr0hGchhvIlwtJepw8+6FccgSu1QhJ9jkUnFS
        i0M4EbWil82yTYiwt/JfpuH3xZdW
X-Google-Smtp-Source: APXvYqwHaPaUzmbngUUvySaIWmgLA10Ha00cYu+v6Z+5LeZNSGiN4e3d0GKVwQtNCJARLSLTQ4orJw==
X-Received: by 2002:a62:2b82:: with SMTP id r124mr3527860pfr.235.1559220100409;
        Thu, 30 May 2019 05:41:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15sm2419333pfi.141.2019.05.30.05.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:41:39 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Zankel <chris@zankel.net>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] xtensa: Fix section mismatch between memblock_reserve and mem_reserve
Date:   Thu, 30 May 2019 05:41:38 -0700
Message-Id: <1559220098-9955-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9012d011660ea5cf2 ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING"), xtensa:tinyconfig fails to build with section
mismatch errors.

WARNING: vmlinux.o(.text.unlikely+0x68): Section mismatch in reference
	from the function ___pa()
	to the function .meminit.text:memblock_reserve()
WARNING: vmlinux.o(.text.unlikely+0x74): Section mismatch in reference
	from the function mem_reserve()
	to the function .meminit.text:memblock_reserve()
FATAL: modpost: Section mismatches detected.

This was not seen prior to the above mentioned commit because mem_reserve()
was always inlined.

Mark mem_reserve(() as __init_memblock to have it reside in the same
section as memblock_reserve().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/xtensa/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index c0ec24349421..176cb46bcf12 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -310,7 +310,8 @@ extern char _SecondaryResetVector_text_start;
 extern char _SecondaryResetVector_text_end;
 #endif
 
-static inline int mem_reserve(unsigned long start, unsigned long end)
+static inline int __init_memblock mem_reserve(unsigned long start,
+					      unsigned long end)
 {
 	return memblock_reserve(start, end - start);
 }
-- 
2.7.4

