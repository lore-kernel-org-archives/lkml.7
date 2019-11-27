Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28ADC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE62D215F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574892936;
	bh=tzkKiC5bw0wXwgBywju5t0wQAzDG3AO9cKzzRulLeJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JHMW98grlD2FWXE6Giui0FejhNRSGBmv4ZjgrYwe1pjE1iVUuDfnfYfiv6DhlmVy4
	 UnzOcETlvWQL6dwidFEWnbrVbzsWOR8K+Vf5TP/i4F8VUmzbsW5asCz3cJ5fbv35y0
	 3uVfchj8JbhAb3MNkPSMrA1dOPTgiBmuT61VJ5xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfK0WPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfK0WPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:15:35 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602FF206F0;
        Wed, 27 Nov 2019 22:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574892933;
        bh=tzkKiC5bw0wXwgBywju5t0wQAzDG3AO9cKzzRulLeJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBiSldletvBXjGw0DWsofLb8V9rzhy9b/rEvoUWEBEUeujA12g4vGti4+gs4xcubU
         kVjiPKf4X7ojfrD3ssXbKUVBJ/apWq28gwF6w5zTG62sgJ/bLmSmf4zlsDjpLxCFGz
         F8PGxTb1w6+mPeiw0FJ5mgfAhkErEhyyWaA72yG8=
Date:   Wed, 27 Nov 2019 14:15:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v2] drivers/base/node.c: Simplify
 unregister_memory_block_under_nodes()
Message-Id: <20191127141532.525708b65a96fd614595bae8@linux-foundation.org>
In-Reply-To: <b2e31976-b07d-11e6-f806-f13f4619be4d@redhat.com>
References: <20190719135244.15242-1-david@redhat.com>
        <b2e31976-b07d-11e6-f806-f13f4619be4d@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 17:53:12 +0100 David Hildenbrand <david@redhat.com> wrote:

> Just a note that this was actually also a bugfix as noted by Chris.
> 
> If the memory we are removing was never onlined,
> get_nid_for_pfn()->pfn_to_nid() will return garbage. Removing will
> succeed but links will remain in place.
> 
> Can be triggered by
> 
> 1. hotplugging a DIMM to node 1
> 2. not onlining the memory blocks
> 3. unplugging it
> 4. re-plugging it to node 1
> 
> We will trigger the BUG_ON(ret) in add_memory_resource(), because
> link_mem_sections() will return with -EEXIST.

Oh.  In that case case we please redo the patch as a bugfix? 
Appropriate title and changelog?  And perhaps the bugfix can be split
from the cleanup, to make the former more backportable?

