Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89569218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DqmrzG0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfC2WXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:23:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8228 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbfC2WXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:23:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9e9abe0000>; Fri, 29 Mar 2019 15:22:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 Mar 2019 15:23:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 Mar 2019 15:23:02 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 22:23:01 +0000
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
To:     Oscar Salvador <osalvador@suse.de>, <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <david@redhat.com>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20190328134320.13232-1-osalvador@suse.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <91cfdf41-ef43-1f18-36b8-806e246538a0@nvidia.com>
Date:   Fri, 29 Mar 2019 15:23:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328134320.13232-1-osalvador@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553898175; bh=U3+Cg2KmhdLf9sXflfQLb4WPspNVvCbzVKQ3Qb8V0J0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DqmrzG0cHnR4jvd40Vi6xsFts3l7d2KYsnimjZYTvcLonF8Dwkal/DGxDorvxqV80
         bOczMwanRQNhGhhQ3KWbVTMGF0Fyi/tSJmENmF9e/RoF/U955vc8itii5RSE42jrwX
         qQn1mo67jXESqS4+hTPheb9+r3hz3dUlEOO4zDJakX3XIzx8L8++fY/6zqsW8gGmFJ
         Xg19unTShmntzSLOt76pblb3NHjXzqjFimSsgAC+aM5i7tZew5VgZEod72QFL1C4rf
         tbQicist8p0rL5/Pwus6B0YFRNr5oXgtPY5SvLGbhaPubf+cH6dSgsfnoUjUTEor2X
         VS1HH/Ww56sgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 6:43 AM, Oscar Salvador wrote:
> Hi,
> 
> since last two RFCs were almost unnoticed (thanks David for the feedback),
> I decided to re-work some parts to make it more simple and give it a more
> testing, and drop the RFC, to see if it gets more attention.
> I also added David's feedback, so now all users of add_memory/__add_memory/
> add_memory_resource can specify whether they want to use this feature or not.
> I also fixed some compilation issues when CONFIG_SPARSEMEM_VMEMMAP is not set.
> 

Hi Oscar, say, what tree and/or commit does this series apply to? I'm having some
trouble finding the right place. Sorry for the easy question, I did try quite
a few trees already...

thanks,
-- 
John Hubbard
NVIDIA
