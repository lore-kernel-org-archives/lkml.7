Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEF720811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553525429;
	bh=eqN51NDFbUAPg5+w5wr1VqKMf4COuFoP9GxRsWv3Ygk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNapSKDQ7HpHsWxqoTexxtD9exNhw+hZdHCuxfOBv3HBUdnNGXOMxScNSsOoeznua
	 iMxqdSlJ4ByvSlV1oC0aYeOvjI7CjcNWYoooTZM6CB8+nWJ1bM+VFETurv0lBQ8EDd
	 S+A2tfqFRor/3c3w8Wg206DMRaa9hj5Uk+uL+T9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfCYOu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCYOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:50:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 058C5AF2F;
        Mon, 25 Mar 2019 14:50:23 +0000 (UTC)
Date:   Mon, 25 Mar 2019 15:50:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] mm: Sub-section memory hotplug support
Message-ID: <20190325145023.GG9924@dhcp22.suse.cz>
References: <155327387405.225273.9325594075351253804.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190322180532.GM32418@dhcp22.suse.cz>
 <CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com>
 <20190325101945.GD9924@dhcp22.suse.cz>
 <x494l7rdo5r.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x494l7rdo5r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-03-19 10:28:00, Jeff Moyer wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> >> > and I would like to know that you are
> >> > not just shifting the problem to a smaller unit and a new/creative HW
> >> > will force us to go even more complicated.
> >> 
> >> HW will not do this to us. It's software that has the problem.
> >> Namespace creation is unnecessarily constrained to 128MB alignment.
> >
> > And why is that a problem? A lack of documentation that this is a
> > requirement? Something will not work with a larger alignment? Someting
> > else?
> 
> See this email for one user-visible problem:
>   https://lore.kernel.org/lkml/x49imxbx22d.fsf@segfault.boston.devel.redhat.com/

: # ndctl create-namespace -m fsdax -s 128m
:   Error: '--size=' must align to interleave-width: 6 and alignment: 2097152
:   did you intend --size=132M?
: 
: failed to create namespace: Invalid argument

So the size is in section size units. So what prevents the userspace to
use a proper alignment? I am sorry if this is a stupid question but I am
not really familiar with ndctl nor the pmem side of it.
-- 
Michal Hocko
SUSE Labs
