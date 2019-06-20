Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA37C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521612085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbDDbAeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfFTILg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:11:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36797 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFTILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:11:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so2144032wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQRh2gTu0XxP02eaevWI4QLBFrAyLvn8wbFwlTAm3vE=;
        b=YbDDbAegnE0dp4YumxpEKd5tEw4La1v3jt4kihJK5jyw2BUQQR1uZFOE2Ik6jnJj36
         z8MiqykH+K7ixsqv71H2SpZ2kIdYvhPPNu4TMwigVUjFZhOQUC7dpx6vVoshTPiYOmNO
         ftClQRkLAgfaq/fv3imw1NNxA6VFMohIC4QSRuxiQu898a6DmHEf4CSVx6pyiixqrYBN
         1OInEzdDKeK18AvYt8iG8qrHFhW24Q7MjjSJI8qT7zjFUvMUZO+pTv9/uBdWejqdfXY7
         GjpcnjXK/PxKVn3+jRWovjUVVZx6CtpbwVRoEAJHq4RSlc2yvBCCA7TDYO+3wgYGkyRH
         vkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQRh2gTu0XxP02eaevWI4QLBFrAyLvn8wbFwlTAm3vE=;
        b=Ltf2SpliIZAeSsw44AXZp7Yvy5osVXYKAox01gQk0CDWxXKQW2seu+4lWiJxF67tcH
         QO0TdlvJioYRP5MBskNPBVHpEuZ5i4hYD1MWOdBIsGnjmliQQOowxh5c3kFkKdyHGcMc
         BsLeSNa6hclz+qNwtYBBJuZhun6rCg3alILvZvsnS+KsBQ/ksAujs+/1N/4m8rAFY7TE
         NP1n7QXhVEa0Ay693BPAcvZlFfeN8jlCLvi28e+3QJ7duJ8BGHb84KF9i+NvBHEVqEhf
         As+9Vjtlgk+F3jQyPctPDda4ZmKKCgHE98jEjV0ZbvYD4bkrZRJEo38V+L3Ml0YlOfk8
         ZcFg==
X-Gm-Message-State: APjAAAV+qRMlYuj81SJAkJi6g/wdqaLCNXDhI45vr0F2Hr+uOjl0QDA7
        GW+yhMoPeNqC0wed4k0esmIetg==
X-Google-Smtp-Source: APXvYqzH+ZLNyvCpXFzWSXrFY3Wsh1CBUpeeYMjj0LkK0ktxpjDOzok10BkKCYtxgWuqjr52/qmPlw==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr1672163wmc.82.1561018292082;
        Thu, 20 Jun 2019 01:11:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q12sm17559174wrp.50.2019.06.20.01.11.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:11:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] slimbus: fix kerneldoc comments
Date:   Thu, 20 Jun 2019 09:11:27 +0100
Message-Id: <20190620081129.4721-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
References: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Corbet <corbet@lwn.net>

The kerneldoc comments in drivers/slimbus/stream.c were not properly
formatted, leading to a distinctly unsatisfying "no structured comments
found" warning in the docs build.  Sprinkle some asterisks around so that
the comments will be properly recognized.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/stream.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 2fa05324ed07..75f87b3d8b95 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -84,7 +84,7 @@ static const int slim_presence_rate_table[] = {
 	512000,
 };
 
-/*
+/**
  * slim_stream_allocate() - Allocate a new SLIMbus Stream
  * @dev:Slim device to be associated with
  * @name: name of the stream
@@ -189,7 +189,7 @@ static int slim_get_prate_code(int rate)
 	return -EINVAL;
 }
 
-/*
+/**
  * slim_stream_prepare() - Prepare a SLIMbus Stream
  *
  * @rt: instance of slim stream runtime to configure
@@ -336,7 +336,7 @@ static int slim_activate_channel(struct slim_stream_runtime *stream,
 	return slim_do_transfer(sdev->ctrl, &txn);
 }
 
-/*
+/**
  * slim_stream_enable() - Enable a prepared SLIMbus Stream
  *
  * @stream: instance of slim stream runtime to enable
@@ -389,7 +389,7 @@ int slim_stream_enable(struct slim_stream_runtime *stream)
 }
 EXPORT_SYMBOL_GPL(slim_stream_enable);
 
-/*
+/**
  * slim_stream_disable() - Disable a SLIMbus Stream
  *
  * @stream: instance of slim stream runtime to disable
@@ -423,7 +423,7 @@ int slim_stream_disable(struct slim_stream_runtime *stream)
 }
 EXPORT_SYMBOL_GPL(slim_stream_disable);
 
-/*
+/**
  * slim_stream_unprepare() - Un-prepare a SLIMbus Stream
  *
  * @stream: instance of slim stream runtime to unprepare
@@ -449,7 +449,7 @@ int slim_stream_unprepare(struct slim_stream_runtime *stream)
 }
 EXPORT_SYMBOL_GPL(slim_stream_unprepare);
 
-/*
+/**
  * slim_stream_free() - Free a SLIMbus Stream
  *
  * @stream: instance of slim stream runtime to free
-- 
2.21.0

