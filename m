Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734FD20659
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJYWYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:24:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:61612 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJYWYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:24:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 15:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="400249052"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.82])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 15:24:53 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: at net/sched/sch_generic.c:448
In-Reply-To: <20191024204134.egc5mdtz2o2tsxyz@linux-p48b>
References: <20191024032105.xmewznsphltnrido@linux-p48b> <87mudpylcc.fsf@linux.intel.com> <20191024204134.egc5mdtz2o2tsxyz@linux-p48b>
Date:   Fri, 25 Oct 2019 15:26:06 -0700
Message-ID: <875zkcxy0x.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Davidlohr Bueso <dave@stgolabs.net> writes:

> I am able to trigger this a few seconds into running pi_stress (from
> rt-tests, quite a non network workload). But this is not the only one.
> I'm going through some logs to see what other test is triggering it.

Looking at the at the caveats section of pi_stress(8), this is expected:

"The pi_stress test threads run as SCHED_FIFO or SCHED_RR threads, which
means that they can starve critical system threads. It is advisable to
change the scheduling policy of critical system threads to be SCHED_FIFO
prior to running pi_stress and use a priority of 10 or higher, to
prevent those threads from being starved by the stress test."

Are the other workloads similar to pi_stress?


Cheers,
--
Vinicius


