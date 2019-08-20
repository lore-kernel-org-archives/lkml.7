Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF491C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE6422CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpB2kY8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfHTC7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:59:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40497 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfHTC7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:59:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so2413342pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xkr4IFk7JE8tZJ5lH5GPaHBkXeIGAFFTk63OiHmuliw=;
        b=LpB2kY8BgQK2hpTo0dJctfeVuA/CaP6yYvy8cfnj76Y9sDqI2ujKQhZSHFyNdKgaOs
         En+s/YIUmXOpUpSzJTHQ7L9BYKYm1ICz6+j5v7Yn0Sdogcfa6s4eOsu2dqZSyHi45U8/
         a2RqmxLh5nbeXuobqflCMc6jX2UZmlpRQSfEPkWYz1bxdpL+Vd9n1i+SWJmDrOfA2hEI
         YnBsyt0rW54mhn5WbD/lZVZ0XdHuH6p0TlbXosYL++PdLoHrkBIqIbwb8GEbE//u4zKw
         ZXuaOuvuhOqOD1yY2v9vrc8tZRW5SzcTdfGKrwhu8JYFRYVhYS54t9e6NnjDlB0kPyw2
         4qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xkr4IFk7JE8tZJ5lH5GPaHBkXeIGAFFTk63OiHmuliw=;
        b=pSNqiCHo9LeFINFgt8Y5349hGcVn1I5QMovPJwJCiov5uaCalZUl48+g7JW1lx7wpj
         olzCpnxdzsun8j3xC3YGEUWjKBil87aWY1enZwMfWGHc12ELHrSxWsVrhZl6+8C8IgPY
         pbR+99xWiVjt9fUZ3puoI8NhRy7vQac30lRsE3yzQlmRJ1clJN73++irYPUgk3wf6cUd
         pj57i+Aw0hdkpY0USWN36ts48bsFanoK3pj4tMlNDIpuPYtNPM26ErP2TGd2YggACOVE
         c584TizGfnV+Qf1VxN4uIRq6mZbbMJiyM+w8qFN8GfpWxlFj6Z4swHPSdIyon0sGPrYS
         9F3g==
X-Gm-Message-State: APjAAAXs+psj7jNUXrRyiwUW95YiCxPQawPDDk9Qt3DGggfJ7NDMKyOP
        AtVQrQ4LsyAQhjOLD+n3cPU=
X-Google-Smtp-Source: APXvYqzoJkr8vPoB1+xNhD+aD7juFSbD1YaXoFMDG5Df9hXhPBM+Xp+F+o2wbpAawUabV7nmevHZzQ==
X-Received: by 2002:a62:38d7:: with SMTP id f206mr27847336pfa.102.1566269983701;
        Mon, 19 Aug 2019 19:59:43 -0700 (PDT)
Received: from localhost ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id a10sm21744430pfl.159.2019.08.19.19.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:59:42 -0700 (PDT)
Date:   Tue, 20 Aug 2019 11:59:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Henry Burns <henryburns@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        HenryBurns <henrywolfeburns@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] mm/zsmalloc.c: Fix race condition in
 zs_destroy_pool
Message-ID: <20190820025939.GD500@jagdpanzerIV>
References: <20190809181751.219326-1-henryburns@google.com>
 <20190809181751.219326-2-henryburns@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809181751.219326-2-henryburns@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/09/19 11:17), Henry Burns wrote:
> In zs_destroy_pool() we call flush_work(&pool->free_work). However, we
> have no guarantee that migration isn't happening in the background
> at that time.
> 
> Since migration can't directly free pages, it relies on free_work
> being scheduled to free the pages.  But there's nothing preventing an
> in-progress migrate from queuing the work *after*
> zs_unregister_migration() has called flush_work().  Which would mean
> pages still pointing at the inode when we free it.
> 
> Since we know at destroy time all objects should be free, no new
> migrations can come in (since zs_page_isolate() fails for fully-free
> zspages).  This means it is sufficient to track a "# isolated zspages"
> count by class, and have the destroy logic ensure all such pages have
> drained before proceeding.  Keeping that state under the class
> spinlock keeps the logic straightforward.
> 
> Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

+ Andrew

	-ss
