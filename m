Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF4C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8420866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="04ayTH0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgABCfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:35:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45948 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgABCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:35:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so17265531pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 18:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jZH1Nd14C4y1v7M9e0zeyyhv8KS4mYmJ4ps3dkwUq6U=;
        b=04ayTH0CAnzc5Ez1133zMZdevAYgMMM7WWWlbvODLlp8zszinnk7Pyum9j6uqkV6p5
         DHqgZYtFq6L7zjdU6pTsbukU1Q2zSmA5xGFQAXbHiSRTEKlWD1ETc7qbDiOrGjwi+eHx
         yzQpUgaeSGtmqRecllkSgYX2Z7OC36BykU5wAXcsIsHller+5thwzlZgW9m0wnGJQFFz
         4s9bgKxfWM33Sx1A1xyrbTJnjWVvGILg/BH1SAQQbgpvdODGkiZw6FvtoePhVfdlj/RU
         iCpfp/5xs4DgnfykW4no5cybXS+y4RYDB0iw52JKPe00LA+421GYP1lQLYHjkcSXwb3A
         MD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jZH1Nd14C4y1v7M9e0zeyyhv8KS4mYmJ4ps3dkwUq6U=;
        b=YjHko+7z7lH5lcFlgBTNaLJaCBSXZxhZ7AtK9o45M8XGoSsG3b3GytlhkpzlPF7xxj
         OL+Lt4OLestMOtc35K3/odpJS5sNF9KkZbdgKjGMnB5d1pj26MCRZIYT8Vzh8gqF5TDl
         JUsliJs3yboSX0Ux+15LTK8AX72QAe5J5KzS7pQRwM2ZRoc3zLmnONXtW1weJYgWiGc4
         CmAF+/UthRtHO5tG+AGBeuIC3P6Wi6BAoRrZNvVBlx+LAEJGL8sIcXRfD6/0GbGfw0BZ
         IRluLiFX2tfVv+b1dOILk4PSZxxEL6TCSsHpV8H3WGigUAJP8LP/6hXNtPXZME9eUMnK
         57UA==
X-Gm-Message-State: APjAAAWxVMrz3hAYJmMJijrNZBUe+67ltDhVbMZzq0p4Wpwa0Drz98hH
        1pic72YvIcSiKz+ma1mLiIv++w==
X-Google-Smtp-Source: APXvYqyT3qG43+wGoOz0zi+FdvZcHKb2ZzuXDiM3Du0pSqmnoVlfUd9bx47Hn9ghCQS8k7/Or4nz2Q==
X-Received: by 2002:a17:902:b711:: with SMTP id d17mr54308596pls.162.1577932522822;
        Wed, 01 Jan 2020 18:35:22 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id s18sm56572809pfh.179.2020.01.01.18.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jan 2020 18:35:22 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH v2 0/2] misc: pvpanic: add crash loaded event
Date:   Thu,  2 Jan 2020 10:35:11 +0800
Message-Id: <20200102023513.318836-1-pizhenwei@bytedance.com>
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

