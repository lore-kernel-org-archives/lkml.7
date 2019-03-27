Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D367D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="pZR3zIYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfC0FZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:25:00 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5248 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfC0FY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:24:59 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 01:24:59 EDT
X-AuditID: 0a650161-78bff700000078a3-e1-5c9b05a26d92
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 13.5D.30883.2A50B9C5; Wed, 27 Mar 2019 13:09:54 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1553663394; h=from:subject:to:date:message-id;
        bh=Cq3QyfDrCxOsHErXF6QgqWBcev6aUspN1MXPvc32OCY=;
        b=pZR3zIYZ5hquydhXwmqwRFoENFoACrORcafpPGq7UZvf0i/cnnFlNXdrcqgIh9lrTCwsTIecmMA
        Q2gm8vL2xbX68ZdxobasEiJBdgKJuvQT5FVledSSHsN/MlLLU3yWxNpe0NPmCYfQ4Sd4rXMMVKCSo
        7AJUyGXnBJfVQP03Bc4=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 27 Mar 2019 13:09:54 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] trace/page_ref: print out the page migratetype name
Date:   Wed, 27 Mar 2019 13:09:37 +0800
Message-ID: <20190327050937.5395-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXClcqYpruIdXaMwcZf/BaXd81hs7h0YAGT
        xb6OB0wOzB4t+26xe7zfd5XN4/MmuQDmKC6blNSczLLUIn27BK6MdY9vsBQ84a44cTmsgfEP
        ZxcjJ4eEgInEywPdbF2MXBxCAicYJW4efssKkmAWkJA4+OIFM0iCReAtk8SyfzPZIaramCQ2
        P53FCFLFJqAhMffEXWYQW0RAUuJ9zzw2iO4YiRMHToLVCAu4SNzY1ANWwyKgKvHyzUwWEJtX
        wFyi5eIOZogz5CVWbzjADBEXlDg58wlQDQfQMgWJFyu1IEqUJJbsncUEYRdKzJi4gnECo8As
        JLfOQtK9gJFpFSN/cW66XmZOaVliSWKRXmLmJkZIECbuYLzR+VLvEKMAB6MSD+8HiVkxQqyJ
        ZcWVuYcYJTiYlUR4n4jOiBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOWzbRJEZIID2xJDU7NbUg
        tQgmy8TBKdXAtIhp7aNvSgLKjcrvuOZ1r2vx+n9Y2PR5pn6JhZyIvZzypLc5riFiTMynuTbZ
        Xgm8a7E20mqbt8jua0uZT+mVeSwSXDJvxYIFUonRf2K23FW0/eB80Fn6VnYs7/rSXao6hot4
        JOMWXlgUqLZdefeOgpqzW41L/vjOWuP89naixsyTc35dsQvSaNew32YSd51jCtP0F/WdD+8F
        hcdH7JjTm/KYo7zimvCWznT1A2KPD3xNf97ZcYHHOkrDq5xJlkl/xtz1i3yllm08M08t5YPc
        0Zx4V/F/z7/H/VkSefOV3VoF3kOfOwSDl0zQWF8ZtMV/2e5phbkGu467clq193zRbjp8jT9i
        Ut9JiczkS5E3lViKMxINtZiLihMBd8/pKL8CAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print out the page migratetype name which is more readable.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 include/trace/events/page_ref.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 5d2ea93956ce..94df979c2d6b 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -36,11 +36,12 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val = v;
 	),
 
-	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%s val=%d",
 		__entry->pfn,
 		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
 		__entry->count,
-		__entry->mapcount, __entry->mapping, __entry->mt,
+		__entry->mapcount, __entry->mapping,
+		migratetype_names[__entry->mt],
 		__entry->val)
 );
 
@@ -86,11 +87,12 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 		__entry->ret = ret;
 	),
 
-	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%s val=%d ret=%d",
 		__entry->pfn,
 		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
 		__entry->count,
-		__entry->mapcount, __entry->mapping, __entry->mt,
+		__entry->mapcount, __entry->mapping,
+		migratetype_names[__entry->mt],
 		__entry->val, __entry->ret)
 );
 
-- 
2.17.1

