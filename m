Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B514C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B663206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsjdWOSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLaPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:16:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53020 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so2073241wmc.2;
        Tue, 31 Dec 2019 07:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IuZodoMyqxWVvgkPYDeRfZ7CtU3buoKs+K2n5bYydxM=;
        b=HsjdWOSldyM0TpjQUTTB0DNQ/NBqpLVTKsfEIbGTGgqcVOqAJ5fFV8AwnnwnCd+E79
         ZjHdSgQuXyaL6Nfroh67pORdTSBm+14RkVKPT+qo7RfrOG3Jh4C4Mr/Msw9YvQpRrgst
         tjlUsqaYplx1vnLRThEsohMOM7/L5B40Grmq0YtcitT/uYDJ//oi8y5EOugFsWjeH22o
         Hn7X7svFd7DrnvEakE4P0iTfQwzu76JCllORoNyVvWclyREffMh47C7adRj2QlsTgu4d
         LE3Mrp/Z+H9axDC7O4FbAIDZkitNSMpfupPPjnwBJteMJb5C9Oi/KzZS99PLhQgCepzn
         zQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IuZodoMyqxWVvgkPYDeRfZ7CtU3buoKs+K2n5bYydxM=;
        b=OXarlZaOLJf29agSPxomj+Z+T4qCbCy4UmoG/8Y402JpIlDeHW7cDGHB3nLD4BOUf3
         cSRqERccHr0nf+y7cVtCFCGz3Q6TrxaAI9RLiw9itEax5sqyWqFc7hyNZVkiI2jWxDFN
         iEiRLLgJvqJIDiOkhZT/LWm+4LOpQxrXSueg9TlLIHvq17NXbr3FGY6sP8oOn7DmlSOD
         5hmXjaamUxUMqkVcG3Hk09gfrgLsCwO1LZZdSnZvsC223LBig3wPb9D5RmQutYFuWtWz
         hj12rxbdc7o1+yrWckkdvLoaEHTsCwcGuCHpYWBM/cCflrdVGts6SQceaF/1BNFCIjbK
         GabA==
X-Gm-Message-State: APjAAAWwzTeF8pYaEpbAW+UB5wte7wJXCrKOvZzewJI9CIAF3+golG/R
        YnQ7PyqQ1WKknfU/+vdnQ/i5xLE+y8I=
X-Google-Smtp-Source: APXvYqyXs3CLrhQctyrKhrV80uTB4H7vfM9YTjYdapzsoXy5/nafeO6bYTA++7Dg731fUGNnVx2R3A==
X-Received: by 2002:a1c:498a:: with SMTP id w132mr4529592wma.10.1577805358784;
        Tue, 31 Dec 2019 07:15:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:15:57 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 0/7] Fix trivial nits in RCU docs
Date:   Tue, 31 Dec 2019 16:15:42 +0100
Message-Id: <20191231151549.12797-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset fixes trivial nits in the RCU documentations.

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

