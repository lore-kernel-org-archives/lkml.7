Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EDA20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="02IXqmiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHLUid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:38:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38729 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:38:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so9705604plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OvGyvW5Iklte0Ea4752AqZSzCvI47sv01KixS4E1a7s=;
        b=02IXqmiPZReQAgyCJd5XNSGkstTKxtHUCQnsagaaTI/Nh5YcPVKftq4hsoImftWUiy
         UNSJu/7l6MF1Uxfqn0NJMq7zLVQWoWjNBYVt6UcKgPMAj4J3vLYX67YbINJzY8O3BvxS
         t59P7WwHqAVA9qyEwtZTq4zBCZwRtvgHdH/2NeLIfUbRhknUrJmreVlGM4iBrRFbGyKa
         FB0S3uNTBf3hEp40WFwr6mnjtWn8CazvUeaTEtQaPHox5O79Zq5gAYLY2pnV99UNu5fX
         Idy85JpYma2zzK/JF1tyDIb57JjheW480EHyTesQUyYt/1+5SNmYiKuQxPLzDnLN41NU
         /AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OvGyvW5Iklte0Ea4752AqZSzCvI47sv01KixS4E1a7s=;
        b=FlFlahTFzQkumcgNEBb6SPYq0Q4VK2QdqtT6p4K0tAOUYMQbbGZzkocpD+c/mQuVmO
         V13y/TlaCUF4f38Wst5gcBxGfhcV6Yf/onyqvvt2ewrmkyFiPrrmD7XMplJ79n3uZp5l
         Tq3kwxtV9lBGNB5zrKiW8r4rv/kGw7WRvqy9fS+nXipJqD0AVBHKEPX+UcJFVsdPA94G
         B4rWQG3rVcK5fEYULXzGJ7SUyi/1tuKLKuQvnR41HKhTCjQ6/jEkudNUUwYE5pck+B4m
         zerA/0neqwARZ81c/1ko4otCiMOlGYyjipxWxgN5y8y0Cp0NtE/TrU7vC9XyVLSJiFJA
         q3sQ==
X-Gm-Message-State: APjAAAVHca9B6Ccr0aWvBKGPmRCjk/6qPjnOH+6VZmSqID0nwJ7FXE2Y
        rocJBf30TIkm+UtraRaXNX32Xg==
X-Google-Smtp-Source: APXvYqx7UX+07QB6rf7tI+JsJp388bL6hSKEDw7jHgHpKKJOqgKh3l4/VtJ/B/CdbYmtlZD9R7SOJg==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4mr33092313plt.13.1565642312071;
        Mon, 12 Aug 2019 13:38:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f08])
        by smtp.gmail.com with ESMTPSA id cx22sm387516pjb.25.2019.08.12.13.38.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:38:31 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:38:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v10 7/7] mm,thp: avoid writes to file with THP in
 pagecache
Message-ID: <20190812203829.GC15498@cmpxchg.org>
References: <20190801184244.3169074-1-songliubraving@fb.com>
 <20190801184244.3169074-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801184244.3169074-8-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:42:44AM -0700, Song Liu wrote:
> In previous patch, an application could put part of its text section in
> THP via madvise(). These THPs will be protected from writes when the
> application is still running (TXTBSY). However, after the application
> exits, the file is available for writes.
> 
> This patch avoids writes to file THP by dropping page cache for the file
> when the file is open for write. A new counter nr_thps is added to struct
> address_space. In do_dentry_open(), if the file is open for write and
> nr_thps is non-zero, we drop page cache for the whole file.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Acked-by: Rik van Riel <riel@surriel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
