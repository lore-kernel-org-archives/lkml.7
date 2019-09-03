Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3264FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EDF23402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfICNXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:23:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:42171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICNXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:23:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 06:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="211986675"
Received: from ldu8-mobl3.ccr.corp.intel.com (HELO [10.254.208.158]) ([10.254.208.158])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2019 06:23:41 -0700
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     "He, Min" <min.he@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: About compiler memory barrier for atomic_set/atomic_read on x86
Message-ID: <256e8ee2-a23c-28e9-3988-8b77307c001a@intel.com>
Date:   Tue, 3 Sep 2019 21:23:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
There is one question regarding following commit:

commit 69d927bba39517d0980462efc051875b7f4db185
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Apr 24 13:38:23 2019 +0200

     x86/atomic: Fix smp_mb__{before,after}_atomic()

     Recent probing at the Linux Kernel Memory Model uncovered a
     'surprise'. Strongly ordered architectures where the atomic RmW
     primitive implies full memory ordering and
     smp_mb__{before,after}_atomic() are a simple barrier() (such as x86)

This change made atomic RmW operations include compiler barrier. And 
made __smp_mb__before_atomic/__smp_mb__after_atomic not include compiler
barrier any more for x86.

We face the issue to handle atomic_set/atomic_read which is mapped to
WRITE_ONCE/READ_ONCE on x86. These two functions don't include compiler
barrier actually (if operator size is less than 8 bytes).

Before the commit 69d927bba39517d0980462efc051875b7f4db185, we could use
__smp_mb__before_atomic/__smp_mb__after_atomic together with these two
functions to make sure the memory order. It can't work after the commit 
69d927bba39517d0980462efc051875b7f4db185. I am wandering whether
we should make atomic_set/atomic_read also include compiler memory
barrier on x86? Thanks.

Regards
Yin, Fengwei
