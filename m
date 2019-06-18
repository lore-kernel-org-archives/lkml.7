Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A4C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C9E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4LqXjau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfFRUC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:02:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39781 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:02:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so10253573lfo.6;
        Tue, 18 Jun 2019 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cVl3SIklS0nHd797FYY4cxHoZEAnPslNYDQOv5OhMDM=;
        b=D4LqXjauq6e8L92SXdCI8dBOeZ9g3qnR+MvRfoDQP4UPl32roBpvGWprF3TjlmHSja
         eZ/6/ZjWzgRN9htttHJTrPzVJCoFvbIqpDA3vC1Cl8utSLu6XzXuxp7AabXcEV/Om6He
         yHiGKcbb2hB4xqghyhAsPiwk4UDzPPVak57pe2KgOS495X1pgno1vQnCtMEqE80s7SDd
         b/xHq26uOBUeyQq+iykM4OWAPJ5VZU59856GZ2QUrHkBfHjmAmn1pe6xmy0ce97q8t4y
         IfDjJ3INQeQbB5asZ/xxIwCfBifBBZjV8Yfyh2WDBB5G9dWZfMSeieDwA07Xq9c2du8P
         K49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVl3SIklS0nHd797FYY4cxHoZEAnPslNYDQOv5OhMDM=;
        b=L+Mw5H2tzDvLIImNk+lqFdo/mYtJN4BEMzCzzEVGODbbeSfr7IGM+GLypvYdOAa6h/
         Q1aoHhe40DvtMx2y5e9xNQb2TQ8T2ktYrDABU6RVhk+DZfGluuE1fMH+7mK0wDjpiXmE
         YJEdUTXMTwZKmbRxtrF5Qj54ZlEjaXd4roWCtbN1slPBmX2Y6x8bk2VOIYjp94Zf1hxY
         qBTwk50bQ3WKs0vdaXU6UDYuNp8PjibeZ3eM4s21gEu5f1aW8g3X/p9iTwGOw85OloTN
         2XEhzpgUaBT7Q13MJ8XF91p8RQ1SDeZ3HMKYiwAX73D3huBEdcLePjTffCkD/VAols+b
         exSQ==
X-Gm-Message-State: APjAAAVxactIGjKsD2BvM0z4i+IPMcbVsUSG7HWws/7qqjpGNpfhMg3a
        +bHSEg8wR1KH8veoIB64IqksEHY3BDA=
X-Google-Smtp-Source: APXvYqzKO9zG2G36ym9WsDHSLpShB5YrpwSynDJM7DvNbZeZWMwp4g4634Uhi3PMXIvAfLocbMbxAg==
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr26109062lfp.44.1560888175432;
        Tue, 18 Jun 2019 13:02:55 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id j23sm1621386lfb.93.2019.06.18.13.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:02:54 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:02:51 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: idle-page: fix oops because end_pfn is larger than
 max_pfn
Message-ID: <20190618200251.hd2uk6qzyvsy55py@esperanza>
References: <20190618124352.28307-1-colin.king@canonical.com>
 <20190618124502.7b9c32a00a54f0c618a12ca4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618124502.7b9c32a00a54f0c618a12ca4@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:45:02PM -0700, Andrew Morton wrote:
> On Tue, 18 Jun 2019 13:43:52 +0100 Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the calcuation of end_pfn can round up the pfn number to
> > more than the actual maximum number of pfns, causing an Oops. Fix
> > this by ensuring end_pfn is never more than max_pfn.
> > 
> > This can be easily triggered when on systems where the end_pfn gets
> > rounded up to more than max_pfn using the idle-page stress-ng
> > stress test:
> > 
> 
> cc Vladimir.  This seems rather obvious - I'm wondering if the code was
> that way for some subtle reason?

No subtle reason at all - just a bug. The patch looks good to me,

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
