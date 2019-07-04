Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B03C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4C5218C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTo9jODm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfGDPgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:36:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37201 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfGDPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:36:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so5835286qkl.4;
        Thu, 04 Jul 2019 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuaFn2pc1K89xSedytgBd1vv5wIzckwD6JixGqi38qI=;
        b=RTo9jODmJXBeTp30ZT5mc2QLYo6A6mWdZF16gFYXy3eb0JVN0qMmawW+72GZoNd9Le
         0KqsU1H6f0C+H+TRXzjIsLHDgyMnelE8lf3dwfF89ruv6Qs67ipdOFl6PYJhpnW1k+wg
         Hffj/LadzBCObYUVzL9aklAXb3Rt+MD3Es06A42tg/tY6sZhs4csBkPkHKTjQsQHSjiY
         JtHryMHa1VSJJdLU8mc3u6QspoKKSjws/6FdxkMQq9V3XmnuawSQPax28qTSKvCCMK89
         OU2trKbK4cpdQvmnm/MTFIFoRtWIoVljhBsAUXZctHX4CtDxq244DKtbVzR/6okqplli
         1oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuaFn2pc1K89xSedytgBd1vv5wIzckwD6JixGqi38qI=;
        b=l4NngnSXLSuPEuOtgwOQhsAvlsJlomh3HQSwG+/ORYkwBzkHI2h306MVv+faJpTtCQ
         RxVAmaVV+tU4d/q2Q/asqULMRWbdo77YYj9hij6qyx4V/26EDEIlN5ghCQYdhjk/TDdV
         VVbHfwQT2cJmHeHt0n9UUI8F50pkJLK+yRo9ARkNehomrohNDE1NvMYEnGsZnlx4dxUK
         h9KpEKvR/4NF2ybvHOJ+24up1hD7ktjapC7ZK8jxJiURwWTOw+QsrYporGSpkdQCrR7f
         88ep4lqOvLvyVkW6wLXB8ZqVNJF/z+ScO/58AcOzMCDxQl684giYUznKQEkPgFvDYDHB
         BHqg==
X-Gm-Message-State: APjAAAX8ELcLX09tulU45BPLJlAOhbdo33V2iOp8ccJDyOu/DiPLJ7ZI
        RKHxWkelWYq8JbnZyxG4GJc=
X-Google-Smtp-Source: APXvYqzIrzQW3c9POmbRbbKUCB2Zqm8+6j9U8w4dtQL+YKRRyWePhzlkmMqJcJwKkvRW1yxG+WJCXw==
X-Received: by 2002:a37:ac1a:: with SMTP id e26mr10145679qkm.231.1562254562996;
        Thu, 04 Jul 2019 08:36:02 -0700 (PDT)
Received: from localhost.localdomain (pool-72-93-241-64.bstnma.fios.verizon.net. [72.93.241.64])
        by smtp.gmail.com with ESMTPSA id 67sm2087140qkh.108.2019.07.04.08.36.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 08:36:01 -0700 (PDT)
From:   Ryan Kennedy <ryan5544@gmail.com>
To:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Kennedy <ryan5544@gmail.com>
Subject: [PATCH 0/2] usb: pci-quirks: AMD PLL quirk fix
Date:   Thu,  4 Jul 2019 11:35:27 -0400
Message-Id: <20190704153529.9429-1-ryan5544@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a minor fix for the AMD PLL USB quirk plus
some clean up to the related code.

Ryan Kennedy (2):
  usb: pci-quirks: Correct AMD PLL quirk detection
  usb: pci-quirks: Minor cleanup for AMD PLL quirk

 drivers/usb/host/ehci-pci.c   |  4 ++--
 drivers/usb/host/ohci-pci.c   |  2 +-
 drivers/usb/host/pci-quirks.c | 45 +++++++++++++++++++++--------------
 drivers/usb/host/pci-quirks.h |  2 +-
 drivers/usb/host/xhci-pci.c   |  2 +-
 5 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.21.0

