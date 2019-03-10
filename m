Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627DAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2731020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OjAJMld4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCJSbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:31:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33670 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfCJSbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:31:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id x9so1475382qkf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YM0Wn0jbNjB6y9zmP7dH8GmfHqq62eVgozcbKGDoac8=;
        b=OjAJMld40/KT0JAIPx6soIHP89Ze06bD3MGxvBqLe0oL0B5vScTMZQDwEvoGkWyKlW
         V/WKCVRTYFZMJxGUhADvY53i+Xe5Esz2rieFZF5o+7VhP8Z7qV6djQmUAbRfsmiXnRrX
         mkayBOoOtusSvWAwZNV/lAU2/w/6TzNx4geFcwC2ho4gEhBFQS6WHpkelbNE9+vZGcMk
         aXvHLjAntJDwLvn1k1nGiG5y9SoATsC66EQU3RT27so82LXlLpTfU1HPWJpiTCrJHF2F
         mq4s8RtdFsw/KU/YvzIUZp9HGomr7sD9pb30prqzyfTxVFLPrPrJ0L+fFCzu8/X2xSSM
         8MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YM0Wn0jbNjB6y9zmP7dH8GmfHqq62eVgozcbKGDoac8=;
        b=kmscjjHOI8ifg/b2auIBznJgTmcQiWLOHye6fGGg9lACYS5A1Y+OCknUIdb2saT65B
         tV6kqCKG0Awy8m7Y2Pxxw6InIO1jDaLSunlpv106K93Dfo3/MaN1qRsABsfa2/V1xrES
         MoV7lgeJjEU2h6ga+G+dfsrn+ByJ1Wv62KWZH9i3agodOxoudRbGSMJk8mmMjW8RzQHw
         mpwvDIC7WA0RKBaCWblFTyRaRuj0BO8LTQ0Gf6UETZwzn5eSW9ug4l26W+wMH45XFWVc
         iQAeKuNcT0CU1bbDmGm3mjufIvH+gp61L5bmLicQFSPpzXiqQMlXM4DeodrjyOvq6A8u
         tAnw==
X-Gm-Message-State: APjAAAVmvt3Ro0QJnHGUR5WRj/sTGqln4w3HnEXvjSx8l5pdRttYOqtN
        vpDluzr+zFABbOIvEh0yqHS5XA==
X-Google-Smtp-Source: APXvYqzs6RndkrdSCNp7wEidhbaphcHOOi4/scuDQle7s3Fl1752DQ6Dc/9nQA5DkP+RbvDT0EZAUA==
X-Received: by 2002:ae9:ed4c:: with SMTP id c73mr1564173qkg.192.1552242659537;
        Sun, 10 Mar 2019 11:30:59 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f7sm2042200qtb.35.2019.03.10.11.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:30:58 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, jgg@mellanox.com, arnd@arndb.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Date:   Sun, 10 Mar 2019 14:30:51 -0400
Message-Id: <20190310183051.87303-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic64_read() on ppc64le returns "long int", so fix the same way as
the commit d549f545e690 ("drm/virtio: use %llu format string form
atomic64_t") by adding a cast to u64, which makes it work on all arches.

In file included from ./include/linux/printk.h:7,
                 from ./include/linux/kernel.h:15,
                 from mm/debug.c:9:
mm/debug.c: In function 'dump_mm':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects
argument of type 'long long unsigned int', but argument 19 has type
'long int' [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^~~~~~
./include/linux/kern_levels.h:8:20: note: in expansion of macro
'KERN_SOH'
 #define KERN_EMERG KERN_SOH "0" /* system is unusable */
                    ^~~~~~~~
./include/linux/printk.h:297:9: note: in expansion of macro 'KERN_EMERG'
  printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~~~
mm/debug.c:133:2: note: in expansion of macro 'pr_emerg'
  pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
  ^~~~~~~~
mm/debug.c:140:17: note: format string is defined here
   "pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
              ~~~^
              %lx

Fixes: 70f8a3ca68d3 ("mm: make mm->pinned_vm an atomic64 counter")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index c0b31b6c3877..45d9eb77b84e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -168,7 +168,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm_pgtables_bytes(mm),
 		mm->map_count,
 		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
-		atomic64_read(&mm->pinned_vm),
+		(u64)atomic64_read(&mm->pinned_vm),
 		mm->data_vm, mm->exec_vm, mm->stack_vm,
 		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
 		mm->start_brk, mm->brk, mm->start_stack,
-- 
2.17.2 (Apple Git-113)

