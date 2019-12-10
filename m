Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B49C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85220726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLJLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:55:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58344 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfLJLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:55:39 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 9eb461fbea0d2796; Tue, 10 Dec 2019 12:55:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC v2][PATCH 0/9] cpuidle: intel_idle: Use ACPI _CTS to get idle states information
Date:   Tue, 10 Dec 2019 12:54:55 +0100
Message-ID: <35821518.IbFVMVmUy3@kreacher>
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

The patch [6/9] adds ACPI _CST support to intel_idle so that _CST is used when
the driver does not have a dedicated list of C-states for the given processor.

Patch [7/9] is the same as https://patchwork.kernel.org/patch/11256815/.

Patch [8/9] changes intel_idle to also use ACPI _CST if there is a tables
of C-states for the given processor in the driver, in which case it will use
the _CST information to decide which C-state to enable by default.

The last patch adds a module parameter called "no_acpi" that can be used to
prevent intel_idle from using ACPI _CST via the kernel command line.

This has been lightly tested on a Dell XPS13 9360 (with an additional patch to
drop the Kaby Lake entries from intel_idle_ids[] which normally would prevent
intel_idle from registering itself as the cpuidle driver).  The difference
between using the idle states list from _CST and the built-in one generally is
that in the latter case the processor spends more time in package C-state when
the system is idle.

If there are any concerns about this series, please let me know.

Thanks,
Rafael



