Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BBF2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC+bR15Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgACDkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:40:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41702 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgACDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:40:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so18572872plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 19:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bB4+hfTmQh6Iiur+hCsUFwSITbgu+0W5H6DxFGQr26k=;
        b=AC+bR15QgXhIl4207I2am+yh3LmmjfutQT4oa1Gpl1lVdPM9G66tO7DynPod4h+uwI
         YYaCxHnh6PBx7kJf6ttKl2k0UaPNtNrDCawfxDe+w5T67ug7m8PUf7B3DkRqQbC9URFU
         zvEc1kuj6rzL1YeCy97rJ/bBjviWddttnLnpoUHDMaIHZYybyGk25ca/QJVW4u+lt1AB
         IeBHL0QMMClL/omq031ZcdEUFztyxkiXR3D/+ip/zHvRmiOpiNlu+YbiBPSv997+x0li
         KgFT2dAGW5hEPwFpk+J6M04VJ/Wz0iYxkyD2SO/1nUpkiplWT5YT45Yy4wt04DM/Jcdm
         XRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bB4+hfTmQh6Iiur+hCsUFwSITbgu+0W5H6DxFGQr26k=;
        b=Qpf4TdymP74FYJQjBYcNvETrgtQ4Bgx44DwgM8hPrDBrUt6SWU8DXJ/gYGTKFjll7j
         TxG71K5niwddIewwRuTDfKlQJmNVVDNeUNppbSnFvVoEa19NZL2JQ6ksllSt7goTns/I
         kRIC5P+zUoew64UlLldm5D1nqEspcqpqR+sEBEb7VnJvCK2RSEmZN69rOc8fasvZPcOC
         BCiggCmOKGH1KtRltPCPd1bfgmqph9j6g8c3MZGYRTAWIj1vuMEc1Q1b1ZuzqTVRoDBY
         OjFPYuql+VqWGZYbfxgjBqiihXB5PZux5v4a6Vg/o5VDF2bP2UQlu0JD91bxLyoHc95y
         mHwA==
X-Gm-Message-State: APjAAAW71CcGehag8cL+uhKNtK8Zw8NAbLaF3CTLAINzxTgNQ+Z8KMdH
        9kX/HBZn9Me2PiycGBvK0e8REfc9qaokbA==
X-Google-Smtp-Source: APXvYqwwdV1BZ9d5XfBCTqZReBZ4cECc7BXTQQigXOelwL/cbwDEBXY9qLRtm+jmWdqOMNDGzATgPA==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr86415065plq.79.1578022834100;
        Thu, 02 Jan 2020 19:40:34 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id g26sm56881618pfo.130.2020.01.02.19.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 19:40:33 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Date:   Fri,  3 Jan 2020 11:39:29 +0800
Message-Id: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
If any of the two macros is undefined, below warning triggers during
build, fix it by moving 'i' in the guard.

arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]

Also use true/false instead of 1/0 for boolean return.

Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
v2: update description per Boris.

 arch/x86/boot/compressed/kaslr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..fff24a55bfd5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -695,7 +695,6 @@ static bool process_mem_region(struct mem_vector *region,
 			       unsigned long long minimum,
 			       unsigned long long image_size)
 {
-	int i;
 	/*
 	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
 	 * use @region directly.
@@ -705,12 +704,13 @@ static bool process_mem_region(struct mem_vector *region,
 
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
-			return 1;
+			return true;
 		}
-		return 0;
+		return false;
 	}
 
 #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
+	int i;
 	/*
 	 * If immovable memory found, filter the intersection between
 	 * immovable memory and @region.
@@ -734,11 +734,11 @@ static bool process_mem_region(struct mem_vector *region,
 
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted e820/efi memmap scan when walking immovable regions(slot_areas full)!\n");
-			return 1;
+			return true;
 		}
 	}
 #endif
-	return 0;
+	return false;
 }
 
 #ifdef CONFIG_EFI
-- 
2.17.1

