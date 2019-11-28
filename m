Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92402176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574942487;
	bh=5elKrlvhdQ7vepqSptwVWBtOg70SCO7dMvSbkpx2ZDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ot8aUncv2t/CMLE+Bb3uI3MJmbGmPUsxUaknXwwtaE8pA4geB1bJr+Ykq/v3Kwpc0
	 hGUwFTWDVkvbfkIprt7H/d/8rDYVAyZm6MftrweURl1bgXs756Abwkx65fAk69L/+o
	 OSK2uiDVgUAzJg9FPXrn5D5xmkQX7OhDJBMECnaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1MB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:01:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54646 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:01:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so10633405wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+ZPcKqtkDfuCFJU9X4A+4eWzs0Y9EwU+RIvA4jfhmI=;
        b=EKuHKvxaQmsvm6UX3Q1rh8Z5gx5aYL5UqwtWk1leVUVRrS1BkBUNLcrN8mK+KLHasd
         yW55hQi4TSaGQMzbg1Clwbt3T3EEBmMq8N1tIa4ine30fCMU62nRjYZ8K3g4oGl5Eu3e
         /SI7G3EilES99WYx4QnBiJk3KNI/imVK9uIBLEEerSxdnij/YvCCAj9g+aUj3sxU+Z6U
         kq3ZxRxaz3rZ1or/aEaYZiCU6xS1IXzF/24N+TYBrLXI+oPfHTCVvX2m9t/AWzPvGldT
         XVGyao3WOeuO5NwTXGB5gZnwcOCPG+LKY1AE+A2ADRHudnwD2vQ+HTch33p7GFky4Rqh
         X3pQ==
X-Gm-Message-State: APjAAAXEzo7KCmqJlQJbHXw/Wk89IToHtjxPN4qntTXXSlpjvBaLFFWV
        mqO+njIoePh77KYHxIUpMD4=
X-Google-Smtp-Source: APXvYqwlSTr1gJjZOtmXNwoyOTPrCKLdd89moEKk18AxOv5EqnRPkYNyia2krUAaIi5brv5PrIcOLw==
X-Received: by 2002:a1c:610b:: with SMTP id v11mr9082613wmb.156.1574942483551;
        Thu, 28 Nov 2019 04:01:23 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m9sm22149062wro.66.2019.11.28.04.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:01:22 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:01:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
Message-ID: <20191128120121.GL26807@dhcp22.suse.cz>
References: <20191128102051.GI26807@dhcp22.suse.cz>
 <5E2F5866-0605-4DD2-9AEA-4B1C44E57D9F@redhat.com>
 <c8d2225f-9a90-65fa-5553-f4af8ca39b44@redhat.com>
 <20191128115021.GJ26807@dhcp22.suse.cz>
 <c7a3c823-d07d-54f7-19f1-bb75fb8f82df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a3c823-d07d-54f7-19f1-bb75fb8f82df@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-11-19 12:52:16, David Hildenbrand wrote:
> On 28.11.19 12:50, Michal Hocko wrote:
> > On Thu 28-11-19 12:23:08, David Hildenbrand wrote:
> > [...]
> >> >From fc13fd540a1702592e389e821f6266098e41e2bd Mon Sep 17 00:00:00 2001
> >> From: David Hildenbrand <david@redhat.com>
> >> Date: Wed, 27 Nov 2019 16:18:42 +0100
> >> Subject: [PATCH] drivers/base/node.c: optimize get_nid_for_pfn()
> >>
> >> Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
> >> unregister_memory_block_under_nodes()") we only have a single user of
> >> get_nid_for_pfn(). The remaining user calls this function when booting -
> >> where all added memory is online.
> >>
> >> Make it clearer that this function should only be used during boot (
> >> e.g., calling it on offline memory would be bad) by renaming the
> >> function to something meaningful, optimize out the ifdef and the additional
> >> system_state check, and add a comment why CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >> handling is in place at all.
> >>
> >> Also, optimize the call site. There is no need to check against
> >> page_nid < 0 - it will never match the nid (nid >= 0).
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Yes this looks much better! I am not sure this will pass all weird
> > config combinations because IS_ENABLED will not hide early_pfn_to_nid
> > from the early compiler stages so it might complain. But if this passes
> > 0day compile scrutiny then this is much much better. If not then we just
> > have to use ifdef which is a minor thing.
> 
> The compiler should optimize out
> 
> if (0)
> 	code
> 
> and therefore never link to early_pfn_to_nid.

You are right, but there is a catch. The optimization phase is much
later than the syntactic check so if the code doesn't make sense
for the syntactic point of view then it will complain. This is a notable
difference to #ifdef which just removes the whole block in the
preprocessor phase.

-- 
Michal Hocko
SUSE Labs
