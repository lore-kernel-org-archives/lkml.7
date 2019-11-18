Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ECCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5B920727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="O8XvTfa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKRKTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:19:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:19:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so18697855wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFGgNdC1ZOo48hA+OmEH9EyctK1S1xIaxbDXHBMAwNA=;
        b=O8XvTfa4Ssrw38qLLQGUQ5qDKhQFRmPQIj8WrZwsr1Ui5W1JTYiR3r+6zcPXnIipCS
         QTlwsnOtYrWwmaMnqIA6Rfh2fzoBwxx6dYUEfE4nZCIG5tc0k2m25/Xf0r+XwmXqb7jP
         XDxjTEbwZQB5TsEBVJ3NsxNT94kkBge4NonSJHLU9NkglqLt8DO2L2iOhP3U65C41Rug
         IXMVXPVzn1VSX3BSwcbaUxeN6zSIN7vW6ohpSDHlffrBDSBieJFG5xSgN5j3L6axVcWT
         IYWS0iyipPvrasWr2c6pvxaE+A8DMekKRovN5qHP0UxR8Ce6Rta5VcEehI75Ke/CHhtc
         cIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFGgNdC1ZOo48hA+OmEH9EyctK1S1xIaxbDXHBMAwNA=;
        b=sC8pfggqRz8/LNEzzhy3+vB1x7AuoYmKT9PCClgGxmnjkugzZcj+UvpkencXwOFMd7
         ulHeu1fMIfd7OGTSYu9wnAkWJ9yCqKc/wCiwdsZzEQn55Ubh7HSEfiNn6l19WQuvOcqi
         FPVW7yX1kHgoxyzh6TGE2QRgVJRwlaOz9kmuYB2Sft/aiiHB0Rx/GK5HC621N2iYDOuo
         77J5Oev5jG1wi2mRwf7+mDhU4hbYxkPGGf23F+7Nw1ncJC7/lW6aRNl+/op7Jf2LbXrN
         y2wGKXh4ZQOMKDUaTI+81Ol6YTk8QOSFpNdAsJgQQxz1xVlo45anlmFoHY8vlen8qBDy
         yTrQ==
X-Gm-Message-State: APjAAAXwyr0HH+iS3WF++TUH2h72/Z/fZFUBCFcRn5QTNJz69wjj5WkO
        dhgDFj19grMIASkd1m+icNOo1zwyCiU4L4ki
X-Google-Smtp-Source: APXvYqyg8b3EDZgID30NT4PlB/agD/pdBq4e0fxr8Hitvk33soVouFWu/h12CJihXcyB94Z6lMCIwQ==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr27665741wru.52.1574072383253;
        Mon, 18 Nov 2019 02:19:43 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t134sm20766740wmt.24.2019.11.18.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:19:42 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH v3 0/3] firmware: google: Fix minor bugs
Date:   Mon, 18 Nov 2019 11:19:28 +0100
Message-Id: <20191118101934.22526-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch series fixes 3 independent bugs in the google firmware
drivers.

Patch 1-2 do proper cleanup at kernel module unloading.

Patch 3 adds a check if the optional GSMI SMM handler is actually
present in the firmware and responses to the driver.

Changes in v2:
 - Add missing return statement
 - Add s-o-b on GSMI patches
 - Add define for reserved GSMI command

Changes in v3:
 - Cosmetic changes only

Arthur Heymans (2):
  firmware: google: Unregister driver_info on failure and exit in gsmi
  firmware: google: Probe for a GSMI handler in firmware

Patrick Rudolph (1):
  firmware: google: Release devices before unregistering the bus

 drivers/firmware/google/coreboot_table.c |  7 +++++++
 drivers/firmware/google/gsmi.c           | 25 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.21.0

