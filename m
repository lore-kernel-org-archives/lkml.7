Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EEC76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8535920880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+SG913I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfGPDdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:33:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39917 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbfGPDdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:33:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so9351272pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 20:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xC/c1W4LGyKMoN2FeMmzo9Wrzexm3+voeGFpDLnQsAA=;
        b=G+SG913ItNx85eheFC9l6D9a8JAJFEd9OAgJ+iMmqgxUuV8S7Pb1LUYFJAp7egAK+7
         7VhAAwde+MzMaZvibd4/K+WcWAxijwQlm+YNOY44p8xwtlbmn3+iGIQeDlCrnAVqgRgY
         smNSBRcEg01w6o+8jxYbNW9jrWZu/sQ8CHoEe7Wvs38bFrnKezrDDiSCOvKNHbIE2wQE
         jkqVQwi0Luc6NRVHqH0AzQiUANsYzb2vcdwnl6GJA9o2dwv9o/1aND7dZpW5BoJM+Ndh
         GkWOLKBkzI8LscEwn77cNn5yCE+wfQcSEztvIC0Zxjqi3TvrBGINJg7xOBtekW/SkK0E
         agPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xC/c1W4LGyKMoN2FeMmzo9Wrzexm3+voeGFpDLnQsAA=;
        b=DNNhMJdEIr18cSldFMmdBWQzxgvayG1P07OtQzuhCSS8QxZ07i5qi7K4uNukGDKIc6
         aGgt85zQtHY9LJejfS4SGYFSDa6YXgphKSsDUpfFms5esJdmExuWGheogJLYog3LjGKe
         6Gj3nDI/IlZk49TTNhjJ1S7EYoZ/30wJtt7iIu9OJAFKPLqBt8zOu/5mweMz3TZ8lXoj
         shGZtUh47fKVN311Mu4UGucEMCgNNhTx1a3Aoo7J3NbqShNJ4MWkNIfu6ld8i656/JhJ
         wl/MXLPMXrkzusx6r3eLIclNm9LdYHPtD6E55ZsByVa/q2IdsovCY95CyzisISQRd8e0
         TDBA==
X-Gm-Message-State: APjAAAWuK7VTTMqeSuUitjPmAjxV8V/v+VlOv/7UpmXuSUSrXPvJnjlD
        48UkorkkDX68aR3ivQn6tqRGR9rizo80Pw==
X-Google-Smtp-Source: APXvYqx+vPghW7WnZShhf6Pl+o8TudLFE3Yrm6YYrO72n9jXNkMQ0EEOOjPt5dw4crlSt03OsbBLUQ==
X-Received: by 2002:a17:902:4501:: with SMTP id m1mr32570267pld.111.1563248025728;
        Mon, 15 Jul 2019 20:33:45 -0700 (PDT)
Received: from ubuntu ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id f12sm17311065pgo.85.2019.07.15.20.33.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 20:33:45 -0700 (PDT)
Date:   Mon, 15 Jul 2019 20:33:42 -0700
From:   JingYi Hou <houjingyi647@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: fix double fetch in sched_copy_attr()
Message-ID: <20190716033342.GA32294@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sched_copy_attr(), attr->size was fetched twice in get_user()
and copy_from_user().

If change it between two fetches may cause security problems
or unexpected behaivor.

We can apply the same pattern used in perf_copy_attr(). That
is, use value fetched first time to overwrite it after second fetch.

Signed-off-by: JingYi Hou <houjingyi647@gmail.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..60088b907ef4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4945,6 +4945,8 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	ret = copy_from_user(attr, uattr, size);
 	if (ret)
 		return -EFAULT;
+
+	attr->size = size;

 	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
 	    size < SCHED_ATTR_SIZE_VER1)
--
2.20.1

