Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE68EC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D192083B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ6PnB60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfGLMCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:02:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47009 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfGLMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:02:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so4212289pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 05:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38IvB5KypHDAuaY3YawsJEBcvuco56ouTYCrEb+HEU0=;
        b=mZ6PnB60as+zd8jQQHihMl6Lq71efQ8gvN2pJtswPVRzB6N/hPqe6FewYIYcF/Tx54
         w3JV1LABmcpp/rKonz9KdKdLcVK/rG5Krf9Jt5ttzc1nQ3ljvY7PDTPlei0Bgi33WA11
         Aa7nCUZQTwoJEhqgXjWw2kDIJVJThfZveZw836caUJMdNr9YV0WVg4j1y1RSyUfFslqS
         qPc286RqXst+zYYpOLQQYE4vBzfeELhFv5O+twhKjyouGtlc3pJexk2o6BXD1itXeGw1
         9tWIRGS5A6A6UtO2ZxTXX4YuzCvw86x9n52+47vXBUJKham10y5GFtrjCzq257QjiP1Z
         cJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38IvB5KypHDAuaY3YawsJEBcvuco56ouTYCrEb+HEU0=;
        b=H5wlOVxaMy/tacPLZ9C2ZdxExiw1CYP1sUBSgAZPddbWE3NbHw9fe1CokD/h6ydunV
         FShTfTbhPSCu+vKZOSZvt40tR8C5mpfKpm/p1y8h7nAqb0X/Kht7TkG6G6a/LeM1Mmv8
         9z3QUjHrlFgPJdcKhK5qv6CFRZfioZAk/EK89mB2gdV17vxaXWu3TkHzzrkgUGc7kbbo
         IdSOCyCO0idJikm3GX/06QRPR1jD7LdRhfuyxR3XKx1qBqaobD69kkgGQt6nV4BeZdue
         6+BV3BoSqkw2C1grO/S8CqC9LQOqteg0tUokrEt1G1MTsG382bI5OMT0EZ3lMFyKWoPe
         CfXA==
X-Gm-Message-State: APjAAAWe9IwECfSBpT2oyAXD5h8zdqYDiZfgJsmM3tkd1+QDEYepUOcG
        NZdYYgnXB9RxjEFPuUV3aac=
X-Google-Smtp-Source: APXvYqyoi0Y6qlEL1iMKqyin6FJjShBWPRtQHr7DHceYStTR3VArKTv7hCnMQqSJv7vqsXDyyqTB9g==
X-Received: by 2002:a17:90a:b394:: with SMTP id e20mr11269156pjr.76.1562932953693;
        Fri, 12 Jul 2019 05:02:33 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:478:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id a128sm4605496pfb.185.2019.07.12.05.02.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 05:02:33 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     urezki@gmail.com, rpenyaev@suse.de, peterz@infradead.org,
        guro@fb.com, rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 0/2] mm/vmalloc.c: improve readability and rewrite vmap_area
Date:   Fri, 12 Jul 2019 20:02:11 +0800
Message-Id: <20190712120213.2825-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:
* Base on next-20190711
* patch 1: From: Uladzislau Rezki (Sony) <urezki@gmail.com> (author)
  - https://lkml.org/lkml/2019/7/3/661
* patch 2: Modify the layout of struct vmap_area for readability

v2 -> v3:
* patch 1-4: Abandoned
* patch 5:
  - Eliminate "flags" (suggested by Uladzislau Rezki)
  - Base on https://lkml.org/lkml/2019/6/6/455
    and https://lkml.org/lkml/2019/7/3/661

v1 -> v2:
* patch 3: Rename __find_vmap_area to __search_va_in_busy_tree
           instead of __search_va_from_busy_tree.
* patch 5: Add motivation and necessary test data to the commit
           message.
* patch 5: Let va->flags use only some low bits of va_start
           instead of completely overwriting va_start.

The current implementation of struct vmap_area wasted space.

After applying this commit, sizeof(struct vmap_area) has been
reduced from 11 words to 8 words.

Pengfei Li (1):
  mm/vmalloc.c: Modify struct vmap_area to reduce its size

Uladzislau Rezki (Sony) (1):
  mm/vmalloc: do not keep unpurged areas in the busy tree

 include/linux/vmalloc.h | 40 ++++++++++++++++-----
 mm/vmalloc.c            | 79 ++++++++++++++++++++++++++++-------------
 2 files changed, 86 insertions(+), 33 deletions(-)

-- 
2.21.0

