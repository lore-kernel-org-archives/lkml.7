Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B054C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B62218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZF7KZ3a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfC2UyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:54:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36564 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfC2UyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:54:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16so3178433edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMyiaAUrglPJr9Arc64c88/PB/gC/yTx+LGIxuZdRXY=;
        b=ZF7KZ3a+wPMB83dx9ZvTO+sXidYeP5+yuTKINB6muqpk7lnqhs9w38kcky4DMdkcto
         J/HfjJXk0+vXVzXI/JHMa1xxR6YUhFGdDiM8Nwr9gOjt2cCIvmJx7DVz5cgDO5PJ2T09
         129pQq7rpMcF/y3p8Y3Ige/pjiuxRsWonFsYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMyiaAUrglPJr9Arc64c88/PB/gC/yTx+LGIxuZdRXY=;
        b=NJofmGLVxMm7Bv7bOGeMK9OxnnLUdBwtMot5yelp8AsEhJQB9mP089KEGeshc4Pinz
         i4iLeKGHddSl8876N2EQf/lGEfE/uyfw6Aaq8GC57HxD2UQk2QUoPzmCBeAdj2u8rU1j
         8+I89X05ov9ESuwsBKG091uuSXzXToWZa3a3UKX97UpFeFHrad+IjnOWaJ7P9pCKutSz
         0FMNx48obK55nqHUlmO3iyFihqYbIjboWboU7WqZVAvpmn6PEd555ePytnQmXd3Okqpt
         4Dw3Du//9kvB27+kZ76nVEDAAVTrWnN3jQ86f1M+0+3uFnlDRNeD6XEb62QMbBzSPR49
         DdqA==
X-Gm-Message-State: APjAAAUBP1dPXDyA247k2uuEzJkwA92Ni1vkHQt4et1bYejYRtpZ0hJ+
        DrogL4jmVxAt1uSmQlG5J977bQ==
X-Google-Smtp-Source: APXvYqzQFn76lVf0VZ/muJtUBdRTbteadVVuub5KckkfjbaAtgkcyqmuAQVW3/VjOhOiKOGBBIpVgw==
X-Received: by 2002:a50:e70a:: with SMTP id a10mr33771038edn.70.1553892839303;
        Fri, 29 Mar 2019 13:53:59 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id 35sm902636edh.43.2019.03.29.13.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 13:53:58 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by CONFIG_NUMA
Date:   Fri, 29 Mar 2019 21:53:51 +0100
Message-Id: <20190329205353.6010-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329205353.6010-1-linux@rasmusvillemoes.dk>
References: <20190329205353.6010-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitmap_remap, _bitremap, _onto and _fold functions are only used,
via their node_ wrappers, in mm/mempolicy.c, which is only built for
CONFIG_NUMA. The helper bitmap_ord_to_pos used by these functions is
global, but its only external caller is node_random() in lib/nodemask.c,
which is also guarded by CONFIG_NUMA.

For !CONFIG_NUMA:

add/remove: 0/6 grow/shrink: 0/0 up/down: 0/-621 (-621)
Function                                     old     new   delta
bitmap_pos_to_ord                             20       -     -20
bitmap_ord_to_pos                             70       -     -70
bitmap_bitremap                               81       -     -81
bitmap_fold                                  113       -    -113
bitmap_onto                                  123       -    -123
bitmap_remap                                 214       -    -214
Total: Before=4776, After=4155, chg -13.00%

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 66421f304f7d..3f3b8051f342 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -649,6 +649,7 @@ int bitmap_parselist_user(const char __user *ubuf,
 EXPORT_SYMBOL(bitmap_parselist_user);
 
 
+#ifdef CONFIG_NUMA
 /**
  * bitmap_pos_to_ord - find ordinal of set bit at given position in bitmap
  *	@buf: pointer to a bitmap
@@ -952,6 +953,7 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 	for_each_set_bit(oldbit, orig, nbits)
 		set_bit(oldbit % sz, dst);
 }
+#endif /* CONFIG_NUMA */
 
 /*
  * Common code for bitmap_*_region() routines.
-- 
2.20.1

