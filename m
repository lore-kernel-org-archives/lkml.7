Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF7C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56920989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGESGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:06:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:36738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGESGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:06:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 11:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="248236591"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2019 11:06:47 -0700
Subject: [PATCH 0/3] [RFC] x86: start the MPX removal process
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 05 Jul 2019 10:53:17 -0700
Message-Id: <20190705175317.1B3C9C52@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPX requires recompiling applications, which requires compiler support.
Unfortunately, GCC 9.1 is expected to be be released without support for
MPX.  This means that there was only a relatively small window where
folks could have ever used MPX.  It failed to gain wide adoption in the
industry, and Linux was the only mainstream OS to ever support it widely.

Support for the feature may also disappear on future processors.

The benefits of keeping the feature in the tree is not worth the ongoing
maintenance cost.

It was a fun run, but it's time for it to go.  Adios, MPX!

This set starts the process, beginning with the removal of code that is
unlikely to cause any collateral damage.  The selftests have been
causing some trouble, so they along with the APIs are first to go.

This series is also available here, and will get some additional 0day
testing to ensure no funkiness:

	git://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx.git mpx-remove-201907

While there's no rocket science in here, this is probably not ready
to be pulled until 0day has the weekend to churn on it.

Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
