Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686B7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C25420665
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFSlFbov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBOQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:16:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47012 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBOQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:16:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so436633pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8tirXskpMAhNy3e7NClMztjS4SZXfLYl5ZSuLbR4Hk=;
        b=bFSlFbov+AMUg7OyusaEXkDzPAaG9WIl2+j01Ib4t9nVU2vyX3V5Suc1jxvh0DMj4T
         osRX55sJ9hfdqs/H2DsXotlaYgrJsTPTosbqaFjZ5Ny7OB/oA1xRiN0mYKeLefCNUYP1
         WWAcMJ0NsOy+TwuofxTX+Y/wOx+q3P9evixECNzjly7tNVKK2hyZj6BeUQC8pkFgeI+1
         hsDXQJzau9+X19hrIKQuBv1or+rC7V/lFvHmy3SlA89akP4tMFNmfn07X+mkdDAFiKwx
         uXtGxoLd6Vjcdocc4x7bqBR8dvoBfmATuNlWtlqxVDvpR8VTTIRwE1atqvT/NAFkaqu5
         uCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8tirXskpMAhNy3e7NClMztjS4SZXfLYl5ZSuLbR4Hk=;
        b=qk4SKnAyf3gTDqIPX5tgakeebhpKkcMhLCW5KP8thtqhlNXqGThRqkODPABrLhNnJ0
         sTAryOEPmVHlMOvJKKAiWlL2wEY88KGFXA84mrYm061KACoF2Rayoz10AoY1iv3c3BUE
         gtnJ+xeROUSBcRRI7t6nOY1V838Yp5i3+VdpXCqO827WsGR31Q1Uqi2b4r8QVg1hTWY4
         ThjQvygoWWMq+Xq9SeCbGhhSf2Eu4WzKA/tB9di89GnCyRcC0zHfTSubi+28SSWhQAuW
         1QGR60GqEs/+DCZwC5lp21OHOfoO3d1DiVoT8jnFnuUN6u4VPsAJTAWvAgtyBvhZj2Zq
         ZHbg==
X-Gm-Message-State: APjAAAXrNQeeJKloeOH1aJ2g6OsShv+zjnzD4ItmhRYjXV7nWi671/ac
        ODC08LMC4WjY72AyjVwaKLM=
X-Google-Smtp-Source: APXvYqyw7rlsqOd28OgPWdKiHxN2laMuLmyw7e1ts1TJND9GEmV3gyIu2BhBR3m8wSMIlF+J6RscHA==
X-Received: by 2002:a17:902:b688:: with SMTP id c8mr35129791pls.243.1562076960851;
        Tue, 02 Jul 2019 07:16:00 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id a5sm744617pjv.21.2019.07.02.07.15.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:16:00 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 0/5] mm/vmalloc.c: improve readability and rewrite vmap_area
Date:   Tue,  2 Jul 2019 22:15:36 +0800
Message-Id: <20190702141541.12635-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v1 -> v2:
* patch 3: Rename __find_vmap_area to __search_va_in_busy_tree
           instead of __search_va_from_busy_tree.
* patch 5: Add motivation and necessary test data to the commit
           message.
* patch 5: Let va->flags use only some low bits of va_start
           instead of completely overwriting va_start.


The current implementation of struct vmap_area wasted space. At the
determined stage, not all members of the structure will be used.

For this problem, this commit places multiple structural members that
are not being used at the same time into a union to reduce the size
of the structure.

And local test results show that this commit will not hurt performance.

After applying this commit, sizeof(struct vmap_area) has been reduced
from 11 words to 8 words.

Pengfei Li (5):
  mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
  mm/vmalloc.c: Introduce a wrapper function of
    insert_vmap_area_augment()
  mm/vmalloc.c: Rename function __find_vmap_area() for readability
  mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
  mm/vmalloc.c: Rewrite struct vmap_area to reduce its size

 include/linux/vmalloc.h |  28 +++++---
 mm/vmalloc.c            | 139 ++++++++++++++++++++++++++++------------
 2 files changed, 118 insertions(+), 49 deletions(-)

-- 
2.21.0

