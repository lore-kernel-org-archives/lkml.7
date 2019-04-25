Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC320C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61A7218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDYJSJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:18:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:52354 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfDYJSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 02:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="167792309"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2019 02:18:06 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 02:18:06 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 02:18:05 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.42]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 17:18:04 +0800
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
Thread-Index: AQHU+wg4wWYFBheblUa8IPBSvnCJwqZL5rWAgACUV7D//39ggIAAhyuw//9+rQCAAIghcP//gTcAABHkxSA=
Date:   Thu, 25 Apr 2019 09:18:03 +0000
Message-ID: <5A90DA2E42F8AE43BC4A093BF067884825786020@SHSMSX104.ccr.corp.intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
 <20190425063807.GK12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785F04@SHSMSX104.ccr.corp.intel.com>
 <20190425074841.GN12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785F50@SHSMSX104.ccr.corp.intel.com>
 <20190425080936.GP12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785FA5@SHSMSX104.ccr.corp.intel.com>
 <20190425084302.GQ12751@dhcp22.suse.cz>
In-Reply-To: <20190425084302.GQ12751@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODQwNThjYmYtYmNiNi00Y2IxLTllY2QtZmFlNWEzYWU0OWM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMDM5V281XC94Zm1Yc2dwc1lqZnJCTDhmckFrZFBId2Rpc0t6TTJva1hJOTJJMk9acWZNRVZ1NHBrZ2JURWJMVVMifQ==
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
>Sent: Thursday, April 25, 2019 4:43 PM
>To: Du, Fan <fan.du@intel.com>
>Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
>Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
>ZONELIST_FALLBACK_SAME_TYPE fallback list
>
>On Thu 25-04-19 08:20:28, Du, Fan wrote:
>>
>>
>> >-----Original Message-----
>> >From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
>> >Behalf Of Michal Hocko
>> >Sent: Thursday, April 25, 2019 4:10 PM
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
>> >On Thu 25-04-19 07:55:58, Du, Fan wrote:
>> >> >> PMEM is good for frequently read accessed page, e.g. page
>cache(implicit
>> >> >> page
>> >> >> request), or user space data base (explicit page request)
>> >> >> For now this patch create GFP_SAME_NODE_TYPE for such cases,
>> >additional
>> >> >> Implementation will be followed up.
>> >> >
>> >> >Then simply configure that NUMA node as movable and you get these
>> >> >allocations for any movable allocation. I am not really convinced a new
>> >> >gfp flag is really justified.
>> >>
>> >> Case 1: frequently write and/or read accessed page deserved to DRAM
>> >
>> >NUMA balancing
>>
>> Sorry, I mean page cache case here.
>> Numa balancing works for pages mapped in pagetable style.
>
>I would still expect that a remote PMEM node access latency is
>smaller/comparable to the real storage so a promoting part is not that
>important for the unmapped pagecache. Maybe I am wrong here but that
>really begs for some experiments before we start adding special casing.

I understand your concern :), please refer to following summary from 3rd party.
https://arxiv.org/pdf/1903.05714.pdf


>--
>Michal Hocko
>SUSE Labs

