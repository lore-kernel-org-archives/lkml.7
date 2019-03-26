Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93655C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5767320811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfCZHCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:02:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:10826 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCZHCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:02:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 00:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="128698117"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 00:02:42 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Ben Gainey <Ben.Gainey@arm.com>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "acme\@redhat.com" <acme@redhat.com>,
        Will Deacon <Will.Deacon@arm.com>
Cc:     "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: BUG in "perf: Suppress AUX/OVERWRITE records"?
In-Reply-To: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com>
References: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com>
Date:   Tue, 26 Mar 2019 09:02:40 +0200
Message-ID: <87k1gm86en.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gainey <Ben.Gainey@arm.com> writes:

> Hi all
>
> Regarding commit 1627314fb54a33ebd23bd08f2e215eaed0f44712 "perf:
> Suppress AUX/OVERWRITE records", I have found that I no longer receive
> PERF_RECORD_AUX on context switch when collecting data from the arm_spe
> PMU driver. This is because, on context switch, the arm_spe driver
> calls perf_aux_output_end with `handle->aux_flags == 0`, failing the
> test added in this commit.
>
> This is a problem as it means when capturing data for multiple threads
> (using perf_event_open) where AUX data is written to a per-cpu buffer,
> I can no longer accurately attribute SPE AUX data to an individual
> thread.

Sounds like PERF_RECORD_SWITCH should be sufficient for your purposes,
have you considered that?

> If I read the intent of the commit as to remove OVERWRITE AUX records,
> then it seems the added if condition is incorrect and should probably
> be formulated as:
>
>     if ((handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE) || !handle-
>>aux_flags)
>
> Is this correct (and would you like a patch?), or is my use of
> PERF_RECORD_AUX incorrect in this case?

No, the point of AUX records is to communicate useful things about the
data in AUX buffer. It was an unintentional side effect that it also
happened to coincide with context switches in the overwrite mode.

Thanks,
--
Alex
