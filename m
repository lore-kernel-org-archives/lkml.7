Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EDBC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113FE222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610241;
	bh=lFxxBxjXHU5mvLq0/vlgvYPguApXQkNTD64lNsNZdvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3YWamm80NLEZYgFeoFtHjB+bqw+X23PTs+BuJffnAWz86J8nCO4KdrDmcK8JTX2E
	 Tl5doyOituLHbOg+grz0Ra4A9S84Ge0cLgosZgOYr24+7O5JqCOAHv/98fvUeEbEFb
	 g0SpzKjTcUAqCSqwp4lzyF4G9MErYqjKrXbHaLDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfKMB5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbfKMB5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BC82247A;
        Wed, 13 Nov 2019 01:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610237;
        bh=lFxxBxjXHU5mvLq0/vlgvYPguApXQkNTD64lNsNZdvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXEW6sBN7qEHe5jZTblr3TMe9n8/RdGLpHTDKJd3mf+h5Eg+OpDmg58K4LyfwzbkJ
         +ZdMrql9huHOUSp1lYYqPuo+SYtMOH14VWYFFZ71YGFYVyDyDbxOblrrJiwTQbW/ZO
         aBBE7Hao1whqCKmXWAwfnA8zJx8BjKWqak9BJeH8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 037/115] PM / hibernate: Check the success of generating md5 digest before hibernation
Date:   Tue, 12 Nov 2019 20:55:04 -0500
Message-Id: <20191113015622.11592-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 749fa17093ff67b31dea864531a3698b6a95c26c ]

Currently if get_e820_md5() fails, then it will hibernate nevertheless.
Actually the error code should be propagated to upper caller so that
the hibernation could be aware of the result and terminates the process
if md5 digest fails.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/power/hibernate_64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 9c80966c80bae..692a179b1ba32 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -250,9 +250,9 @@ static int get_e820_md5(struct e820_table *table, void *buf)
 	return ret;
 }
 
-static void hibernation_e820_save(void *buf)
+static int hibernation_e820_save(void *buf)
 {
-	get_e820_md5(e820_table_firmware, buf);
+	return get_e820_md5(e820_table_firmware, buf);
 }
 
 static bool hibernation_e820_mismatch(void *buf)
@@ -272,8 +272,9 @@ static bool hibernation_e820_mismatch(void *buf)
 	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
 }
 #else
-static void hibernation_e820_save(void *buf)
+static int hibernation_e820_save(void *buf)
 {
+	return 0;
 }
 
 static bool hibernation_e820_mismatch(void *buf)
@@ -318,9 +319,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 
 	rdr->magic = RESTORE_MAGIC;
 
-	hibernation_e820_save(rdr->e820_digest);
-
-	return 0;
+	return hibernation_e820_save(rdr->e820_digest);
 }
 
 /**
-- 
2.20.1

