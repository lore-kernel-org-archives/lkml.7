Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31390C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F281421850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfB1K5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:57:32 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:12666 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727810AbfB1K5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:57:32 -0500
X-Greylist: delayed 1516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2019 05:57:31 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x1SAVbFZ086882
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:31:37 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x1SAUwQJ086776;
        Thu, 28 Feb 2019 18:30:58 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 28 Feb 2019
 18:31:36 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>, <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 0/3] riscv: Fix debug instruction check and support trap-based WARN()
Date:   Thu, 28 Feb 2019 18:31:28 +0800
Message-ID: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x1SAUwQJ086776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handler for the debug exception will call is_valid_bugaddr(bugaddr) to
check if the instruction in bugaddr is a real debug instruction. However,
the expected instruction, ebreak, is possibly translated to c.ebreak by 
assmebler when C extension is supported. This patchset will add c.ebreak
into the check mechanism. In addition, BUG() is currently unable to work in
the kernel module due to an inappropriated condition in is_valid_bugaddr().
This issue will be fixed in this patchset. Finally, this patchset enables
WARN() related functions to trap the code to help developers debug it.





Vincent Chen (3):
  riscv: Add the support for c.ebreak check in is_valid_bugaddr()
  riscv: Support BUG() in kernel module
  riscv: Make WARN() related functions able to trigger a trap exception


