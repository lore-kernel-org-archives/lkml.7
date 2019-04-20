Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64BC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3762183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xs0iuGSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDTKYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:24:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:24:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3KAJIcO684200
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 20 Apr 2019 03:19:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3KAJIcO684200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555755558;
        bh=E+sLm9uehRiGlzT+W/+y7Z+7JdEqg9tMPYCh/w6fgas=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Xs0iuGStg/dROYjoMJkdRR4xqGDA8RuNrrNI5c+X1AKw9kfoF8niHcBp+6S+niXcd
         HaupjVSxhhqyXTDvZD7HXzs0gKh9TnoEFq78aZfweBJRQ7706TdGsTKvugdgP9Nntc
         rwVSEt4GVDo9w5EtvSf7e4vlwLFb5WWQvwzkGN+E+oGz8qTCUWUFw7rICeemHYzu0b
         md/fMWMkQuw4ej2cABni4iZRjl14RvjUgMK5QsU/f065jSMXujyTY1n1WfI9rPupF5
         DFzX/p4LVcBQEHUqzHRTQ98zi1djNsWeELrQrC5zPtSARxowj2UuXxGesBnfQ7dDry
         bYSOeXNV++4oA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3KAJEwk684195;
        Sat, 20 Apr 2019 03:19:14 -0700
Date:   Sat, 20 Apr 2019 03:19:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for WANG Chao <tipbot@zytor.com>
Message-ID: <tip-06e0fe2d8e9178bda874a75083bc13647fbf983f@git.kernel.org>
Cc:     tony.luck@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        chao.wang@ucloud.cn, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, linux-edac@vger.kernel.org
Reply-To: bp@suse.de, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-edac@vger.kernel.org, chao.wang@ucloud.cn,
          linux-kernel@vger.kernel.org, tony.luck@intel.com
In-Reply-To: <20190418034115.75954-2-chao.wang@ucloud.cn>
References: <20190418034115.75954-2-chao.wang@ucloud.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Increment cec_entered under the mutex lock
Git-Commit-ID: 06e0fe2d8e9178bda874a75083bc13647fbf983f
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

Commit-ID:  06e0fe2d8e9178bda874a75083bc13647fbf983f
Gitweb:     https://git.kernel.org/tip/06e0fe2d8e9178bda874a75083bc13647fbf983f
Author:     WANG Chao <chao.wang () ucloud ! cn>
AuthorDate: Thu, 18 Apr 2019 03:41:14 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 20 Apr 2019 12:13:13 +0200

RAS/CEC: Increment cec_entered under the mutex lock

Modify ->cec_entered in the critical section of the mutex.

Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190418034115.75954-2-chao.wang@ucloud.cn
---
 drivers/ras/cec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..88e4f3ff0cb8 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -286,10 +286,10 @@ int cec_add_elem(u64 pfn)
 	if (!ce_arr.array || ce_arr.disabled)
 		return -ENODEV;
 
-	ca->ces_entered++;
-
 	mutex_lock(&ce_mutex);
 
+	ca->ces_entered++;
+
 	if (ca->n == MAX_ELEMS)
 		WARN_ON(!del_lru_elem_unlocked(ca));
 
