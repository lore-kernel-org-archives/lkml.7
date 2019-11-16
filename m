Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318EC43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30F20733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573862917;
	bh=BJ4L9qrJoht0uLRblWQg7JYdL1y/ny6VjCVp2vX5Asw=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=C4VTHOqSftxr5QJRREFoCJEWXoysYio9m3JfUVOETXgAfKxgmOAj2UaWgvPaX1762
	 0x3HZIuf+zVQ1QCy3UbdfjL8gemPhW/gjMhF+bRnGvIU3/RJSpLhyAb4CnJ0MpMiRG
	 PLO6fciCXPSdho7ltp0tiTcUmY4xEt7JCDoiYwko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKPAIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 19:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfKPAIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 19:08:35 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E2520730;
        Sat, 16 Nov 2019 00:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573862915;
        bh=BJ4L9qrJoht0uLRblWQg7JYdL1y/ny6VjCVp2vX5Asw=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=XdMvhhx7k/NONyYyoAW+m7AtxuYNLSkXLSZ2GzgV2o7DiqAly91BIGv/NBTJALLbw
         0mwvxegDQP6OFHcLQ+FbJIUd9dpArgT1GJRh41HQpvhEpSt19ZLysDQecSM4INWHYI
         5R2cRUvU6G2xztbjCIxxpeD01gCkI2c1b6s1rjWM=
Date:   Fri, 15 Nov 2019 16:08:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v3] mm/memory_hotplug: Fix try_offline_node()
Message-Id: <20191115160833.beda52bc6f1145bc81960ba7@linux-foundation.org>
In-Reply-To: <20191107195845.b0b3921ea146a60d042a8f64@linux-foundation.org>
References: <20191102120221.7553-1-david@redhat.com>
        <51bdb854-a60e-d076-5dde-38481bf4a4b1@redhat.com>
        <20191107195845.b0b3921ea146a60d042a8f64@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 19:58:45 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 7 Nov 2019 00:14:13 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
> > > +	/*
> > > +	 * Especially offline memory blocks might not be spanned by the
> > > +	 * node. They will get spanned by the node once they get onlined.
> > > +	 * However, they link to the node in sysfs and can get onlined later.
> > > +	 */
> > > +	rc = for_each_memory_block(&nid, check_no_memblock_for_node_cb);
> > > +	if (rc)
> > >   		return;
> > > -	}
> > >   
> > >   	if (check_cpu_on_node(pgdat))
> > >   		return;
> > > 
> > 
> > @Andrew, can you queued this one instead of v1 so we can give this some 
> > more testing? Thanks!
> 
> Sure.
> 
> We have a tested-by but no reviewed-by or acked-by :(
> 
> Null pointer derefs are unpopular.  Should we cc:stable?

<Crickets>

I added cc:stable and shall send it upstream unreviewed.
