Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB47C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190A02081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mpoob6V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfILOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:54:14 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:41147 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732592AbfILOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568300053; x=1599836053;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iXXC6QHvhsukvUq7xWp72n4eTBHxcxsmsJia2V5Zs38=;
  b=mpoob6V7HZEEMVbTD7DnToIwYyKpJ4vremUz6R2+JQ8+9nH75sv4u5XA
   2vDPIhA8zeRel7jcXlCE7Bhpc9yqXNMaCIT1POfx8gQlzMA/dx1VO83NS
   vnLTq8sSW5b+XjHoq4XSAabBR5OhLuZFpRl1xlv9FGhk6HHiUqX7ZoeXo
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414933565"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 14:54:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 93FFBA2AE4;
        Thu, 12 Sep 2019 14:54:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 14:54:08 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.99) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 14:54:02 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v2 0/2] Add an API for edac device, for mulriple errors
Date:   Thu, 12 Sep 2019 15:53:03 +0100
Message-ID: <20190912145305.21008-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.99]
X-ClientProxiedBy: EX13D15UWA002.ant.amazon.com (10.43.160.218) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API for EDAC device to report for multiple errors, and move the
old report function to use the new API.

Changes from v1:
----------------
- use 'unsigned int' instead of u16
- update variable name to be count
- remove WARN_ON and simply exit if count is zero
- add inline functions in header file

Hanna Hawa (2):
  edac: Add an API for edac device to report for multiple errors
  edac: move edac_device_handle_*() API functions to header

 drivers/edac/edac_device.c | 72 ++++++++++++++++++++------------------
 drivers/edac/edac_device.h | 63 ++++++++++++++++++++++++---------
 2 files changed, 84 insertions(+), 51 deletions(-)

-- 
2.17.1

