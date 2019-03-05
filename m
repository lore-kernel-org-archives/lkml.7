Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92614C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC3206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCEKoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:44:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58787 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfCEKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:44:28 -0500
Received: from 79.184.253.110.ipv4.supernova.orange.pl (79.184.253.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id cc2b7da285b581c1; Tue, 5 Mar 2019 11:44:26 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 0/3] cpufreq: intel_pstate: Handle _PPC updates on global turbo disable/enable
Date:   Tue, 05 Mar 2019 11:23:48 +0100
Message-ID: <1755407.S0oJirvq9V@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a follow-up to the RFT patch set posted previously:
https://lore.kernel.org/lkml/9956076.F4luUDm1Dq@aspire.rjw.lan/

Patch [1/3] causes intel_pstate to update all policies if it gets a _PPC change
notification and sees a global turbo disable/enable change.

Patch [2/3] adds cpufreq_cpu_acquire() and cpufreq_cpu_release() to reduce
code duplication after the next patch a bit (and Srinivas wanted the rwsem
manipulation to not be done directly by the driver).

Patch [3/3] makes intel_pstate update cpuinfo.max_freq for all policies in
those cases.

I've atted Tested-by tags to patches [1/3] and [3/3], because there are only
cosmetic differences between them and what has been tested.

Thanks,
Rafael


