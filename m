Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B5C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FF9208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDOAghVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF3H5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:57:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37221 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3H5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:57:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so5033817pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zot35M/uaWueI3Zn11kPJ6IoYKlYtkLl9I4J6OvDMjU=;
        b=MDOAghVfP0e9bM/YbPeMmPhQMwo21Fzh3ULYKrYMmY51cSPsMd0TKeTq2mz0MMAQqh
         2FxILl8UP4nlrKoUX1a2KqBTRUVC21XguujryIxOEmbrKUhiJXlZuDumw8UMmP/Wy6zf
         X56oMJ4bEzANTKRWLKZs6gUUMFh00IBTpWHmvmMUTR5NuL/45yh9AjzHHMyvI1qi28bg
         jPvu93egb0PNGacqq0d7lfCrRJC1N9HDSYGv6k81Jjnwt/eRYqe1rRMAA9mokS7ubI2H
         9xT3VZtB9lXk8hW8a1r9Mk2+yYBTBNwiJGntmIKAc8fEtazTjLIxl2CT2Y6oAGt4g6GF
         ElLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zot35M/uaWueI3Zn11kPJ6IoYKlYtkLl9I4J6OvDMjU=;
        b=CeUOI5YPId8bJ9JI27GK6YI+MnzoGXHyBLYLOHyUe3fVxT5YqHZA2C9AL/Atge7HLq
         HyzcrQiVaciecnzl1Gn1QvwVX2xww1PrSxEWzMMzdJTgucB8GtCNHacIan7Y+TuVJ2vX
         taVKvkoeSENG3QBQeobekY0nuXv5Uw9XFDaarcAmrfJmpTE+9dm8zMsm6oCbW8Etw09N
         /BLYYRjde+Yz6XiA8IX8nUkDTGkb+ZON9PrxBN0lH4O60lacRLgvMzzwEYRz+epcGNoW
         ZPAQokxR4rVL43xxCm/dGIcFkjqmHKf9PUA7Y0IswDVWj3+wtVPWhL+PMLl24ypcPUNh
         hWrA==
X-Gm-Message-State: APjAAAVno3eXxIkgngG/LwepPWry+4k4HWXPj+0Vp76tKGTYBPPYRp4B
        rNn6U3VJOQEnMsmQDnD+mlA=
X-Google-Smtp-Source: APXvYqycBX9TRWgleMymlOn1K6bwXz8ht5R8eZXbow/n8eSDdBMe0GA1g+zblHybHoTG7dMX1EbwYw==
X-Received: by 2002:a65:4085:: with SMTP id t5mr18419154pgp.109.1561881439844;
        Sun, 30 Jun 2019 00:57:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id w10sm5989637pgs.32.2019.06.30.00.57.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:57:19 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 0/5] mm/vmalloc.c: improve readability and rewrite vmap_area
Date:   Sun, 30 Jun 2019 15:56:45 +0800
Message-Id: <20190630075650.8516-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches is to reduce the size of struct vmap_area.

Since the members of struct vmap_area are not being used at the same time,
it is possible to reduce its size by placing several members that are not
used at the same time in a union.

The first 4 patches did some preparatory work for this and improved
readability.

The fifth patch is the main patch, it did the work of rewriting vmap_area.

More details can be obtained from the commit message.

Thanks,

Pengfei

Pengfei Li (5):
  mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
  mm/vmalloc.c: Introduce a wrapper function of
    insert_vmap_area_augment()
  mm/vmalloc.c: Rename function __find_vmap_area() for readability
  mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
  mm/vmalloc.c: Rewrite struct vmap_area to reduce its size

 include/linux/vmalloc.h |  28 +++++---
 mm/vmalloc.c            | 144 +++++++++++++++++++++++++++-------------
 2 files changed, 117 insertions(+), 55 deletions(-)

-- 
2.21.0

