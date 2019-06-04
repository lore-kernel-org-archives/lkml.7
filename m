Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3E9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35602075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rQWBsgW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFDT3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:29:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1632 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:29:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf6c6ae0000>; Tue, 04 Jun 2019 12:29:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 12:29:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Jun 2019 12:29:52 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 19:29:52 +0000
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Pingfan Liu <kernelfans@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        <linux-kernel@vger.kernel.org>, Sanket Murti <smurti@nvidia.com>,
        "Ralph Pattinson" <rpattinson@nvidia.com>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org>
 <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4b448fa6-dd85-ca45-5cb8-d2c950bddf37@nvidia.com>
Date:   Tue, 4 Jun 2019 12:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559676591; bh=L5ssfsr4CdbgOzijHbr9sPxMKKvikmBYGkIxWSlzZPI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rQWBsgW5BRDGBf1MYzgpB3Q35yRaA45Lx6vyonOmAVTZnpSbwf2zHeSvs8Yh0CtyO
         yhGbnjVHZsxQ5JRJtlCOI63vBIro0O+7q/ZqJChiGfgFQ7rX9uXSFWZNlqbwRei6tx
         Wppl46/8Xx/ObqeQ/f5M8qolzh+OKE4Qj2NM666ELlnpWDyKZgOEtM35jz1Nn8qOit
         VEDsbi7C6JAONUUIsKyZHjIMJ3mR9A0K80wih6aJYiEEMsA3vIynzzmfbveBjY0N6T
         4gtxYjsCF2R7ZgYG9suvbq7rEE/CjgnJkNMDF+eAh9df3xa4fJ2Pof2ndbE7KfBelY
         YtdL+BuoLdNBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 4:56 PM, Ira Weiny wrote:
> On Mon, Jun 03, 2019 at 09:42:06AM -0700, Christoph Hellwig wrote:
>>> +#if defined(CONFIG_CMA)
>>
>> You can just use #ifdef here.
>>
>>> +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
>>> +	struct page **pages)
>>
>> Please use two instead of one tab to indent the continuing line of
>> a function declaration.
>>
>>> +{
>>> +	if (unlikely(gup_flags & FOLL_LONGTERM)) {
>>
>> IMHO it would be a little nicer if we could move this into the caller.
> 
> FWIW we already had this discussion and thought it better to put this here.
> 
> https://lkml.org/lkml/2019/5/30/1565
> 
> Ira
> 
> [PS John for some reason your responses don't appear in that thread?]


Thanks for pointing out the email glitches! It looks like it's making it over to
lore.kernel.org/linux-mm, but not to lkml.org, nor to the lore.kernel.org/lkml 
section either:

    https://lore.kernel.org/linux-mm/e389551e-32c3-c9f2-2861-1a8819dc7cc9@nvidia.com/

...and I've already checked the DKIM signatures, they're all good. So I think this
is getting narrowed down to, messages from nvidia.com (or at least from me) are not
making it onto the lkml list server.  I'm told that this can actually happen *because*
of DKIM domains: list servers may try to avoid retransmitting from DKIM domains. sigh.

Any hints are welcome, otherwise I'll try to locate the lkml admins and see what can
be done.

(+Sanket, Ralph from our email team)


thanks,
-- 
John Hubbard
NVIDIA
 
