Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECFB2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCKU2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:28:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:34729 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKU2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:28:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="124572202"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2019 13:28:49 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 00DAC301E30; Mon, 11 Mar 2019 13:28:48 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:28:48 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] perf, tools, stat: Avoid memory overrun with -r
Message-ID: <20190311202848.GC29294@tassilo.jf.intel.com>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-3-andi@firstfloor.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:38PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When -r is used memory would get corrupted because the evsel->id array
> would get overrun. evsel->ids is a running counter of the last id.
> Normally this works fine, but with -r the same event is initialized
> multiple times, but not this counter, so it would keep growing
> beyond the array limit and corrupt random memory.
> 
> Always reinitialize ->ids, and also add an assert to catch
> such overruns in the future.
> 
> This fixes a perf segfault when running it from toplev.

This one should be Cc: stable

-Andi
