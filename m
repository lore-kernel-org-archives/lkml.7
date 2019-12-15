Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5CC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407C2072B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Lq8NIJld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfLODsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 22:48:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:42080 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfLODsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 22:48:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id o11so1471162pjp.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 19:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jZH1Nd14C4y1v7M9e0zeyyhv8KS4mYmJ4ps3dkwUq6U=;
        b=Lq8NIJldTr9jeULVySSZbA0zflyeeH7hXt6V+RE48VpGfgFXkGk7qgHtZGfJDjyKNK
         gAZmyVaB6Om9lwY8GTMfjNZlA0da7K8T4wJoGobKuy3QINmaueEWwjQNaK6nA823DIxT
         Co1oN3RLfhWGuMpqTv9DZAnhlxzG2L4GcfJ+ENdJR6iJPJrYqamzzwf6Bgpgb+Gu4ajF
         9Lo77SWiH+Q23uPAouZiDhkQEtd+y4MTtgcrg2n6U8c2DDYgWNKVIWN/JroYrENUKtn3
         kKZ06vosWc7KGzW5K5LnbTI6SwfuKuzYDM+yvZdGEX1LsOHobfgVFDCZlBtNREbNpYnY
         uKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jZH1Nd14C4y1v7M9e0zeyyhv8KS4mYmJ4ps3dkwUq6U=;
        b=XrFDSB9Js+yc/k8wmIK73c92Rlxavnk4FYurQSHHJSrQ5mIOpRDBZxvqHu16Rxo4eZ
         TkBPkXx4n6hetpkV5gi4QKO30YzWrgMZFL0W7k6GAVZwgwQAl4jC8W8OHPFXlBh5Wgd6
         bXNdHvNsTPqxxsDP2EiexjD5JOAwmkTYq3A6UgzNJXlvIfGzYiBXy7dabPy2BEcLmUiv
         uVxvbpEcHmIGM89askST4b4ARSig/q79yYE5eogf3CnLxlo0RBFS27hE5pW/33dcJ0Os
         z8UyKdtXifE18aDbG/i50yrQHw4jFWx4FmdYdmkfPXwLAG3qG/SzlAQ+NemlbQ8O6574
         nbKA==
X-Gm-Message-State: APjAAAU58hO+h7rdndogtuHHuRDmWguKp7c0LxEKXyJSgNhNSyABWFlU
        MCzoadLSA7lamQr5xmzRy7otlQ==
X-Google-Smtp-Source: APXvYqz3IQ7BdZj8owuB/Gt2m9F16tC1gkuQNKndaOjNPjEDX5gAwx0dvlZz3Npmu7WxJhpPHBwEuQ==
X-Received: by 2002:a17:902:6a8a:: with SMTP id n10mr9026414plk.9.1576381728198;
        Sat, 14 Dec 2019 19:48:48 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id e10sm17437727pfm.3.2019.12.14.19.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 19:48:47 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, peng.hao2@zte.com.cn
Cc:     hutao@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v2 0/2] misc: pvpanic: add crash loaded event
Date:   Sun, 15 Dec 2019 11:48:38 +0800
Message-Id: <20191215034840.2273096-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PVPANIC_CRASH_LOADED bit for pvpanic event, it means that guest
kernel actually hit a kernel panic, but the guest kernel wants to
handle by itself.

Suggested by Greg KH, move the bit definition to uapi header file
for the programs outside of kernel.

zhenwei pi (2):
  misc: pvpanic: move bit definition to uapi header file
  misc: pvpanic: add crash loaded event

 drivers/misc/pvpanic.c      | 12 +++++++++---
 include/uapi/misc/pvpanic.h |  9 +++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/misc/pvpanic.h

-- 
2.11.0

