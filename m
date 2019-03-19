Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C30C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9EF20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pcr54m33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCSTYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:24:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9399 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfCSTYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:24:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9141d60000>; Tue, 19 Mar 2019 12:24:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 12:24:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Mar 2019 12:24:07 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Mar
 2019 19:24:07 +0000
Subject: Re: [PATCH v4 0/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Christopher Lameter <cl@linux.com>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <01000169972802f7-2d72ffed-b3a6-4829-8d50-cd92cda6d267-000000@email.amazonses.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <dc2499a6-4475-bea3-605a-7778ffcf76fc@nvidia.com>
Date:   Tue, 19 Mar 2019 12:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <01000169972802f7-2d72ffed-b3a6-4829-8d50-cd92cda6d267-000000@email.amazonses.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553023446; bh=B4FuCFgWwDXwO2PMosZVJcIQ7FyaY1g0iFVVlUcEXgc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Pcr54m33hAY5+G1DxNuTgqEP0O0rC1NZ1dS7TpgNqEtN58Do8NCaXyvPcCY9D7Ebt
         giBwXsvb/USudSDVE57EBMZsDeMVF20GRfInVh3nFfGKs4cmMUDvD0MH3OAbUqkRiS
         v1u1ksXJ7k+IVC/26xMvrmJOgsdOnTwTp6GV1gSjOVck6l3uugy88GR2eMgLhN2Yj6
         lfSp55JiL54qGodDwJN9Pfm+qXEloGPiLxh1PkVCKlvxvanF1zXUiXWs/nmt30QgP1
         IyyNtuER93PF2uPGSF3iKcraGVN8PyKsCwlcqIdHZO0Kk6ilXKt/Gb1qAbBuG0YLjL
         0ESRUpd2tDtPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 11:12 AM, Christopher Lameter wrote:
> On Fri, 8 Mar 2019, john.hubbard@gmail.com wrote:
> 
>> We seem to have pretty solid consensus on the concept and details of the
>> put_user_pages() approach. Or at least, if we don't, someone please speak
>> up now. Christopher Lameter, especially, since you had some concerns
>> recently.
> 
> My concerns do not affect this patchset which just marks the get/put for
> the pagecache. The problem was that the description was making claims that
> were a bit misleading and seemed to prescribe a solution.
> 
> So lets get this merged. Whatever the solution will be, we will need this
> markup.
> 

Sounds good. Do you care to promote that thought into a formal ACK for me? :)


thanks,
-- 
John Hubbard
NVIDIA
