Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2422133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCRTPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:15:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:38402 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfCRTPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:15:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 12:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="156107020"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2019 12:15:04 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 00/10] HID: intel-ish-hid: Clean up external interfaces
Date:   Mon, 18 Mar 2019 12:14:18 -0700
Message-Id: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOT FOR kernel v5.1.

v2
- Rebased on the top of
"HID: intel-ish: enable raw interface to HID devices on ISH"
which Jiri already applied.
- Also exported devc pointer for DMA

No functional changes are expected with this series. I am posting this now
because of usage of ISH in ChromeOS Embedded Controller.
https://lkml.org/lkml/2019/2/24/26
I want to make sure that API is restricted before more development and posting
there.

Currently only one ISH client is using ISH transport. But it is changing now
with the development of other clients using ISH transport. Some of these
clients which are targeted for Linux based OS only laptops, are not using
HID to export sensors. As more clients are getting developed it is important
that the external interface for ISH transport only allows what clients need.
Currently the header files used by clients "client.h" and "ishtp-dev.h"
include other ISH header files. Also clients access fields from structure
which also has other fields which are only used by ISH transort.

So this series introduces one header file "linux/intel-ish-client-if.h".
This header files doesn't include any other ISH transport header files.
There are interface functions defined so that clients never have to directly
access any ISH transort structures.
Also clients don't have to match there GUID in probe. They will be only
probbed if their GUID matches, which is passed as driver registry. 


Hong Liu (1):
  HID: intel-ish-hid: Add match callback to ishtp bus type

Srinivas Pandruvada (9):
  HID: intel-ish-hid: Hide members of struct ishtp_cl_device
  HID: intel-ish-hid: Simplify ishtp_cl_link()
  HID: intel-ish-hid: Move driver registry functions
  HID: intel-ish-hid: Store ishtp_cl_device instance in device
  HID: intel-ish-hid: Move the common functions from client.h
  HID: intel-ish-hid: Add interface functions for struct ishtp_cl
  HID: intel-ish-hid: Move functions related to bus and device
  HID: intel-ish-hid: Use the new interface functions in HID ish client
  HID: intel-ish-hid: Add interface function for PCI device pointer

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 131 ++++++++++---------
 drivers/hid/intel-ish-hid/ishtp-hid.c        |   6 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |   6 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c        |  96 +++++++++++++-
 drivers/hid/intel-ish-hid/ishtp/bus.h        |  37 +-----
 drivers/hid/intel-ish-hid/ishtp/client.c     |  60 +++++++--
 drivers/hid/intel-ish-hid/ishtp/client.h     |  24 ----
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  31 -----
 include/linux/intel-ish-client-if.h          | 112 ++++++++++++++++
 9 files changed, 325 insertions(+), 178 deletions(-)
 create mode 100644 include/linux/intel-ish-client-if.h

-- 
2.17.2

