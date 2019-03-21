Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1991C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9246218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfCUJVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbfCUJVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB603F74A8;
        Thu, 21 Mar 2019 09:21:45 +0000 (UTC)
Received: from localhost (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0F3600C1;
        Thu, 21 Mar 2019 09:21:42 +0000 (UTC)
Date:   Thu, 21 Mar 2019 17:21:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190321092138.GY18740@MiWiFi-R3L-srv>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
 <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
 <20190320122243.GX19508@bombadil.infradead.org>
 <20190320123658.GF13626@rapoport-lnx>
 <20190320125843.GY19508@bombadil.infradead.org>
 <20190321064029.GW18740@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321064029.GW18740@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 21 Mar 2019 09:21:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/19 at 02:40pm, Baoquan He wrote:
> Hi all,
> 
> On 03/20/19 at 05:58am, Matthew Wilcox wrote:
> > On Wed, Mar 20, 2019 at 02:36:58PM +0200, Mike Rapoport wrote:
> > > There are more than a thousand -EEXIST in the kernel, I really doubt all of
> > > them mean "File exists" ;-)
> > 
> > And yet that's what the user will see if it's ever printed with perror()
> > or similar.  We're pretty bad at choosing errnos; look how abused
> > ENOSPC is:
> 
> When I tried to change -EEXIST to -EBUSY, seems the returned value will
> return back over the whole path. And -EEXIST is checked explicitly
> several times during the path. 
> 
> acpi_memory_enable_device -> __add_pages .. -> __add_section -> sparse_add_one_section
> 
> Only look into hotplug path triggered by ACPI event, there are also
> device memory and ballon memory paths I haven't checked carefully
> because not familiar with them.
> 
> So from the checking, I tend to agree with Oscar and Mike. There have
> been so many places to use '-EEXIST' to indicate that stuffs checked have
> been existing. We can't deny it's inconsistent with term explanation
> text. While the defense is that -EEXIST is more precise to indicate a
> static instance has been present when we want to create it, but -EBUSY
> is a little blizarre. I would rather see -EBUSY is used on a device.
> When want to stop it or destroy it, need check if it's busy or not.
> 
> #define EBUSY           16      /* Device or resource busy */
> #define EEXIST          17      /* File exists */
> 
> Obviously saying resource busy or not, it violates semanics in any
> language. So many people use EEXIST instead, isn't it the obsolete

Surely when we require a lock which is protecting resource, we can also
return -EBUSY since someone is busy on this resource. For creating one
instance, just check if the instance exists already, no matter what the
code comment of the errno is saying, IMHO, it really should not be -EBUSY.

Thanks
Baoquan
