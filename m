Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40718C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C07320409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VPIkac5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKNH0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:26:36 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10389 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:26:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcd01ab0000>; Wed, 13 Nov 2019 23:26:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 23:26:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 23:26:36 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 07:26:35 +0000
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
 <CAPcyv4hK1hkDn9WohRn4F8JkAOBu94jzOJtU+43PP2qSX77Fqg@mail.gmail.com>
 <20191114072354.GA26448@lst.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <588a955d-0750-b6db-738a-7556704fa894@nvidia.com>
Date:   Wed, 13 Nov 2019 23:26:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114072354.GA26448@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573716395; bh=bAjMhffZlUOOQ4J77AH0Tz30434cSCz8DX1xgdnGyZo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VPIkac5L735bU9bvuVXOajHcI4VxRWpWKyWtIEWF/mc2BDNfPoypitaHjXmKC1Epg
         +D3HzQ4S7/khVD+3f9UwNYzRG6XNLXh3dLzGjj0AznLRQBu8lJXhK/t/nr0/g33v3i
         CWoCOPGILs+u7fpkSz4rSibyd8ZmGuv1LI0qML6E7ELjNq9tSPkjt45w/+Ky5DjUEp
         UCw5HnA6k92XlD00WuxlgYgWz9mC4SoOIrGvvRBlfqhUtrv1fFMjgcj7hSK8RksdUi
         58PpdVwukn3k+GwdElgFuIZEgabCZF9OTjH1YhowQm1PHnzrnp1HJqIo25LRhlCBlx
         4OWwzN+jbwWvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 11:23 PM, Christoph Hellwig wrote:
> On Wed, Nov 13, 2019 at 04:47:38PM -0800, Dan Williams wrote:
>>> Got it. This will appear in the next posted version of my "mm/gup: track
>>> dma-pinned pages: FOLL_PIN, FOLL_LONGTERM" patchset.
>>
>> Thanks!
> 
> John - can you please send a small series just doing the zone device
> patches rework?  That way we can review it separately and maybe even get
> it into 5.5.
> 

Sure.


thanks,
-- 
John Hubbard
NVIDIA
