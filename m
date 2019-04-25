Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC5BC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8E218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfDYIFn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:05:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:21957 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387417AbfDYIFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:05:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 01:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="145575472"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2019 01:05:42 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 01:05:41 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 01:05:41 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.93]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 16:05:39 +0800
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
Subject: RE: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory
 system
Thread-Topic: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory
 system
Thread-Index: AQHU+wguqC0/BskpLkaHU1TotE//DKZL5oWAgACMEvD//4lJgIAAhy/Q
Date:   Thu, 25 Apr 2019 08:05:38 +0000
Message-ID: <5A90DA2E42F8AE43BC4A093BF067884825785F6E@SHSMSX104.ccr.corp.intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <20190425063727.GJ12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785EE8@SHSMSX104.ccr.corp.intel.com>
 <20190425075353.GO12751@dhcp22.suse.cz>
In-Reply-To: <20190425075353.GO12751@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjQzYjI5MDEtYzA0OC00YjFhLWExZWQtNjI0ZDFlYWYwMGU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOGxlSk84SDgyWVM3akFtZ2ozbkpSdXh2SlhoaEh1ZmJpaE13cjJCa1wvWlZzNFwvd1NTZlJqRXZlVFdaMTEzS0lGIn0=
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
>Sent: Thursday, April 25, 2019 3:54 PM
>To: Du, Fan <fan.du@intel.com>
>Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
>Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous
>memory system
>
>On Thu 25-04-19 07:41:40, Du, Fan wrote:
>>
>>
>> >-----Original Message-----
>> >From: Michal Hocko [mailto:mhocko@kernel.org]
>> >Sent: Thursday, April 25, 2019 2:37 PM
>> >To: Du, Fan <fan.du@intel.com>
>> >Cc: akpm@linux-foundation.org; Wu, Fengguang
><fengguang.wu@intel.com>;
>> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
>> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
>> ><ying.huang@intel.com>; linux-mm@kvack.org;
>linux-kernel@vger.kernel.org
>> >Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous
>> >memory system
>> >
>> >On Thu 25-04-19 09:21:30, Fan Du wrote:
>> >[...]
>> >> However PMEM has different characteristics from DRAM,
>> >> the more reasonable or desirable fallback style would be:
>> >> DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3.
>> >> When DRAM is exhausted, try PMEM then.
>> >
>> >Why and who does care? NUMA is fundamentally about memory nodes
>with
>> >different access characteristics so why is PMEM any special?
>>
>> Michal, thanks for your comments!
>>
>> The "different" lies in the local or remote access, usually the underlying
>> memory is the same type, i.e. DRAM.
>>
>> By "special", PMEM is usually in gigantic capacity than DRAM per dimm,
>> while with different read/write access latency than DRAM.
>
>You are describing a NUMA in general here. Yes access to different NUMA
>nodes has a different read/write latency. But that doesn't make PMEM
>really special from a regular DRAM. 

Not the numa distance b/w cpu and PMEM node make PMEM different than
DRAM. The difference lies in the physical layer. The access latency characteristics
comes from media level.

>There are few other people trying to
>work with PMEM as NUMA nodes and these kind of arguments are repeating
>again and again. So far I haven't really heard much beyond hand waving.
>Please go and read through those discussion so that we do not have to go
>throug the same set of arguments again.
>
>I absolutely do see and understand people want to find a way to use
>their shiny NVIDIMs but please step back and try to think in more
>general terms than PMEM is special and we have to treat it that way.
>We currently have ways to use it as DAX device and a NUMA node then
>focus on how to improve our NUMA handling so that we can get maximum
>out
>of the HW rather than make a PMEM NUMA node a special snow flake.
>
>Thank you.
>
>--
>Michal Hocko
>SUSE Labs

