Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD38FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6952173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uD/OBooE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbfGPVV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:21:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:21:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLLMlZ1230024
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:21:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLLMlZ1230024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563312083;
        bh=XL2J5BXXWJRYOdO4xgkautfUHWrLhcBhKpUX5V3sGas=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uD/OBooEPuALoJO5I1ngVLT56MYRlrAjiwZQBpv5W3fPm0bU/BZqowFEzn8bX3RIv
         PwoxWkv5UzPJZ8OKQ15P7PcMDv34uBAj9/qy1fZpLEvTpwApVJitAmTFceBkvhTlXv
         bImrMse0/ZeRmje5euMtKl0u0NOSJdcM0vVp+WPfAyzbOpu3FC57GKMiMLeqf1su/M
         Qn7rHcPqBq0lteYxv69PdYCX6g9C3WSQefp2g5xDIOuvpZMvk3HPsq9tf+OzfEImLF
         9xG54PUmkLyeCP5stLPqWbh1NEKMEa8CIODGm2+CQq0n5kALddlT7/KXME3D31jyGx
         AZX/ZY/F0xn4g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLLMwr1230021;
        Tue, 16 Jul 2019 14:21:22 -0700
Date:   Tue, 16 Jul 2019 14:21:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-f709f81483d652b4ae5bbda2204b95593ce07c8f@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, mingo@kernel.org
Reply-To: mingo@kernel.org, wang.yi59@zte.com.cn, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1563158829-44373-1-git-send-email-wang.yi59@zte.com.cn>
References: <1563158829-44373-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/e820: Use proper booleans instead of 0/1
Git-Commit-ID: f709f81483d652b4ae5bbda2204b95593ce07c8f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f709f81483d652b4ae5bbda2204b95593ce07c8f
Gitweb:     https://git.kernel.org/tip/f709f81483d652b4ae5bbda2204b95593ce07c8f
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Mon, 15 Jul 2019 10:47:09 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:49 +0200

x86/e820: Use proper booleans instead of 0/1

This fixes the following coccinelle warning:
./arch/x86/kernel/e820.c:89:9-10: WARNING: return of 0/1 in function '_e820__mapped_any' with return type bool

Return type bool instead of 0/1.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1563158829-44373-1-git-send-email-wang.yi59@zte.com.cn

---
 arch/x86/kernel/e820.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e69408bf664b..7da2bcd2b8eb 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -86,9 +86,9 @@ static bool _e820__mapped_any(struct e820_table *table,
 			continue;
 		if (entry->addr >= end || entry->addr + entry->size <= start)
 			continue;
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type)
