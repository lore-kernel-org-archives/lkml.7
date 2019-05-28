Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A5BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9952120989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPR2LkbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfE1UIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:08:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfE1UIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:08:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so3086wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FwyZOikIAHRFT3QzU5wwJvymvoehhUYtGScgb3Iy2KU=;
        b=sPR2LkbHDwHBTrxKddz4MuIh6aBwoiLqSbdvQbRKGiA5Aqukg3caA5AvXt6kAxSkTL
         sb0u1UNAWSM6ztF0l3FGHD4AK2BOg/fFM0i9KpDsoZOEovrdKkxgxhU26wADOC34XQ94
         j33ud1TudwfJjNOyyMCzHvtB7I+lzLZNxrWoZsoq2yg8bWbmhJLxxrwZKwQK8E8iNzIX
         yeA27iq4cdSD0bOEL8ih2aHe1EzuAwhPdpl8zAbmkm6ZrddC0BkRRoy0l5W/BXLY8D/c
         oysvMAlxRqGB7lXUbCJEGjC5cD+dQ510HpQ34tosTrJUR79g5esZauTc3f7gy7xRiCUL
         obuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FwyZOikIAHRFT3QzU5wwJvymvoehhUYtGScgb3Iy2KU=;
        b=PjD5jF83vMA/ZTwZY8gKKt3rzZjvzv3ft3VskKPZaDRojKPnsb/J5T95J1jn0VUfEk
         v6z988Wp3KfV3YeP1zNJKEx87/8FsYnMbOalwirs59Q4iRQamu1Ikz64j+syGAu8Mpm0
         iJz+W8cB2awj68OKfJvwnlXvwhDr8QUEAYYCzNP/y0vgZmuZ9LVbjUIQvp7qGRKbgqoV
         uMBz4Klgflq1VuceXJS/hUggYfCGcldOtjtMQ263RLYEbtTjXfIuEAAbIQ8SxrPcVlmR
         bqUVg7ARE7TA3OA6o197bPTHQKZOyUMOuwZr1lyneG8aSu5s8LEHFH6GuhP/5QUf//OH
         yS3g==
X-Gm-Message-State: APjAAAWvTTI6KlxzvDgsPLadT347XOM0ZaDa6vERIVfGB75XWUSr1ZR6
        JfvJhCkD9mh1Xb7u9TEwyqY=
X-Google-Smtp-Source: APXvYqxLdRrmpq0R7779TRRUtBGMMOCmaLOaFGClALZCcIJ45dYfe6GOEIs7RwPFEkvgZ47KlrVspA==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr601730wrw.10.1559074110241;
        Tue, 28 May 2019 13:08:30 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id g2sm14396336wru.37.2019.05.28.13.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:08:29 -0700 (PDT)
Date:   Tue, 28 May 2019 22:05:40 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Fail when offset == num in first check of
 vm_map_pages_zero()
Message-ID: <20190528193004.GA7744@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user asks us for offset == num, we should already fail in the
first check, i.e. the one testing for offsets beyond the object.

At the moment, we are failing on the second test anyway,
since count cannot be 0. Still, to agree with the comment of the first
test, we should first there.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index ddf20bd0c317..74cf8b0ce353 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1547,7 +1547,7 @@ static int __vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 	int ret, i;
 
 	/* Fail if the user requested offset is beyond the end of the object */
-	if (offset > num)
+	if (offset >= num)
 		return -ENXIO;
 
 	/* Fail if the user requested size exceeds available object size */
-- 
2.17.1

