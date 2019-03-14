Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6977C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A489821874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jpTdb9Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCNUhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:37:07 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18794 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCNUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:37:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8abb740000>; Thu, 14 Mar 2019 13:37:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 14 Mar 2019 13:37:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 14 Mar 2019 13:37:06 -0700
Received: from ngvpn01-165-234.dyn.scz.us.nvidia.com (10.124.1.5) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 14 Mar 2019 20:37:06 +0000
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
To:     William Kucharski <william.kucharski@oracle.com>,
        Jan Kara <jack@suse.cz>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Christopher Lameter <cl@linux.com>,
        Jerome Glisse <jglisse@redhat.com>, <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
 <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
 <20190314090345.GB16658@quack2.suse.cz> <20190314125718.GO20037@ziepe.ca>
 <20190314133038.GJ16658@quack2.suse.cz>
 <3AF66C8F-F4BC-4413-A01C-3C90A3C27B28@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b3090734-7250-8ee6-8c15-661ad8177c11@nvidia.com>
Date:   Thu, 14 Mar 2019 13:37:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <3AF66C8F-F4BC-4413-A01C-3C90A3C27B28@oracle.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552595828; bh=DgWsHZ14WtEAfPFOWW1z2Gf+RMCUzw4CBvC7Or4dKYg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jpTdb9OciKuyWNtxC/d1OlI3Sd/Cq6Uwi8BEbaAuli5lMpDCFIslwzEtCyWQ5s9pP
         yag3egLlxKb8JoNaDiA5B3fNolLhyACXMoRdr/CfWKdrXNxpa1KELCWTkXhllRS3o9
         Lt9cApp1NapXxvVHOb6o60T2AYiZinJGfejLmjcPv3B6e36Z5tlCoo7ZbWLmC+NUHP
         7PEcdjTc7yLcVPTB6YbHvX1zefygfGRi2pRuVIqA5zS5SAugjNEAnWO/Tdr3cprYNO
         SPIs3ifMB1H8GsXj+PnE3iEybhHN0PyHvCO/gOJBJgw3mRMbFwMwfyPs1FOj56faEv
         OFY3y4rNhAhLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 1:25 PM, William Kucharski wrote:
> 
> 
>> On Mar 14, 2019, at 7:30 AM, Jan Kara <jack@suse.cz> wrote:
>>
>> Well I have some crash reports couple years old and they are not from QA
>> departments. So I'm pretty confident there are real users that use this in
>> production... and just reboot their machine in case it crashes.
> 
> Do you know what the use case in those crashes actually was?
> 
> I'm curious to know they were actually cases of say DMA from a video
> capture card or if the uses posited to date are simply theoretical.


It's not merely theoretical. In addition to Jan's bug reports, I've
personally investigated a bug that involved an GPU (acting basically as
an AI accelerator in this case) that was doing DMA to memory that turned
out to be file backed.

The backtrace for that is in the commit description.

As others have mentioned, this works well enough to lure people into
using it, but then fails when you load down a powerful system (and put
it under memory pressure).

I think that as systems get larger, and more highly threaded, we might
see more such failures--maybe even in the Direct IO case someday,
although so far that race window is so small that that one truly is
still theoretical (or, we just haven't been in communication with
anyone who hit it).

thanks,
-- 
John Hubbard
NVIDIA

> 
> It's always good to know who might be doing this and why if for no other
> reason than as something to keep in mind when designing future interfaces.
> 
