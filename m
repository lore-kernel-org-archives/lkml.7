Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228992084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfHMOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:05:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:23725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfHMOFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 07:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="183879780"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2019 07:05:46 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v6 7/7] perf intel-pt: Add brief documentation for PEBS via Intel PT
In-Reply-To: <20190813135149.GA3754@redhat.com>
References: <20190806084606.4021-1-alexander.shishkin@linux.intel.com> <20190806084606.4021-8-alexander.shishkin@linux.intel.com> <20190813135149.GA3754@redhat.com>
Date:   Tue, 13 Aug 2019 17:05:46 +0300
Message-ID: <87imr12m9x.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@redhat.com> writes:

> Em Tue, Aug 06, 2019 at 11:46:06AM +0300, Alexander Shishkin escreveu:
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> 
>> Document how to select PEBS via Intel PT and how to display synthesized
>> PEBS samples.
>> 
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> ---
>>  tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
>> index 50c5b60101bd..8dc513b6607b 100644
>> --- a/tools/perf/Documentation/intel-pt.txt
>> +++ b/tools/perf/Documentation/intel-pt.txt
>> @@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
>>  
>>  Note there is currently no advantage to using Intel PT instead of LBR, but
>>  that may change in the future if greater use is made of the data.
>> +
>> +
>> +PEBS via Intel PT
>> +=================
>> +
>> +Some hardware has the feature to redirect PEBS records to the Intel PT trace.
>> +Recording is selected by using the aux-output config term e.g.
>> +
>> +	perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
>> +
>> +Note that currently, software only supports redirecting at most one PEBS event.
>
> So, with these patches, but not the kernel ones I end up getting:
>
> [root@quaco ~]# perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname

FWIW, the correct command line for that would have the two events
grouped and intel_pt be the group leader.

Regards,
--
Alex
