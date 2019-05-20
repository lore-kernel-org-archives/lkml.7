Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB1C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782CA213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfETT1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfETT1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C022985365;
        Mon, 20 May 2019 19:27:25 +0000 (UTC)
Received: from redhat.com (ovpn-125-16.rdu2.redhat.com [10.10.125.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0781600C6;
        Mon, 20 May 2019 19:27:23 +0000 (UTC)
Date:   Mon, 20 May 2019 15:27:21 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while
 computing virtual address
Message-ID: <20190520192721.GA4049@redhat.com>
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
 <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
 <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 20 May 2019 19:27:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:07:38AM +0530, Anshuman Khandual wrote:
> On 05/18/2019 03:20 AM, Andrew Morton wrote:
> > On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > 
> >> The presence of struct page does not guarantee linear mapping for the pfn
> >> physical range. Device private memory which is non-coherent is excluded
> >> from linear mapping during devm_memremap_pages() though they will still
> >> have struct page coverage. Just check for device private memory before
> >> giving out virtual address for a given pfn.
> > 
> > I was going to give my standard "what are the user-visible runtime
> > effects of this change?", but...
> > 
> >> All these helper functions are all pfn_t related but could not figure out
> >> another way of determining a private pfn without looking into it's struct
> >> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
> >> it used by out of tree drivers ? Should we then drop it completely ?
> > 
> > Yeah, let's kill it.
> > 
> > But first, let's fix it so that if someone brings it back, they bring
> > back a non-buggy version.
> 
> Makes sense.
> 
> > 
> > So...  what (would be) the user-visible runtime effects of this change?
> 
> I am not very well aware about the user interaction with the drivers which
> hotplug and manage ZONE_DEVICE memory in general. Hence will not be able to
> comment on it's user visible runtime impact. I just figured this out from
> code audit while testing ZONE_DEVICE on arm64 platform. But the fix makes
> the function bit more expensive as it now involve some additional memory
> references.

A device private pfn can never leak outside code that does not understand it
So this change is useless for any existing users and i would like to keep the
existing behavior ie never leak device private pfn.

Cheers,
Jérôme
