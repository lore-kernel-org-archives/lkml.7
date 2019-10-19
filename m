Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E89CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8727222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2z5pF25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJSOHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:07:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39961 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJSOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:07:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so8618091wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7Q5YgxIlsTOJ6RN4Gx4aIi4gFkJcajKi+6SvF9kn/0=;
        b=u2z5pF250EIkte8lyu3Ud+41Bfg4Xea7dGxk3D+jBXT0gHXPBYH9VVaD3TxBHfA881
         Cd3V9utv9g4a1wc56H+4/cEQp8oNWsXiuBmMF3YB92lffUuFSi2qRO1Euq3z7s0prnSk
         Y1NACEZccO7vIpybvASZjcVifQ8NVXMB6U/ngK8IsG7dOS8nYgCyMjeWC2zDy5XWwf9v
         mRBTngY0mj5t6SOMIhPBske3Z/mReI+wmSmd70MlXkVxd3MNeQibNq3MizisP2SPKrVf
         tpvns7yRRNyx5+vxyhoHMx/yeQcEsi476a7sYwhE7/apT8tocqn6hBM+9cnc50eHu0Cm
         VhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7Q5YgxIlsTOJ6RN4Gx4aIi4gFkJcajKi+6SvF9kn/0=;
        b=B6ZQmVuXfM53DOlU0UEH/8guJ9vnjpvJNg9/PhKTblU2FqowqRWJlH/bTcDf6uy7N4
         cWPk7+3yziYpUu4Mg30Z1gEgURP6ScmbjBb4SFeTBc3pH1glFObTduayifFy10khqm1X
         EZM6C8VrikS8xgTu2VSyPTpn4U5MlgJ700LYlfU12P0dhOMXX2d5VS8uGk7aF5d342ki
         HPdBptHmStDFX9W+/4UknI/5KuCdwW/bNGYMjEeVxgEhKsSF6037LunxgdPYTQxQhzBo
         Aw4m2ATXpjmeWeYebWxYfh9EFTDyv9+xh3gkwxpldenaPOLYWDGL/yHhDJeYNqsNkPYS
         GD1g==
X-Gm-Message-State: APjAAAXVdD9T4MBZMMS72Rz3o9F7zGzAp1Orkkw3oMtqkUr77A5y09fz
        0hcj2dr7KWSCUPpgyJOl5w==
X-Google-Smtp-Source: APXvYqxtjRpbCww16AMVNk3tJbdUfa7U59DGmNm1JpB6NrtOCrVeSeMPlsYvSBPpcQp30APalPxJ7A==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr12424365wmb.88.1571494064634;
        Sat, 19 Oct 2019 07:07:44 -0700 (PDT)
Received: from ninjahub.lan (host-92-23-80-57.as13285.net. [92.23.80.57])
        by smtp.googlemail.com with ESMTPSA id t4sm7893080wrm.13.2019.10.19.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 07:07:43 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v1 0/5]  staging: wfx: fix checkpatch warnings
Date:   Sat, 19 Oct 2019 15:07:14 +0100
Message-Id: <20191019140719.2542-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings.

Jules Irenge (5):
  staging: wfx: fix warnings of no space is necessary
  staging: wfx: fix warning of line over 80 characters
  staging: wfx: fix warnings of logical continuation
  staging: wfx: correct misspelled words
  staging: wfx: fix warnings of alignment should match open parenthesis

 drivers/staging/wfx/bh.c       |  25 ++++---
 drivers/staging/wfx/bus.h      |   6 +-
 drivers/staging/wfx/bus_sdio.c |   9 +--
 drivers/staging/wfx/bus_spi.c  |  11 +--
 drivers/staging/wfx/data_rx.c  |  35 +++++----
 drivers/staging/wfx/data_tx.c  | 127 +++++++++++++++++++++------------
 drivers/staging/wfx/data_tx.h  |   4 +-
 drivers/staging/wfx/debug.c    |  14 ++--
 8 files changed, 143 insertions(+), 88 deletions(-)

-- 
2.21.0

