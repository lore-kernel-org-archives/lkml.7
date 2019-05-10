Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F579C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55808217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFPAa0My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfEJTIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:08:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJTIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:08:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so3249250plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qqmmhku5NomnoxUpgEvNAyGjbBl3yg9ZxTTgvkD102M=;
        b=JFPAa0MyN843d9zgKq8io8uewPn7zQ1PlQO8aYvOzS1Mi4/cHmf4jamtybEB7GaMdr
         KQKmp/J9r0HGIdRuJ/pkRJn8cj6NUlBep2gl0Jwa4FytvdYtKgSqtH0gsuq+tlZFZB50
         qaIVA8B5VcbN4RkEpELN/98rLFrA+O95RU+IjnZLOxsYUlx3OV+iP1Q7MR39z/xEZTMm
         MqthEewVVIosDHZ8TNNC+DHXXKw8d3hzaBJweBxrZzrC22mujl3Ai2pHvhT2nJ/gq4G3
         Wafflc2ems0wgOGPDIkzVZiSFwxjEyOADGhqyfbq7Gk/aaW4QmnQBGXsvExXeC8W17wr
         uplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qqmmhku5NomnoxUpgEvNAyGjbBl3yg9ZxTTgvkD102M=;
        b=Fjf3IxXY3wPMze0J9tFs9+f25EfCnpIMH31ute4tjBAOkYaQ+ogKYDCBDItLMXkamB
         bkGal3IkLayGYy4tOOef9zpp8GaEInNbrFWr9aymnfT6FDS9PKw7Dn+tk3RwriMDhq7w
         XboOG1RBPLqcxBt+7uwoMt2cyFdcJTC2NTKLbN/cnTidaIQl01zqKTlCo2/jLbWcosnE
         j6fYbRla71wsqKvHkqYGiKLwgaT/D109LnD4HKvpHXEddquEJDmB0cfcs5ntPro6mb/2
         b1zwSXcJ7g52/04INMkQ4B9py8YuqJdVagpe/yW4pBq5WBnh+3IvaZObpyH4YiS6ZpdR
         35pA==
X-Gm-Message-State: APjAAAWy5M6WlS8a15Fy4aZAqHRyiwO9Iu7Hqvbi9tGmHn4OBXo+15EV
        gTi4ylKyN0jIiaDTUkUTkmg=
X-Google-Smtp-Source: APXvYqxh11p32GP45ZppQiFiuUUwfmEh21dKrieWhO5ETBbE1nGlSaazDVYxL6/U8v91WdBwtgfbfg==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr15124532pld.97.1557515318193;
        Fri, 10 May 2019 12:08:38 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id g83sm3699314pfb.158.2019.05.10.12.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:08:37 -0700 (PDT)
Date:   Sat, 11 May 2019 00:38:32 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     akpm@linux-foundation.org, jack@suse.cz, keith.busch@intel.com,
        aneesh.kumar@linux.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/gup.c: Make follow_page_mask static
Message-ID: <20190510190831.GA4061@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_page_mask is only used in gup.c, make it static.

Tested by compiling and booting. Grepped the source for
"follow_page_mask" to be sure it is not used else where.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 91819b8..e6f3b7f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -409,7 +409,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  * an error pointer if there is a mapping to something not represented
  * by a page descriptor (see also vm_normal_page()).
  */
-struct page *follow_page_mask(struct vm_area_struct *vma,
+static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
 			      struct follow_page_context *ctx)
 {
-- 
2.7.4

