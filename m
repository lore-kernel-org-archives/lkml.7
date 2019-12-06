Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3983C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08221823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLFJtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:49:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64169 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLFJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:49:36 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id a94a341a3eddd6ac; Fri, 6 Dec 2019 10:49:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC][PATCH 0/6] cpuidle: intel_idle: Use ACPI _CTS to get idle states information
Date:   Fri, 06 Dec 2019 10:28:51 +0100
Message-ID: <2037014.bnAicLLH9b@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The purpose of this set of patches is to allow the intel_idle driver to use
C-states information from ACPI _CST on systems where the processor is not
recognized by it.

The first five patches are preparatory (please look into the changelogs for
details) and are not expected to make any functional difference.

The last patch adds ACPI _CST support to intel_idle so that _CST is used when
the driver does not have a dedicated list of C-states for the given processor.

The plan (for the future) is to also use _CST in some cases when there is a
list of C-states for the given processor in intel_idle in order to produce a
combined list in which some states may be disabled by default.

This has been lightly tested on a Dell XPS13 9360 (with an additional patch to
drop the Kaby Lake entries from intel_idle_ids[] which normally would prevent
intel_idle from registering itself as the cpuidle driver).  The difference
between using the idle states list from _CST and the built-in one generally is
that in the latter case the processor spends more time in package C-state when
the system is idle.

If there are any concerns about this series, please let me know.

Thanks,
Rafael



