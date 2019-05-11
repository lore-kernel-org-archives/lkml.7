Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7EAC04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 03:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A1217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 03:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEFPwcEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfEKDe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 23:34:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43248 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfEKDe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 23:34:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so3677996plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=LDc7rNdw62w/seke1MS8uCzmq10Ut2jeFbOZTp/I/g0=;
        b=uEFPwcEAzl3OyLKOZVjvUMfB0VPWcdQksFusopwojrvwDdk2xOIM3Y/FL24LT+U5/0
         qpnGB5nBmdJwKQ09pKm9dGSd1ndjnf111Y7Q0xczQJBT4zfaUrCVTWCKyoUKfJRfV0eS
         3MqED+rBGdCiuxoKnxgQ+bDm2bERhYnw9uCZsvRFL4aFTScYJpKAkBdGwJ2dfBbcrdPA
         VVfGp8Q/VqZDGXeUGCTBDhm1ltbzYyaGmYEuyhX49P8SAWjmVdAH1IrrznSC1VmabSBH
         0Zc/Q0x++7O9Di4QrozzI0mGO5zS4vQsEPeTIYjoji2sTfvE4tFxjVuTwkyIsRH3Fmff
         0FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=LDc7rNdw62w/seke1MS8uCzmq10Ut2jeFbOZTp/I/g0=;
        b=lYuTfH+CLWEmvlgqAfBdO/vE+YeFBFBXAP64oDbmHxAUG/W0eBZVhH7Zq5ZvSk+f5F
         7dbmid/Kziq94j9Ickk57R3QWV1K2+scMjvHiRI6ahmzHmDP1iOIurPVcijps+yD7aeL
         PHjzP0gb93eDamL3NCi0Yu6zJFJLwoh1rLGpWeJDSiSSFIEap8tqV08ZI0vPW2AUgnA6
         T7gROZlumJd66uIda8WFumLxWvnv3MPLlDBq6ZN1oqnmdTe8VkTeIZdr5bfQZnlL+mPW
         e9CoXgTQeQMFygBj9PxKJrXlSMoBf6ldw1xgdoK87FXnLsjvgc44hkvXutGIQowg9Iyu
         qpXw==
X-Gm-Message-State: APjAAAXFW++va058/ac91PVmedDviFSjxQ9DEHil2/vkUV+lNT644mQE
        uuQpaXiIkL2IB8gzYGXWzrtIeZBl
X-Google-Smtp-Source: APXvYqzy2WoxWCz1Vm6unYTT1LzLCRqW+x4Zw/BP8g15+4R82vnJfaOGMAxc9GxrU7g6acOeQreO+w==
X-Received: by 2002:a17:902:a614:: with SMTP id u20mr17106340plq.117.1557545698049;
        Fri, 10 May 2019 20:34:58 -0700 (PDT)
Received: from sabyasachi ([2405:205:6182:13c5:d90f:fd61:4614:86da])
        by smtp.gmail.com with ESMTPSA id r5sm6495335pgv.52.2019.05.10.20.34.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 20:34:57 -0700 (PDT)
Message-ID: <5cd642e1.1c69fb81.4ee83.327d@mx.google.com>
X-Google-Original-Message-ID: <20190511033453.GA5696@sabyasachi.linux@gmail.com>
Date:   Sat, 11 May 2019 09:04:53 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     linux@armlinux.org.uk, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        changbin.du@gmail.com, sfr@canb.auug.org.au
Cc:     jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Remove duplicate headers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asm/sections.h and asm/fixmap.h which are included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/arm/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index fcded2c..29035f4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -23,7 +23,6 @@
 #include <asm/sections.h>
 #include <asm/cachetype.h>
 #include <asm/fixmap.h>
-#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
@@ -36,7 +35,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
-#include <asm/fixmap.h>
 
 #include "fault.h"
 #include "mm.h"
-- 
2.7.4

