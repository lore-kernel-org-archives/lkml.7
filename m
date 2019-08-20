Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C37720644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr29nm3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfHTCxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:53:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43395 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTCxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:53:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so2395636pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bqlUN1RbXA27ROpphRzaYTA2mgCbmo3KU3uDDJtbs+c=;
        b=lr29nm3uGUjC4tDgF6auRf/OYsKefNJqZ7MSVyRTDeoGlrPjplxyn9dfl4B7QryWg7
         x2iMe30DUCe/+bRalNLIvdcqkkqA2y40Q4+Laqlxhe+Kpp/RuD7zB47Uik52cxzBuSrE
         +tGNU/BuG4845FxkLzP/MWpzfsG2SJShUa32NcjCz3HeBMpt16Uk6CMxj+wgsK81GPbD
         PCanrgFnXL+W5O10eya769ZA/qhWDd6mvxm/HX1PwGbOGYxPdUs86okmrqEud1qD9gne
         R5809FKmHRSZMLZ0ByVG2nNAQ6QpgIUO6NsyV4zu08Sz751NPR31SPBKgAOtpwpdgKdm
         G/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqlUN1RbXA27ROpphRzaYTA2mgCbmo3KU3uDDJtbs+c=;
        b=lfAwWOHXT57MNoG2IJ/yaJLcH1eA847hg1v1jLB7YhLyilcdE6+OQWKJu5cH/G5YKr
         72ykbJ6aZXW6xv3vz8N+bQ8f3oK8Gh0YZJ7aNnuRMnVdOed1VTpyJZQfFh4kceeGGjf/
         3fnZwBhTVZq2G/IOZfNI32y4OOtPOUFwagJFqCsNlgEa5Ep0q+DCEdKsUL+1H0ownrnK
         JUftRi/hmOTEcqeFd5mbkzgf6ZnoXov+9ayT+Q3o0PWljkRcZUFJ0cNy3tXCILbTTvir
         bPcj7RoTp59dKmbFFgScU3msTHJpJ+/om+67l+wmtY2xgkxX36pBIf5ld3GYXNg/zw9d
         QWCg==
X-Gm-Message-State: APjAAAViHARGzqUSLhvW0fws6leOeNFn6j4T4Ram9GRHtfYOE6FRT0KE
        nWDmZefx9rn/cz8c6nwgDnQ=
X-Google-Smtp-Source: APXvYqwJs1ADMhrxxHHKzA1gs2MWDS3cqhoQTiMn5DXjUNOd0nP1apznaWbmYbQNSscGREpSp2eJPQ==
X-Received: by 2002:aa7:8e10:: with SMTP id c16mr26972942pfr.124.1566269591111;
        Mon, 19 Aug 2019 19:53:11 -0700 (PDT)
Received: from localhost ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id k5sm20942706pfg.167.2019.08.19.19.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:53:10 -0700 (PDT)
Date:   Tue, 20 Aug 2019 11:53:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Henry Burns <henryburns@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        HenryBurns <henrywolfeburns@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] mm/zsmalloc.c: Migration can leave pages in
 ZS_EMPTY indefinitely
Message-ID: <20190820025307.GC500@jagdpanzerIV>
References: <20190809181751.219326-1-henryburns@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809181751.219326-1-henryburns@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/09/19 11:17), Henry Burns wrote:
> In zs_page_migrate() we call putback_zspage() after we have finished
> migrating all pages in this zspage. However, the return value is ignored.
> If a zs_free() races in between zs_page_isolate() and zs_page_migrate(),
> freeing the last object in the zspage, putback_zspage() will leave the page
> in ZS_EMPTY for potentially an unbounded amount of time.
> 
> To fix this, we need to do the same thing as zs_page_putback() does:
> schedule free_work to occur.  To avoid duplicated code, move the
> sequence to a new putback_zspage_deferred() function which both
> zs_page_migrate() and zs_page_putback() call.
> 
> Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

+ Andrew

	-ss
