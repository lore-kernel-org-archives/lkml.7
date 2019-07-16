Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170ACC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E1920693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O85w6Uft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfGPN0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:26:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42424 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:26:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so9442830pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNuXYfJpH7xodxMP8TOSGp32e8S4xkphHFsCZYElfVY=;
        b=O85w6UftvzCE5S7QNcUPHTwRK89UOIVN5UwkFUBVkoJlgzFkrecIe1HCHZxp8XpTpc
         LUsUclB+E0i+ylxp3D4lng3UpJtIw1gZXPwBcCaJKcOivr+2o+5GI9PbWUU8w2l4ssaM
         Qtr9x++RI1Bqm8fFQo7D8JkNWH1KOLvF6koLHwDvY5GzS6HhmQNvb3lah7Oib81HpAUW
         H5STE9MUFYLpzD/VPToXLQZvmF8aqc9g44wgHJrkD0G6zhs92+jqI5ntp2oCI5TampeZ
         K+RZc+cL1r1vBvh6vYS5CrrUA77bkwWs9B5APzX0SBgrGjo3Rvd1OWxrYMsqirI00fIB
         Npbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNuXYfJpH7xodxMP8TOSGp32e8S4xkphHFsCZYElfVY=;
        b=b7aH31K8g3pTUop35jx7sAUqQrYfKwwjyNBYrz0zt7GdTSAs1cB5/rGt+zD4qydyJa
         UR33cobUiT818eQ4Q0yLMh1omOAfre6xLXZOOm+xpglnSHLdPuz4l35zZ+IZQBqjL2Z8
         gUDeUvNQcVt0RJoHHX8xdtrGh5lbrc635Pi4Pq76T6GYiZ3h6piwYdi+rWkcgoQcGWDX
         0tZdEdILoG6HfLtvpbDjzI1WBmlA4EcoJNnhghKclkgljl53Lhu4LFB198s/iT24nPmu
         8ID0g6obFz5ify75hNww2CWIcsOxBoVvBxdTT1KykfsbY0MOzO0v1x1prn1uW9POoiA5
         1yBw==
X-Gm-Message-State: APjAAAXTMKmqyKotntTv3CtHcf2XsoXo0HBJ8w1GzL4eS1vuYN/31GlC
        dOYbRnk6JHpTFUUfWxEiU2g=
X-Google-Smtp-Source: APXvYqxMR+qcGzM00MAIReSnrdIh/7uLycc7Pudrqz68yEXSZKY7d3bokAlFxAcJq29ZEfJxTtL3OA==
X-Received: by 2002:a63:6eca:: with SMTP id j193mr33082479pgc.74.1563283600675;
        Tue, 16 Jul 2019 06:26:40 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:bf0:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id q1sm21472311pfg.84.2019.07.16.06.26.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 06:26:39 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     urezki@gmail.com, rpenyaev@suse.de, peterz@infradead.org,
        guro@fb.com, rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v5 0/2] mm/vmalloc.c: improve readability and rewrite vmap_area
Date:   Tue, 16 Jul 2019 21:26:02 +0800
Message-Id: <20190716132604.28289-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 -> v5
* Base on next-20190716
* patch 1: From Uladzislau Rezki (Sony) <urezki@gmail.com> (author)
  - https://lkml.org/lkml/2019/7/16/276
* patch 2: Use v3

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
  mm/vmalloc: modify struct vmap_area to reduce its size

Uladzislau Rezki (Sony) (1):
  mm/vmalloc: do not keep unpurged areas in the busy tree

 include/linux/vmalloc.h | 20 +++++++----
 mm/vmalloc.c            | 76 +++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 29 deletions(-)

-- 
2.21.0

