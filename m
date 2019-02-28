Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A101F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZGN+GuTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfB1SSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:18:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37309 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1SSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:18:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so24655104qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ljQRzmSVHZ8FUWlGnEiX6dnZnYIPE+woVYSvg1vnVl8=;
        b=ZGN+GuTTkFiYk6EBJySQlSM0ZZxVYMiH7AiaMYMR2RY1fC6K6wACV9tQpQHfjnnfR4
         mSUZhAC37d1TPzUre3jMCuXs+I6NY0hVZGIro6Wl48Oomfgd6HWZzey8AiS3kcIcUS95
         N7pyU4wct/4QOH2WuS4F+Y89l6rUdkRdgLQYPmrs9XbOGx+7aNFa0cf0O1obX6zC712Y
         vqfY4XdFz3vFC7qoTqDOGRN9oQGgtNUbWDOnjyFSbhjS0jgjIzW2O03gte+meZYdiuPC
         oNc8M7c7l9HyBlo7U53a7/Zo9CQZhK+HWNnpLUmeaBr+hiyPL5frVuSgbqT0kC/wNdhp
         PbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ljQRzmSVHZ8FUWlGnEiX6dnZnYIPE+woVYSvg1vnVl8=;
        b=PJRoquk259jU1vBgsnY+2pbAlzhBb+deXodvv9TJCqxK8ul1An/mSYk277Q01DYpuM
         ulKxmCjuT5YbCPTY1zB2v/k27ysMbHg0KVujpTLugtT1PB7Z1CBs6jTbj1fHNuYzlPQH
         UP8rnDVKKXP7fSprGVC+Rj8KNrYLE2cMxevee3e7YAEWDjpdIk4wMMrJZFD6tYapSZyD
         SOBlmMEiowRn9vc4gIyKB0V9BcC1ssIDbWKBgtnTvZyR3cAb+9pmZlAE3QZ/6MAJk4WX
         vrGJMsKhOatnRZuub+AeD8t7KybKuTiNd8m/2ilKnI5/d+7Uk9gdEyoDwfBsHUZPXoWF
         topQ==
X-Gm-Message-State: APjAAAXjjULkmp7nd9eHEFYbKnHJCCz1Pf8qRXrM1rffAPo+96DrK4Zw
        vgdWVYBw49QzGidnTKNJ0pvsShoPrV8=
X-Google-Smtp-Source: APXvYqxFKSVHE9vkdmn5TB89Yj1mBAEz3pM9mtmc2n71EZavt9Z2FW3+aGEsTA2Lbo8LnzvyC7wmWw==
X-Received: by 2002:ac8:168b:: with SMTP id r11mr469269qtj.387.1551377932381;
        Thu, 28 Feb 2019 10:18:52 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i21sm9570633qtp.73.2019.02.28.10.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 10:18:51 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/sparse: fix a bad comparison
Date:   Thu, 28 Feb 2019 13:18:39 -0500
Message-Id: <20190228181839.86504-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

next_present_section_nr() could only return an unsigned number -1, so
just check it specifically where compilers will convert -1 to unsigned
if needed.

mm/sparse.c: In function 'sparse_init_nid':
mm/sparse.c:200:20: warning: comparison of unsigned expression >= 0 is
always true [-Wtype-limits]
       ((section_nr >= 0) &&    \
                    ^~
mm/sparse.c:478:2: note: in expansion of macro
'for_each_present_section_nr'
  for_each_present_section_nr(pnum_begin, pnum) {
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/sparse.c:200:20: warning: comparison of unsigned expression >= 0 is
always true [-Wtype-limits]
       ((section_nr >= 0) &&    \
                    ^~
mm/sparse.c:497:2: note: in expansion of macro
'for_each_present_section_nr'
  for_each_present_section_nr(pnum_begin, pnum) {
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/sparse.c: In function 'sparse_init':
mm/sparse.c:200:20: warning: comparison of unsigned expression >= 0 is
always true [-Wtype-limits]
       ((section_nr >= 0) &&    \
                    ^~
mm/sparse.c:520:2: note: in expansion of macro
'for_each_present_section_nr'
  for_each_present_section_nr(pnum_begin + 1, pnum_end) {
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: c4e1be9ec113 ("mm, sparsemem: break out of loops early")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7ea5dc6c6b19..77a0554fa5bd 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -197,7 +197,7 @@ static inline int next_present_section_nr(int section_nr)
 }
 #define for_each_present_section_nr(start, section_nr)		\
 	for (section_nr = next_present_section_nr(start-1);	\
-	     ((section_nr >= 0) &&				\
+	     ((section_nr != -1) &&				\
 	      (section_nr <= __highest_present_section_nr));	\
 	     section_nr = next_present_section_nr(section_nr))
 
-- 
2.17.2 (Apple Git-113)

