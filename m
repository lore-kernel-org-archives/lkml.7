Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF45CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA0821906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbfJWMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:34:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:51610 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732680AbfJWMe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:34:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 05:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="228109565"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2019 05:34:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 1/3] perf: Optimize perf_install_in_event()
In-Reply-To: <20191022092307.368892814@infradead.org>
References: <20191022092017.740591163@infradead.org> <20191022092307.368892814@infradead.org>
Date:   Wed, 23 Oct 2019 15:30:27 +0300
Message-ID: <874kzz4pb0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> +	/*
> +	 * perf_event_attr::disabled events will not run and can be initialized
> +	 * without IPI. Except when this is the first event for the context, in
> +	 * that case we need the magic of the IPI to set ctx->is_active.
> +	 *
> +	 * The IOC_ENABLE that is sure to follow the creation of a disabled
> +	 * event will issue the IPI and reprogram the hardware.
> +	 */
> +	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
> +		raw_spin_lock_irq(&ctx->lock);
> +		if (task && ctx->task == TASK_TOMBSTONE) {

Confused: isn't that redundant? If ctx->task reads TASK_TOMBSTONE, task
is always !NULL, afaict. And in any case, if a task context is going
away, we shouldn't probably be adding events there. Or am I missing
something?

Other than that, this makes sense to me, fwiw.

Regards,
--
Alex
