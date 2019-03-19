Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28B32146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cEUH3Lqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCSTCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:02:35 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12311 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCSTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:02:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c913cb90000>; Tue, 19 Mar 2019 12:02:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 12:02:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Mar 2019 12:02:33 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Mar
 2019 19:02:32 +0000
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Jerome Glisse <jglisse@redhat.com>, <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com> <20190319141416.GA3879@redhat.com>
 <20190319142918.6a5vom55aeojapjp@kshutemo-mobl1>
 <20190319153644.GB26099@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <99882bf1-1db8-fd2c-cc72-2a6ea8ea4f89@nvidia.com>
Date:   Tue, 19 Mar 2019 12:02:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319153644.GB26099@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553022138; bh=NZoJbC8WOTr0NdLPHDxUPPIt9/DJYfgztYt8n26Np0U=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cEUH3Lqw9UBui8Fl9HmBEvNVfx73iPEdZqVl+LLKqXgHVwB0VcSbDy385l75xJqu5
         331YZ/UQtFcSBuZnrKiQz6kQOIs07Y/L9OVI0ot2hjFtbEzxLPlHH6RHrAxg5oRzHy
         7jnl03iZU4oMHJiDR4HmuuR04+8nBrMtK1y4qb3b38mhnm4ZNsfBH9v88Pw5q+3XHh
         1L4YW/u593GRa+5uQQo71uYfBXVoLojpt+lxUXMJKnsIY9pWVT/vLyfF57No+6qBeJ
         RUvCPIT0OiytlsDBsz/EGmWiyI2RDo/55GN4obyJ++mj4Ll3E8oWcXLEgy2jbDWpZd
         8AHmcW7zcs33g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 8:36 AM, Jan Kara wrote:
> On Tue 19-03-19 17:29:18, Kirill A. Shutemov wrote:
>> On Tue, Mar 19, 2019 at 10:14:16AM -0400, Jerome Glisse wrote:
>>> On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
>>>> On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
>>>>> On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
>>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>> [...]
>>> Forgot to mention one thing, we had a discussion with Andrea and Jan
>>> about set_page_dirty() and Andrea had the good idea of maybe doing
>>> the set_page_dirty() at GUP time (when GUP with write) not when the
>>> GUP user calls put_page(). We can do that by setting the dirty bit
>>> in the pte for instance. They are few bonus of doing things that way:
>>>     - amortize the cost of calling set_page_dirty() (ie one call for
>>>       GUP and page_mkclean()
>>>     - it is always safe to do so at GUP time (ie the pte has write
>>>       permission and thus the page is in correct state)
>>>     - safe from truncate race
>>>     - no need to ever lock the page
>>>
>>> Extra bonus from my point of view, it simplify thing for my generic
>>> page protection patchset (KSM for file back page).
>>>
>>> So maybe we should explore that ? It would also be a lot less code.
>>
>> Yes, please. It sounds more sensible to me to dirty the page on get, not
>> on put.
> 
> I fully agree this is a desirable final state of affairs. And with changes
> to how we treat pinned pages during writeback there won't have to be any
> explicit dirtying at all in the end because the page is guaranteed to be
> dirty after a write page fault and pin would make sure it stays dirty until
> unpinned. However initially I want the helpers to be as close to code they
> are replacing as possible. Because it will be hard to catch all the bugs
> due to driver conversions even in that situation. So I still think that
> these helpers as they are a good first step. Then we need to convert
> GUP users to use them and then it is much easier to modify the behavior
> since it is no longer opencoded in two hudred or how many places...
> 
> 								Honza

In fact, we had this very same question come up last month [1]: I was also
wondering if we should just jump directly to the final step, and not
do the dirtying call, but it is true that during the conversion process,
(which effectively wraps put_page(), without changing anything else),
it's safer to avoid changing things. 

The whole system is fragile because it's running something that has some 
latent bugs in this area, so probably best to do it the way Jan says, and 
avoid causing any new instances of reproducing this problem, even though 
there is a bit more churn involved.


[1] https://lore.kernel.org/r/20190205112107.GB3872@quack2.suse.cz

thanks,
-- 
John Hubbard
NVIDIA
