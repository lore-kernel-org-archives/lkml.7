Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD22C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410A92070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IXcfai26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfHEDo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:44:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41506 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHEDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:44:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so28614209pgg.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qaevOKKBkx9wzczWsPhokAptJGi+7DJxhR9knuVBhIc=;
        b=IXcfai26P/X8GzjqUOtmAH/Jo83R/2UjSztaety4x290UiwGJr62Nqbed+2gcSQnQq
         dqrgQtS9ocweR9XW2Mm9pHhrHFFRMBaxYLcm1pzOCTxIROUS9hvQ0qWmtamBqxPLZnOT
         EhjWLNHhSgeW0KfvyTB5RDtd5Dx9aJd7gcu2qMZsycPbBk5FRPwlnfzs1JqQpV41O2NT
         TPWPxUu0Sy5kUJDKrSn5SMTtpXqbO/vsBlmx8w9Dg1h8usHVPrStDNgIQeda0jezkGNQ
         kPsX+LoS4FBe/97ALO78rYF45eRlRbbdHtywIrV0PhhVjh1e7t5mswweENmRPEKXbsYl
         gxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaevOKKBkx9wzczWsPhokAptJGi+7DJxhR9knuVBhIc=;
        b=RC+4KjkDwdIcCBYMXWBg9ap+GtrpAyzKdp7hPJjVtutybauoDmr8DLuD9Ptjb897uI
         z2eCuwmotYkWtw13c5Lt8xkty33pzkvjLomvluZFwTQzzpph/1KEmZXnJUrLumUenEVJ
         JyYDH3IatfOGYb2IQ9FRnLvDH9aPkg9aAnS5oXOG4fupyl77IEf+CYLGNWlPUU8tzoPI
         iwvXxTUCIzvNXHWBb1Zed9wTxmNEYCmcEtXjYp50C2ZSQ7N/tcUvQLTWRsqZg28VELm8
         dfPa3GayTQsHYcqvXDyq3WUwysC3B131srQGlC3w6ZUG3CPvQAVPHqlBzfb9Zk3/Ze9I
         8sYA==
X-Gm-Message-State: APjAAAXwLqHYr+5EKpZrv/VuJnjsu66SMUgokYgKg/d2tQouv2nUY1VK
        e00yZwH2sX3DXuJi+sKW6e4=
X-Google-Smtp-Source: APXvYqy4lnuT+Nq4f5lxPk3nmqptozGkTW1Nn0qcFMewuAbFZKOxXjof5Tv5YsVkUmYJ47dOKqH08g==
X-Received: by 2002:a17:90a:376f:: with SMTP id u102mr16333110pjb.5.1564976665920;
        Sun, 04 Aug 2019 20:44:25 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:61e6:1197:7c18:827e? ([2605:e000:100e:83a1:61e6:1197:7c18:827e])
        by smtp.gmail.com with ESMTPSA id t8sm13977229pji.24.2019.08.04.20.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 20:44:25 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: convert put_page() to put_user_page*()
To:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
References: <20190805023206.8831-1-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0b9303-fce0-e7a8-a27d-af8e3903f097@kernel.dk>
Date:   Sun, 4 Aug 2019 20:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805023206.8831-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/19 7:32 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").

Applied for 5.4, thanks.

-- 
Jens Axboe

