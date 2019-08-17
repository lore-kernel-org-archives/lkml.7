Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D2EC3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 00:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDD72086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 00:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdYQLM9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfHQAYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 20:24:10 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:33874 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfHQAYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 20:24:10 -0400
Received: by mail-lf1-f52.google.com with SMTP id b29so5200607lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 17:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5BCk8bFtxwiRj/dtDmyR2CqB0dW325WAsdwABRHioXU=;
        b=VdYQLM9o0hIXZUJKTYv3xybe+MsZqxJIUjzUNVfm1RUlRdBYhQrVUul/vKNg8ko5vA
         NEoyP+Puvvjz1dBlMdQPFr+C4raCP/qeYU1T/W1Mcrul9Xir8cg9HueIcdWihrXMo1vZ
         NaX5WYv//9KBNNOjWHL2XOcChFQ98YSzXMbVMvyvJ57ypyvQq73Ljzgcp9wcMXkIyMA5
         oVScKImhM3GnmY2LyIkrNCcBkAXbMOPD/6QKDp8RYZpNuSyhs/GfSHs0zD5qr7lTqqCZ
         Z7uyyjh8E2QTVMN/+pcXOmmXHrHIAgdtCGbPY+QAyGwfSY6UfOqgbHFE3qeTiJSdbZdA
         QIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5BCk8bFtxwiRj/dtDmyR2CqB0dW325WAsdwABRHioXU=;
        b=Gv2dpVIYI4V83VAr2E3OV4+pyO6XxFTkzot0iJr1FjDHmDhbllnFtQtBReEuhRqzw2
         NMI2pCJKPspULgMRuS+fJlbOSv3nqJPEuMWRG8bUsjKMNLX8lS982yKmdCNBmPnrEbqp
         NTp5RezON2MNXPuIq6QWC3Ai/4UZLzrsYPKAci/e2BdEsklXz7/NK7CpSIIZD/UpI/xm
         U7+9b2LLFfKdASJutOVa02SZUYz89Ta2QZ2Kq/aInTx6uvz/e+9hfGq4SLn4zq0fRFjC
         sX2P37EUMtH1ekZlLNqXw3Wvo4jULpZvBpCeLFOOg1xqqO6+afvrE/9wXL16xP65Y9sE
         lsbQ==
X-Gm-Message-State: APjAAAUxjV00WnQxC5QaIHIAk69hIZX8BTDc105Iw2HBBE3Gqk3op1rH
        A9r5YpLGuWxBqDbb2OHhMvk=
X-Google-Smtp-Source: APXvYqykHZ6nHNGIyr15OwALdLImvl18zWCo0bcVFvKGQDwHSddoOMs4F23dXqxmFol1AU3GPdCs6Q==
X-Received: by 2002:a19:4c88:: with SMTP id z130mr6588499lfa.149.1566001448127;
        Fri, 16 Aug 2019 17:24:08 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id 25sm1146633lft.71.2019.08.16.17.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 17:24:07 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/1] Xtensa fix for v5.3
Date:   Fri, 16 Aug 2019 17:23:49 -0700
Message-Id: <20190817002349.28658-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull another small fix for the Xtensa architecture.

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190816

for you to fetch changes up to cd8869f4cb257f22b89495ca40f5281e58ba359c:

  xtensa: add missing isync to the cpu_reset TLB code (2019-08-12 15:05:48 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.3:

- add missing isync into cpu_reset to make sure ITLB changes are
  effective.

----------------------------------------------------------------
Max Filippov (1):
      xtensa: add missing isync to the cpu_reset TLB code

 arch/xtensa/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Thanks.
-- Max
