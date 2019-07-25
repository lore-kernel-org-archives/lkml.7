Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE1C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B7622BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9VG6ezI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbfGYRkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:40:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38216 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbfGYRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:40:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so23114369pfn.5;
        Thu, 25 Jul 2019 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+WexidVxLEGFt6DmVlRbFT099hsDOv39Z19dnK1H4o=;
        b=I9VG6ezIbJHkOo0zTA1ccxSYyDWmkWeSGHUOKExB7AFL7dwrQGZQR27krq2gt710Zh
         cpMjyvLBhMB+tKIbeY95cgCc49ZXL5uJmqkWeHYSUXh78KfmgN2G8+F6qoyuvXAJStS/
         +ibl2WhrHMPdmGJoIc433Mv8yGXSVJH9tGz0vrhzjkabGcUhBQWqY8EtUNNJfyBoCQ+9
         RrN4agk4dhu+pXvqGqG24C3GIoJlbn+5xcHSYZomts9l3Al0BFSO0nxTgEMUsuoujpsE
         hVWVz3FmIqiqmOqvv8RK+4ouufG9dK6GyJaDbSoJ6oKQomyWuU6BMa+7swcVMKW6ivW+
         Z4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=F+WexidVxLEGFt6DmVlRbFT099hsDOv39Z19dnK1H4o=;
        b=D49yb3vsEhyydz+iBJsjhnfp3NwPBOuOsf9I24aehuChdFy9trborL7506QYL8NkEU
         eGXepsjqCVG3cPy3vq+XCQE3+rj5mTdSvxp1LPWUFRKbjjkrm9bWJbeUf2T2PkIUoriN
         BybQIgqkOPkr1R19BgehWtT7gWkFUJ+3eeZy/e5NPHv67ENo5qagEpPoPhS6UM5jyoN6
         xmzlfYQOiB5Okdj8nJkmwWVP31nDoSsV8SmxZoar4MvUYc3Yxa53XTFwtX5tW5f1H9iO
         U3fd/BrthXsV+K2STETapuJhgzcxU/rWG9I7WvgLrETFBMJBg1ESbw0HvOq8Qx9/lyFG
         E6Ww==
X-Gm-Message-State: APjAAAWKdThTHeqxi8Jjrui9yAT+tWEraQvQXVh0EiMKnL04dnWIYEgm
        dI+sRawEZ4fdiAq69lkQDxfFyQYL
X-Google-Smtp-Source: APXvYqwvmNiwQBEDOOdvmUil2aU3A84KQW5PYHZF30NNW2i9/fksR6PhRwtE9hnzjLsKqW81ICv3hg==
X-Received: by 2002:a17:90a:36e4:: with SMTP id t91mr90785262pjb.22.1564076445987;
        Thu, 25 Jul 2019 10:40:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i126sm56090898pfb.32.2019.07.25.10.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:40:45 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.3-rc2
Date:   Thu, 25 Jul 2019 10:40:44 -0700
Message-Id: <1564076444-24557-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.3-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3-rc2

Thanks,
Guenter
------

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.3-rc2

for you to fetch changes up to 223b2b5030f370f219c23c2c4678b419a72434d9:

  hwmon: (k8temp) documentation: update URL of datasheet (2019-07-21 19:18:45 -0700)

----------------------------------------------------------------
Couple of hwmon bug fixes

Update k8temp documentation URL
Register address fixes in nct6775 driver
Fix potential division by zero in occ driver

----------------------------------------------------------------
Björn Gerhart (1):
      hwmon: (nct6775) Fix register address and added missed tolerance for nct6106

Lei YU (1):
      hwmon: (occ) Fix division by zero issue

Robert Karszniewicz (1):
      hwmon: (k8temp) documentation: update URL of datasheet

 Documentation/hwmon/k8temp.rst | 2 +-
 drivers/hwmon/nct6775.c        | 3 ++-
 drivers/hwmon/occ/common.c     | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)
