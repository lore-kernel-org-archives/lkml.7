Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A602081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GXLavN/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfEVWSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:18:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42054 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfEVWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:18:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id e17so1859091pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Jd0RSCXoP1EdL1cjt/xgeuNaQX2V7Ph/JBkgB7uNH0g=;
        b=GXLavN/7grE6LNJqyGhvPPesKBk185WFjgJna7ETOIJBaq1hY/O3DZYH9mqYTRPG6J
         GdFKCMBa8+OJJ7SXTg/NgAmRQpnKKVfSSiZLmo2keKmw0ot67menzPS8qFUMaPrsgUDO
         GNub7HFs2rNTz94sRTH62HK1i3T4MLXdmoCYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jd0RSCXoP1EdL1cjt/xgeuNaQX2V7Ph/JBkgB7uNH0g=;
        b=etYOGF3PZX2lZZ7m1//Usl8rE+9POhSF7fERskw9NccNX+FbPFvhQFYcBerKUFmzAU
         hU6T2v9O70OFOtCwR3IeeYzNy4TYFGdhOyblHC8ClUJKSUy6SbYkJWq70fsdI1HaUJGD
         1rGr3QMvLHADcvgenRShG5mPm8muFp0iHsu/HBwOUDuNapPfXjrzCStUX085gFiGdRIv
         sZhZAHb8Bmvq2J7GwMSzpgTsy8IwnRqJNzMLYDjPgUbnhylQUpKAI9GXn7fphz3R/NvC
         Up3V3tRDlm3jeBjxhQZFCpo5ydeZSJXi/9lTE4VHazzEZnl2PMaiPS+ZGxQoSxWYgLcX
         upcQ==
X-Gm-Message-State: APjAAAUw2X9LvDhbCaIaQnWcANcPuyv/W/9KNLynlzNTey8Y9/h7t/rY
        pf155NQtPkhNkibBIT9cMUFfyQ==
X-Google-Smtp-Source: APXvYqwYkSpq4sI0OwVnuYJtsng97b6lnFAf2peUNKoiZTQR4ze4ezgmfpK+1cl50ZPOllSPkVklsg==
X-Received: by 2002:a63:6f0b:: with SMTP id k11mr92068194pgc.342.1558563487623;
        Wed, 22 May 2019 15:18:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::e733])
        by smtp.gmail.com with ESMTPSA id l7sm28232045pfl.9.2019.05.22.15.18.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 15:18:06 -0700 (PDT)
Date:   Wed, 22 May 2019 18:18:05 -0400
From:   Chris Down <chris@chrisdown.name>
To:     deepa.kernel@gmail.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de, axboe@kernel.dk,
        dave@stgolabs.net, dbueso@suse.de, e@80x24.org, jbaron@akamai.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        omar.kilani@gmail.com, stable@vger.kernel.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org
Subject: Re: [PATCH v2] signal: Adjust error codes according to
 restore_user_sigmask()
Message-ID: <20190522221805.GA30062@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190522032144.10995-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: linux-mm, since this broke mmots tree and has been applied there

This patch is missing a definition for signal_detected in io_cqring_wait, which 
breaks the build.

diff --git fs/io_uring.c fs/io_uring.c
index b785c8d7efc4..b34311675d2d 100644
--- fs/io_uring.c
+++ fs/io_uring.c
@@ -2182,7 +2182,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 {
        struct io_cq_ring *ring = ctx->cq_ring;
        sigset_t ksigmask, sigsaved;
-       int ret;
+       int ret, signal_detected;
 
        if (io_cqring_events(ring) >= min_events)
                return 0;
