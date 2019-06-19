Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ABFC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396CE2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfFSCEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:04:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:50525 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSCEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 19:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,391,1557212400"; 
   d="scan'208";a="162064481"
Received: from unknown (HELO localhost) ([10.239.159.128])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2019 19:04:36 -0700
From:   Weijiang Yang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com,
        jmattson@google.com, yu.c.zhang@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH 0/1] selftest for SPP feature
Date:   Wed, 19 Jun 2019 10:02:59 +0800
Message-Id: <20190619020300.30392-1-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Weijiang <weijiang.yang@intel.com>

Sub-Page Permission(SPP) is to protect finer granularity subpages
(128Byte each) within a 4KB page. 
There're three specific ioctls for the feature in KVM:
KVM_INIT_SPP - initialize SPP runtime environment 
KVM_SUBPAGES_SET_ACCESS - set SPP protection for guest page
KVM_SUBPAGES_GET_ACCESS - get SPP permission bits for guest page
This selftest uses these ioctls to verify whether SPP is working
on SPP powered platforms.

test results:
--------------------------------------------------------------------------
SPP protected zone: size = 4096, gva = 0x700000, gpa = 0x10001000, hva =
0x0x7f6ff3b92000
SPP initialized successfully.
set spp protection info: gfn = 0x10001, access = 0x0, npages = 1
get spp protection info: gfn = 0x10001, access = 0x0, npages = 1
got matched subpage permission vector.
expect VM exits caused by SPP below.
1 - exit reason: SPP
2 - exit reason: SPP
3 - exit reason: SPP
4 - exit reason: SPP
5 - exit reason: SPP
6 - exit reason: SPP
7 - exit reason: SPP
8 - exit reason: SPP
9 - exit reason: SPP
10 - exit reason: SPP
11 - exit reason: SPP
12 - exit reason: SPP
13 - exit reason: SPP
14 - exit reason: SPP
15 - exit reason: SPP
16 - exit reason: SPP
17 - exit reason: SPP
18 - exit reason: SPP
19 - exit reason: SPP
20 - exit reason: SPP
21 - exit reason: SPP
22 - exit reason: SPP
23 - exit reason: SPP
24 - exit reason: SPP
25 - exit reason: SPP
26 - exit reason: SPP
27 - exit reason: SPP
28 - exit reason: SPP
29 - exit reason: SPP
30 - exit reason: SPP
31 - exit reason: SPP
32 - exit reason: SPP
total EPT violation count: 32
unset SPP protection at gfn: 0x10001
expect NO VM exits caused by SPP below.
completed SPP test successfully!
------------------------------------------------------------------------


Yang Weijiang (1):
  kvm: selftests: add selftest for SPP feature

 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
 tools/testing/selftests/kvm/x86_64/spp_test.c | 206 ++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/spp_test.c

-- 
2.17.2

