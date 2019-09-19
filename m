Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D24C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC620678
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931441;
	bh=Gnb060WgRtLXs6JnHukAVdDIzLPHCh1bvcZjwA+WdiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNwtqVX5N/3Axwp7rQUHRfpI1/79NJmW1PwKZyT02irO+gt1FUsH2TdFpKTc7Oldb
	 ptlYvKTXa9KKzoOqpDm6n2DCqtmBrN1Pql6DmVAwBwOlheNKRADrzlYO43KXdqVVFi
	 x9oEQOSYPrQ1zEwPdMJHnkg7Fv+ZDOkQCUxda0aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392424AbfISWRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406449AbfISWRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:17:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91957217D6;
        Thu, 19 Sep 2019 22:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931434;
        bh=Gnb060WgRtLXs6JnHukAVdDIzLPHCh1bvcZjwA+WdiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPlai6I59iLR1539vZ+nsGNcz7z++7JwKDZQzEw/ffGCIQQm0dBYcBj1mXm0w1qPl
         bleFob94g4y7sBnTNxWHGCttblgUb+qHoPUfU8dE9GNICr5EmsIwcaZf03aMrH4TvK
         LPJNsz8hi0qoXgtYA7xfCOt8usBu/s6VmQmEEb1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 45/59] tools/power turbostat: fix buffer overrun
Date:   Fri, 20 Sep 2019 00:04:00 +0200
Message-Id: <20190919214807.377475773@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit eeb71c950bc6eee460f2070643ce137e067b234c ]

turbostat could be terminated by general protection fault on some latest
hardwares which (for example) support 9 levels of C-states and show 18
"tADDED" lines. That bloats the total output and finally causes buffer
overrun.  So let's extend the buffer to avoid this.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3e5f8b3db2720..19e345cf8193e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4488,7 +4488,7 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.20.1



