Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E581C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F8A2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oputHxGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgAFTTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44145 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so12029939wrm.11;
        Mon, 06 Jan 2020 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A27WQZOEbgSzITJcY4rI27WoWfYXi0S0dPxyuFu6MSY=;
        b=oputHxGnw1oGn3BatQlgSJmMMlzHK/XNNzFFStKqT0RbR4G7fEJieEg9fHeD/4P1Ji
         tRezg3ma4TOTbq6DSvbL9NLT8w85FhHBXiEmT3nmulD1HIysGxbrfV+oLrnY3ji0zJ4o
         lN7+xpc7+6Rj9ly9t2MgExZqFsBOW9dfhP3OfS+5rrj93SuRjqGsw0op/2sLFgY40mMk
         WrWkAieTchgq5C8zMFVVLn27QpopjItt/3ozKfkv5HmI05RYajEnaJCAROWP1lNKpnUn
         OKxTCzGF6Q6CyOoEeqyaVBvrEux/DTECgN1QeBUKa/dkL5DPyjN30H8vmTnEv1Of/GrW
         URXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A27WQZOEbgSzITJcY4rI27WoWfYXi0S0dPxyuFu6MSY=;
        b=G8P6iXDLt1YEX4n1cqqQXRw1YxThF6716IW90t01Vo3kb+H1eErkasYVKmXrT1g+le
         XwvoHcfBsqM5bkxM0mDYIqqlMZ5ETkaqCrz6XTGlLq06dHAis6FOBh4KKzgUiXX2OUxB
         gRQDptPVFB7LvAJsjIq7rtFY1dUeJmW4YGwJTHOlYHPjDN6G6vS+IyXbRcPj8b5H/ds+
         txSGxDglO+UeT0d1MJiI8e/Ee3OEjTVx4I4QF0lQTJuhI2yq5M+4UgLc5jcv/WxP30qN
         uzuW1p1bPGswfQgDG598Fd/+tNxIQ2OGnPQbG4fr3JU9SomzSzWKSVLoAFgguPQId8JX
         /J/A==
X-Gm-Message-State: APjAAAUKRh4E2greAEaD5zUTQVhCUR7sWoSf5ll1vxDyS2mDuvh0xV8f
        QBNocnHpH5QWkxhvqIMKIGc=
X-Google-Smtp-Source: APXvYqxZ+TmUFdkPrK14zayrozuKucwL/kzOUHuSKHDxBzEG3aS32lnpkMzzUiTMQ2jgW0Wq01r66A==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr100976013wro.45.1578338350359;
        Mon, 06 Jan 2020 11:19:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:09 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 0/7] Fix trivial nits in RCU docs
Date:   Mon,  6 Jan 2020 20:18:45 +0100
Message-Id: <20200106191852.22973-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes trivial nits in the RCU documentations.

It is based on the latest dev branch of Paul's linux-rcu git repository.
The Complete git tree is also available at
https://github.com/sjp38/linux/tree/patches/rcu/docs/2019-12-31/v2.

Changes from v1
(https://lore.kernel.org/linux-doc/20191231151549.12797-1-sjpark@amazon.de/)

 - Add 'Reviewed-by' from Madhuparna
 - Fix wrong author email address
 - Rebased on latest dev branch of Paul's linux-rcu git repository.

SeongJae Park (7):
  doc/RCU/Design: Remove remaining HTML tags in ReST files
  doc/RCU/listRCU: Fix typos in a example code snippets
  doc/RCU/listRCU: Update example function name
  doc/RCU/rcu: Use ':ref:' for links to other docs
  doc/RCU/rcu: Use absolute paths for non-rst files
  doc/RCU/rcu: Use https instead of http if possible
  rcu: Fix typos in beginning comments

 .../Tree-RCU-Memory-Ordering.rst               |  8 ++++----
 Documentation/RCU/listRCU.rst                  | 10 +++++-----
 Documentation/RCU/rcu.rst                      | 18 +++++++++---------
 kernel/rcu/srcutree.c                          |  2 +-
 kernel/rcu/tree.c                              |  4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.17.1

