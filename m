Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D5DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB7D207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qu+Kyycs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfFFMEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:04:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35165 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfFFMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:04:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so1767978ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VVA1sBKfaRg4LAK0uCbWUTy67eDK44ZySJJKqojIYWk=;
        b=qu+KyycsiKB5H0DVZc1zgw4MCI9LyalwWjcXI8qkPcLtMJjQiwz/0glLYdyI+MP7Hy
         y/nA4L6p2EgYW/fYGhiptMUltMUmA+1j3Ks/i5EGUbT8Zfy+aH8H0hnEchW80QQ0+WJA
         JEmhu6B/I7OEvcJxnR8DgpvWBKVeueyOy3whTiA6TzPpF1IIEm6+6QtqXqm+lDIey/I2
         3YnHLghk21E+RQ/tBlHnrvL5batshl5zttiKnNGZxZWrQA3x4r7l+eLRZVTxdBFspj6j
         gE4dEWg6hJ3+c5uS14T0b0CFUl5HYMRo/qayxwT2iUAYzqqpyIfIFR1w2NgtEq674dUs
         itEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VVA1sBKfaRg4LAK0uCbWUTy67eDK44ZySJJKqojIYWk=;
        b=Yon8oo/l/1YP1y/V7pJVI//Oacqnv02uTGKeI9o6HDanL16Xifa5VAfbPiXP85IZ2B
         LXPrNQFIgfJjRxCx6Ip5igbBo75rvmQ7HesKb3sbwpyYz1BBTPL4T+xQUKhdBHZH1v8p
         nWo5Qy8NypUVJMthuJc2phjbHbRlDu8ZWXJqfd/fjIEoliW621N0iY00duBiGchkbsYE
         KOaBHMvgayhZEWdyjBtr1tcx9DokJSVj17Z4Bp39gStiywL37l9Foy8smigav3Ma1Em/
         7H0jmjYFgPoLRHZL71dBwcNEkeYRzzFqWkScwdgk6Oi4G9IKdBvRoQKzYGA3+dfxtYqa
         plyQ==
X-Gm-Message-State: APjAAAUhbhQPx8mNvw5u5SKpBFnOHP6532QXoCRI4God9LmIwg162TLf
        HJe/qhrYHNJc031rb3DyZd4=
X-Google-Smtp-Source: APXvYqw5NsxmFarYoS87ELBeow1UTJ+6nrV64ACjRY5wOWzr1dHJz3NiqdcF6n9Dn1psQiM6BlTViA==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr123396ljh.167.1559822663131;
        Thu, 06 Jun 2019 05:04:23 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm309036lja.94.2019.06.06.05.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:04:21 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5 0/4] Some cleanups for the KVA/vmalloc
Date:   Thu,  6 Jun 2019 14:04:07 +0200
Message-Id: <20190606120411.8298-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4->v5:
    - base on next-20190606
    - embed preloading directly into alloc_vmap_area(). [2] patch
    - update the commit message of [2].
    - if RB_EMPTY_NODE(), generate warning and return; [4] patch

v3->v4:
    - Replace BUG_ON by WARN_ON() in [4];
    - Update the commit message of the [4].

v2->v3:
    - remove the odd comment from the [3];

v1->v2:
    - update the commit message. [2] patch;
    - fix typos in comments. [2] patch;
    - do the "preload" for NUMA awareness. [2] patch;

Uladzislau Rezki (Sony) (4):
  mm/vmalloc.c: remove "node" argument
  mm/vmalloc.c: preload a CPU with one object for split purpose
  mm/vmalloc.c: get rid of one single unlink_va() when merge
  mm/vmalloc.c: switch to WARN_ON() and move it under unlink_va()

 mm/vmalloc.c | 92 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 27 deletions(-)

-- 
2.11.0

