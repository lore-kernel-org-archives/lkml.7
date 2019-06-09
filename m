Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE9C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9C0208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed4WEy3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfFIMcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:32:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38172 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:32:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so3561233pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YGKq/MnQ3vnVXHhKPVhYbpS69nm1Le8k6iQsn94TsI=;
        b=ed4WEy3VsHRnMV/jqBEoObrTVrIEf4cE0FCQ+g4vH8MH8MH6MvEKhs9rMrcv/ATtoo
         lCiJj2M8TvkSFugbkOf50+mMxyDrGj901TNVh4R78cKEMeGKN9VStFVJTzdZM/mRmS+n
         xliczn8C629TxIEjoFbeT9Ks4dKLfTlHUmXCMOay4PlIsUwUSP6O3O+knbxRzL7r6x2h
         RdHY4OEEm/wez7ojUk4TH9+HFIZMPXBSwmcMzZL5qu5SWjl5WdEp8CYL2H3il5OZsIEa
         5AZfM3+WhynQiRa/sXPO7nOfbpTYSkp43fU1g0fOxz/Dp4IQvrMYy4lsSCrxvbRMUQMf
         i8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YGKq/MnQ3vnVXHhKPVhYbpS69nm1Le8k6iQsn94TsI=;
        b=Ym42Kbj3IcgHj5aMjUktqoySxeLci054dk15gYA0YG9X5pCmHygVLxARnbXg9V5D4Q
         KgzHHRPZkwN8BsXP+oi+4xGXnR7/3B3QtJlSsY0HKpUX4nGMOZ7WHlXtHlPprauK/Ub1
         YLRz3r8Fau3RVVNePJHOxQ3ZdFoUArLbl1GLJ7ry5m9Ks7TYAjf/2fCIhygKF4k7X+a9
         g0W1PUP3cQGoFG0csF7amoXjLLRBKQILf3s70OZCbabqt9bdTtJQ9YsMgw+br3XoWx4m
         9yF2Ry8FieaVXRj0HGs1eGPN7P4APEXxcQQcVmkGYWftBGxpKIhExQMSNhopcAySAnFm
         BEQA==
X-Gm-Message-State: APjAAAXNu5Uy5L/6Aw4uaIuBebhkPP8uKYcSuy0j2qZVgDB1OS57+TzX
        +R8KPAIyiyhpSnBbmMDCSwx+dyUI
X-Google-Smtp-Source: APXvYqyt6e3b8AXTfXCIhrexXupyhqqnhjxoxn0sKwuLn8aDfXZpuTtfy0E5qF2xmJkFP+c1x74bew==
X-Received: by 2002:a17:90a:bd88:: with SMTP id z8mr9374045pjr.60.1560083519961;
        Sun, 09 Jun 2019 05:31:59 -0700 (PDT)
Received: from localhost.localdomain ([117.192.26.87])
        by smtp.googlemail.com with ESMTPSA id c142sm10209982pfb.171.2019.06.09.05.31.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 05:31:59 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v5 0/6] staging: rtl8712: cleanup struct _adapter 
Date:   Sun,  9 Jun 2019 18:01:39 +0530
Message-Id: <cover.1560081971.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In process of cleaning up rtl8712 struct _adapter in drv_types.h I have
tried to remove some unused variables and redundant lines of code
associated with those variables. I have also fixed some CamelCase
reported by checkpatch.pl  

Following review comments from previous versions are addressed 
1. Separated CamelCase fix for lockRxFF0Filter and wkFilterRxFF0 to
separate patches
2. Separated CamelCase EepromAddressSizefrom removal of unused variable
ImrContent two different patches.
3. Remove redundant code along with removing variable ImrContent from
the structure
4. Instead of fixing CamelCase issue, remove the variables not in use.
5. Fixing of CamelCase of variable blnEnableRxFF0Filter is removed
from this patch set as spinning on a random variable for synchronization
needs to be fixed separately
 
Deepak Mishra (6):
  staging: rtl8712: Fixed CamelCase for EepromAddressSize
  staging: rtl8712: Removed redundant code from function
    oid_rt_pro_write_register_hdl
  staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
  staging: rtl8712: removed unused variables from struct _adapter
  staging: rtl8712: Renamed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0
  staging: rtl8712: Renamed CamelCase lockRxFF0Filter to
    lock_rx_ff0_filter

 drivers/staging/rtl8712/drv_types.h        | 13 ++++---------
 drivers/staging/rtl8712/os_intfs.c         |  6 +++---
 drivers/staging/rtl8712/rtl871x_eeprom.c   |  6 +++---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c |  5 -----
 drivers/staging/rtl8712/rtl871x_xmit.c     |  2 +-
 drivers/staging/rtl8712/usb_intf.c         |  4 ++--
 drivers/staging/rtl8712/xmit_linux.c       |  6 +++---
 7 files changed, 16 insertions(+), 26 deletions(-)

-- 
2.19.1

