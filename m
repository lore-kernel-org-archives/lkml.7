Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553982175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4/rFMz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfDXKWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:22:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42943 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfDXKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so4712717pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HDIg6ROZRC2jfQ3nCG9gUelBX+LREsHvgd1/Lztul0=;
        b=i4/rFMz4p1i8vXbatI/palG8YptRmoo1LHUDBGR8Ay5DruCATulff09VlWu5Tosmlr
         UtntX8RYUw7NTBXwxNXRYFlJKPwcYBd6vqqMuleUFcbXJiHq09XaMf204+r0Mkewexgc
         i2VnnVBfDEVIjW1oCSUE74vbrD7D8yol2BamSkMNUdzwqLHN2D7FnDHdiEsxPqkCRme3
         Lw87IGgzwK6AvnTSc62V8CA7poN+cNjOaYYluOxemK2MO9zoK37PP+so4qDQX+ay5oAV
         AzaDIqDR8K4PbcBCDPIw1MtPRb8WYsAK5zCcdlrcDIVccLqlnFlyvb5ZAZSnKPl8WNh4
         nL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HDIg6ROZRC2jfQ3nCG9gUelBX+LREsHvgd1/Lztul0=;
        b=GhbxFv2X8gfpkzmhoT1cUsZEEzThAmjgA/yZOJPFN+9Uq+hfr4YF5yvtEpr0bprBqy
         ESPJqaT30cs9bEd8FWUmMgR6/Dgt3IKvSCTV0ZktKcedHEs6BBNmF/n1oyBANHVRGKjm
         Ob/nYo+evofhSOUBHztFeXZLsioNgHfbQ3G+aV2362lQuwMC+AYfsGPiN59WbAogqUdZ
         /7YU1hKyXru2HUtcm9Jw4/tOAK/wr5FXQlAseuhSISMimSFpMC+uYgHHgeMbXydgQRxC
         w7AQFpVl2fGAJ51lTHQqKWxVn61nKjOnXBaMNB0/6AU5GHpWoM6NRE/TLOfp29fxwiYx
         TRZw==
X-Gm-Message-State: APjAAAVzaXFlPkTiES8tbTa1ERzDdqMZ1c66cY7FTvbo7hX0tdsYfeFy
        MXK3bUYBmgGneUaWXZGQO0Q=
X-Google-Smtp-Source: APXvYqyZjsMd1Z5gM5SAuGjYtpVb2bRlxmrAZ+Bp9Gba+Q2kMUbOMeu2GpY0RjMLJD4CtKVHV5l/0g==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr30487952plb.174.1556101282880;
        Wed, 24 Apr 2019 03:21:22 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:22 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 18/28] locking/lockdep: Remove unused argument in __lock_release
Date:   Wed, 24 Apr 2019 18:19:24 +0800
Message-Id: <20190424101934.51535-19-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @nested is not used in __release_lock so remove it despite that it
is not used in lock_release in the first place.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index eb85183..6e79bd6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3988,7 +3988,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
  * @nested is an hysterical artifact, needs a tree wide cleanup.
  */
 static int
-__lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
+__lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
@@ -4276,7 +4276,7 @@ void lock_release(struct lockdep_map *lock, int nested,
 	check_flags(flags);
 	current->lockdep_recursion = 1;
 	trace_lock_release(lock, ip);
-	if (__lock_release(lock, nested, ip))
+	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
-- 
1.8.3.1

