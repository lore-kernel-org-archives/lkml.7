Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B7C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469F0208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICdbh1rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfFHK5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfFHK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so1798366plr.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cY1zZ5eNx8V+Wy+uWFjevtDZh4MtWLjKpVeteLeu7Dw=;
        b=ICdbh1rLajGRAczZ6o10B0GSroqXOdleXmaZzH5pv/udHDoxq5kUCfuuFGp0uix6yk
         IeVIQMKgWTV/0Cj0P1DSJjiNQ2JSNkd3/ccDhcISwQe6z06PQFsbB3qyteb1DH9rx/2U
         TKBCQ0qs7uKdPTM7f/M0qtTanlHkgw87cehb/Gr/X88mAc7KLIWoZe8h7v403jY5EqxM
         WRMYix8GWoIU6pOR5xP5Ft8y4GZJeDfzCdFjXBhH21P4V1n8SaWusaliwWVqJXTyiqmO
         6fLRAHNSUh0iweqxlGW3JRwoylxmbq1R8wm+PDiTSDn6p0xscWkoXeeJH9CA69PRbgR9
         ituQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cY1zZ5eNx8V+Wy+uWFjevtDZh4MtWLjKpVeteLeu7Dw=;
        b=rBRxDOUjt28PgO3i1tBrSOVRvqWdrBNKpuW267YQonBUtXCHqglXzm1DX+9Ssb/qTl
         stxuOysxrO7WSwErIIngTgtBbi8ag64iLyEUKdqy9PlnYRf7xdybUvs9ViZTUMOyAYmW
         8q7nDLLvHQ9mWiCOpsg+K/fdca37H+310HOBdK8Xz9Z9ooWYVEc7118vke6PIzXSw/g6
         8tVl3hMfbik4xoQ2z3r3E412ku3AJSPWXsztIPAWC9HmqRYJg3XJi5+Z+/Hb/cInqe31
         vgc1e4Rj4lkX8y1PUX5Aj8nqAXjpRkYxpOHIPN8cib+bBPmV7iiZ2FrEaovri+m5wZf6
         oDyQ==
X-Gm-Message-State: APjAAAVo3LxGeWQJL2BQ6G8N3rx1oz4ALDmcucnL+kneytg0vVNLF9kc
        RRQ9ZKo/ANuek6AbNLujlJYFo/T+
X-Google-Smtp-Source: APXvYqyHGHMJCSrl1D3+nRADJ7zJ0RDzH0QqTpHyYd8Tr3Sq9G7EbNK+NMFHaJajxPtPmHCpHqWEFg==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr61322898pls.123.1559991438708;
        Sat, 08 Jun 2019 03:57:18 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:18 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 0/6] staging: rtl8712: cleanup struct _adapter 
Date:   Sat,  8 Jun 2019 16:26:55 +0530
Message-Id: <cover.1559990697.git.linux.dkm@gmail.com>
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

