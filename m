Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B45BECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533B3207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439339AbfJPWON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:14:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:64007 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405224AbfJPWOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:14:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 15:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="208057636"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2019 15:14:09 -0700
Subject: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, dan.j.williams@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 16 Oct 2019 15:11:48 -0700
Message-Id: <20191016221148.F9CCD155@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're starting to see systems with more and more kinds of memory such
as Intel's implementation of persistent memory.

Let's say you have a system with some DRAM and some persistent memory.
Today, once DRAM fills up, reclaim will start and some of the DRAM
contents will be thrown out.  Allocations will, at some point, start
falling over to the slower persistent memory.

That has two nasty properties.  First, the newer allocations can end
up in the slower persistent memory.  Second, reclaimed data in DRAM
are just discarded even if there are gobs of space in persistent
memory that could be used.

This set implements a solution to these problems.  At the end of the
reclaim process in shrink_page_list() just before the last page
refcount is dropped, the page is migrated to persistent memory instead
of being dropped.

While I've talked about a DRAM/PMEM pairing, this approach would
function in any environment where memory tiers exist.

This is not perfect.  It "strands" pages in slower memory and never
brings them back to fast DRAM.  Other things need to be built to
promote hot pages back to DRAM.

This is part of a larger patch set.  If you want to apply these or
play with them, I'd suggest using the tree from here.  It includes
autonuma-based hot page promotion back to DRAM:

	http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
