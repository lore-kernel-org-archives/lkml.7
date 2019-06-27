Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A7C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB34120843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIFIdW8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfF0JpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:45:05 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:38633 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfF0JpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:45:05 -0400
Received: by mail-vs1-f74.google.com with SMTP id k10so503405vso.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G7q4MddQh2Qki7wvcHF8MIsvZAyVqJ4sXwbvqTqIetQ=;
        b=iIFIdW8AGFd89LJxBaWWybfiMjDFHCabZe9xHyImXhv671LcsmIa7K7Tofzu9sXAul
         J6bNWjuGkFUHeR2krrbECMJePceBifglobPRtKN/cXZJsjYIVeoD4lXItkrM38T76+jA
         zwtMOzMy1KNIRVR5YxIkdxpocBQ10jwq9Wn/CKqhoOYZRRfJkGiPsIFYeXjhzm/uJYXV
         v7C/Zsm4y+VwHU1CR/WXLCSAIDGnE3xn92f7bl+aU9itCoELLmmeSwEV1kyIXYznyYCW
         Bk4UVaxCl6s5guRQ60IGuUBkhWKMoPZaR4f9zT+72vZEk7nMWv0Mn4fEQk7pbXUE9u0f
         CRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G7q4MddQh2Qki7wvcHF8MIsvZAyVqJ4sXwbvqTqIetQ=;
        b=dfaqVjHHFZHLukr45PA/hHGfPwXJ05hyEdMoCATYLh/eWr2Tdxobip9qX82LurRsNn
         ctNQfaDT8wVMRB+mD4mDksJTL3MBTWwLBQ81aLnwJdFVnvn/SkGPBWavn/Wp03O3KUDp
         ndgA/Zy7csw8C5gQ+1ez//BawyDIevKdmGRMChgr3NZ1gJhDS1klRNzJkOjM5BqFcnHY
         NPqevdIXhzw+zdmUynHl1Nm2bJEevL//1rZU6+SoZUv9LeYOzJ6Y6YJ56+XCdcyU25Q/
         OICtO7uN3hU0GTrSkIjHXwW/znbJ+141KwKRU2+bYo3IKhGm89FFRlR8QP6hhw51mDM1
         0Nrg==
X-Gm-Message-State: APjAAAUpNScxp8Qgi2mw5I5WdWjCJKljY6C6gV92Ew1Mf8btKff17DOA
        0FCUAqk0D7E/M1jfZ2yuavLMRT91YA==
X-Google-Smtp-Source: APXvYqxzyiSxraxoQcgmvDUSkWBKWNaU3/TfGuQXyTBHlYvu2COk1tr4TQDRG849kXyhCzR4wstX8R617w==
X-Received: by 2002:a67:f795:: with SMTP id j21mr1954700vso.226.1561628703889;
 Thu, 27 Jun 2019 02:45:03 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:44:40 +0200
Message-Id: <20190627094445.216365-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 0/5] mm/kasan: Add object validation in ksize()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version only changes use of BUG_ON to WARN_ON_ONCE in
mm/slab_common.c.

Previous version:
http://lkml.kernel.org/r/20190626142014.141844-1-elver@google.com

Marco Elver (5):
  mm/kasan: Introduce __kasan_check_{read,write}
  mm/kasan: Change kasan_check_{read,write} to return boolean
  lib/test_kasan: Add test for double-kzfree detection
  mm/slab: Refactor common ksize KASAN logic into slab_common.c
  mm/kasan: Add object validation in ksize()

 include/linux/kasan-checks.h | 47 ++++++++++++++++++++++++++++++------
 include/linux/kasan.h        |  7 ++++--
 include/linux/slab.h         |  1 +
 lib/test_kasan.c             | 17 +++++++++++++
 mm/kasan/common.c            | 14 +++++------
 mm/kasan/generic.c           | 13 +++++-----
 mm/kasan/kasan.h             | 10 +++++++-
 mm/kasan/tags.c              | 12 +++++----
 mm/slab.c                    | 28 +++++----------------
 mm/slab_common.c             | 46 +++++++++++++++++++++++++++++++++++
 mm/slob.c                    |  4 +--
 mm/slub.c                    | 14 ++---------
 12 files changed, 148 insertions(+), 65 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

