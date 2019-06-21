Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8373BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56914208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuDC9qVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFUU6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:58:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39160 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUU6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:58:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so3920952pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8yYOqvu5kX2LRYKzF9g/pziCLKwTlUixwBsdMp/H9Nc=;
        b=cuDC9qVShlq//zw6GpvnrOHJFr1tcJ4HACKd/9B6u34xyHNjsW0OOZZDRgr1qM5/Hp
         M0EB1zZM9gs5L8IJxIQGhXyVdveLkFnCOdJvfz/4XhENaTANN3GCW8/cP3RIrws83hYf
         NjmDQ0cqNT7vUgF56dqnL3z2x4Gapjcups6HVuJqAMMa/NjkniW/WC2yI0x1gkc+P1oR
         x+W55orwr1MH5BNxQsFA9adhAFgSOApJrYCp+37QsyH3D9VgVufcKKcs67USdy54C/lM
         H/QFupT5whQ6zNnOb0NQtQr+1v35QV8uptQ7kg+pJdyJOUZxnqhRROHJzPv+icVCuj+Y
         QuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8yYOqvu5kX2LRYKzF9g/pziCLKwTlUixwBsdMp/H9Nc=;
        b=cclHuvvOtDuNC9EZ5a3/5dmcb8CIwJWuXReDkiE9EPcfVbgOrVL7hdy2zyvStOcZY6
         ESXmk6xB9YQV5K/lxHzTt6BFukR/NsYuSsiCIi84Jnf4uQu+vdeMN5KXx5/EDg5t7YYI
         nlETy2jC+gwlFK4NsLHeBvLENaeinWjCVfN04rOzwu6ymaMYgq2zrM82OFg+jdob7fqT
         cJkBo2nnZQPq/DbGRbQIcbQEv1yoku0ToG1LOrGfH2K463zV3O233n2HfzBybIpTp/dD
         8AeHK3FIjrgwgvH7LnUso/hF5U0Zfi7JVNC6JexzIRTdxrMtFUTB1feUR8p+iTQJ0SdZ
         AAmw==
X-Gm-Message-State: APjAAAXKAvEgsE4bk5uWubgk22YJ9rp01kVM7lbk1Q+bDql23WMd5N6L
        RiAArLrm7vOa7HNCvC6wZwCZnw==
X-Google-Smtp-Source: APXvYqzENl1koEQxTi7C5Y8/9tx1iueVhtL6QRrM0tus5wsF6Daa6W5Dsr6LEZDlBw4XS9jAkYfZew==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr9083829pje.123.1561150689472;
        Fri, 21 Jun 2019 13:58:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h1sm4763129pfo.152.2019.06.21.13.58.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 13:58:08 -0700 (PDT)
Date:   Fri, 21 Jun 2019 13:58:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
cc:     linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: Re: [PATCH v2] mm: avoid inconsistent "boosts" when updating the
 high and low watermarks
In-Reply-To: <20190621153107.23667-1-alan.christopher.jenkins@gmail.com>
Message-ID: <alpine.DEB.2.21.1906211357560.77141@chino.kir.corp.google.com>
References: <3d15b808-b7cd-7379-a6a9-d3cf04b7dcec@suse.cz> <20190621153107.23667-1-alan.christopher.jenkins@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Alan Jenkins wrote:

> When setting the low and high watermarks we use min_wmark_pages(zone).
> I guess this was to reduce the line length.  Then this macro was modified
> to include zone->watermark_boost.  So we needed to set watermark_boost
> before we set the high and low watermarks... but we did not.
> 
> It seems mostly harmless.  It might set the watermarks a bit higher than
> needed: when 1) the watermarks have been "boosted" and 2) you then
> triggered __setup_per_zone_wmarks() (by setting one of the sysctls, or
> hotplugging memory...).
> 
> I noticed it because it also breaks the documented equality
> (high - low == low - min).  Below is an example of reproducing the bug.
> 
> First sample.  Equality is met (high - low == low - min):
> 
> Node 0, zone   Normal
>   pages free     11962
>         min      9531
>         low      11913
>         high     14295
>         spanned  1173504
>         present  1173504
>         managed  1134235
> 
> A later sample.  Something has caused us to boost the watermarks:
> 
> Node 0, zone   Normal
>   pages free     12614
>         min      10043
>         low      12425
>         high     14807
> 
> Now trigger the watermarks to be recalculated.  "cd /proc/sys/vm" and
> "cat watermark_scale_factor > watermark_scale_factor".  Then the watermarks
> are boosted inconsistently.  The equality is broken:
> 
> Node 0, zone   Normal
>   pages free     12412
>         min      9531
>         low      12425
>         high     14807
> 
> 14807 - 12425 = 2382
> 12425 -  9531 = 2894
> 
> Co-developed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
>                       fragmentation event occurs")
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: David Rientjes <rientjes@google.com>
