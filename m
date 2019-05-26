Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334FEC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098F02075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXFsLaIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfEZQF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 12:05:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37750 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfEZQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 12:05:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so6065259pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T+Mawwo8dbExPe1NlhGh5Bdm0Ad60nu3jrGl8X5WPJ0=;
        b=VXFsLaIa7EYxnHazNCjxhigloJgxfdWS1DKn8IeifcHtyLp72pGDS0aAIuMGoOLXRJ
         TFyRAuGYRjr0C41tHH3+rezHo2BkDg8S2kMbYM00NRATYQmKg8JutK1XGRtiXDA4P/65
         lVX0Xto1g0VAf14C2rvDPoJ+svg71eNJr+SVqZk9ambFofpHf3vlgW503KiRbmiCHbCr
         TP1HCmrDUXSVHLPG8YOXrMbhs3Wpw8YHhafNrevR3kLYch6/w/iNfmlZufGIAGdGENsu
         Z86aRqFwff2YiiSg+ggQzizTGUEg5bLtEjwDdCDV5cEtPwILSnZH9PJhrKLUURaTGopf
         YVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T+Mawwo8dbExPe1NlhGh5Bdm0Ad60nu3jrGl8X5WPJ0=;
        b=IL817cdjcIDdyuYGPRsu4gPqrrehKddcmy6qU6Y49HJ6y6VkPCKYsp0meCU5ervyL2
         PyyzGcCV/SN0Q/aZzGc8+Rfl1Juyzl8YiwfvYFuQhQaSAs2t/u7AA7TPwTeWJfSjFMmw
         YqXK28y64WWNWr4Uct9yGG3IOUIfvT6ge5hP4xHK36q2sgVS0bVmBya5RWmCpe45Q/un
         Eqjbz/EssCHLU4sYARQ0kFtRy1N8kFzrIzah075MRC5bdlCot+tITRnBZZ+IhZ+n32E6
         mC2GUCSjtdkiyPER0w+mpQYLhgqm2/CcQp3ZM4MkQlD3NK+mxP0hnvZxKH0zSALPa9kr
         zT6w==
X-Gm-Message-State: APjAAAUHO/lYgotCvaHCim2xoDtgr3e3xXy823xEVFvkwxOcB0fk+zP4
        mB1fUc5UAjn3NDX6+YhjyCAysoYg
X-Google-Smtp-Source: APXvYqzJ/y5UOIz6wFJpg6jL7zMyOUJw2MoqTh3us4EgRArwpUuULvhziV721W/Sfm4B0u1Ud3Np2A==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12mr101967606plr.181.1558886726098;
        Sun, 26 May 2019 09:05:26 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.23.119])
        by smtp.gmail.com with ESMTPSA id h60sm8716246pjb.10.2019.05.26.09.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 09:05:24 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH 1/2] auxdisplay/cfag12864bfb.c: Convert to use vm_map_pages_zero()
Date:   Sun, 26 May 2019 21:40:27 +0530
Message-Id: <1558887028-4026-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using mmap, the incorrect values of length and vm_pgoff are
ignored and this driver goes ahead with mapping cfag12864b_buffer
to user vma.

Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
"fix" these drivers to behave according to the normal vm_pgoff
offsetting simply by removing the _zero suffix on the function name and
if that causes regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Fixed minor typo.

 drivers/auxdisplay/cfag12864bfb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 40c8a55..4074886 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -52,8 +52,9 @@
 
 static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	return vm_insert_page(vma, vma->vm_start,
-		virt_to_page(cfag12864b_buffer));
+	struct page *pages = virt_to_page(cfag12864b_buffer);
+
+	return vm_map_pages_zero(vma, &pages, 1);
 }
 
 static struct fb_ops cfag12864bfb_ops = {
-- 
1.9.1

