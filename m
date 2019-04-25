Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EAAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8F8217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfDYH4D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:56:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:27470 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfDYH4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:56:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="164917971"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2019 00:56:01 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:56:01 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:56:01 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.149]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:55:59 +0800
From:   "Du, Fan" <fan.du@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: RE: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
Thread-Topic: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
Thread-Index: AQHU+wg4wWYFBheblUa8IPBSvnCJwqZL5rWAgACUV7D//39ggIAAhyuw
Date:   Thu, 25 Apr 2019 07:55:58 +0000
Message-ID: <5A90DA2E42F8AE43BC4A093BF067884825785F50@SHSMSX104.ccr.corp.intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
 <20190425063807.GK12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785F04@SHSMSX104.ccr.corp.intel.com>
 <20190425074841.GN12751@dhcp22.suse.cz>
In-Reply-To: <20190425074841.GN12751@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGMzZGYyNWMtN2QxZi00Yjc4LTgzMzYtZjIzZWNhM2YyNzE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid1d2NmNCdTJDVUl5THJXMHROcGtHNlJROWlSY0RZc1NlYzJsMmRuckdSb2RFU0xkd2Ewam1TSGVLYXljazlWTSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
>Behalf Of Michal Hocko
>Sent: Thursday, April 25, 2019 3:49 PM
>To: Du, Fan <fan.du@intel.com>
>Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
>Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
>ZONELIST_FALLBACK_SAME_TYPE fallback list
>
>On Thu 25-04-19 07:43:09, Du, Fan wrote:
>>
>>
>> >-----Original Message-----
>> >From: Michal Hocko [mailto:mhocko@kernel.org]
>> >Sent: Thursday, April 25, 2019 2:38 PM
>> >To: Du, Fan <fan.du@intel.com>
>> >Cc: akpm@linux-foundation.org; Wu, Fengguang
><fengguang.wu@intel.com>;
>> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
>> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
>> ><ying.huang@intel.com>; linux-mm@kvack.org;
>linux-kernel@vger.kernel.org
>> >Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
>> >ZONELIST_FALLBACK_SAME_TYPE fallback list
>> >
>> >On Thu 25-04-19 09:21:35, Fan Du wrote:
>> >> On system with heterogeneous memory, reasonable fall back lists woul
>be:
>> >> a. No fall back, stick to current running node.
>> >> b. Fall back to other nodes of the same type or different type
>> >>    e.g. DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node
>3
>> >> c. Fall back to other nodes of the same type only.
>> >>    e.g. DRAM node 0 -> DRAM node 1
>> >>
>> >> a. is already in place, previous patch implement b. providing way to
>> >> satisfy memory request as best effort by default. And this patch of
>> >> writing build c. to fallback to the same node type when user specify
>> >> GFP_SAME_NODE_TYPE only.
>> >
>> >So an immediate question which should be answered by this changelog.
>Who
>> >is going to use the new gfp flag? Why cannot all allocations without an
>> >explicit numa policy fallback to all existing nodes?
>>
>> PMEM is good for frequently read accessed page, e.g. page cache(implicit
>page
>> request), or user space data base (explicit page request)
>> For now this patch create GFP_SAME_NODE_TYPE for such cases, additional
>> Implementation will be followed up.
>
>Then simply configure that NUMA node as movable and you get these
>allocations for any movable allocation. I am not really convinced a new
>gfp flag is really justified.

Case 1: frequently write and/or read accessed page deserved to DRAM
Case 2: frequently read accessed page deserved to PMEM

We need something like a new gfp flag to sort above two cases out
From each other.

>--
>Michal Hocko
>SUSE Labs

