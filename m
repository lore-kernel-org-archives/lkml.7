Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F4FC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D4020652
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nOknGD66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfFWMbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:31:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:31:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NCVJXo2633732
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 05:31:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NCVJXo2633732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561293080;
        bh=KKMXSnyf4VSeHReQVXg74nKhnTOLhY30m9opQB6TO6M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nOknGD66BYnCoZ9vH3wG1UFpcUDKaien9CkYjla1FAvECuxtgI4SePIK1V4XZX7wY
         ptfwzoM2yxDHSMQctr1qYrbFX/zNu+uzGzp3YepmD6taZAeSd0ygHLE/dFHtCj6qhE
         Rel2vjsuukxlnyuUkKlvggj5/rvNIWcem4xk8RogytUOB9dB+RPzieNEnqArTI39+M
         GZLoHxTa2BintDsxtOrZGVBQzReNzOvCOLThaQlLatYzFmBIwFUvqN0m+l6CvPLZlh
         zBK54liMGYUQFiSK3CEkb+WIlXpgQAjAEb9ltBQj+2M4WPvf6gg551xmp7DPuaoz4G
         TavprnJc0ZpHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NCVI9p2633729;
        Sun, 23 Jun 2019 05:31:18 -0700
Date:   Sun, 23 Jun 2019 05:31:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-a22793c79d6ea0a492ce1a308ec46df52ee9406e@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, riel@surriel.com, bp@alien8.de,
        mingo@kernel.org, namit@vmware.com, linux-kernel@vger.kernel.org,
        luto@kernel.org
Reply-To: luto@kernel.org, namit@vmware.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, bp@alien8.de, riel@surriel.com,
          tglx@linutronix.de, peterz@infradead.org,
          dave.hansen@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190613064813.8102-8-namit@vmware.com>
References: <20190613064813.8102-8-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] smp: Do not mark call_function_data as shared
Git-Commit-ID: a22793c79d6ea0a492ce1a308ec46df52ee9406e
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

Commit-ID:  a22793c79d6ea0a492ce1a308ec46df52ee9406e
Gitweb:     https://git.kernel.org/tip/a22793c79d6ea0a492ce1a308ec46df52ee9406e
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 12 Jun 2019 23:48:11 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 23 Jun 2019 14:26:25 +0200

smp: Do not mark call_function_data as shared

cfd_data is marked as shared, but although it hold pointers to shared
data structures, it is private per core.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lkml.kernel.org/r/20190613064813.8102-8-namit@vmware.com

---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d155374632eb..220ad142f5dd 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -34,7 +34,7 @@ struct call_function_data {
 	cpumask_var_t		cpumask_ipi;
 };
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct call_function_data, cfd_data);
+static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
