Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98363CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71016204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyMY9isg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJ1Twa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:52:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46322 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfJ1Twa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:52:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so16381535qtq.13;
        Mon, 28 Oct 2019 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gH4y2MFqABtX7zjcmdwe1o93nYkmE33y7ZMgRkG6HKA=;
        b=UyMY9isgczsRGGj0g1nqEHPUKIFtiw+ehWC7EFwImXQeQBD9BqdyPNl2Wds9pczum2
         xO9qxFYd8gPGOKZGaz38YVSemepFNwVA7MDvC3bqefM5DreHWQMguKpGzIBu+Mpje1aM
         BwE0Dm+WQ9/vRyx9hw0slP6z8jlQ2zHOBYJF5EYWeh3bhUJPFqZODjocfr29EjfUlwdW
         zUzaz515Iq8IORYd+QiBfvmsGT1Fnnq+l+EzqtjEzdl+OQJqeenwMXfPzU5NGUQXMDTI
         jOmzYFlii/9bc9WVLyV6ahqI1hFNbuSVzgbxhpEPNo0qbXw7HXm0w0C3jgzrDeYi4AAf
         iSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gH4y2MFqABtX7zjcmdwe1o93nYkmE33y7ZMgRkG6HKA=;
        b=mWfQU0N7y2Qj6Ha6bT4rkAZoEOHHJUL/jzrHdCxsVpFtyZ/3YNvV9rG3Oxt8o7R88e
         Hf3pfzMrGbw3SyXLO/BazJAkIL8YD8JARflZAq6i89Uxvitf/rZUF2rXJePvyTh8quKc
         JxjmLGlo5ox9I8855F22/8x5RGj2f/7B3es5owg5LRCOV+9w5S9hrSl2rMhJnMjKSkF2
         zKIrpzICR/xg3eVHP4jywkBHSFlhDYk64ZwA2YJHlFMdSI45HSPMq9cDH4hK9nd/QAWh
         a5Zp2N1zltGgXi/pu5c0nhYH7KvKtkm1UjSJ79EIGrgCogo6WKS2wkPWF7sn1EHMLBOf
         VrjQ==
X-Gm-Message-State: APjAAAWznDYI5wqEU7sfmXj6I5ByVA9RMDEMpZq+K+zezzjnZmcouOeN
        qgrGHJZ3Kxws7A0LjXz5nqxuY6tH
X-Google-Smtp-Source: APXvYqz/r5oIKJ4Ebe62mr0bZwyPRcPYHmln5UQpZG2k3xPXZBAp8k74ZHmTkvf8ylemlJXPm+xRLQ==
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr213925qta.374.1572292348833;
        Mon, 28 Oct 2019 12:52:28 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id m72sm3115968qke.5.2019.10.28.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:52:27 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH net-next 0/7] net: dsa: replace routing tables with a list
Date:   Mon, 28 Oct 2019 15:52:13 -0400
Message-Id: <20191028195220.2371843-1-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This branch gets rid of the ds->rtable static arrays in favor of
a single dst->rtable list. This allows us to move away from the
DSA_MAX_SWITCHES limitation and simplify the switch fabric setup.

This branch applies on top of Colin's "net: dsa: fix dereference on
ds->dev before null check error" commit.

Vivien Didelot (7):
  net: dsa: list DSA links in the fabric
  net: dsa: remove ds->rtable
  net: dsa: remove switch routing table setup code
  net: dsa: remove the dst->ds array
  net: dsa: remove tree functions related to switches
  net: dsa: remove limitation of switch index value
  net: dsa: tag_8021q: clarify index limitation

 drivers/net/dsa/mv88e6xxx/chip.c |   8 +--
 include/net/dsa.h                |  39 ++++++----
 net/dsa/dsa2.c                   | 119 +++++++++++++------------------
 net/dsa/tag_8021q.c              |   5 +-
 4 files changed, 83 insertions(+), 88 deletions(-)

-- 
2.23.0

