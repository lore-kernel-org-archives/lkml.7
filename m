Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E8C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2B62190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2461pL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbfGYBky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:40:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45209 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfGYBks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:40:48 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so93746330ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oXN5GwXNrqWezDYAWTbIPylSr9KykD38a2m5LA5Vzvk=;
        b=H2461pL6theAnpW5edW+3dqP8T5QMrpFl0SXGGIZnqB+ZlHIXGHeYrYrfnlBuLfUp9
         o+DcklySifYG765de/M6SgutOlGYOP4WF5mJtz1jTM2lOmhvJX9V6DhHKgn2HOScs53e
         IzBcWiOROr/uvNK+aKEyV/oc1kulroh6fFFau4kjUzN5aRYuMC+51OMqOcoZLa0nC2bS
         8+BoGmCcQceVuXdjrqbcfXyFNI4xY1/t62QHTPZefRz7oOXBCShHxOwzmafADOk8VhJX
         gLdEGHfYCnCmIhAozPvWbPT1+3C7/khPdVJ4aX000z8Dz28NjCaJoqArS2QvPkpIHpQM
         slfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oXN5GwXNrqWezDYAWTbIPylSr9KykD38a2m5LA5Vzvk=;
        b=pgAGLRByQPom6Fl1rXCsFvUBa2RIk/P08rV5d1qZFOjud8JAs3+iWhH0XbYR+Gm+qR
         ZoIe2MSBlGCwcF5C4DWCSxob8VeajKaoMwRj+35WewQyAna6qjNnkXxshqSN+gxr4WtE
         XwCjgk/TT4KPk1GDUcI4Rk3At/3mC+8VqK4ui1LDZV1afZAm9FtqO+0ktfXrBqAamubo
         bA9QZQC2eeHPAQL7yiLIXkCuAoL26HBZ3aPcLG9pww0RbeRU69EVemesOckemkxCsMBT
         /0k9jDIYC3CJcL0MnD3n3zZrS6z29mvnr30GwIdEfgTxgURUIjM5C/njMK0iofxKJTfh
         Paxg==
X-Gm-Message-State: APjAAAUTyafMl67MIITK8yW1KdLfFeaA3NiJcQcVk0CAmNb+ma5ZUin1
        3266tsQAXBdq3NImohjH9xs=
X-Google-Smtp-Source: APXvYqwZV+csN65QFH3c/+ek2MRlo4Jzp+G1GLrE+iP8KG1lV2GK5/itgNtY2zuUMy76j+9IordQ7Q==
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr88348318jai.39.1564018847231;
        Wed, 24 Jul 2019 18:40:47 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id h19sm32973203iol.65.2019.07.24.18.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 18:40:46 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     emamd001@umn.edu
Cc:     kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb.c: check the failure case for find_vma
Date:   Wed, 24 Jul 2019 20:39:44 -0500
Message-Id: <20190725013944.20661-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vma may fail and return NULL. The null check is added.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab..9c5e8b7a6476 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4743,6 +4743,9 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
+	if (!vma)
+		return (pte_t *)pmd_alloc(mm, pud, addr);
+
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
 			vma->vm_pgoff;
-- 
2.17.1

