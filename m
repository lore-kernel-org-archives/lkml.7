Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C8C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B2525D4B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JrzH8Ix8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfE3Eup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:50:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37957 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbfE3Eu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:50:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so2422909pfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 21:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VEMJ0wAN6f0L2PBPwqBlNkJT86VV7w23G1COjLoFnLQ=;
        b=JrzH8Ix8SoZsVncsTmXV8fH3M7JjbmYl33YE8gDnA7QgHftaChETKuHHntJCjE3/aL
         FnJgOjKcGVkR+iwR5G7lFO/RxCTdU77nQkBLTFHgAteGpbTIlewLGFncxGgQOeV/xOlK
         8Qnfzv6hiXk3kB7WNns7hXrGTBCvcj64Pcb18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VEMJ0wAN6f0L2PBPwqBlNkJT86VV7w23G1COjLoFnLQ=;
        b=A26nR6lgHGCuDQlagPGJC8s293fabt60kIEO1wVFXt2ifFudjOUcaQUZoyQZK9COIQ
         IF9fDTdtiFuL5jqZhDzIvXrqdZDhuoxXd1Ud6Yd2lYzGRZT7vrtr4ctaRLZFVlCMGeIz
         nSbvFONdosJOHb/9M8kivFTYifXnLbXckT6xiF/+SQZLM/O7OdL3ZNMUJznSo8lNHh8o
         2qapEpE9+dQndOzdiTHwKaNuxA20EyKhuH/0G1/+N5PjYeB7sLuoA8u5B4+93zTBb+2v
         8hInriB79Qbbi0uAXKSzQESYDEIuCAs1Gj+4cQLrVW4MfCq7Q4fF07wS/IjQe5MospBJ
         kGDw==
X-Gm-Message-State: APjAAAWHg1C5lje+l8xqvseJehwBm0IfbR7akVGY3ACAELWKNoMtkIik
        HfYZDaqCcse2lq8wDRC6bM6/Rw==
X-Google-Smtp-Source: APXvYqzXBek/OrXF+N6Pci+DQWdzVuUKcdPizytLviTusXIyCypNjwhwjiK8ABKt8GhYJWDAKq7/oA==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr2006961pgp.56.1559191825754;
        Wed, 29 May 2019 21:50:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm1331586pfh.13.2019.05.29.21.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 21:50:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3] mm/slab: Improved sanity checking
Date:   Wed, 29 May 2019 21:50:14 -0700
Message-Id: <20190530045017.15252-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds defenses against slab cache confusion (as seen in real-world
exploits[1]) and gracefully handles type confusions when trying to look
up slab caches from an arbitrary page. (Also is patch 3: new LKDTM tests
for these defenses as well as for the existing double-free detection. To
avoid possible merge conflicts, I'd prefer patch 3 went via drivers/misc,
which I will send to Greg separately, but I've included it here to help
illustrate the issues.)

-Kees

[1] https://github.com/ThomasKing2014/slides/raw/master/Building%20universal%20Android%20rooting%20with%20a%20type%20confusion%20vulnerability.pdf

Kees Cook (3):
  mm/slab: Validate cache membership under freelist hardening
  mm/slab: Sanity-check page type when looking up cache
  lkdtm/heap: Add tests for freelist hardening

 drivers/misc/lkdtm/core.c  |  5 +++
 drivers/misc/lkdtm/heap.c  | 72 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h |  5 +++
 mm/slab.c                  | 14 ++++----
 mm/slab.h                  | 29 +++++++++------
 5 files changed, 107 insertions(+), 18 deletions(-)

-- 
2.17.1

