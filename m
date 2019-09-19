Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DDC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D0A217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fxu3TNsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbfISRRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:17:41 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36646 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388943AbfISRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568913460; x=1600449460;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7/ufa7vNDq03J7rJcwWzKdIosJz93JtbhFQOq7c9jEc=;
  b=fxu3TNsXK9z6BXrhC5c3DYyzq+5mBk9HRhqIX1B/7CcZvwSWVrHR/JnQ
   cKsG4RTe6bRlt+nv+Ns70+qmitrE8KGGaYNGzLQQXE2Sz9ERSkGS8Vzm8
   c2OO0KlBo4YQCuTvRU/Q+rd0lq4qEsRuAo77bwV9ZgB7ZP8OOdAzoJDo7
   0=;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="416145656"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 19 Sep 2019 17:17:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 60E14A00AA;
        Thu, 19 Sep 2019 17:17:35 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 17:17:34 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.160.5) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 17:17:27 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v3 0/2] Add an API for edac device, for mulriple errors
Date:   Thu, 19 Sep 2019 18:17:11 +0100
Message-ID: <20190919171713.8060-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.5]
X-ClientProxiedBy: EX13D06UWC002.ant.amazon.com (10.43.162.205) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API for EDAC device to report for multiple errors, and move the
old report function to use the new API.

Changes from v2:
----------------
- Remove copy of edac_device_handle_*() functions, modify the existing
functions.

Changes from v1:
----------------
- use 'unsigned int' instead of u16
- update variable name to be count
- remove WARN_ON and simply exit if count is zero
- add inline functions in header file

Hanna Hawa (2):
  edac: Add an API for edac device to report for multiple errors
  edac: move edac_device_handle_*() API functions to header

 drivers/edac/edac_device.c | 50 +++++++++++++++++-------------
 drivers/edac/edac_device.h | 63 ++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 37 deletions(-)

-- 
2.17.1

