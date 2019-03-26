Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B596C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C3520856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfCZLkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:40:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57958 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:40:16 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b1acf7c466be819c; Tue, 26 Mar 2019 12:40:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pprakash@codeaurora.org,
        wangxiongfeng2@huawei.com
Subject: Re: [PATCH v2 0/2] Correct the processing for base_frequency
Date:   Tue, 26 Mar 2019 12:38:17 +0100
Message-ID: <3574470.KuU4jANTQq@aspire.rjw.lan>
In-Reply-To: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
References: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 25, 2019 5:04:38 PM CET Srinivas Pandruvada wrote:
> The base_frequency display in cpufreq sysfs for intel_pstate gets the
> guaranteed ratio by reading CPPC guaranteed performance register as a
> first preference before falling back to x86 MSR for Hardware P-state
> Capabilities. The current code in cppc_acpi.c assumed that "guaranteed
> performance register" can be an integer field, which is invalid as per
> ACPI spec. So this change explicitly check for INTEGER values for
> invalid BIOS/firmware and ignore. 
> Also guaranteed performance register field is optional and when not
> present, nominal performance can be used as the guaranteed performance.
> But spec calls that this is true only in non-autonomous mode. So
> no change is made in cppc_acpi.c to make nominal as guaranteed in this
> case to avoid dependency on autonomous and non-autonomous mode. Instead
> a change is added to intel_pstate driver, which is specific to x86 to
> make nominal as guaranteed when guaranteed performance field is absent
> or has invalid value.
> Also we are working to clarify this non-autonomous mode requirement
> through ACPI standard body.
> 
> v2:
> Changes done as suggested by Rafael.
> 
> 
> Srinivas Pandruvada (2):
>   ACPI / CPPC: Fix processing for guaranteed performance
>   cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency
> 
>  drivers/acpi/cppc_acpi.c       | 9 +++++++--
>  drivers/cpufreq/intel_pstate.c | 5 ++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> 

Both applied, thanks!


