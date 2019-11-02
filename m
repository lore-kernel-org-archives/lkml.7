Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5613CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE0120663
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERSvUmMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKBO6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 10:58:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46399 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfKBO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 10:58:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id 193so7688910pfc.13;
        Sat, 02 Nov 2019 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JlODO+Zw4HpnzLEHJkewQtttAbaBlBjwv58aYsKBJYM=;
        b=ERSvUmMz4VDt5ZuGyU/O3KnGajZSRsagx/aKu/Dd9kFY0zfwh7yZ/K5YHYl2RWeLRU
         brwHUPHKExoSCsK+Mp2Sf3hGJCU/wg558X0OpkihW5I5ZPjGB2XwcIF3cplQ9YFdaEGG
         5hiM/Srgdy8tBTqYZmXW1gu3uzv1YortI1+KVfCXG+9xwt6V1ZBKjsWJXtCLGxGTFyP2
         ZhlFovzzrfUuH/XjvhJgmYaNSn7gSdPnIoQcpqLLG7sbrJoa+gAEV4TdMYF97jrXr5JI
         iOzcdLQ5Z/7+YVZNYWaG9LdOKbeJZ0HhMd9U96/3bWjkqdK84Qn2NLtmm2sX8Pt7VML5
         dL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JlODO+Zw4HpnzLEHJkewQtttAbaBlBjwv58aYsKBJYM=;
        b=LOItbPYPZmv+FBTrhnIUQ9Xrcj1RQ5vtpFaVq40vhHttdTxCkXhwHHTjzGsmaMOxC3
         pBJaTI/YIQF5Xvlf6qhDbgxei3rBbQZnevXBxRj1p5kUxwV30SUv81VrmSQJycV2VBbs
         b05Wj5vKogCv58GRMTnl5rb/7NM/2gTJKffjl8yH9wd0+l+d9AIAgY/RaAMMYvQzPFiv
         vKl12CQrtWklbEK+0PceAaKGeXF7eRixXwVBwHQ8P1YjqJZ4RxSCCz0C11261oUnJP0I
         8Vd0AWFVRNCrU07navtmxImXsUW3YIn9Q3tEv8D1OKDNX+TUpaVwnCBm4/7lSLxQ00ep
         6EsA==
X-Gm-Message-State: APjAAAXF4/uES9TXoKpqgGlfNo1uURMktX/jMOfPqlBXv8LP/oy6mK9Z
        3LZvZOpTz1izLBu/7Rp2T9G8lB5a
X-Google-Smtp-Source: APXvYqwoOvc5iUpfT8zdyokPGPzDNvrYCFkNAscJ6wBplzCLmsBvnxJ0W8LbHKUP4e2k0+occtOqlg==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr20868285pgi.128.1572706725314;
        Sat, 02 Nov 2019 07:58:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c66sm11051057pfb.25.2019.11.02.07.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 07:58:44 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.4-rc6
Date:   Sat,  2 Nov 2019 07:58:43 -0700
Message-Id: <20191102145843.16952-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.4-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.4-rc6

Thanks,
Guenter
------

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.4-rc6

for you to fetch changes up to 2ccb4f16d013a0954459061d38172b1c53553ba6:

  hwmon: (ina3221) Fix read timeout issue (2019-10-28 18:46:55 -0700)

----------------------------------------------------------------
hwmon fixes for v5.4-rc6

Fix read timeout problem in ina3221 driver
Fix wrong bitmask in nct7904 driver

----------------------------------------------------------------
Nicolin Chen (1):
      hwmon: (ina3221) Fix read timeout issue

amy.shih (1):
      hwmon: (nct7904) Fix the incorrect value of vsen_mask & tcpu_mask & temp_mode in nct7904_data struct.

 drivers/hwmon/ina3221.c |  2 +-
 drivers/hwmon/nct7904.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)
