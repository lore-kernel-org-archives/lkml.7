Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19892C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2162067D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 00:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGFGZFLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfHDAeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 20:34:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37190 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfHDAeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 20:34:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so55350267lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IDK+5GJsZg/moQTYynkFTD4VZ9t6Tz3FIid8VE7y7kI=;
        b=bGFGZFLRVjn1uAjxt0g6Xpfpd0DZhYy7lhDfricGG0nHBKOvemXKtt9o+hmbu8Xfn9
         74otpIeSgbrAjTTr2x6xoBdBA7jdM8dn2qFjA9XWcaQBuVVJ6zBi2Lxrn97NXxKE3vDJ
         LqfmmaR4GFQbxZAELYtn48dD5fRU1Dih2jWWWTULEmOkfDHHg13TzEoKxGi+vTzH30S6
         SImvND02Zdb/vcExsfarjxee/+jhVPF/W4LiSg0GLJRMgG2lI2qbTbCS76+uL6DM7jlG
         UcNiFqGG83dagfrevFpWuA0qqCdO3XslVlj+coIOa4HLOrN5ObNHkepQ8+K0cdYGatIw
         0Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IDK+5GJsZg/moQTYynkFTD4VZ9t6Tz3FIid8VE7y7kI=;
        b=hLOvlpZyZu7RmabiWlLQpeWnm8K+5a6nHKthljyrFA+2WLWHQdwEClxvlINfMaj5L7
         hq74DpRlAEDQJ7lHUHdiqsZXGk8J6v6mNDUksKVOhjFEql9ce7LcA3PS6UeLZJt7peDc
         aElvZCuxrG2rctzjxZBOk6tjwTqUvTaQ69oHRwrhzjxa33m1+Vd+cIPelR3yy3JqYqqm
         8GJoN5Wmg4ViNv4e7ViumjZvwnndLae53IYKEDmTqtMbjJ+xZh+RSLeA1wkPaypfpQ4x
         +dWMkxS9eNjlTQcSTbvbKa1lMtEngKurUo+TxGcEwvY+tHjD/CxR+KpeVYDCttUq4mWd
         JKaw==
X-Gm-Message-State: APjAAAVFb63wKaB6phR6cO+FZ2RvnNdFPpuBgPvhnMMkK1BMoxhi2tbM
        4eA2JFhMjvZ6fxrV4BHx/Zc=
X-Google-Smtp-Source: APXvYqwVzou9iJ1UwdgKNFFg+Q9vHwibyzvE4IAqQwjoFWjcnQhys467V/V3deTpaF+HZ6xKl3eD+w==
X-Received: by 2002:ac2:4d02:: with SMTP id r2mr23021734lfi.138.1564878840353;
        Sat, 03 Aug 2019 17:34:00 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net. (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x22sm13687848lfq.20.2019.08.03.17.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 17:33:59 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/1] xtensa fixes for v5.3
Date:   Sat,  3 Aug 2019 17:33:17 -0700
Message-Id: <20190804003317.15370-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fix for the Xtensa architecture.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190803

for you to fetch changes up to e3cacb73e626d885b8cf24103fed0ae26518e3c4:

  xtensa: fix build for cores with coprocessors (2019-07-24 17:44:42 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.3:

- fix build for xtensa cores with coprocessors that was broken by
  entry/return abstraction patch.

----------------------------------------------------------------
Max Filippov (1):
      xtensa: fix build for cores with coprocessors

 arch/xtensa/kernel/coprocessor.S | 1 +
 1 file changed, 1 insertion(+)

-- 
Thanks.
-- Max
