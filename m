Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9567F2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nN9GaP2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfH0IcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:32:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46394 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfH0IcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:32:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id z51so30182184edz.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mn5KDVhwwChGG6/LPdXL9ASx19vYGpyQz4cnp0ZsO64=;
        b=nN9GaP2qDNZuPmqS08OSMU8Huq4aCRmmZzhT8DnxntN2vffDdHKBjdGhJzXFYocIl8
         6xVlrvQc4enclmZw83Vw1fcat6UOLNMQKAvGhvneyZ5ra6oZOv0Wh0jfirxdN8gT0ZWn
         /r/nUCayxZSNmEMi7S0LIVVdMNXXRZitVMUVXLAEuU8JeqBKGaqKCNgMVTWHyXk+aC4K
         uxDyJeFSFoId3Irrcu7auJg4oxQ415pQVawtyC065Ahb/w2P0CxpMuIyB0Zm18Lc+Qio
         F6gJIICJ5WW0rT67I4N9eIt6kowvkiI3G65jmnTsGEF+FJF+HNMC3BTXA8IUb/bN7Tri
         FWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mn5KDVhwwChGG6/LPdXL9ASx19vYGpyQz4cnp0ZsO64=;
        b=nWL5brpz3c4APHCde4VoLOeQLPyLIuvAh8vwuwBYEZTjdW/RslNjqRUvK8IRrDuPx9
         Nv0o2aCSJ2LrDxhP1Nii71e5mh+hMzQtAQBIf5LhP3vVzwDbfiMxz+uFFw4HRDqpzWIW
         Tv2/oH4C8p8PczIPCrkji3TGL8F+2LhDryJ98y/UudoFBg+5JKuifJXXqIb/sR2K0aHe
         QYuSHV853uzKK+wNo6ohl3k/vCBxFizd4j7Evpr7TPq9CZ9ynvhbmABOxpw1bkNUvPis
         1HkYfy2hMTKnoRpzB+GvXtyjcQ7LzRjLFVjgE575u3qJ/WTWynj9isZOJzs2R/HPpqD/
         Nahg==
X-Gm-Message-State: APjAAAWbjoiAQlrO4YXPrlUqYLXfqzJ3O5kYo/2nCSm2fi7d898teoQG
        MjoEkp+/8eYmFNQkRSgiKic8mC34D7U=
X-Google-Smtp-Source: APXvYqy1k2rGciB3gixbkGCGnzVsxkvoKZD9KqaqMcXAredlFXWTowmF9iBpZRxgetzzOudrTBTarQ==
X-Received: by 2002:a17:906:5391:: with SMTP id g17mr20529475ejo.61.1566894734382;
        Tue, 27 Aug 2019 01:32:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q10sm3413891ejt.54.2019.08.27.01.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:32:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C1EEA100746; Tue, 27 Aug 2019 11:32:15 +0300 (+03)
Date:   Tue, 27 Aug 2019 11:32:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190827083215.lrgaonueazq7etl5@box>
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <9e4ba38e-0670-7292-ab3a-38af391598ec@linux.alibaba.com>
 <20190826074350.GE7538@dhcp22.suse.cz>
 <416daa85-44d4-1ef9-cc4c-6b91a8354c79@linux.alibaba.com>
 <20190827055941.GL7538@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827055941.GL7538@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:59:41AM +0200, Michal Hocko wrote:
> > > > > IIUC deferred splitting is mostly a workaround for nasty locking issues
> > > > > during splitting, right? This is not really an optimization to cache
> > > > > THPs for reuse or something like that. What is the reason this is not
> > > > > done from a worker context? At least THPs which would be freed
> > > > > completely sound like a good candidate for kworker tear down, no?
> > > > Yes, deferred split THP was introduced to avoid locking issues according to
> > > > the document. Memcg awareness would help to trigger the shrinker more often.
> > > > 
> > > > I think it could be done in a worker context, but when to trigger to worker
> > > > is a subtle problem.
> > > Why? What is the problem to trigger it after unmap of a batch worth of
> > > THPs?
> > 
> > This leads to another question, how many THPs are "a batch of worth"?
> 
> Some arbitrary reasonable number. Few dozens of THPs waiting for split
> are no big deal. Going into GB as you pointed out above is definitely a
> problem.

This will not work if these GBs worth of THPs are pinned (like with
RDMA).

We can kick the deferred split each N calls of deferred_split_huge_page()
if more than M pages queued or something.

Do we want to kick it again after some time if split from deferred queue
has failed?

The check if the page is splittable is not exactly free, so everyting has
trade offs.

-- 
 Kirill A. Shutemov
