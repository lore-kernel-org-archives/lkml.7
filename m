Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD6ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFD4218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfJONbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:31:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:18418 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfJONbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:31:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 06:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="395532726"
Received: from spandruv-mobl3.jf.intel.com ([10.254.34.58])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2019 06:31:47 -0700
Message-ID: <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Date:   Tue, 15 Oct 2019 06:31:46 -0700
In-Reply-To: <20191015084833.GD2311@hirez.programming.kicks-ass.net>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
         <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
         <20191015084833.GD2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 10:48 +0200, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 02:21:00PM -0700, Srinivas Pandruvada wrote:
> > Some modern systems have very tight thermal tolerances. Because of
> > this
> > they may cross thermal thresholds when running normal workloads
> > (even
> > during boot). The CPU hardware will react by limiting
> > power/frequency
> > and using duty cycles to bring the temperature back into normal
> > range.
> > 
> > Thus users may see a "critical" message about the "temperature
> > above
> > threshold" which is soon followed by "temperature/speed normal".
> > These
> > messages are rate limited, but still may repeat every few minutes.
> > 
> > The solution here is to set a timeout when the temperature first
> > exceeds
> > the threshold.
> 
> Why can we even reach critical thresholds when the fans are working?
> I
> always thought it was BAD to ever reach the critical temps and have
> the
> hardware throttle.
CPU temperature doesn't have to hit max(TjMax) to get these warnings.
OEMs has an ability to program a threshold where a thermal interrupt
can be generated. In some systems the offset is 20C+ (Read only value).

In recent systems, there is another offset on top of it which can be
programmed by OS, once some agent can adjust power limits dynamically.
By default this is set to low by the firmware, which I guess the prime
motivation of Benjamin to submit the patch.

Thanks,
Srinivas



