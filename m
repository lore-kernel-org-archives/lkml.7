Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C03AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE12087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfCLOpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:45:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:12005 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCLOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:44:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 07:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="327901946"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2019 07:44:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43F291D4; Tue, 12 Mar 2019 16:44:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/5] auxdisplay: Introduce charlcd_free()
Date:   Tue, 12 Mar 2019 16:44:27 +0200
Message-Id: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have found a memory leak in hd44780 and it becomes that we have no
counterpart to charlcd_alloc() that developers can easily miss.

So, this series fixes a leak and introduces the charlcd_free().

In v2:
- add new patch to convert to_priv() to charlcd_to_priv()
- address Geert's comment what should be freed

Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Andy Shevchenko (5):
  auxdisplay: hd44780: Fix memory leak on ->remove()
  auxdisplay: charlcd: Move to_priv() to charlcd namespace
  auxdisplay: charlcd: Introduce charlcd_free() helper
  auxdisplay: panel: Convert to use charlcd_free()
  auxdisplay: hd44780: Convert to use charlcd_free()

 drivers/auxdisplay/charlcd.c | 32 +++++++++++++++++++-------------
 drivers/auxdisplay/hd44780.c |  4 +++-
 drivers/auxdisplay/panel.c   |  4 ++--
 include/misc/charlcd.h       |  1 +
 4 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.20.1

