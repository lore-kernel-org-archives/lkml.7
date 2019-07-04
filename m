Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C23C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9813D21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXnIoQC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfGDNbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:31:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46781 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGDNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:31:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so1527754plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7rWNTi1E7hTeWQY3QnrdEdcklqFz+mTRT0ti6i3yOE=;
        b=sXnIoQC+a7Tp+ha4YF6+8hVuxOYjc/an3avVApFlkpwWWfbXtZgkdZ6lUnMCqAyxza
         JtWvhS5buGGMbRS5wPpm0u/kBRoCElF6LHAqyef3Qd2o+EpxepLOU8zQF3S4DkC7Wz0o
         I1k1xme567aV15OHMlTzldlKgejxfdjqkqFhz6Mt5UlBXGMIU2CEiq94i3rw3VPMikuU
         pgDlIJswlcJ0Pwpoz1RlVhN28GHwlUq0L3zu6aQpcNET8QspamP3MKPK6jH8F1bSLJnp
         16CTZE0WYpHjyF4EYVZZ8D6AnONWtWRnfwfWa44SUA2Whg3FpI5Xd23f/QxEZ7EauQCC
         F/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7rWNTi1E7hTeWQY3QnrdEdcklqFz+mTRT0ti6i3yOE=;
        b=NYPNWQvJXwkhNk2k9jQc+TWDKWANj+4loFVLxKfdPpTs/Y9rozLniiNgDHtKlO+Tpr
         uCjahW+27ZD9xyMv1rws3d+m9G9ZFOfZFd08yuDB/bF8Mj9r8j+jfuijqfNpRSmYBryD
         OsgWxPHJMjaZPfNTjoqTDvV+mYB4W4mpUmsf+ZfO1GJt7fjOge1e2dj/6O5Rxpf89JHa
         t8qYIPHEMfRj6OkTzigV7xDZzUsImQAjS9N4RN5P8mCDI+N9d7lkn1JvNeYwEWNWg/52
         T0Vv77Go8nRLhgHB8PkCrGwG2rvVStzpW5hUa538RwFL4VYqsNyrRfMemy5cZndkHOxg
         naNg==
X-Gm-Message-State: APjAAAXZyZiVeK798d/UhOklAEUFBtZa1WhMKAiNFx4w+xkugIjc2ovC
        x6PU0i2KvAXuSngZaaJlhtM=
X-Google-Smtp-Source: APXvYqwqYSyuN2HHjZcixXdS2u2w049iaOAV3EmisamSxAwJucP6UsEqXY/v1VVYeIkmhogul62i8g==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3mr49317115plt.248.1562247059375;
        Thu, 04 Jul 2019 06:30:59 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id h26sm12517367pfq.64.2019.07.04.06.30.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 06:30:58 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v3 0/1] mm/vmalloc.c: improve readability and rewrite vmap_area
Date:   Thu,  4 Jul 2019 21:30:39 +0800
Message-Id: <20190704133040.5623-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
* patch 1-4: Abandoned
* patch 5:
  - Eliminate "flags" (suggested by Uladzislau Rezki)
  - Based on https://lkml.org/lkml/2019/6/6/455
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
  Modify struct vmap_area to reduce its size

 include/linux/vmalloc.h | 20 +++++++++++++-------
 mm/vmalloc.c            | 24 ++++++++++--------------
 2 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.21.0

