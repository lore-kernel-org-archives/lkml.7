Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A9C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57F92053B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561985192;
	bh=vleVEvf9zhD4NvAGhjmRW8eayRWPUWbnRVNQFZI+CII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ge0SQj0t7jJywweyJ0Fx8ENRfazKsSfGr5P5fW88ASBPAPIqCTixNl2R4CAEWFoN1
	 r2QoWaptOqYGPj8WIMdHdfb3bTFfBuEyUinrJGxYcpkSYfFh9xL4ISYw8gEJhxoxXS
	 wBAOXGIS8yx2aPbOaAGIHXHlzYiRMFFEGBOuP1cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfGAMqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:46:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGAMqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:46:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4AF5AEF5;
        Mon,  1 Jul 2019 12:46:28 +0000 (UTC)
Date:   Mon, 1 Jul 2019 14:46:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH v3 02/11] s390x/mm: Fail when an altmap is used for
 arch_add_memory()
Message-ID: <20190701124628.GT6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-3-david@redhat.com>
 <20190701074306.GC6376@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701074306.GC6376@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-07-19 09:43:06, Michal Hocko wrote:
> On Mon 27-05-19 13:11:43, David Hildenbrand wrote:
> > ZONE_DEVICE is not yet supported, fail if an altmap is passed, so we
> > don't forget arch_add_memory()/arch_remove_memory() when unlocking
> > support.
> 
> Why do we need this? Sure ZONE_DEVICE is not supported for s390 and so
> might be the case for other arches which support hotplug. I do not see
> much point in adding warning to each of them.

I would drop this one. If there is a strong reason to have something
like that it should come with a better explanation and it can be done on
top.
-- 
Michal Hocko
SUSE Labs
