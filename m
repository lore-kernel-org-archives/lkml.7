Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57023206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="N9O/P989"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfDDQjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:39:17 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:46902 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDDQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:39:17 -0400
Received: by mail-yw1-f43.google.com with SMTP id v127so1194968ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sVZzefylPUert59vxaZI/oiiATEF9PQOgxdOg2fXoEs=;
        b=N9O/P989CYq5nDJ+5cfuaXQTyO9yPFp/1/eKojWhp/i7Y2K8efOxl8h5pcHtpCFXpV
         2/Fgk3oF02TPKWP0j2FhXquqaxWo7pcBk+LSDFbvbP6L7+AKKu3P8X1Bc/ih1Un5oAHW
         lidSBfVBXnjoYtvNI8yPV/jeLc7aSm1KqADr4p45hgk+VpTgdmNZgYK7a9ZtS8/nOvWv
         Ze6qWGbBNiCJZnPke88ZMLvYVM1HMR/817cLJax12DTXw/4xn7MrjL1SOwjZX3E93CRT
         n9tNcxv2bv+8v9aEkys2lEACvHlf/xG0dxvVaY7Mo0mI/Orl1g12urtpIGjl1Q1vKsWG
         eLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVZzefylPUert59vxaZI/oiiATEF9PQOgxdOg2fXoEs=;
        b=IT45/cG4k3LUEVdE5SAVDZr5UZlDVPAG/GgTJV0rIxq1hNhZZGpn6VrR1KYqeHRseF
         V6Pc/wcAe1Y99B6k9p+9MpAZX0Otdb90XHyAOoWvRF8RUIkVCvrcCylJK1GOg2tn/SI/
         H3zjQxWbNSoygtcoLtN311tDlczsGohyu3p05uhhQfQBI9HMUWGTvp12Ou3ACtvAPJLB
         dLh/8IT8WIXgdxxb3gYS8PxRrIn1+PkxdR50Am/BqciL4J9a6TTb4YMNrrIVvHGLJvZw
         TYJzrbuE7b8XcZ0Tk6tkOql1/8DK+YxIMEMoQoSz2YPVEQIforCSk54VEUgQvUt5vClD
         H/WA==
X-Gm-Message-State: APjAAAWO08OmmLNEzDvg+1VBFQ+udUfSmrzUndf3D7dTO/0asEnjF4ND
        FvfGqR1pqkGBd11n4QTQpL346Q==
X-Google-Smtp-Source: APXvYqzilLKYDRMZlOnegsGNrRHGCTLtWjZZcd0Pk6bBZMtt4KU1a29LEu2clZfsFtRi2mMQ7fOucw==
X-Received: by 2002:a81:4d8b:: with SMTP id a133mr5725050ywb.122.1554395956113;
        Thu, 04 Apr 2019 09:39:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:af4])
        by smtp.gmail.com with ESMTPSA id j187sm6563806ywj.32.2019.04.04.09.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:39:15 -0700 (PDT)
Date:   Thu, 4 Apr 2019 12:39:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:workingset use real time to judge activity of the
 file page
Message-ID: <20190404163914.GA4229@cmpxchg.org>
References: <1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:30:17AM +0800, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> In previous implementation, the number of refault pages is used
> for judging the refault period of each page, which is not precised as
> eviction of other files will be affect a lot on current cache.
> We introduce the timestamp into the workingset's entry and refault ratio
> to measure the file page's activity. It helps to decrease the affection
> of other files(average refault ratio can reflect the view of whole system
> 's memory).

I don't understand what exactly you're saying here, can you please
elaborate?

The reason it's using distances instead of absolute time is because
the ordering of the LRU is relative and not based on absolute time.

E.g. if a page is accessed every 500ms, it depends on all other pages
to determine whether this page is at the head or the tail of the LRU.

So when you refault, in order to determine the relative position of
the refaulted page in the LRU, you have to compare it to how fast that
LRU is moving. The absolute refault time, or the average time between
refaults, is not comparable to what's already in memory.
