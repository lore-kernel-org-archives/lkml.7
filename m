Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6639C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC4D2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub6RFasA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfJLWAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:00:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41318 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfJLWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:00:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so8147767pfh.8;
        Sat, 12 Oct 2019 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdX1AvP0jU+JAMglCXDBLRHeX+aZyBphY7SECFf/oEM=;
        b=Ub6RFasAtB4+Y+MWZSV9kAK2W+59H09O1OQXtJPzY+KGUFg+LtRoXAOZ4u/rUPU0C3
         Yj0iMN+xWmRyN+8r5OxvYcSS4LuiDLXEIVcVnlT82c+3d2jvbslJ/5XcV1zu8THaLN3c
         fTDDDa8J/TGTHLdHhYOohR3FxIhY5iekRr18ydx9SuW4ZNU9/hoNG02sMmV/43O1rwKk
         +79Vn7oOOJU7wbDkhNWFtHqvAihcZRMW0/nqCrF3/YTHa9gC8E9HGreR/2k5yViVC8JH
         WsqhY8PY+P64CU8uN0/hhhWDioThaCw1uZ2CH1iuFDy/SmzAsX8K+TJ5WUDsbm8dVwxk
         /X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gdX1AvP0jU+JAMglCXDBLRHeX+aZyBphY7SECFf/oEM=;
        b=gRBtlNRTG1YMiyYsWsn5uQTyKz3To12RECTkGKnS0mhElp/jHYH7c2MYwDvmR7VqVX
         AFoWDnSudwPVBMsKQCUzbK60/1S1KpFE1X/yBIfft+qFw8sq5EjDyPR+TNYQchcIk3Kw
         jsT6Ar3WDJn7nWzLNDJRy+KaAhwwCAFztLnWdDritP7dyyMtl+ROKlhw7G1djU9vp7OB
         g+AGCXLMUSPmnFav83EIkJ3gS6pURazgTpv0bU42T3Cq261VJSKCeh05noCQYEPQfEq7
         8EZ/jS7wNUfJbxSMLFBYYcwu5gsTrivk1k/2HSSu6vnFL94Q+mcVobdVypZRF8g6EuCU
         V1AA==
X-Gm-Message-State: APjAAAW49TXimMVhrQx5oS9hWS9cQRdZtqfsnjiDAFU0hjqOe0PtFN3n
        7xPYReTmP2uXou9/9av8/5m6KuFA
X-Google-Smtp-Source: APXvYqycCPELiBjZ3k0potG/68WXfXtEzbLq66IsgoZk5orSN97dsKSvzbYDhANwrC2qw9K+MgOGng==
X-Received: by 2002:a65:614e:: with SMTP id o14mr24385352pgv.237.1570917610319;
        Sat, 12 Oct 2019 15:00:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8sm16741484pfi.117.2019.10.12.15.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Oct 2019 15:00:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.4-rc3
Date:   Sat, 12 Oct 2019 15:00:07 -0700
Message-Id: <20191012220007.1384-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.4-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.4-rc3

Thanks,
Guenter
------

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.4-rc3

for you to fetch changes up to 11c943a1a635d2c7141b5b6667ebb521ab4ecd58:

  hwmon: docs: Extend inspur-ipsps1 title underline (2019-10-07 05:56:57 -0700)

----------------------------------------------------------------
hwmon fixes for v5.4-rc3

Update/fix inspur-ipsps1 and k10temp Documentation
Fix nct7904 driver
Fix HWMON_P_MIN_ALARM mask in hwmon core

----------------------------------------------------------------
Adam Zerella (2):
      docs: hwmon: Include 'inspur-ipsps1.rst' into docs
      hwmon: docs: Extend inspur-ipsps1 title underline

Lukas Zapletal (1):
      hwmon: (k10temp) Update documentation and add temp2_input info

Nuno Sá (1):
      hwmon: Fix HWMON_P_MIN_ALARM mask

amy.shih (2):
      hwmon: (nct7904) Fix the incorrect value of vsen_mask in nct7904_data struct
      hwmon: (nct7904) Add array fan_alarm and vsen_alarm to store the alarms in nct7904_data struct.

 Documentation/hwmon/index.rst         |  1 +
 Documentation/hwmon/inspur-ipsps1.rst |  2 +-
 Documentation/hwmon/k10temp.rst       | 18 +++++++++++++++++-
 drivers/hwmon/nct7904.c               | 33 +++++++++++++++++++++++++++------
 include/linux/hwmon.h                 |  2 +-
 5 files changed, 47 insertions(+), 9 deletions(-)
