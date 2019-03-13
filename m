Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851422147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZG2p8yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCMOzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:55:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfCMOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:55:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id g18so2361293wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBA6VvfF+Du0ehvzgVMRdAkktTaOAX3Y0CkEAW+/cY0=;
        b=uZG2p8yvwRPTrCYZzahSo7vcEMEfyNE38lfUWc3mrcvnRiBpgVbcaPCtKainZus/Jx
         jR87uIMMx/8+CQ3PpqeQowaYwPwEQYdjbGuxpW8WPV6XoOojJf2vZFs1HZGehe0kRmwk
         8WAAubSCBfYlXUSFhtnRN11XgnqYmAyReK1sDcl/kxuVWLYng6JViFIdkI++TDrF8IHN
         dWPlMoxJx20A8pZahdWDx71gXoRtR30tDquoUxjEgR+fe0MqeDxC3UelkvyhK7MoZdA2
         f2x4N7s6f/d8fUQNpEf3MD7cT3/scNAAw9l58G7tumbdyrDfy0n61EU0HqbU3epJEMYQ
         lT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBA6VvfF+Du0ehvzgVMRdAkktTaOAX3Y0CkEAW+/cY0=;
        b=ekcDok0oMpWvA63e27gakBd69ZALG7SIgUm+jS5eC3Ewt/WxNQtfOZ8QoRUgmdw9Z6
         kY1fLdD9B5Da740KNbqBtoN6A0QVn0xT//ah2TL8705YHpN8dpfKxwNeeb9qQjYwW0S5
         J5742++qrIkCUJCIxmGdf0Yl51JltDkMiSaHPYWV9uBeynDhp5IfFVwumlgR+AupKYNg
         zw7Mp8OClSU5FUdoCExgo3zTOgid1Z18r3MeXfR7RKDlxq3yyc01pCoKi8nKVQyxFE3K
         aes/DfKB21CboQeQtYucMyi4jdeaoCNPWAczR/Ov4VsZAfrN146VKKaRZdr//WfflAl+
         TPbQ==
X-Gm-Message-State: APjAAAUpdFftPB6tt1KMbYo2aC0jK6a0lU9PV6JRrEh7nmuvdq4qGGQq
        9yC7hshD6h+iUnSMr5Bwww==
X-Google-Smtp-Source: APXvYqwFV1L1x2nCVzGurxSZj2hMgrjUfrRP+430naLgHeoFWMyiqbnN548HXgkjrBWQwPrdb/sMTA==
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr26614129wrx.102.1552488943947;
        Wed, 13 Mar 2019 07:55:43 -0700 (PDT)
Received: from localhost.localdomain (cpc102034-bagu16-2-0-cust471.1-3.cable.virginm.net. [81.97.71.216])
        by smtp.gmail.com with ESMTPSA id p68sm1329218wme.45.2019.03.13.07.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:55:43 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v3 1/2] staging: rtl8192e: add SPDX GPL-2.0 license identifier
Date:   Wed, 13 Mar 2019 14:53:19 +0000
Message-Id: <20190313145320.26782-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313145320.26782-1-jbi.octave@gmail.com>
References: <20190313145320.26782-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDX GPL-2.0 license identifier to fix checkpatch.pl warning
Issue found by checkpatch.pl warning:
"WARNING: Missing or malformed SPDX-License-Identifier tag in line 1"

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 68f53013cb95..6d57abedaa34 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
-- 
2.20.1

