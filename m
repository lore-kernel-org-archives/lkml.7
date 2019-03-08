Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC379C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA22081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiYcIqwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCHFdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:33:38 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34464 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHFdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:33:37 -0500
Received: by mail-yw1-f67.google.com with SMTP id u205so15444534ywe.1;
        Thu, 07 Mar 2019 21:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eQ4ZcW2hnDNAwu2nu+LyvgYkeEVl9tOIC3zqWKXyuiQ=;
        b=QiYcIqwNL1AIEFBvsfqS/HF+zPb6KXqSZRdKGuki99ftoUI+coAPfFfMAbrP4gGPMP
         ZfoaavtFBNu/5JxRK7AQQTTJ+/EZEGr9zr/S725yVxdnxzU8/rV5kYBr7K0xxSugnBB7
         ntNM/KBytEv2KEGLGeLP5nmRm7H7eez9JASMdm0O4Qhu0aImH59YNZfr2H5b5EDNtX1x
         VJYjWjSFpAO27W8nbO9auh8duo7SMvK1zLvA4VapqFFiB53cCn4kbfCOOaK3ya0xw/d0
         nBM+AMiBW/F1x4FjvfblIOryfvqVBLx24LYgnBXCo6OgwuSroQoCwapJ4TTsIZtn71x/
         kp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eQ4ZcW2hnDNAwu2nu+LyvgYkeEVl9tOIC3zqWKXyuiQ=;
        b=C+dN0F5PFJqnCGQwgackXmphKYvGrEyoOFj1gaalKkoexf6eAXP7MZ3JV7U+4ZLSU6
         8EimeHVDxN6aN5HmPS9EAplTqxOlt6VYK+x9hN0DesQ1aGtEVc60Xcu83uSTrAOloHDw
         NtDfKD/2qbkQKekJ4pILnw5nAX0QP15vhdO9emDkYbFpnPLyWtwIEa1txpMKsfG+CiZ3
         0mNdJmMyIu4fEZ3T/ZEpUmi6zFHGmsxfDHzs7YsnxFWsbFFj6hsFWcn2e6scjyCJ/0I8
         yymuLwEZ11+ikPAOxHnp50Kpm9xOHbPs280eXzXxiN2cTbJ0Ybtc7bh12ZC8OQapzop6
         Q4oQ==
X-Gm-Message-State: APjAAAXv0zf3STpZRHnPUzCLRfVy5q30YD4Ye3+CbZq1wUH1XE0GiT/O
        5vqhcxxN27Wt5pinkMIhOz4=
X-Google-Smtp-Source: APXvYqwMlvdVof96jQyDo2iMKgqj4841GOumxfmkWu2ulAYAQoqcjgCwR4RINjNquSNfy0x1ki5RiA==
X-Received: by 2002:a81:78cb:: with SMTP id t194mr1854537ywc.81.1552023217181;
        Thu, 07 Mar 2019 21:33:37 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id f131sm158699ywf.93.2019.03.07.21.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 21:33:36 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net
Cc:     Bo YU <tsu.yubo@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH 0/2] net: bonding: fix sparse warning
Date:   Fri,  8 Mar 2019 00:33:29 -0500
Message-Id: <cover.1552023000.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bo YU (2):
  net: bonding: fix restricted __be16 degrades to integer
  net: bonding: fix incorrect type in assignment

 drivers/net/bonding/bond_main.c    | 8 ++++----
 drivers/net/bonding/bond_options.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

--
2.11.0

