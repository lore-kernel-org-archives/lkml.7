Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5720652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ab1gt2ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbfDRNey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:34:54 -0400
Received: from a9-32.smtp-out.amazonses.com ([54.240.9.32]:49086 "EHLO
        a9-32.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbfDRNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1555594493;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=tGKbg7T4m2hja67VSnD+5sN45YQjy0gEHiOhoXRYwnE=;
        b=ab1gt2ubDBnvlERvCSi1ce9rbtCoG/YS77M3OGWWcVMUjDZG7kdCTAIh3pFVU73u
        JBYkidNGYMpwtlzEcOGCrYV7+GGxIkApxsJL4FIYB0Sro4vm00cQ7klrHZkK5gkWFTd
        +5z2ftsGtTwkIdbIkR74gay/PBi7mTjrZi0orids=
Date:   Thu, 18 Apr 2019 13:34:52 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Roman Gushchin <guroan@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, david@fromorbit.com,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle
 management
In-Reply-To: <20190417215434.25897-5-guro@fb.com>
Message-ID: <0100016a30a83bcf-7f99039c-77ec-4c48-a1c4-92e398f8f185-000000@email.amazonses.com>
References: <20190417215434.25897-1-guro@fb.com> <20190417215434.25897-5-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.18-54.240.9.32
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Roman Gushchin wrote:

> Let's make every page to hold a reference to the kmem_cache (we
> already have a stable pointer), and make kmem_caches to hold a single
> reference to the memory cgroup.

Ok you are freeing one word in the page struct that can be used for other
purposes now?

