Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB8FC28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A3D2444A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HxRm98xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfE3C4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:56:16 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:2423 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfE3C4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559184974; x=1590720974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IryhIRAluN0UnomwvxkbYxdPEqGdg0Oi5OVTWudGcpM=;
  b=HxRm98xT5YYSlHMw7NJsIzIwDbRppO/P12XpWAfqDXUSY/3cLqsLmie8
   tIbkKCgv52UjnrgNQL1MSXpAESVnB2tgLF7Va5mnDlOaa/zaLHBMdfg9G
   fk8QSB8fS3Jr/tf42uxVlaAiFcem5ZATDd0NzVgP+dWdgIKNOS76O7lw2
   g=;
X-IronPort-AV: E=Sophos;i="5.60,529,1549929600"; 
   d="scan'208";a="768210708"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 May 2019 02:56:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id A51B6A2156;
        Thu, 30 May 2019 02:56:10 +0000 (UTC)
Received: from EX13D05UWB002.ant.amazon.com (10.43.161.50) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 02:56:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB002.ant.amazon.com (10.43.161.50) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 02:56:09 +0000
Received: from localhost (10.94.220.85) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 30 May 2019 02:56:10 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCHv2 0/2] hwmon: couple of fixes on HWMON_C_REGISTER_TZ
Date:   Wed, 29 May 2019 19:56:03 -0700
Message-ID: <20190530025605.3698-1-eduval@amazon.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

I found these bugs in the error path of hwmon_device_register().
One related to calling of-thermal when no dev->of_node is present.
And another in the error path handling of it.

Only difference from V1 is that I changed patch 2/2 to remove
the device_unregister() before jumping into the new label.

Eduardo Valentin (2):
  hwmon: core: add thermal sensors only if dev->of_node is present
  hwmon: core: fix potential memory leak in *hwmon_device_register*

 drivers/hwmon/hwmon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.21.0

