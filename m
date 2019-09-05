Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA412C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14852070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwYg3DPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfIEShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:37:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44745 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:37:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so1873254pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cdXMooijOVCDDklAhZuef4glr7GEYQsndAFC5Dzs39I=;
        b=NwYg3DPGtouRXEFmIVaeTkxg/FzR6vJ0B1wp1Jb423FCaSfHNTzFGTFBNPWy3159fl
         H9KmXPmRRPWz93zBA6+IcK/rjm2iBELYPk4ycDH2nRYHnJDLYulNdn2c3WPKjLp9els/
         lc60ZGbr5PShXttY3+d7K4II+2+gEoVTMUr5JvnMKaVa3g784WbXSNZWwSyieJDH2Dt4
         lsleHHKSV9+VcIRGcpKwxB0qWXBdxngPcXtsk+dlbQOCzNTqjSK9QymsT0aJqTD+6Awe
         z8aEDm324f48MDpYMuHo633InHRSqfaidV9OwVqJh8wy0bo2oIkppaKBjqkYPWQWOu7+
         Hxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cdXMooijOVCDDklAhZuef4glr7GEYQsndAFC5Dzs39I=;
        b=de4AGvorFrWD2Q0sNqteUX/8+9LLtMyX8YQuxYkSS1jks1W3bKhBNNoOwjUOHAYlNR
         lvUQVUkYO9BOpCZc8O9ia1CAVqDtsdW4mSIQLHIRtBzfO40eWpUpeP2qW3POPztMBh/N
         plaNbY/IDXCouXwES3JAc3tgsP5AMksO0Xy3tC/afVeaUPoInxjLQXpJoDuCXbtpdY0G
         itoQMZF04RTvRtnwNvJPmP0aG/gBq/5hbic17gc48x4spT8JK/fe7Fc2SPKWeyfHSdmR
         qWDF82E6wwDUJu6tsHoFYX4rxF6YDJnX957uaG6GmztswCn0bvS0XxjmP/wq/M6lmes7
         bXog==
X-Gm-Message-State: APjAAAWWqnOrfpGIy9k7YrNl6jvThh97rqgieQWzh26+9VTLokwzKigk
        5YjK2QfOUWsTJxl3PPVaRMQ=
X-Google-Smtp-Source: APXvYqw+buhM4MmEZlgwtHc9HIsoOVpXQbIrVDPW9qehdHehSaoXp043dp5dL6H28Ob+jCYqwfSCRw==
X-Received: by 2002:a63:eb51:: with SMTP id b17mr4366305pgk.384.1567708628796;
        Thu, 05 Sep 2019 11:37:08 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.17.197])
        by smtp.gmail.com with ESMTPSA id k64sm7386471pge.65.2019.09.05.11.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 11:37:07 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        rcampbell@nvidia.com, jglisse@redhat.com, mhocko@suse.com,
        aneesh.kumar@linux.ibm.com, peterz@infradead.org,
        airlied@redhat.com, thellstrom@vmware.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/memory.c: Convert to use vmf_error()
Date:   Fri,  6 Sep 2019 00:13:00 +0530
Message-Id: <1567708980-8804-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vmf_error() here.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/memory.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b..1302be32 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1750,13 +1750,10 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (err < 0 && err != -EBUSY)
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
+	if (!err || err == -EBUSY)
+		return VM_FAULT_NOPAGE;
+	else
+		return vmf_error(err);
 }
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-- 
1.9.1

