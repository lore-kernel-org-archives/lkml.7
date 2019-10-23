Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44CC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6114121929
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gzPtJc9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406971AbfJWP4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:56:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36676 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406962AbfJWP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:56:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so18401366qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qCDfb7NBt3k96Z3LHT9+wyaPinygdsUVG4eMjwQIig0=;
        b=gzPtJc9UG7/c3nCw1QDLmDFrPZ2p/5hVgwAWj5fxU7jOZw+4M6LELBbAGYk+6wbln3
         f8ief24ppj67ptUxcdk4CzpF1yUiOP/2cRcPsqUBcFvNqdvDdfh1GrdDRfcdT6jSga8O
         lCUDrd5RQn/iYeUN5F8eMCJalFsQlOXYkpMo6RwW+lAx6M9sN67Bw/rIRZs76wUfN5ST
         3CmZcNDi0/pmB0JWE+/PHNP2bwbar9mrnhDdr4HqOzD/LbibMVqfVF5SBw424VYUqiAQ
         ZP48m8ZlTKx6J90KvpquV6g52d05IyK6VPpkmJ5aUaOaY30+/V/qPLq6e17IUoCMFz2f
         +SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qCDfb7NBt3k96Z3LHT9+wyaPinygdsUVG4eMjwQIig0=;
        b=hRs/1N2WkLNgE14Hi8A7W5dVee9aqaPKHPZ48YOqDe7ab/vsnfEw6Twwjf6VE4zRfy
         F7z07/hO4JQx92CLO04NWmvjrDH7p2sGLkyZg2o7G9fgfia21Vl1joEBkUwWZ5g3l/4O
         H9EzO32hkYQIyrEze/+DP6GIRsDl0OEgtZ3VhfByCMKyh7Dxl+hzADMxor2mwJVEKeHY
         REXMNHVKX2peYFsv39C5c5F6QzpvVhAXTh51acGu8w229E4ve0msGEn2iEbOHYHkjvo9
         QXc3n1EMbVrsuZTxaJTkEc9YZBCV8uGCQ0Zr89mN2pXEhIiGLp69cQvTpN1VSWYEkbGZ
         WBnw==
X-Gm-Message-State: APjAAAUcbVeMQUbuqqFqCHzM0yo7BNgMxN8MQlteV5qsowtbZsYNU2d/
        5mtashu72ZNN3O1FI8EC4BGfLg==
X-Google-Smtp-Source: APXvYqx0acPfaJc7aDp/xUAu/oImOejs62QLL76QQZnIiy0PFClGHYdtIYajkheNs7/YVZ6DSkKAsQ==
X-Received: by 2002:ac8:4506:: with SMTP id q6mr10062633qtn.277.1571846205200;
        Wed, 23 Oct 2019 08:56:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c4de])
        by smtp.gmail.com with ESMTPSA id p7sm12637822qkc.21.2019.10.23.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 08:56:44 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:56:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and
 sane_reclaim()
Message-ID: <20191023155643.GB366316@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-5-hannes@cmpxchg.org>
 <20191023141436.GE17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023141436.GE17610@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:14:36PM +0200, Michal Hocko wrote:
> On Tue 22-10-19 10:47:59, Johannes Weiner wrote:
> > Seven years after introducing the global_reclaim() function, I still
> > have to double take when reading a callsite. I don't know how others
> > do it, this is a terrible name.
> 
> I somehow never had problem with that but ...
> > 
> > Invert the meaning and rename it to cgroup_reclaim().
> > 
> > [ After all, "global reclaim" is just regular reclaim invoked from the
> >   page allocator. It's reclaim on behalf of a cgroup limit that is a
> >   special case of reclaim, and should be explicit - not the reverse. ]
> 
> ... this is a valid point.
> 
> > sane_reclaim() isn't very descriptive either: it tests whether we can
> > use the regular writeback throttling - available during regular page
> > reclaim or cgroup2 limit reclaim - or need to use the broken
> > wait_on_page_writeback() method. Use "writeback_throttling_sane()".
> 
> I do have a stronger opinion on this one. sane_reclaim is really a
> terrible name. As you say the only thing this should really tell is
> whether writeback throttling is available so I would rather go with
> has_writeback_throttling() or writeba_throttling_{eabled,available}
> If you insist on having sane in the name then I won't object but it just
> raises a question whether we have some levels of throttling with a
> different level of sanity.

I mean, cgroup1 *does* have a method to not OOM due to pages under
writeback: wait_on_page_writeback() on each wb page on the LRU.

It's terrible, but it's a form of writeback throttling. That's what
the sane vs insane distinction is about, I guess: we do in fact have
throttling implementations with different levels of sanity.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
