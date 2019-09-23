Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36172C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16B21783
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwi8Rwhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439489AbfIWM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:27:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38074 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439375AbfIWM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:27:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id w10so6461152plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=auNuXMeMyMe+nvucDBj+uIoi22EYZzDpjbiwmbcP0hY=;
        b=Dwi8Rwhpumd5m1szOxbaiwVHT5innrszEicWzrrUjwjiwKU9vH8idiORVVxfc3YaBF
         MmN6wUtjKZRzAPiGc5ccWNEHYjxjBfZeFx/u1KXE2OBnvqvLR+iplp9IwpJtNZGnZcVk
         FU0zEgJkE+dWYPwzRyQuxNV/PLJFq0gyOkzhRxIJHmz5IxYaiZ3lg3gPETxYrjN1D09f
         +NjCxIQJ1p0GxAfnpt1TWgLUa9OG3CJDuvvFHpYv+cufV+rXJ6aw4UNxeyPU7vbjojlk
         uoc2VakbM/0u28AYPAw8U0FizeD1Le14QM5P5vJ3UyHjM1kIFu9UdZSN8rvgRwNe/Q2C
         Aq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=auNuXMeMyMe+nvucDBj+uIoi22EYZzDpjbiwmbcP0hY=;
        b=hn64gjMKcpWPlP56KTt50Az8I4i6piVAr1qQR7nDyDhn0oyWGOv4/uv6aW9brzsikA
         bxDYcSjhclKISyr85nLqFjwmjm+pJHvWQj1BkyXilp3zfIbEbwrEPUvxIea9GYM5z7Zy
         +7g/rlDoVav+jYgJHfEpqm9M9rawBQeqiALwQS+Qk29u8bRQddaONhU4HIg5I1avmo2V
         +yYbtcSU8601qGR4uo8BwKR+B31vSaYP5McGjZzLCqJ6pv2/o6g7mnq7SNFI7dS9dah6
         Grh6m9/EhsBS16GT76DhOqeon4qa5peCU6mmq4LBAS99NSV+H9yvm/tDTB/6h0hbQ73h
         xDtg==
X-Gm-Message-State: APjAAAWkLAO/d5cWrmLS8PvxchYrbAFiF3M+cXz5iAI87og8ZNDg0A0t
        WGd1NBtur+TSPgSCrkTRuvI=
X-Google-Smtp-Source: APXvYqx292SWALRo+kG8973EYAzY7HhL1QO4p/t7Sznp4vgFroRNUkc3Vk/6TcRGXm/I4os3PGwoKQ==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr31550908plk.176.1569241664061;
        Mon, 23 Sep 2019 05:27:44 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 202sm9692016pfu.161.2019.09.23.05.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 05:27:43 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v6 0/3] mm, slab: Make kmalloc_info[] contain all types of names
Date:   Mon, 23 Sep 2019 20:27:25 +0800
Message-Id: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6
--
1. abandon patch 4-7 (Because there is not enough reason to explain
that they are beneficial)

Changes in v5
--
1. patch 1/7:
    - rename SET_KMALLOC_SIZE to INIT_KMALLOC_INFO
2. patch 5/7:
    - fix build errors (Reported-by: kbuild test robot)
    - make all_kmalloc_info[] static (Reported-by: kbuild test robot)
3. patch 6/7:
    - for robustness, determine kmalloc_cache is !NULL in
      new_kmalloc_cache()
4. add ack tag from David Rientjes

Changes in v4
--
1. [old] abandon patch 4/4
2. [new] patch 4/7:
    - return ZERO_SIZE_ALLOC instead 0 for zero sized requests
3. [new] patch 5/7:
    - reorder kmalloc_info[], kmalloc_caches[] (in order of size)
    - hard to split, so slightly larger
4. [new] patch 6/7:
    - initialize kmalloc_cache[] with the same size but different
      types
5. [new] patch 7/7:
    - modify kmalloc_caches[type][idx] to kmalloc_caches[idx][type]

Patch 4-7 are newly added, more information can be obtained from
commit messages.

Changes in v3
--
1. restore __initconst (patch 1/4)
2. rename patch 3/4
3. add more clarification for patch 4/4
4. add ack tag from Roman Gushchin

Changes in v2
--
1. remove __initconst (patch 1/5)
2. squash patch 2/5
3. add ack tag from Vlastimil Babka


There are three types of kmalloc, KMALLOC_NORMAL, KMALLOC_RECLAIM
and KMALLOC_DMA.

The name of KMALLOC_NORMAL is contained in kmalloc_info[].name,
but the names of KMALLOC_RECLAIM and KMALLOC_DMA are dynamically
generated by kmalloc_cache_name().

Patch1 predefines the names of all types of kmalloc to save
the time spent dynamically generating names.

These changes make sense, and the time spent by new_kmalloc_cache()
has been reduced by approximately 36.3%.

                         Time spent by new_kmalloc_cache()
                                  (CPU cycles)
5.3-rc7                              66264
5.3-rc7+patch                        42188

Pengfei Li (3):
  mm, slab: Make kmalloc_info[] contain all types of names
  mm, slab: Remove unused kmalloc_size()
  mm, slab_common: Use enum kmalloc_cache_type to iterate over kmalloc
    caches

 include/linux/slab.h | 20 -----------
 mm/slab.c            |  7 ++--
 mm/slab.h            |  2 +-
 mm/slab_common.c     | 99 ++++++++++++++++++++++++++++------------------------
 4 files changed, 58 insertions(+), 70 deletions(-)

-- 
2.7.4

