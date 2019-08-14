Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5131BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265C1216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SElBQSnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfHNUUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:20:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43311 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfHNUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:20:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id h13so338762edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YdsxBm4SorcCs6LR7QkyWK07j5ac679kdHnkcCO8NA=;
        b=SElBQSnY/MEpHH8627z9LUJO0AwXfwMVSdTTj8+/meirzqVOVaUQig461Ql4grU9BW
         AVOrqu2gy8FVObWFxEJFZZI9KGDQ9zAPfmV41ZLckaSp17XA9+mEmzFQIBhzh/7c6swP
         BOywaRmA/1lgbIGeuvAe+e1TOiq/MWLuxLS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YdsxBm4SorcCs6LR7QkyWK07j5ac679kdHnkcCO8NA=;
        b=j27NSoZURBpqc+tLSH6VJmAGrDX0ykq9Hide4PkBdE2a+f9pmDVGKKgQ+90n0Q7N2n
         BuT/DjgjCIM1fsF+p2QJgC3cRBqRRxPTIbZ4+xGXwYExK6iJaHhzyAQxMljEkULTDrqv
         K3RsR4Owkz9oiCkQCKsdnbdgHAuodG8yECtT9IuHSMF5cP6/Tu6k0QLigK8GhFamDv0a
         EK97LaEJAEdK3LpwYInXLTu6Gr14285cOw3+z1Vc4SnrDpeYU8pSyDMnva+uF1J8j46s
         JfkC/Hxp3dgHODe3pvnPl9D2MCmXY6nRYUS5Qr/xcVZ/HHlYjPKXxJGvT59KpT6eu49v
         Ft0A==
X-Gm-Message-State: APjAAAUVauD7gGpM+JCSjbmYTGZgWIp6cWLbbjaij99o38vogiDFbHZW
        r5KS177Iyt2GPIW1Y3FgGBieGbMzlO4mKQ==
X-Google-Smtp-Source: APXvYqyP95CvDgYSo4eGFz7IoA7gCAiTTQNCbZZ85IgUxdxzhynRxhcbBwMwFB/O5KsYTtdIbvM0uQ==
X-Received: by 2002:aa7:d285:: with SMTP id w5mr1658562edq.134.1565814040425;
        Wed, 14 Aug 2019 13:20:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ns22sm84342ejb.9.2019.08.14.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:20:39 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 5/5] mm/hmm: WARN on illegal ->sync_cpu_device_pagetables errors
Date:   Wed, 14 Aug 2019 22:20:27 +0200
Message-Id: <20190814202027.18735-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the warning in the mmu notifer, warning if an hmm mirror
callback gets it's blocking vs. nonblocking handling wrong, or if it
fails with anything else than -EAGAIN.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/hmm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index 16b6731a34db..52ac59384268 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -205,6 +205,9 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			ret = -EAGAIN;
 			break;
 		}
+		WARN(ret, "%pS callback failed with %d in %sblockable context\n",
+		     mirror->ops->sync_cpu_device_pagetables, ret,
+		     update.blockable ? "" : "non-");
 	}
 	up_read(&hmm->mirrors_sem);
 
-- 
2.22.0

