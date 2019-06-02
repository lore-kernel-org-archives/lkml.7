Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30636C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D0A278C0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+7c6Q/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFBK0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBK03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so6561844pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaxKPyv2ZkSoSLlbiUzUfzTm8zGISBR0eF/G7f2PZcE=;
        b=a+7c6Q/rH8yGZnIiR0P5vj3AbE0f9Hsb0ZWBgTUraFZD+7iMAuzNLY904cQ4ussiq8
         tl3yHirSsOnlA4SZQLNTmPOVdNd3BCYyNYLwhjRgYJFkpz9GsihhGnOE+ZdhxQdTb/B6
         XQrFviLvi29psA/KXLINtVRezvygYm/xjdG6lJv4XB+krNJ+QY+UXb2MR/iehMVcqPzh
         RdV7uL/1euPr+zo2mWyNs2oNqk+MdDOfQblFqGCRiQFmL93EbjC4lFIapkib3qBZnyKc
         T5vI6ZGYJ3cfyOonOfcuwyb3Zx62dnZIKKb/P0IqxUU8xBehWJfRtaKDI8dXRx1eXQxn
         kXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaxKPyv2ZkSoSLlbiUzUfzTm8zGISBR0eF/G7f2PZcE=;
        b=LDLvzzPUeL+55SBVb0u9woRjix47GjysyaPrGfWi2HDcBAQlfE2n/6RiHa9gx+XecR
         O++5s1dOSdiMvM+8cBIeSSFkppsdzwW7x4Z5PoflLOLj4An4KAypPPeq6av8EDYUA/JY
         k1Up0TLszNomdAt9yDFb7+5kqOWQW5kveUoVQrnemkjq71tHWHu8WqNnf/QUE4mhIpNB
         7WoJj4yMrBuRV9USP0J/8s+0mAiND5cdy7eecRYFRoQovHu4qILET3+O5luiXGZUD6KL
         m5ruf1aOoPd3QEbFQWLgzzzyPo03aiRcC+Lq2Z7BTDUqPaBMGbjAXOEB3BbE4wNukit2
         q70g==
X-Gm-Message-State: APjAAAWou63hV91bWy6zhT489NoJplJg6/M0OmIIVrrf9j2nXDBi57hA
        S+Wo5bbcG18c/exE6JLjQvGMkpyf
X-Google-Smtp-Source: APXvYqy8lUoajjVgXX+T7Je7m9CWdCqZyiZ4+7Vw9Hs4xHZ4OFMYWh81VcfMdrwricnBJV4xmw5i1Q==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr23698470pfb.2.1559471188681;
        Sun, 02 Jun 2019 03:26:28 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:27 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 0/9] staging: rtl8712: Fixed CamelCase in struct _adapter
Date:   Sun,  2 Jun 2019 15:55:29 +0530
Message-Id: <cover.1559470737.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes CamelCase checks in struct _adapter in drv_types.h
and in files where struct _adapter is used by renaming the variables
without camel case.

These check were reported by checkpatch.pl

This patch also changes type of enable_rx_ff0_filter as bool

Deepak Mishra (9):
  staging: rtl8712: Fixed CamelCase rename ImrContent to imr_content
  staging: rtl8712: Fixed CamelCase EepromAddressSize rename to
    eeprom_address_size
  staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
  staging: rtl8712: Fixed CamelCase renames evtThread to evt_thread
  staging: rtl8712: Fixed CamelCase renames IsrContent to isr_content
  staging: rtl8712: Fixed CamelCase renames xmitThread and recvThread
  staging: rtl8712: Fixed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0 in
  staging: rtl8712: fixed enable_rx_ff0_filter as bool and CamelCase
  staging: rtl8712: Fixed CamelCase lockRxFF0Filter

 drivers/staging/rtl8712/drv_types.h        | 20 ++++++++++----------
 drivers/staging/rtl8712/os_intfs.c         |  6 +++---
 drivers/staging/rtl8712/rtl871x_cmd.c      |  2 +-
 drivers/staging/rtl8712/rtl871x_eeprom.c   |  6 +++---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c |  2 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h  |  2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c     |  2 +-
 drivers/staging/rtl8712/usb_intf.c         |  4 ++--
 drivers/staging/rtl8712/xmit_linux.c       | 10 +++++-----
 9 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.19.1

