Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14462075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553782597;
	bh=PkqeEq4WwmfERWDYJBk7vTulq+B0vgd/JOOSLAP/RP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UqhsdRZ/2hSMoFnBap9Mpw+1GR5tedWv+s1YWe5VHiQarVXd8Wi+TxXXmYwfsjfjh
	 Pazp0nIQcwpKYJQCcF0CYzBk1PTAZ/bycpDWu7MiCZqHW3jE1ta1+YNS28cJfZ7ciD
	 JDTtGkO/TH9LKLLcoU/gon9QF5nSLCPoT/VieYVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfC1OQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:16:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbfC1OQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:16:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C140EB780;
        Thu, 28 Mar 2019 14:16:32 +0000 (UTC)
Date:   Thu, 28 Mar 2019 15:16:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] mm: Sub-section memory hotplug support
Message-ID: <20190328141631.GB7155@dhcp22.suse.cz>
References: <155327387405.225273.9325594075351253804.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190322180532.GM32418@dhcp22.suse.cz>
 <CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com>
 <20190325101945.GD9924@dhcp22.suse.cz>
 <CAPcyv4iJCgu-akJM_O8ZtscqWQt=CU-fvx-ViGYeau-NJufmSQ@mail.gmail.com>
 <20190326080408.GC28406@dhcp22.suse.cz>
 <CAPcyv4jUeUPwbfToWQtWX1AxfgFLNpBUhm8BvgJ2Hv1RbNPiog@mail.gmail.com>
 <20190327161306.GM11927@dhcp22.suse.cz>
 <9e769f3d-00f2-a8bb-2d8d-097735cb2a6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e769f3d-00f2-a8bb-2d8d-097735cb2a6d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-03-19 14:38:15, David Hildenbrand wrote:
> On 27.03.19 17:13, Michal Hocko wrote:
[...]
> > People are asking for a smaller memory hotplug granularity for other
> > usecases (e.g. memory ballooning into VMs) which are quite dubious to
> > be honest and not really worth all the code rework. If we are talking
> > about something that can be worked around elsewhere then it is preferred
> > because the code base is not in an excellent shape and putting more on
> > top is just going to cause more headaches.
> 
> At least for virtio-mem, it will be handled similar to xen-balloon and
> hyper-v balloon, where whole actions are added and some parts are kept
> "soft-offline". But there, one device "owns" the complete section, it
> does not overlap with other devices. One section only has one owner.

This is exactly what I meant by handing at a higher level.

-- 
Michal Hocko
SUSE Labs
