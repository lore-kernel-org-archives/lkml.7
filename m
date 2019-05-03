Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A102075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfECI5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:57:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:44380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfECI5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:57:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343004022"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 01:57:44 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 0/2] perf, intel: Add support for PEBS output to Intel PT
In-Reply-To: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
Date:   Fri, 03 May 2019 11:57:43 +0300
Message-ID: <87o94jykxk.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Peter,
>
> New PEBS feature: output to Intel PT stream instead of the DS area. It's
> theoretically useful in virtualized environments, where DS area can't be
> used. It's also good for those who are interested in instruction trace for
> context of the PEBS events. As PEBS goes, it can provide LBR context with
> all the branch-related information that PT doesn't provide at the moment.
>
> PEBS records are packetized in the PT stream, so instead of extracting
> them in the PMI, we leave it to the perf tool, because real time PT
> decoding is not practical. Tooling patches are not included, but can be
> found here [1].
>
> Added is an attribute bit 'aux_source' to mean that an event is a source of
> AUX data. This bit enables PEBS output to PT.

Forgot to CC Kan.

Regards,
--
Alex
